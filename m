From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Test failures in t4034
Date: Tue, 21 Aug 2012 19:37:39 +0100
Message-ID: <5033D573.9030103@ramsay1.demon.co.uk>
References: <80B6C6EE-130C-48C3-BBBB-5FCD1E7EFDEF@gernhardtsoftware.com> <5030FD49.6060704@ramsay1.demon.co.uk> <7vboi6nzym.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 21:07:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3tnJ-0002jx-Ih
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 21:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756205Ab2HUTHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 15:07:09 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:46476 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048Ab2HUTHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 15:07:07 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 414ABA640D5;
	Tue, 21 Aug 2012 20:07:05 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id B901CA640C9;	Tue, 21 Aug 2012 20:07:03 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;	Tue, 21 Aug 2012 20:07:02 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vboi6nzym.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203984>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> I had the same problem (or at least it *looks* like the same problem) on Linux
>> last year (May 2011), which turned out to be a bug in the regex routines in an
>> old version of glibc. 
>>
>> I don't know OS X at all, so this may not be relevent; does OS X use glibc?
>> (I didn't think so, but ...)
>>
>> I sent some patches to the list which may be helpful. I can't get to gmane to
>> look up a reference, but you need to search for:
>>
>>     [RFC/PATCH] userdiff.c: Avoid old glibc regex bug causing t4034-*.sh test failures
>>
>> sent on 3rd May 2011.
> 
> Thanks; that's $gmane/172676 for people who prefer easier to read
> threading interface.
> 
>> Also, in the same thread, a reply to Jonathan Nieder on 7th May contains a
>> test which checks whether your regex routines suffer this bug.
>>
>> These patches were not applied since I didn't think this would be a common
>> problem. I simply set NO_REGEX=1 in my config.mak, since the compat/ regex
>> routines don't suffer from this problem.
> 
> You also said:
> 
>   This is an RFC because:
>    - A simple fix would be for me to put NO_REGEX=1 in my config.mak,
>      since the compat/regex routines don't suffer this problem.
>    - I suspect this bug is old enough that it will not affect many users.
>    - I have not audited the other non-matching list expressions in
>      userdiff.c
>    - blame, grep and pickaxe all call regcomp() with the REG_NEWLINE
>      flag, but get the regex from the user (eg from command line).
> 
> I think:
> 
>  - the second "this is old enough" assumption was broken again by
>    Brian this week ;-)
> 
>  - the first "Use NO_REGEX if your regexp library is broken" is a
>    reasonable thing to do; is this something we may want to throw
>    into the platform specific section of the top-level Makefile?
> 
>  - among the fourth, "blame" and "grep" goes line by line, and even
>    though pickaxe is primarily meant to take multi-line pattern, I
>    do not think people give multi-line pattern when they use it in
>    the regexp mode.  So I do not think they pose a real issue even
>    though they get an arbitrary pattern from the user.
> 
>  - the third, combined with the fact that end user can define their
>    own pattern, is a killer.  We cannot really afford to let broken
>    regex library to break us.
> 
> I think a sensible way to go in the longer term, while we wait these
> old regexp libraries die out, is to help people to avoid building
> git without NO_REGEX on platforms where they need it.

Agreed. Did you take a look at the second patch I mentioned above?
I've included a rebased version (onto v1.7.12) of that patch below.

NOTE: I have not even attempted to compile this version of the patch
and I can't remember how much testing I did last year, so this is
included *only* for discussion purposes ...

I think that, after some testing, this (or something like it) is the
best that we can do. What do you think?

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] test-regex: Add a test to check for a bug in the regex routines

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 .gitignore             |  1 +
 Makefile               |  1 +
 t/t0070-fundamental.sh |  5 +++++
 test-regex.c           | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)
 create mode 100644 test-regex.c

diff --git a/.gitignore b/.gitignore
index bb5c91e..68fe464 100644
--- a/.gitignore
+++ b/.gitignore
@@ -189,6 +189,7 @@
 /test-mktemp
 /test-parse-options
 /test-path-utils
+/test-regex
 /test-revision-walking
 /test-run-command
 /test-sha1
diff --git a/Makefile b/Makefile
index 6b0c961..3b760d3 100644
--- a/Makefile
+++ b/Makefile
@@ -496,6 +496,7 @@ TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
+TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
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
1.7.12
