From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Restore ls-remote reference pattern matching
Date: Sat, 8 Dec 2007 21:35:48 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712082134350.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Dec 09 03:36:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1C1d-0006r9-22
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 03:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbXLICfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 21:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753350AbXLICfv
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 21:35:51 -0500
Received: from iabervon.org ([66.92.72.58]:33397 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348AbXLICfu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 21:35:50 -0500
Received: (qmail 14993 invoked by uid 1000); 9 Dec 2007 02:35:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Dec 2007 02:35:48 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67589>

I entirely missed that "git ls-remote <repo> <ref-pattern>..." is
supposed to work. This restores it.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
How's this? I vaguely tested it, and it doesn't break existing tests, and 
it matches my guess at how the old code worked, at least maybe.

 builtin-ls-remote.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 56f3f88..f8669ce 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -17,6 +17,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	struct transport *transport;
 	const struct ref *ref;
+	const char **refpathspec = NULL;
 
 	setup_git_directory_gently(&nongit);
 
@@ -50,9 +51,12 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	if (!dest || i != argc - 1)
+	if (!dest)
 		usage(ls_remote_usage);
 
+	if (argc > i + 1)
+		refpathspec = get_pathspec("*", argv + i);
+
 	remote = nongit ? NULL : remote_get(dest);
 	if (remote && !remote->url_nr)
 		die("remote %s has no configured URL", dest);
@@ -66,7 +70,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		return 1;
 
 	while (ref) {
-		if (check_ref_type(ref, flags))
+		if (check_ref_type(ref, flags) && 
+		    (!refpathspec || 
+		     pathspec_match(refpathspec, NULL, ref->name, 0)))
 			printf("%s	%s\n", sha1_to_hex(ref->old_sha1), ref->name);
 		ref = ref->next;
 	}
-- 
1.5.3.6.886.gb204
