From: Jeff King <peff@peff.net>
Subject: [PATCH v3 03/14] remote.c: drop "remote" pointer from "struct branch"
Date: Thu, 21 May 2015 00:45:13 -0400
Message-ID: <20150521044512.GC23409@peff.net>
References: <20150521044429.GA5857@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 06:45:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvIMF-0008Mn-Mg
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbbEUEpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:45:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:33671 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753181AbbEUEpP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:45:15 -0400
Received: (qmail 2271 invoked by uid 102); 21 May 2015 04:45:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 23:45:15 -0500
Received: (qmail 31142 invoked by uid 107); 21 May 2015 04:45:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:45:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 00:45:13 -0400
Content-Disposition: inline
In-Reply-To: <20150521044429.GA5857@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269544>

When we create each branch struct, we fill in the
"remote_name" field from the config, and then fill in the
actual "remote" field (with a "struct remote") based on that
name. However, it turns out that nobody really cares about
the latter field. The only two sites that access it at all
are:

  1. git-merge, which uses it to notice when the branch does
     not have a remote defined. But we can easily replace this
     with looking at remote_name instead.

  2. remote.c itself, when setting up the @{upstream} merge
     config. But we don't need to save the "remote" in the
     "struct branch" for that; we can just look it up for
     the duration of the operation.

So there is no need to have both fields; they are redundant
with each other (the struct remote contains the name, or you
can look up the struct from the name). It would be nice to
simplify this, especially as we are going to add matching
pushremote config in a future patch (and it would be nice to
keep them consistent).

So which one do we keep and which one do we get rid of?

If we had a lot of callers accessing the struct, it would be
more efficient to keep it (since you have to do a lookup to
go from the name to the struct, but not vice versa). But we
don't have a lot of callers; we have exactly one, so
efficiency doesn't matter. We can decide this based on
simplicity and readability.

And the meaning of the struct value is somewhat unclear. Is
it always the remote matching remote_name? If remote_name is
NULL (i.e., no per-branch config), does the struct fall back
to the "origin" remote, or is it also NULL? These questions
will get even more tricky with pushremotes, whose fallback
behavior is more complicated. So let's just store the name,
which pretty clearly represents the branch.*.remote config.
Any lookup or fallback behavior can then be implemented in
helper functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-remote.txt | 4 ----
 builtin/merge.c                        | 2 +-
 remote.c                               | 7 ++++---
 remote.h                               | 1 -
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/api-remote.txt b/Documentation/technical/api-remote.txt
index 5d245aa..2cfdd22 100644
--- a/Documentation/technical/api-remote.txt
+++ b/Documentation/technical/api-remote.txt
@@ -97,10 +97,6 @@ It contains:
 
 	The name of the remote listed in the configuration.
 
-`remote`::
-
-	The struct remote for that remote.
-
 `merge_name`::
 
 	An array of the "merge" lines in the configuration.
diff --git a/builtin/merge.c b/builtin/merge.c
index f89f60e..85c54dc 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -933,7 +933,7 @@ static int setup_with_upstream(const char ***argv)
 
 	if (!branch)
 		die(_("No current branch."));
-	if (!branch->remote)
+	if (!branch->remote_name)
 		die(_("No remote for the current branch."));
 	if (!branch->merge_nr)
 		die(_("No default upstream defined for the current branch."));
diff --git a/remote.c b/remote.c
index ac17e66..c298a43 100644
--- a/remote.c
+++ b/remote.c
@@ -1632,6 +1632,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 
 static void set_merge(struct branch *ret)
 {
+	struct remote *remote;
 	char *ref;
 	unsigned char sha1[20];
 	int i;
@@ -1649,11 +1650,13 @@ static void set_merge(struct branch *ret)
 		return;
 	}
 
+	remote = remote_get(ret->remote_name);
+
 	ret->merge = xcalloc(ret->merge_nr, sizeof(*ret->merge));
 	for (i = 0; i < ret->merge_nr; i++) {
 		ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
 		ret->merge[i]->src = xstrdup(ret->merge_name[i]);
-		if (!remote_find_tracking(ret->remote, ret->merge[i]) ||
+		if (!remote_find_tracking(remote, ret->merge[i]) ||
 		    strcmp(ret->remote_name, "."))
 			continue;
 		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
@@ -1673,8 +1676,6 @@ struct branch *branch_get(const char *name)
 		ret = current_branch;
 	else
 		ret = make_branch(name, 0);
-	if (ret && ret->remote_name)
-		ret->remote = remote_get(ret->remote_name);
 	set_merge(ret);
 	return ret;
 }
diff --git a/remote.h b/remote.h
index 02d66ce..4bb6672 100644
--- a/remote.h
+++ b/remote.h
@@ -203,7 +203,6 @@ struct branch {
 	const char *refname;
 
 	const char *remote_name;
-	struct remote *remote;
 
 	const char **merge_name;
 	struct refspec **merge;
-- 
2.4.1.528.g00591e3
