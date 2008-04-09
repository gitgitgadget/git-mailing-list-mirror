From: Joachim B Haga <jobh@broadpark.no>
Subject: [PATCH] Re: git clean removes directories when not asked to
Date: Wed, 09 Apr 2008 19:04:15 +0200
Message-ID: <85fxtvj6y8.fsf_-_@lupus.strangled.net>
References: <85prt0jjen.fsf@lupus.strangled.net> <85k5j8jioc.fsf@lupus.strangled.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 19:06:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjdjX-0003xP-48
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 19:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbYDIRE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 13:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbYDIRE3
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 13:04:29 -0400
Received: from main.gmane.org ([80.91.229.2]:56895 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597AbYDIRE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 13:04:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jjdik-0003GB-Jn
	for git@vger.kernel.org; Wed, 09 Apr 2008 17:04:26 +0000
Received: from 22.80-203-45.nextgentel.com ([80.203.45.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Apr 2008 17:04:26 +0000
Received: from jobh by 22.80-203-45.nextgentel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Apr 2008 17:04:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 22.80-203-45.nextgentel.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:Ht7prgpJsmT5VmuTMmV5PFqPc80=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79119>

Joachim B Haga <jobh@broadpark.no> writes:

> Joachim B Haga <jobh@broadpark.no> writes:
>
>> When invoked from a subdirectory, git clean removes more than it
>> should. According to the documentation, it should not remove
>> directories unless "-d" is given. However:

I have tried to fix this, but I don't know the code. The previous logic was
obviously (?) broken, as it had this (paraphrased):

if (remove_directories || matches)
	remove_dir_recursively(...);

which should have been &&. But with only this change, top-level directories
were not removed even if "-d" was given. Looking at the (!ISDIR) branch, I
guessed that it should instead trigger if pathspec is NULL; i.e, generally
treat (!pathspec) as a match. It looks like the behaviour is correct now, but
somebody who knows this code should check my guesses.

-j.




>From 73647e7bb73b6037b9d14535ec027da8ee7d6091 Mon Sep 17 00:00:00 2001
From: Joachim B Haga <jobh@broadpark.no>
Date: Wed, 9 Apr 2008 18:49:34 +0200
Subject: [PATCH] Stop builtin-clean from removing directories unless "-d" is given.

---
 builtin-clean.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index fefec30..15201d5 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -130,29 +130,32 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
                        matches = match_pathspec(pathspec, ent->name, ent->len,
                                                 baselen, seen);
                } else {
-                       matches = 0;
+                       matches = 1;
                }
 
                if (S_ISDIR(st.st_mode)) {
                        strbuf_addstr(&directory, ent->name);
                        qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
-                       if (show_only && (remove_directories || matches)) {
-                               printf("Would remove %s\n", qname);
-                       } else if (remove_directories || matches) {
-                               if (!quiet)
-                                       printf("Removing %s\n", qname);
-                               if (remove_dir_recursively(&directory, 0) != 0) {
-                                       warning("failed to remove '%s'", qname);
-                                       errors++;
+                       if (remove_directories && matches) {
+                               if (show_only)
+                                       printf("Would remove %s\n", qname);
+                               else {
+                                       if (!quiet)
+                                               printf("Removing %s\n", qname);
+                                       if (remove_dir_recursively(&directory, 0) != 0) {
+                                               warning("failed to remove '%s'", qname);
+                                               errors++;
+                                       }
                                }
-                       } else if (show_only) {
-                               printf("Would not remove %s\n", qname);
                        } else {
-                               printf("Not removing %s\n", qname);
+                               if (show_only)
+                                       printf("Would not remove %s\n", qname);
+                               else
+                                       printf("Not removing %s\n", qname);
                        }
                        strbuf_reset(&directory);
                } else {
-                       if (pathspec && !matches)
+                       if (!matches)
                                continue;
                        qname = quote_path_relative(ent->name, -1, &buf, prefix);
                        if (show_only) {
-- 
1.5.4.4
