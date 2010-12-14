From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 08/14] help.c: Fix detection of custom merge strategy on cygwin
Date: Tue, 14 Dec 2010 18:29:26 +0000
Message-ID: <4D07B786.2060602@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, j6t@kdbg.org,
	jrnieder@gmail.com, vmiklos@frugalware.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:46:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZtg-0005L5-Vy
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758385Ab0LNSqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:46:44 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:40659 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758283Ab0LNSqo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:46:44 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZtC-0000MW-de; Tue, 14 Dec 2010 18:46:43 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163669>


Test t7606-merge-custom.sh fails on cygwin when git-merge fails
with an "Could not find merge strategy 'theirs'" error, despite
the test correctly preparing an (executable) git-merge-theirs
script.

The cause of the failure is the mis-detection of the executable
status of the script, by the is_executable() function, while the
load_command_list() function is searching the path for additional
merge strategy programs.

Note that the l/stat() "functions" on cygwin are somewhat
schizophrenic (see commits adbc0b6, 7faee6b and 7974843), and
their behaviour depends on the timing of various git setup and
config function calls. In particular, until the "git_dir" has
been set (have_git_dir() returns true), the real cygwin (POSIX
emulating) l/stat() functions are called. Once "git_dir" has
been set, the "native Win32 API" implementations of l/stat()
may, or may not, be called depending on the setting of the
core.filemode and core.ignorecygwinfstricks config variables.

We also note that, since commit c869753, core.filemode is forced
to false, even on NTFS, by git-init and git-clone. A user (or a
test) can, of course, reset core.filemode to true explicitly if
the filesystem supports it (and he doesn't use any problematic
windows software). The test-suite currently runs all tests on
cygwin with core.filemode set to false.

Given the above, we see that the built-in merge strategies are
correctly detected as executable, since they are checked for
before "git_dir" is set, whereas all custom merge strategies are
not, since they are checked for after "git_dir" is set.

In order to fix the mis-detection problem, we change the code in
is_executable() to re-use the conditional WIN32 code section,
which actually looks at the content of the file to determine if
the file is executable. On cygwin we also make the additional
code conditional on the executable bit of the file mode returned
by the initial stat() call. (only the real cygwin function would
set the executable bit in the file mode.)

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 help.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/help.c b/help.c
index 7f4928e..eabadc9 100644
--- a/help.c
+++ b/help.c
@@ -126,7 +126,10 @@ static int is_executable(const char *name)
 	    !S_ISREG(st.st_mode))
 		return 0;
 
-#ifdef WIN32
+#if defined(WIN32) || defined(__CYGWIN__)
+#if defined(__CYGWIN__)
+if ((st.st_mode & S_IXUSR) == 0)
+#endif
 {	/* cannot trust the executable bit, peek into the file instead */
 	char buf[3] = { 0 };
 	int n;
-- 
1.7.3
