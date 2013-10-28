From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Avoid difference in tr semantics between System V and BSD
Date: Mon, 28 Oct 2013 09:13:53 +0000
Message-ID: <1382951633-6456-1-git-send-email-bdwalton@gmail.com>
References: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com>
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 28 10:14:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vaits-0003gi-JW
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 10:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab3J1JOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 05:14:12 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:49914 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab3J1JOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 05:14:12 -0400
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:36093 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1Vaitn-0007yy-Be ; Mon, 28 Oct 2013 05:14:11 -0400
Received: from 86-42-140-29-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.140.29]:40845 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1Vaitk-0004DN-H6 ; Mon, 28 Oct 2013 05:14:08 -0400
Received: from bwalton by neilyoung with local (Exim 4.80)
	(envelope-from <bwalton@benandwen.net>)
	id 1Vaiti-0001gf-3p; Mon, 28 Oct 2013 09:14:06 +0000
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236825>

Solaris' tr (both /usr/bin/ and /usr/xpg4/bin) uses the System V
semantics for tr whereby string1's length is truncated to the length
of string2 if string2 is shorter. The BSD semantics, as used by GNU tr
see string2 padded to the length of string1 using the final character
in string2. POSIX explicitly doesn't specify the correct behavior
here, making both equally valid.

This difference means that Solaris' native tr implementations produce
different results for tr ":\t\n" "\0" than GNU tr. This breaks a few
tests in t0008-ignores.sh.

Possible fixes for this are to make string2 be "\0\0\0" or "[\0*]".

Instead, use perl to perform these transliterations which means we
don't need to worry about the difference at all. Since we're replacing
tr with perl, we also use perl to replace the sed invocations used to
transform the files.

Replace four identical transforms with a function named
broken_c_unquote. Replace the other two identical transforms with a
fuction named broken_c_unquote_verbose.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 t/t0008-ignores.sh | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 181513a..4ebda99 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -37,6 +37,14 @@ test_stderr () {
 	test_cmp "$HOME/expected-stderr" "$HOME/stderr"
 }
 
+broken_c_unquote () {
+	perl -pe 's/^"//; s/\\//; s/"$//; tr/\n/\0/' "$@"
+}
+
+broken_c_unquote_verbose () {
+	perl -pe 's/	"/	/; s/\\//; s/"$//; tr/:\t\n/\0/' "$@"
+}
+
 stderr_contains () {
 	regexp="$1"
 	if grep "$regexp" "$HOME/stderr"
@@ -606,12 +614,11 @@ cat <<-EOF >expected-verbose
 	$global_excludes:2:!globaltwo	b/globaltwo
 EOF
 
-sed -e 's/^"//' -e 's/\\//' -e 's/"$//' stdin | \
-	tr "\n" "\0" >stdin0
-sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
-	tr "\n" "\0" >expected-default0
-sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' expected-verbose | \
-	tr ":\t\n" "\0" >expected-verbose0
+broken_c_unquote stdin >stdin0
+
+broken_c_unquote expected-default >expected-default0
+
+broken_c_unquote_verbose expected-verbose >expected-verbose0
 
 test_expect_success '--stdin' '
 	expect_from_stdin <expected-default &&
@@ -692,12 +699,11 @@ EOF
 grep -v '^::	' expected-all >expected-verbose
 sed -e 's/.*	//' expected-verbose >expected-default
 
-sed -e 's/^"//' -e 's/\\//' -e 's/"$//' stdin | \
-	tr "\n" "\0" >stdin0
-sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
-	tr "\n" "\0" >expected-default0
-sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' expected-verbose | \
-	tr ":\t\n" "\0" >expected-verbose0
+broken_c_unquote stdin >stdin0
+
+broken_c_unquote expected-default >expected-default0
+
+broken_c_unquote_verbose expected-verbose >expected-verbose0
 
 test_expect_success '--stdin from subdirectory' '
 	expect_from_stdin <expected-default &&
-- 
1.8.1.2
