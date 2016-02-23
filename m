From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t8005: avoid grep on non-ASCII data
Date: Tue, 23 Feb 2016 15:01:43 -0800
Message-ID: <xmqqegc3xc88.fsf@gitster.mtv.corp.google.com>
References: <20160219193310.GA1299@sigill.intra.peff.net>
	<cover.1456075680.git.john@keeping.me.uk>
	<81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
	<CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
	<20160221231913.GA4094@sigill.intra.peff.net>
	<20160221234135.GA14382@river.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Feb 24 00:01:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYLxl-0004ZC-Mz
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 00:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbcBWXBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 18:01:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753816AbcBWXBp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 18:01:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13D3348205;
	Tue, 23 Feb 2016 18:01:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MkbULUpOr33vB7dCrIfu0rdur7s=; b=Zb5aFK
	BaK2aMfNBuVss0shRbbCzSGXsCkw5SgJY4r9dmd3TZHs93kwRvoYoQBefW7+sqPL
	ANUm1wlKwcOpNm6+iEIut4HbNC1mOaqksVKzpgn8K7TkeqVIlj1SwHZZ7U4NILO9
	RxuSVwY6c3l2Pkqyn35DZNQDzb7+lh56l6P+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GwRTECSR8ILOMK6dH0HYILPhBfmW3ano
	nqc4d1Uje+PwmMAlY3LGWU3jGSDQKpCobbXQ0sDw4dsk4qRJC6Q1+VBMO2fcHKqc
	uKwGjemB4E9/xWH1JjtPdYOP7uX3ZBfZSOltbdMk6twD1ha6YEdZcYXKiVQ7LVoU
	FYYGuyANa2s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B71C48204;
	Tue, 23 Feb 2016 18:01:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7F40A48203;
	Tue, 23 Feb 2016 18:01:44 -0500 (EST)
In-Reply-To: <20160221234135.GA14382@river.lan> (John Keeping's message of
	"Sun, 21 Feb 2016 23:41:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 689B7BBA-DA81-11E5-B556-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287138>

John Keeping <john@keeping.me.uk> writes:

> My original sed version was:
>
> 	sed -ne "/^author /p" -e "/^summary /p"
>
> which I think will work on all platforms (we already use it in
> t0000-basic.sh) but then I decided to be too clever :-(
>
> I still think sed is simpler than introducing a new function to wrap a
> perl script.

Let's do this, before everybody forgets what we discussed.

-- >8 --
From: John Keeping <john@keeping.me.uk>
Date: Sun, 21 Feb 2016 17:32:21 +0000
Subject: [PATCH] t8005: avoid grep on non-ASCII data

GNU grep 2.23 detects the input used in this test as binary data so it
does not work for extracting lines from a file.  We could add the "-a"
option to force grep to treat the input as text, but not all
implementations support that.  Instead, use sed to extract the desired
lines since it will always treat its input as text.

While touching these lines, modernize the test style to avoid hiding the
exit status of "git blame" and remove a space following a redirection
operator.  Also swap the order of the expected and actual output
files given to test_cmp; we compare expect and actual to show how
actual output differs from what is expected.

Signed-off-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t8005-blame-i18n.sh | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index 847d098..75da219 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -33,11 +33,15 @@ author $SJIS_NAME
 summary $SJIS_MSG
 EOF
 
+filter_author_summary () {
+	sed -n -e '/^author /p' -e '/^summary /p' "$@"
+}
+
 test_expect_success !MINGW \
 	'blame respects i18n.commitencoding' '
-	git blame --incremental file | \
-		egrep "^(author|summary) " > actual &&
-	test_cmp actual expected
+	git blame --incremental file >output &&
+	filter_author_summary output >actual &&
+	test_cmp expected actual
 '
 
 cat >expected <<EOF
@@ -52,9 +56,9 @@ EOF
 test_expect_success !MINGW \
 	'blame respects i18n.logoutputencoding' '
 	git config i18n.logoutputencoding eucJP &&
-	git blame --incremental file | \
-		egrep "^(author|summary) " > actual &&
-	test_cmp actual expected
+	git blame --incremental file >output &&
+	filter_author_summary output >actual &&
+	test_cmp expected actual
 '
 
 cat >expected <<EOF
@@ -68,9 +72,9 @@ EOF
 
 test_expect_success !MINGW \
 	'blame respects --encoding=UTF-8' '
-	git blame --incremental --encoding=UTF-8 file | \
-		egrep "^(author|summary) " > actual &&
-	test_cmp actual expected
+	git blame --incremental --encoding=UTF-8 file >output &&
+	filter_author_summary output >actual &&
+	test_cmp expected actual
 '
 
 cat >expected <<EOF
@@ -84,9 +88,9 @@ EOF
 
 test_expect_success !MINGW \
 	'blame respects --encoding=none' '
-	git blame --incremental --encoding=none file | \
-		egrep "^(author|summary) " > actual &&
-	test_cmp actual expected
+	git blame --incremental --encoding=none file >output &&
+	filter_author_summary output >actual &&
+	test_cmp expected actual
 '
 
 test_done
-- 
2.7.2-532-g79873b4
