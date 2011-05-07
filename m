From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] userdiff.c: Avoid old glibc regex bug causing t4034-*.sh
 test failures
Date: Sat, 07 May 2011 18:54:44 +0100
Message-ID: <4DC58764.2070207@ramsay1.demon.co.uk>
References: <4DC04021.1040606@ramsay1.demon.co.uk> <20110503210716.GL1019@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, trast@student.ethz.ch,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 07 19:56:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIlk3-0004kI-ES
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 19:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849Ab1EGR4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 13:56:30 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:36363 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752865Ab1EGR4a (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2011 13:56:30 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1QIljw-0004nC-Zo; Sat, 07 May 2011 17:56:29 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20110503210716.GL1019@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173057>

Jonathan Nieder wrote:
> Ramsay Jones wrote:
>> This is an RFC because:
>>     - A simple fix would be for me to put NO_REGEX=1 in my config.mak,
>>       since the compat/regex routines don't suffer this problem.
>>     - I suspect this bug is old enough that it will not affect many users.
>>     - I have not audited the other non-matching list expressions in
>>       userdiff.c
>>     - blame, grep and pickaxe all call regcomp() with the REG_NEWLINE
>>       flag, but get the regex from the user (eg from command line).
> 
> I think excluding \n along with ' ' and \t in similar places makes
> sense, ...

I briefly considered replacing ' \t' with [:space:], but that would
also add \v, \f and \r in addition to \n (and, maybe, some locale
specific chars too), so I decided not to go that route ...

>        ... but that meanwhile we should add tests to the testsuite for
> blame/grep/pickaxe to catch such implementations failing when
> NO_REGEX=1 is not set.

Hmm, well I would certainly never complain about additional tests, but
who would these tests benefit? I suspect that the number of people
building git from source on an old (pre about 2008 say) glibc system
with this bug is somewhat small. (Of course I have no numbers to back
up that gut feeling! :-))

Having said that, I have attached a patch (below), that adds a test
(to t0070-fundamental.sh) using a stand-alone test-regex program, in
order to simplify the detection of this bug.

What do you think? (would this exchange in the list-archive suffice?)

> Does that make sense?  Thanks for tracking this down.

No problem.

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] test-regex: Add a test to check for a bug in the regex routines


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 .gitignore             |    1 +
 Makefile               |    1 +
 t/t0070-fundamental.sh |    5 +++++
 test-regex.c           |   35 +++++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100644 test-regex.c

diff --git a/.gitignore b/.gitignore
index 711fce7..70af8b1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -174,6 +174,7 @@
 /test-obj-pool
 /test-parse-options
 /test-path-utils
+/test-regex
 /test-run-command
 /test-sha1
 /test-sigchain
diff --git a/Makefile b/Makefile
index 3a1fe20..482b9f9 100644
--- a/Makefile
+++ b/Makefile
@@ -428,6 +428,7 @@ TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-obj-pool
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
+TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 9bee8bf..da2c504 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -25,4 +25,9 @@ test_expect_success POSIXPERM 'mktemp to unwritable directory prints filename' '
 	grep "cannotwrite/test" err
 '
 
+test_expect_success 'check for a bug in the regex routines' '
+	# if this test fails, re-build git with NO_REGEX=1
+	test-regex
+'
+
 test_done
diff --git a/test-regex.c b/test-regex.c
new file mode 100644
index 0000000..9259985
--- /dev/null
+++ b/test-regex.c
@@ -0,0 +1,35 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <sys/types.h>
+#include <regex.h>
+
+static void die(const char *fmt, ...)
+{
+	va_list p;
+
+	va_start(p, fmt);
+	vfprintf(stderr, fmt, p);
+	va_end(p);
+	fputc('\n', stderr);
+	exit(128);
+}
+
+int main(int argc, char **argv)
+{
+	char *pat = "[^={} \t]+";
+	char *str = "={}\nfred";
+	regex_t r;
+	regmatch_t m[1];
+
+	if (regcomp(&r, pat, REG_EXTENDED | REG_NEWLINE))
+		die("failed regcomp() for pattern '%s'", pat);
+	if (regexec(&r, str, 1, m, 0))
+		die("no match of pattern '%s' to string '%s'", pat, str);
+
+	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3957  */
+	if (m[0].rm_so == 3) /* matches '\n' when it should not */
+		exit(1);
+
+	exit(0);
+}
-- 
1.7.5
