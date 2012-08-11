From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] help: correct behavior for is_executable on Windows
Date: Sat, 11 Aug 2012 09:00:30 +0200
Message-ID: <20120811070030.GA83665@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 09:02:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T05iA-00072t-7N
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 09:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606Ab2HKHCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 03:02:09 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:34515 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab2HKHCH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 03:02:07 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1T05gV-0003JJ-L3; Sat, 11 Aug 2012 09:00:31 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203281>

The previous implementation said that the filesystem information on
Windows is not reliable to determine whether a file is executable.
To find gather this information it was peeking into the first two bytes
of a file to see whether it looks executable.
Apart from the fact that on Windows executables are usually defined as
such by their extension it lead to slow opening of help file in some
situations.

When you have virus scanner running calling open on an executable file
is a potentially expensive operation. See the following measurements (in
seconds) for example.

With virus scanner running (coldcache):

$ ./a.exe /libexec/git-core/
before open (git-add.exe): 0.000000
after open (git-add.exe): 0.412873
before open (git-annotate.exe): 0.000175
after open (git-annotate.exe): 0.397925
before open (git-apply.exe): 0.000243
after open (git-apply.exe): 0.399996
before open (git-archive.exe): 0.000147
after open (git-archive.exe): 0.397783
before open (git-bisect--helper.exe): 0.000160
after open (git-bisect--helper.exe): 0.397700
before open (git-blame.exe): 0.000160
after open (git-blame.exe): 0.399136
...

With virus scanner running (hotcache):

$ ./a.exe /libexec/git-core/
before open (git-add.exe): 0.000000
after open (git-add.exe): 0.000325
before open (git-annotate.exe): 0.000229
after open (git-annotate.exe): 0.000177
before open (git-apply.exe): 0.000167
after open (git-apply.exe): 0.000150
before open (git-archive.exe): 0.000154
after open (git-archive.exe): 0.000156
before open (git-bisect--helper.exe): 0.000132
after open (git-bisect--helper.exe): 0.000180
before open (git-blame.exe): 0.000718
after open (git-blame.exe): 0.000724
...

This test did just list the given directory and open() each file in it.

With this patch I get:

$ time git help git
Launching default browser to display HTML ...

real    0m8.723s
user    0m0.000s
sys     0m0.000s

and without

$ time git help git
Launching default browser to display HTML ...

real    1m37.734s
user    0m0.000s
sys     0m0.031s

both tests with cold cache and giving the machine some time to settle
down after restart.

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
 help.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index 662349d..b41fa21 100644
--- a/help.c
+++ b/help.c
@@ -103,10 +103,19 @@ static int is_executable(const char *name)
 		return 0;
 
 #if defined(WIN32) || defined(__CYGWIN__)
+	/* On Windows we cannot use the executable bit. The executable
+	 * state is determined by extension only. We do this first
+	 * because with virus scanners opening an executeable for
+	 * reading is potentially expensive.
+	 */
+	if (has_extension(name, ".exe"))
+		return S_IXUSR;
+
 #if defined(__CYGWIN__)
 if ((st.st_mode & S_IXUSR) == 0)
 #endif
-{	/* cannot trust the executable bit, peek into the file instead */
+{	/* now that we know it does not have an executable extension,
+	   peek into the file instead */
 	char buf[3] = { 0 };
 	int n;
 	int fd = open(name, O_RDONLY);
@@ -114,8 +123,8 @@ if ((st.st_mode & S_IXUSR) == 0)
 	if (fd >= 0) {
 		n = read(fd, buf, 2);
 		if (n == 2)
-			/* DOS executables start with "MZ" */
-			if (!strcmp(buf, "#!") || !strcmp(buf, "MZ"))
+			/* look for a she-bang */
+			if (!strcmp(buf, "#!"))
 				st.st_mode |= S_IXUSR;
 		close(fd);
 	}
-- 
1.7.12.rc2.10.gaf2525e
