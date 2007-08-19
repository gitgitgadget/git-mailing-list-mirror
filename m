From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC] Clean way to disable pager
Date: Sun, 19 Aug 2007 19:26:07 +0200
Message-ID: <vpq1wdz307k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 19 19:27:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMoYM-0002JP-R7
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 19:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbXHSR0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 13:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754137AbXHSR0g
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 13:26:36 -0400
Received: from imag.imag.fr ([129.88.30.1]:53642 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754089AbXHSR0f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 13:26:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7JHQ7hr023926
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 19 Aug 2007 19:26:08 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IMoXP-0005xU-Nu; Sun, 19 Aug 2007 19:26:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IMoXP-0002TG-Jk; Sun, 19 Aug 2007 19:26:07 +0200
Mail-Followup-To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 19 Aug 2007 19:26:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56130>

Hi,

The man page for git documents the -p option to _enable_ the paginated
output for git, which isn't very usefull since the commands that might
actually need paging have it enabled by default.

What I can't find is a clean way to _disable_ the pager. A hacky way
is to run "git whatever | cat", or "GIT_PAGER=cat git whatever". From
the code, it seems that git doesn't even launch the pager if it's set
to "cat".

I think that deserves an less-hacky, and documented way. I'd suggest a
--no-pager, or --dont-paginate, that would do the opposite of -p as a
global option for git.

Below is a patch that does this:




>From 2148c2564ca6480feaec9a9d091259032257918d Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Sun, 19 Aug 2007 19:24:36 +0200
Subject: [PATCH] Add and document a global --no-pager option for git.

To keep the change small, this is done by setting GIT_PAGER to "cat". I'd
prefer not using global/environment variables for that, but it would
require a complete refactoring of options handling in git.
---
 Documentation/git.txt |    6 +++++-
 git.c                 |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 8017997..707a756 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,8 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate]
+'git' [--version] [--exec-path[=GIT_EXEC_PATH]] 
+    [-p|--paginate] [--no-pager]
     [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
     [--help] COMMAND [ARGS]
 
@@ -103,6 +104,9 @@ OPTIONS
 -p|--paginate::
        Pipe all output into 'less' (or if set, $PAGER).
 
+--no-pager::
+       Do not pipe git output into a pager.
+
 --git-dir=<path>::
        Set the path to the repository. This can also be controlled by
        setting the GIT_DIR environment variable.
diff --git a/git.c b/git.c
index cab0e72..f280e7d 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,7 @@
 #include "quote.h"
 
 const char git_usage_string[] =
-       "git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
+       "git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND
 [ARGS]";                                                                                                                                                   
 
 static void prepend_to_path(const char *dir, int len)
 {
@@ -58,6 +58,10 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
                        }
                } else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
                        setup_pager();
+               } else if (!strcmp(cmd, "--no-pager")) {
+                       setenv("GIT_PAGER", "cat", 1);
+                       if (envchanged)
+                               *envchanged = 1;
                } else if (!strcmp(cmd, "--git-dir")) {
                        if (*argc < 2) {
                                fprintf(stderr, "No directory given for --git-dir.\n" );
-- 
1.5.3.rc0.64.gf4f4a-dirty



-- 
Matthieu
