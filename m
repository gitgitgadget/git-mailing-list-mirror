From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] rebase: accept indented comments (fixes regression)
Date: Wed, 30 Sep 2015 10:11:01 +0200
Message-ID: <1443600661-19391-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 30 10:23:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhCfK-0001hs-CH
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 10:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317AbbI3IXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 04:23:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50453 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754193AbbI3IW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 04:22:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8U8B8VO019888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 30 Sep 2015 10:11:08 +0200
Received: from estrop.imag.fr (estrop.imag.fr [129.88.7.56])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8U8B9jo003828;
	Wed, 30 Sep 2015 10:11:09 +0200
Received: from moy by estrop.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZhCTl-00054i-1K; Wed, 30 Sep 2015 10:11:09 +0200
X-Mailer: git-send-email 2.5.0.402.g8854c44
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 Sep 2015 10:11:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8U8B8VO019888
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1444205469.74728@RiayCed048+szZSTCK20EA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278841>

With Git <2.0.6, 'git rebase' used to accept lines starting with
whitespaces followed with '#' as a comment. This was broken by
804098b (git rebase -i: add static check for commands and SHA-1,
2015-06-29), which introduced additional checks on the TODO-list using
"git stripspaces" which only strips comments starting at the first
column.

Whether it's a good thing to accept indented comments is
debatable (other commands like "git commit" do not accept them), but we
already accepted them in the past, and some people and scripts rely on
this behavior. Also, a line starting with space followed by a '#' cannot
have any meaning other than being a comment, hence it doesn't harm to
accept them as comments.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I know you alluded to preprocess what is fed to stripspace, but I
>> wonder if we can remove the misguided call to stripspace in the
>> first place and do something like the attached instead.
>>
>>  git-rebase--interactive.sh | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index f01637b..a64f77a 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -886,7 +886,6 @@ check_commit_sha () {
>>  # from the todolist in stdin
>>  check_bad_cmd_and_sha () {
>>  	retval=0
>> -	git stripspace --strip-comments |
>>  	(
>>  		while read -r line
>>  		do
>> @@ -896,7 +895,7 @@ check_bad_cmd_and_sha () {
>>  			sha1=$2
>>  
>>  			case $command in
>> -			''|noop|x|"exec")
>> +			'#'*|''|noop|x|"exec")
>>  				# Doesn't expect a SHA-1
>>  				;;
>>  			pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
>
> Nah, that would not work, as I misread the "split only at SP" manual
> parsing of $line.

OK, let's go for the solution I seem to be able to get right even with
low cafeine ;-).

 git-rebase--interactive.sh    |  3 +++
 t/t3404-rebase-interactive.sh | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f01637b..55adf78 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -886,6 +886,9 @@ check_commit_sha () {
 # from the todolist in stdin
 check_bad_cmd_and_sha () {
 	retval=0
+	# git rebase -i accepts comments preceeded by spaces, while
+	# stripspace does not.
+	sed 's/^[[:space:]]*//' |
 	git stripspace --strip-comments |
 	(
 		while read -r line
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d26e3f5..ac5bac3 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1227,6 +1227,16 @@ test_expect_success 'static check of bad command' '
 	test C = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'indented comments are accepted' '
+	rebase_setup_and_clean indented-comment &&
+	write_script add-indent.sh <<-\EOF &&
+	printf "\n \t # comment\n" >>$1
+	EOF
+	test_set_editor "$(pwd)/add-indent.sh" &&
+	git rebase -i HEAD^ &&
+	test E = $(git cat-file commit HEAD | sed -ne \$p)
+'
+
 cat >expect <<EOF
 Warning: the SHA-1 is missing or isn't a commit in the following line:
  - edit XXXXXXX False commit
-- 
2.6.0.rc2.24.g231a9a1.dirty
