From: Jeff King <peff@peff.net>
Subject: [PATCH v3 09/14] remote.c: add branch_get_push
Date: Thu, 21 May 2015 00:45:36 -0400
Message-ID: <20150521044536.GI23409@peff.net>
References: <20150521044429.GA5857@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 06:45:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvIMd-0000B5-4Q
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbbEUEpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:45:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:33699 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753356AbbEUEpi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:45:38 -0400
Received: (qmail 2386 invoked by uid 102); 21 May 2015 04:45:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 23:45:38 -0500
Received: (qmail 31250 invoked by uid 107); 21 May 2015 04:45:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:45:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 00:45:36 -0400
Content-Disposition: inline
In-Reply-To: <20150521044429.GA5857@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269550>

In a triangular workflow, the place you pull from and the
place you push to may be different. As we have
branch_get_upstream for the former, this patch adds
branch_get_push for the latter (and as the former implements
@{upstream}, so will this implement @{push} in a future
patch).

Note that the memory-handling for the return value bears
some explanation. Some code paths require allocating a new
string, and some let us return an existing string. We should
provide a consistent interface to the caller, so it knows
whether to free the result or not.

We could do so by xstrdup-ing any existing strings, and
having the caller always free. But that makes us
inconsistent with branch_get_upstream, so we would prefer to
simply take ownership of the resulting string. We do so by
storing it inside the "struct branch", just as we do with
the upstream refname (in that case we compute it when the
branch is created, but there's no reason not to just fill
it in lazily in this case).

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h | 10 ++++++++
 2 files changed, 95 insertions(+)

diff --git a/remote.c b/remote.c
index 1b7051a..be45a39 100644
--- a/remote.c
+++ b/remote.c
@@ -1737,6 +1737,91 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 	return branch->merge[0]->dst;
 }
 
+static const char *tracking_for_push_dest(struct remote *remote,
+					  const char *refname,
+					  struct strbuf *err)
+{
+	char *ret;
+
+	ret = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, refname);
+	if (!ret)
+		return error_buf(err,
+				 _("push destination '%s' on remote '%s' has no local tracking branch"),
+				 refname, remote->name);
+	return ret;
+}
+
+static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
+{
+	struct remote *remote;
+
+	if (!branch)
+		return error_buf(err, _("HEAD does not point to a branch"));
+
+	remote = remote_get(pushremote_for_branch(branch, NULL));
+	if (!remote)
+		return error_buf(err,
+				 _("branch '%s' has no remote for pushing"),
+				 branch->name);
+
+	if (remote->push_refspec_nr) {
+		char *dst;
+		const char *ret;
+
+		dst = apply_refspecs(remote->push, remote->push_refspec_nr,
+				     branch->refname);
+		if (!dst)
+			return error_buf(err,
+					 _("push refspecs for '%s' do not include '%s'"),
+					 remote->name, branch->name);
+
+		ret = tracking_for_push_dest(remote, dst, err);
+		free(dst);
+		return ret;
+	}
+
+	if (remote->mirror)
+		return tracking_for_push_dest(remote, branch->refname, err);
+
+	switch (push_default) {
+	case PUSH_DEFAULT_NOTHING:
+		return error_buf(err, _("push has no destination (push.default is 'nothing')"));
+
+	case PUSH_DEFAULT_MATCHING:
+	case PUSH_DEFAULT_CURRENT:
+		return tracking_for_push_dest(remote, branch->refname, err);
+
+	case PUSH_DEFAULT_UPSTREAM:
+		return branch_get_upstream(branch, err);
+
+	case PUSH_DEFAULT_UNSPECIFIED:
+	case PUSH_DEFAULT_SIMPLE:
+		{
+			const char *up, *cur;
+
+			up = branch_get_upstream(branch, err);
+			if (!up)
+				return NULL;
+			cur = tracking_for_push_dest(remote, branch->refname, err);
+			if (!cur)
+				return NULL;
+			if (strcmp(cur, up))
+				return error_buf(err,
+						 _("cannot resolve 'simple' push to a single destination"));
+			return cur;
+		}
+	}
+
+	die("BUG: unhandled push situation");
+}
+
+const char *branch_get_push(struct branch *branch, struct strbuf *err)
+{
+	if (!branch->push_tracking_ref)
+		branch->push_tracking_ref = branch_get_push_1(branch, err);
+	return branch->push_tracking_ref;
+}
+
 static int ignore_symref_update(const char *refname)
 {
 	unsigned char sha1[20];
diff --git a/remote.h b/remote.h
index 03ca005..3326f2b 100644
--- a/remote.h
+++ b/remote.h
@@ -209,6 +209,8 @@ struct branch {
 	struct refspec **merge;
 	int merge_nr;
 	int merge_alloc;
+
+	const char *push_tracking_ref;
 };
 
 struct branch *branch_get(const char *name);
@@ -229,6 +231,14 @@ int branch_merge_matches(struct branch *, int n, const char *);
  */
 const char *branch_get_upstream(struct branch *branch, struct strbuf *err);
 
+/**
+ * Return the tracking branch that corresponds to the ref we would push to
+ * given a bare `git push` while `branch` is checked out.
+ *
+ * The return value and `err` conventions match those of `branch_get_upstream`.
+ */
+const char *branch_get_push(struct branch *branch, struct strbuf *err);
+
 /* Flags to match_refs. */
 enum match_refs_flags {
 	MATCH_REFS_NONE		= 0,
-- 
2.4.1.528.g00591e3
