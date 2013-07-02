From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v8 4/5] pretty: Add failing tests: --format output should
 honor logOutputEncoding
Date: Tue, 02 Jul 2013 08:46:19 +0200
Message-ID: <51D2773B.9020006@viscovery.net>
References: <cover.1372719264.git.Alex.Crezoff@gmail.com> <f0307d1e6d5bebb0a90ff1c0ffe70f8ef32f78df.1372719264.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 08:46:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtuMD-0007qr-MU
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 08:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266Ab3GBGq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 02:46:29 -0400
Received: from so.liwest.at ([212.33.55.13]:26260 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932177Ab3GBGq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 02:46:28 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UtuLz-0006X6-On; Tue, 02 Jul 2013 08:46:20 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4F6CC1660F;
	Tue,  2 Jul 2013 08:46:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <f0307d1e6d5bebb0a90ff1c0ffe70f8ef32f78df.1372719264.git.Alex.Crezoff@gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229369>

Am 7/2/2013 1:19, schrieb Alexey Shumkin:
> +commit_msg() {
> +	# String "initial. initial" partly in German
> +   # (translated with Google Translate),
> +	# encoded in UTF-8, used as a commit log message below.
> +	msg=$(printf "initial. anf\303\244nglich")
> +	if test -n "$1"
> +	then
> +		msg=$(echo $msg | iconv -f utf-8 -t $1)
> +	fi
> +	if test -n "$2" -a -n "$3"
> +	then
> +		# cut string, replace cut part with two dots
> +		# $2 - chars count from the beginning of the string
> +		# $3 - "trailing" chars
> +		# LC_ALL is set to make `sed` interpret "." as a UTF-8 char not a byte
> +		# as it does with C locale
> +		msg=$(echo $msg | LC_ALL=en_US.UTF-8 sed -e "s/^\(.\{$2\}\)$3/\1../")
> +	fi
> +	echo $msg
> +}

Ignoring failure reports is not very helpful. Anyway, here is how I would
adjust this patch. (There are trivial conflicts when 5/5 is applied on
top.) Notice the comment I added in test case 'left alignment formatting
with ltrunc'.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>

To be squashed into v8 4/5:

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index a23da67..ef3a226 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -7,25 +7,13 @@
 test_description='Test pretty formats'
 . ./test-lib.sh
 
-commit_msg() {
-	# String "initial. initial" partly in German
-   # (translated with Google Translate),
-	# encoded in UTF-8, used as a commit log message below.
-	msg=$(printf "initial. anf\303\244nglich")
-	if test -n "$1"
-	then
-		msg=$(echo $msg | iconv -f utf-8 -t $1)
-	fi
-	if test -n "$2" -a -n "$3"
-	then
-		# cut string, replace cut part with two dots
-		# $2 - chars count from the beginning of the string
-		# $3 - "trailing" chars
-		# LC_ALL is set to make `sed` interpret "." as a UTF-8 char not a byte
-		# as it does with C locale
-		msg=$(echo $msg | LC_ALL=en_US.UTF-8 sed -e "s/^\(.\{$2\}\)$3/\1../")
-	fi
-	echo $msg
+# String "initial. initial" partly in German encoded in UTF-8
+initial_msg=$(printf "initial. anf\303\244nglich")
+
+# extract part of the initial commit message
+# $1 - a RE with \( \) brackets that specify which part to keep
+extract_msg() {
+	echo "$initial_msg" | sed -e "s/$1/\1/"
 }
 
 test_expect_success 'set up basic repos' '
@@ -33,12 +21,11 @@ test_expect_success 'set up basic repos' '
 	>bar &&
 	git add foo &&
 	test_tick &&
-	git config i18n.commitEncoding iso8859-1 &&
-	git commit -m "$(commit_msg iso8859-1)" &&
+	test_config i18n.commitEncoding iso8859-1 &&
+	git commit -m "$(echo "$initial_msg" | iconv -f utf-8 -t iso8859-1)" &&
 	git add bar &&
 	test_tick &&
-	git commit -m "add bar" &&
-	git config --unset i18n.commitEncoding
+	git commit -m "add bar"
 '
 
 test_expect_success 'alias builtin format' '
@@ -63,10 +50,9 @@ test_expect_success 'alias user-defined format' '
 '
 
 test_expect_success 'alias user-defined tformat with %s (iso8859-1 encoding)' '
-	git config i18n.logOutputEncoding iso8859-1 &&
+	test_config i18n.logOutputEncoding iso8859-1 &&
 	git log --oneline >expected-s &&
 	git log --pretty="tformat:%h %s" >actual-s &&
-	git config --unset i18n.logOutputEncoding &&
 	test_cmp expected-s actual-s
 '
 
@@ -110,13 +96,13 @@ test_expect_success 'alias loop' '
 '
 
 test_expect_failure 'NUL separation' '
-	printf "add bar\0$(commit_msg)" >expected &&
+	printf "add bar\0$initial_msg" >expected &&
 	git log -z --pretty="format:%s" >actual &&
 	test_cmp expected actual
 '
 
 test_expect_failure 'NUL termination' '
-	printf "add bar\0$(commit_msg)\0" >expected &&
+	printf "add bar\0$initial_msg\0" >expected &&
 	git log -z --pretty="tformat:%s" >actual &&
 	test_cmp expected actual
 '
@@ -124,7 +110,7 @@ test_expect_failure 'NUL termination' '
 test_expect_failure 'NUL separation with --stat' '
 	stat0_part=$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=$(git diff-tree --no-commit-id --stat --root HEAD^) &&
-	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n" >expected &&
+	printf "add bar\n$stat0_part\n\0$initial_msg\n$stat1_part\n" >expected &&
 	git log -z --stat --pretty="format:%s" >actual &&
 	test_i18ncmp expected actual
 '
@@ -132,7 +118,7 @@ test_expect_failure 'NUL separation with --stat' '
 test_expect_failure 'NUL termination with --stat' '
 	stat0_part=$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=$(git diff-tree --no-commit-id --stat --root HEAD^) &&
-	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n0" >expected &&
+	printf "add bar\n$stat0_part\n\0$initial_msg\n$stat1_part\n0" >expected &&
 	git log -z --stat --pretty="tformat:%s" >actual &&
 	test_i18ncmp expected actual
 '
@@ -154,7 +140,7 @@ test_expect_failure 'left alignment formatting' '
 message two                            Z
 message one                            Z
 add bar                                Z
-$(commit_msg)                    Z
+$initial_msg                    Z
 EOF
 	test_cmp expected actual
 '
@@ -167,7 +153,7 @@ test_expect_failure 'left alignment formatting at the nth column' '
 $head1 message two                    Z
 $head2 message one                    Z
 $head3 add bar                        Z
-$head4 $(commit_msg)            Z
+$head4 $initial_msg            Z
 EOF
 	test_cmp expected actual
 '
@@ -180,7 +166,7 @@ test_expect_failure 'left alignment formatting with no padding' '
 message two
 message one
 add bar
-$(commit_msg)
+$initial_msg
 EOF
 	test_cmp expected actual
 '
@@ -193,7 +179,7 @@ test_expect_failure 'left alignment formatting with trunc' '
 message ..
 message ..
 add bar  Z
-$(commit_msg "" "8" ".\+$")
+$(extract_msg "^\(........\).*")..
 EOF
 	test_cmp expected actual
 '
@@ -206,8 +192,10 @@ test_expect_failure 'left alignment formatting with ltrunc' '
 ..sage two
 ..sage one
 add bar  Z
-$(commit_msg "" "0" ".\{11\}")
+..$(extract_msg ".*\(.........\)$")
 EOF
+	# the RE above covers 9 bytes because there is one UTF-8 character
+	# where two bytes occupy only one character position
 	test_cmp expected actual
 '
 
@@ -219,7 +207,7 @@ test_expect_failure 'left alignment formatting with mtrunc' '
 mess.. two
 mess.. one
 add bar  Z
-$(commit_msg "" "4" ".\{11\}")
+$(extract_msg "^\(....\).*")..$(extract_msg ".*\(....\)$")
 EOF
 	test_cmp expected actual
 '
@@ -232,7 +220,7 @@ test_expect_failure 'right alignment formatting' '
 Z                            message two
 Z                            message one
 Z                                add bar
-Z                    $(commit_msg)
+Z                    $initial_msg
 EOF
 	test_cmp expected actual
 '
@@ -245,7 +233,7 @@ test_expect_failure 'right alignment formatting at the nth column' '
 $head1                      message two
 $head2                      message one
 $head3                          add bar
-$head4              $(commit_msg)
+$head4              $initial_msg
 EOF
 	test_cmp expected actual
 '
@@ -258,7 +246,7 @@ test_expect_failure 'right alignment formatting with no padding' '
 message two
 message one
 add bar
-$(commit_msg)
+$initial_msg
 EOF
 	test_cmp expected actual
 '
@@ -271,7 +259,7 @@ test_expect_failure 'center alignment formatting' '
 Z             message two              Z
 Z             message one              Z
 Z               add bar                Z
-Z         $(commit_msg)          Z
+Z         $initial_msg          Z
 EOF
 	test_cmp expected actual
 '
@@ -284,7 +272,7 @@ test_expect_failure 'center alignment formatting at the nth column' '
 $head1           message two          Z
 $head2           message one          Z
 $head3             add bar            Z
-$head4       $(commit_msg)      Z
+$head4       $initial_msg      Z
 EOF
 	test_cmp expected actual
 '
@@ -297,7 +285,7 @@ test_expect_failure 'center alignment formatting with no padding' '
 message two
 message one
 add bar
-$(commit_msg)
+$initial_msg
 EOF
 	test_cmp expected actual
 '
@@ -311,7 +299,7 @@ test_expect_failure 'left/right alignment formatting with stealing' '
 short long  long long
 message ..   A U Thor
 add bar      A U Thor
-$(commit_msg "" "8" ".\+$")   A U Thor
+$(extract_msg "^\(........\).*")..   A U Thor
 EOF
 	test_cmp expected actual
 '
