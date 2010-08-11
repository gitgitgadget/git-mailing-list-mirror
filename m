From: Greg Brockman <gdb@MIT.EDU>
Subject: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked files
Date: Wed, 11 Aug 2010 03:03:56 -0400
Message-ID: <1281510236-8103-1-git-send-email-gdb@mit.edu>
Cc: Greg Brockman <gdb@mit.edu>
To: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed Aug 11 09:04:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj5MK-00038u-P5
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 09:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab0HKHEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 03:04:09 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:62731 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752037Ab0HKHEI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 03:04:08 -0400
X-AuditID: 12074422-b7bb6ae0000009fa-86-4c624b5db618
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id 0A.D4.02554.D5B426C4; Wed, 11 Aug 2010 03:03:57 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o7B7466d011489;
	Wed, 11 Aug 2010 03:04:06 -0400
Received: from localhost (STRATTON-FOUR-FORTY-FOUR.MIT.EDU [18.187.6.189])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7B7442n017927;
	Wed, 11 Aug 2010 03:04:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153194>

Currently, 'git add' will complain about excluded files, even if they
are already tracked:

$ mkdir dir && touch dir/file && cat > .gitignore <<< dir
$ git add -f dir/file
$ git status
  ...
  new file:   dir/file
  ...
$ git add dir/file
The following paths are ignored by one of your .gitignore files:
dir
Use -f if you really want to add them.
fatal: no files added

This commit changes 'git add' to disregard excludes for tracked files
whose paths are explicitly specified on the command-line.  So in the
above example, 'git add dir/file' no longer requires a '-f'.  However,
'git add dir' does.

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 builtin/add.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

What do people think of this behavior?  My motivation in writing this patch is
that I sometimes track files in an ignored directory, and it can be cumbersome
to remember to pass '-f' when adding them.  Related commands such as 'git add -p'
and 'git commit -a' do not require a '-f' in this case, so it feels natural to me not
to require extra user confirmation when an explicit path has been provided.

As always, thanks in advance for your comments.

diff --git a/builtin/add.c b/builtin/add.c
index 56a4e0a..46b1fdb 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -423,8 +423,27 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		/* Set up the default git porcelain excludes */
 		memset(&dir, 0, sizeof(dir));
 		if (!ignored_too) {
+			const char **tracked = xmalloc(sizeof(char *) * (argc + 1));
+			const char **p;
+			int tidx = 0;
+			int pidx = 0;
+
 			dir.flags |= DIR_COLLECT_IGNORED;
 			setup_standard_excludes(&dir);
+
+			for (p = pathspec; *p; p++) {
+				if ((*p)[0] && cache_name_exists(*p, strlen(*p), 0))
+					tracked[tidx++] = *p;
+				else
+					pathspec[pidx++] = *p;
+			}
+
+			tracked[tidx] = NULL;
+			pathspec[pidx] = NULL;
+			exit_status |= add_files_to_cache(prefix, tracked, flags);
+			/* All files were tracked */
+			if (pidx == 0)
+				goto finish;
 		}
 
 		/* This picks up the paths that are not tracked */
-- 
1.7.0.4
