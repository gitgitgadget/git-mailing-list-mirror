From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Fix the exit code of MSVC build scripts on cygwin
Date: Thu, 08 Oct 2009 16:33:31 +0100
Message-ID: <4ACE064B.5020909@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: mstormo@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 19:13:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvwXy-0006tk-H8
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 19:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758985AbZJHRK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 13:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758976AbZJHRK0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 13:10:26 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:32920 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758967AbZJHRK0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2009 13:10:26 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1MvwUo-0004gs-kL; Thu, 08 Oct 2009 17:09:44 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129704>


During an MSVC build on cygwin, the make program did not notice
when the compiler or linker exited with an error. This was caused
by the scripts exiting with the value returned by system() directly.

On POSIX-like systems, such as cygwin, the return value of system()
has the exit code of the executed command encoded in the first byte
(ie the value is shifted up by 8 bits). This allows the bottom
7 bits to contain the signal number of a terminated process, while
the eighth bit indicates whether a core-dump was produced. (A value
of -1 indicates that the command failed to execute.)

The make program, however, expects the exit code to be encoded in the
bottom byte. Futhermore, it apparently masks off and ignores anything
in the upper bytes.

However, these scripts are (naturally) intended to be used on the
windows platform, where we can not assume POSIX-like semantics from
a perl implementation (eg ActiveState). So, in general, we can not
assume that shifting the return value right by eight will get us
the exit code.

In order to improve portability, we assume that a zero return from
system() indicates success, whereas anything else indicates failure.
Since we don't need to know the exact exit code from the compiler
or linker, we simply exit with 0 (success) or 1 (failure).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi *,

I have tried to be conservative with this patch and, although I can
confirm that it works great on cygwin, it should probably be tested
(and Acked) by someone with an MSYS/Mingw installation.
(or whatever Marius has installed :)

ATB,
Ramsay Jones

 compat/vcbuild/scripts/clink.pl |    4 +++-
 compat/vcbuild/scripts/lib.pl   |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index 0ffd59f..26aec61 100644
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -45,4 +45,6 @@ if ($is_linking) {
 	push(@args, @cflags);
 }
 #printf("**** @args\n");
-exit system(@args);
+system(@args) == 0
+	or exit 1;
+exit 0;
diff --git a/compat/vcbuild/scripts/lib.pl b/compat/vcbuild/scripts/lib.pl
index 68f6644..c11016d 100644
--- a/compat/vcbuild/scripts/lib.pl
+++ b/compat/vcbuild/scripts/lib.pl
@@ -23,4 +23,6 @@ while (@ARGV) {
 }
 unshift(@args, "lib.exe");
 # printf("**** @args\n");
-exit system(@args);
+system(@args) == 0
+	or exit 1;
+exit 0;
-- 
1.6.4
