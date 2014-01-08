From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] implement @{publish} shorthand
Date: Wed, 8 Jan 2014 04:37:16 -0500
Message-ID: <20140108093716.GE15720@sigill.intra.peff.net>
References: <20140108093338.GA15659@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 10:37:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0pZk-0003Oe-B8
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 10:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572AbaAHJhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 04:37:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:57101 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753919AbaAHJhS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 04:37:18 -0500
Received: (qmail 29749 invoked by uid 102); 8 Jan 2014 09:37:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jan 2014 03:37:18 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jan 2014 04:37:16 -0500
Content-Disposition: inline
In-Reply-To: <20140108093338.GA15659@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240203>

In a triangular workflow, you may have a distinct
@{upstream} that you pull changes from, but publish by
default (if you typed "git push") to a different remote (or
a different branch on the remote). It may sometimes be
useful to be able to quickly refer to that publishing point
(e.g., to see which changes you have that have not yet been
published).

This patch introduces the <branch>@{publish} shorthand (or
"@{pu}" to be even shorter). It refers to the tracking
branch of the remote branch to which you would push if you
were to push the named branch. That's a mouthful to explain,
so here's an example:

  $ git checkout -b foo origin/master
  $ git config remote.pushdefault github
  $ git push

Signed-off-by: Jeff King <peff@peff.net>
---
The implementation feels weird, like the "where do we push to" code
should be factored out from somewhere else. I think what we're doing
here is not _wrong_, but I don't like repeating what "git push" is doing
elsewhere. And I just punt on "simple" as a result. :)

 sha1_name.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 50df5d4..59ffa93 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -435,6 +435,12 @@ static inline int upstream_mark(const char *string, int len)
 	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
 }
 
+static inline int publish_mark(const char *string, int len)
+{
+	const char *suffix[] = { "@{publish}" };
+	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
+}
+
 static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
 static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf);
 
@@ -481,7 +487,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 					nth_prior = 1;
 					continue;
 				}
-				if (!upstream_mark(str + at, len - at)) {
+				if (!upstream_mark(str + at, len - at) &&
+				    !publish_mark(str + at, len - at)) {
 					reflog_len = (len-1) - (at+2);
 					len = at;
 				}
@@ -1100,6 +1107,69 @@ static int interpret_upstream_mark(const char *name, int namelen,
 	return len + at;
 }
 
+static const char *get_publish_branch(const char *name_buf, int len)
+{
+	char *name = xstrndup(name_buf, len);
+	struct branch *b = branch_get(*name ? name : NULL);
+	struct remote *remote = b->pushremote;
+	const char *dst;
+	const char *track;
+
+	free(name);
+
+	if (!remote)
+		die(_("branch '%s' has no remote for pushing"), b->name);
+
+	/* Figure out what we would call it on the remote side... */
+	if (remote->push_refspec_nr)
+		dst = apply_refspecs(remote->push, remote->push_refspec_nr,
+				     b->refname);
+	else
+		dst = b->refname;
+	if (!dst)
+		die(_("unable to figure out how '%s' would be pushed"),
+		    b->name);
+
+	/* ...and then figure out what we would call that remote here */
+	track = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, dst);
+	if (!track)
+		die(_("%s@{publish} has no tracking branch for '%s'"),
+		    b->name, dst);
+
+	return track;
+}
+
+static int interpret_publish_mark(const char *name, int namelen,
+				  int at, struct strbuf *buf)
+{
+	int len;
+
+	len = publish_mark(name + at, namelen - at);
+	if (!len)
+		return -1;
+
+	switch (push_default) {
+	case PUSH_DEFAULT_NOTHING:
+		die(_("cannot use @{publish} with push.default of 'nothing'"));
+
+	case PUSH_DEFAULT_UNSPECIFIED:
+	case PUSH_DEFAULT_MATCHING:
+	case PUSH_DEFAULT_CURRENT:
+		set_shortened_ref(buf, get_publish_branch(name, at));
+		break;
+
+	case PUSH_DEFAULT_UPSTREAM:
+		set_shortened_ref(buf, get_upstream_branch(name, at));
+		break;
+
+	case PUSH_DEFAULT_SIMPLE:
+		/* ??? */
+		die("@{publish} with simple unimplemented");
+	}
+
+	return at + len;
+}
+
 /*
  * This reads short-hand syntax that not only evaluates to a commit
  * object name, but also can act as if the end user spelled the name
@@ -1150,6 +1220,10 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 	if (len > 0)
 		return len;
 
+	len = interpret_publish_mark(name, namelen, cp - name, buf);
+	if (len > 0)
+		return len;
+
 	return -1;
 }
 
-- 
1.8.5.2.500.g8060133
