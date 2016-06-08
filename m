From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/6] t9001: non order-sensitive file comparison
Date: Wed, 08 Jun 2016 10:17:08 -0700
Message-ID: <xmqqmvmvmwh7.fsf@gitster.mtv.corp.google.com>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160608130142.29879-1-samuel.groot@grenoble-inp.org>
	<20160608130142.29879-2-samuel.groot@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, e@80x24.org
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:17:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAh6U-0004Xt-K3
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 19:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593AbcFHRRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 13:17:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757549AbcFHRRN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 13:17:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DB8D1FD98;
	Wed,  8 Jun 2016 13:17:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FINEFUub0mgsrnUffSmxZUBB0q4=; b=MLPMGm
	G3RQhTRRqcc5zE7WAVxcBsjKT06/jLvfuIRxdiyyLUSDVpGnipTuSNYoZPANt7Is
	OnYcjsRGtwY/wumsuM/7Ic026L8Afkh6Mw4vx1DEJ/EbOUncbts9PJS+7TQ6X/yJ
	KNyPQd2AoSDi2Jyj6h97wc+04I6bpAWMdN0t0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dwdd3GHTBqKHHh9Fze4zZAMaiJDtxlR2
	vVPdZoZgbvZDwv0hj3kmrIO1RgKdQ9oumpSM21KSxiokbz5M8xc8Y0V+7oEuMQzc
	O3EApdnEp7Wvn3LNCbI4pTtERJfw5Yic3E5VhAIuvBg/VMnajxTfAMAr/4GjKlkE
	ne5XkAGiiik=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 435AB1FD97;
	Wed,  8 Jun 2016 13:17:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9DFC1FD93;
	Wed,  8 Jun 2016 13:17:10 -0400 (EDT)
In-Reply-To: <20160608130142.29879-2-samuel.groot@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 8 Jun 2016 15:01:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D5E94DFA-2D9C-11E6-A9CE-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296813>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> @@ -97,7 +104,7 @@ test_expect_success $PREREQ 'setup expect' '
>  '
>  
>  test_expect_success $PREREQ 'Verify commandline' '
> -	test_cmp expected commandline1
> +	test_cmp_noorder expected commandline1
>  '
>  
>  test_expect_success $PREREQ 'Send patches with --envelope-sender' '

By the way, don't you find it irritating to review this patch that
has three hunks, all of which look like the above?  You cannot
easily tell which 3 among 27 instances of test_cmp are modified,
because the hunks do not give useful context.

This is not at all your fault, but because the existing tests are
structured poorly.  It separates one logical step into three pieces
without a good reason.

Here is an illustration of an organization that I think would be
easier to read, and would result in a more readable patch when
modification is made on top.  The first two hunks collapse the
overall "setup" steps that appear as three separate tests into a
single "setup" test.  The last hunk that begin at -83/+79 collapses
a logically-single test that is split across three into one, and
makes the order of things done in the test to (1) set an
expectation, (2) execute the command and (3) compare the result with
the expectation.

I am not going to commit this myself, because I do not want to
create conflicts with the change your topic is trying to do, and
besides, almost all the remainder of the tests follow "one logical
test split into three" pattern and need to be corrected before this
"illustration" can become a real patch.

I do not mind if you take it and complete it as a preliminary
clean-up step in your series; or you can "keep it in mind, but
ignore it for now", in which case this can be a "low hanging fruit"
somebody else, hopefully somebody new to the development community,
can use to dip their toes ;-)



 t/t9001-send-email.sh | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index b3355d2..858bdbe 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -6,14 +6,16 @@ test_description='git send-email'
 # May be altered later in the test
 PREREQ="PERL"
 
-test_expect_success $PREREQ 'prepare reference tree' '
+clean_fake_sendmail () {
+	rm -f commandline* msgtxt*
+}
+
+test_expect_success $PREREQ 'setup' '
 	echo "1A quick brown fox jumps over the" >file &&
 	echo "lazy dog" >>file &&
 	git add file &&
-	GIT_AUTHOR_NAME="A" git commit -a -m "Initial."
-'
+	GIT_AUTHOR_NAME="A" git commit -a -m "Initial." &&
 
-test_expect_success $PREREQ 'Setup helper tool' '
 	write_script fake.sendmail <<-\EOF &&
 	shift
 	output=1
@@ -28,14 +30,8 @@ test_expect_success $PREREQ 'Setup helper tool' '
 	cat >"msgtxt$output"
 	EOF
 	git add fake.sendmail &&
-	GIT_AUTHOR_NAME="A" git commit -a -m "Second."
-'
-
-clean_fake_sendmail () {
-	rm -f commandline* msgtxt*
-}
+	GIT_AUTHOR_NAME="A" git commit -a -m "Second." &&
 
-test_expect_success $PREREQ 'Extract patches' '
 	patches=$(git format-patch -s --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1)
 '
 
@@ -83,20 +79,19 @@ test_expect_success $PREREQ 'No confirm with sendemail.confirm=never' '
 	check_no_confirm
 '
 
-test_expect_success $PREREQ 'Send patches' '
-	git send-email --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
-'
-
-test_expect_success $PREREQ 'setup expect' '
-	cat >expected <<-\EOF
+test_expect_success $PREREQ 'with --suppress-cc=sob --from and --to' '
+	cat >expected <<-\EOF &&
 	!nobody@example.com!
 	!author@example.com!
 	!one@example.com!
 	!two@example.com!
 	EOF
-'
 
-test_expect_success $PREREQ 'Verify commandline' '
+	git send-email --suppress-cc=sob \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" $patches 2>errors &&
+
 	test_cmp expected commandline1
 '
 
