From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Update tests to use test-chmtime
Date: Sun, 25 Feb 2007 11:33:14 -0800
Message-ID: <7vps7yrq11.fsf@assigned-by-dhcp.cox.net>
References: <11723651923476-git-send-email-normalperson@yhbt.net>
	<11723651934078-git-send-email-normalperson@yhbt.net>
	<7vzm72vhl4.fsf@assigned-by-dhcp.cox.net>
	<20070225192329.GA13535@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 20:33:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLP7W-0006MF-M7
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 20:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbXBYTdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 14:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752402AbXBYTdQ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 14:33:16 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33515 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbXBYTdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 14:33:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225193315.QOLH2394.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 14:33:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TvZE1W0081kojtg0000000; Sun, 25 Feb 2007 14:33:14 -0500
In-Reply-To: <20070225192329.GA13535@localdomain> (Eric Wong's message of
	"Sun, 25 Feb 2007 11:23:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40569>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> ...
>> I would suggest changing "test-chmtime =-200 file" to set the
>> mtime of the file to 200 seconds in the past, relative to
>> present.
>> 
>> ---
>> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
>> index d5bb6ec..639d45f 100755
>
> Your patch looks good to me.

Thanks.  Here is the final version I'll push out in 'master'
shortly.

-- >8 --
From: Eric Wong <normalperson@yhbt.net>
Date: Sat, 24 Feb 2007 18:18:22 -0800
Subject: [PATCH] Add test-chmtime: a utility to change mtime on files

This is intended to be a portable replacement for our usage
of date(1), touch(1), and Perl one-liners in tests.

Usage: test-chtime (+|=|-|=+|=-)<seconds> <file>..."

  '+' increments the mtime on the files by <seconds>
  '-' decrements the mtime on the files by <seconds>
  '=' sets the mtime on the file to exactly <seconds>
  '=+' and '=-' sets the mtime on the file to <seconds> after or
      before the current time.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 .gitignore     |    1 +
 Makefile       |    5 +++-
 test-chmtime.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletions(-)
 create mode 100644 test-chmtime.c

diff --git a/.gitignore b/.gitignore
index f15155d..eb8a1f8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -139,6 +139,7 @@ git-whatchanged
 git-write-tree
 git-core-*/?*
 gitweb/gitweb.cgi
+test-chmtime
 test-date
 test-delta
 test-dump-cache-tree
diff --git a/Makefile b/Makefile
index e51b448..8a42be9 100644
--- a/Makefile
+++ b/Makefile
@@ -829,7 +829,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
 
 export NO_SVN_TESTS
 
-test: all
+test: all test-chmtime$X
 	$(MAKE) -C t/ all
 
 test-date$X: test-date.c date.o ctype.o
@@ -844,6 +844,9 @@ test-dump-cache-tree$X: dump-cache-tree.o $(GITLIBS)
 test-sha1$X: test-sha1.o $(GITLIBS)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
+test-chmtime$X: test-chmtime.c
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $<
+
 check-sha1:: test-sha1$X
 	./test-sha1.sh
 
diff --git a/test-chmtime.c b/test-chmtime.c
new file mode 100644
index 0000000..90da448
--- /dev/null
+++ b/test-chmtime.c
@@ -0,0 +1,61 @@
+#include "git-compat-util.h"
+#include <utime.h>
+
+static const char usage_str[] = "(+|=|=+|=-|-)<seconds> <file>...";
+
+int main(int argc, const char *argv[])
+{
+	int i;
+	int set_eq;
+	long int set_time;
+	char *test;
+	const char *timespec;
+
+	if (argc < 3)
+		goto usage;
+
+	timespec = argv[1];
+	set_eq = (*timespec == '=') ? 1 : 0;
+	if (set_eq) {
+		timespec++;
+		if (*timespec == '+') {
+			set_eq = 2; /* relative "in the future" */
+			timespec++;
+		}
+	}
+	set_time = strtol(timespec, &test, 10);
+	if (*test) {
+		fprintf(stderr, "Not a base-10 integer: %s\n", argv[1] + 1);
+		goto usage;
+	}
+	if ((set_eq && set_time < 0) || set_eq == 2) {
+		time_t now = time(NULL);
+		set_time += now;
+	}
+
+	for (i = 2; i < argc; i++) {
+		struct stat sb;
+		struct utimbuf utb;
+
+		if (stat(argv[i], &sb) < 0) {
+			fprintf(stderr, "Failed to stat %s: %s\n",
+			        argv[i], strerror(errno));
+			return -1;
+		}
+
+		utb.actime = sb.st_atime;
+		utb.modtime = set_eq ? set_time : sb.st_mtime + set_time;
+
+		if (utime(argv[i], &utb) < 0) {
+			fprintf(stderr, "Failed to modify time on %s: %s\n",
+			        argv[i], strerror(errno));
+			return -1;
+		}
+	}
+
+	return 0;
+
+usage:
+	fprintf(stderr, "Usage: %s %s\n", argv[0], usage_str);
+	return -1;
+}
-- 
1.5.0.1.791.g4c9a
