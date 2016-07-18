Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03E492018B
	for <e@80x24.org>; Mon, 18 Jul 2016 19:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbcGRTnc (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 15:43:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752009AbcGRTnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 15:43:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E3502D17D;
	Mon, 18 Jul 2016 15:43:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0RdBBgsZPki49auKQzPLeJbCE4o=; b=viAYM4
	LfOSGQnkKjriCTPnIhV6mPRR1SYF7WIlf0v3IZm5iwMAcy+f0PORPrDG8MZxsIoJ
	n8hZkGYDAG2XTqBp4uFxLyX83I5bBVSZQtsRK4cLEqRYzPrjYmbNyq8kED0SCa9Z
	IH75jsKt8XdTzfGfqIg5teOWHfQkexNIOu47w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NRJYROQOhw0qXN9xNXYzMGr798DWOOOj
	G/JvuBJPVWCh3zZXLPJhCelP/oAcohonCKx8Wh5SCCR9TAijZKpHKxTyBLdi238R
	JDc1JV30naclO+h0RmsWvtaWw5tfcXtzyAleUe3ooxRvZAtcZFyweGCYJ2aUvxXN
	34r0EiUqisI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DE882D17C;
	Mon, 18 Jul 2016 15:43:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06EEA2D17B;
	Mon, 18 Jul 2016 15:43:29 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Eric Wong <e@80x24.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: stricter unzip(1) check
References: <20160718064431.GA10819@starla>
	<20160718130405.GA19751@sigill.intra.peff.net>
Date:	Mon, 18 Jul 2016 12:43:27 -0700
In-Reply-To: <20160718130405.GA19751@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 18 Jul 2016 07:04:05 -0600")
Message-ID: <xmqqshv6ivfk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E73FB89E-4D1F-11E6-9C9A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> My Debian version of unzip (which is derived from Info-zip) seems to
> give return code 0 for just "unzip". So for the first check, we could
> possibly drop "-v"; we don't care about "-v", but just wanted some way
> to say "does unzip exist on the path?". Another option would just be
> checking whether "unzip" returns something besides 127 (so what we have
> now, minus "-v").
>
> To test for "-a", I think we'd have to actually feed it a sample zip
> file, though. My unzip returns "10", which its manpage explains as
> "invalid command line options" (presumably because of the missing
> zipfile argument). But that seems like it probably isn't portable.  And
> it's also what I might expect another unzip to return if it doesn't
> support "-a".
>
> So while this patch does solve the immediate problem, I think it does so
> by overly skipping tests that we _could_ run.

Hmm, how about taking Dscho's "default GIT_UNZIP to /usr/local/bin/unzip
on FreeBSD" thing, together with something like this, then?

I suspect that 4 checks that look at $extracted/* after running
unzip -a should probably be inside a single test that runs unzip -a,
simply because they do not make any sense if the extraction failed,
but I did not fix that with this.

-- >8 --
test: check "unzip" and "unzip -a"

Different platforms have implementations "unzip" that behave
differently.  Most of the tests we use GIT_UNZIP we only care about
the command to be able to extract from *.zip archive, but one test
in t5003 wants it to also be able to grok the "-a" option.

Prepare a sample zip file that has a single text file in it, and try
extracting its contents to see GIT_UNZIP is usable. when setting
UNZIP prerequisite.  Similarly, set UNZIP_AUTOTEXT prerequisite by
running GIT_UNZIP with the "-a" option.

---
 t/t5003-archive-zip.sh   |  19 ++++++++++++++-----
 t/t5003/infozip-text.zip | Bin 0 -> 163 bytes
 t/test-lib.sh            |   4 ++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 14744b2..43c0cfd 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -15,6 +15,15 @@ test_lazy_prereq UNZIP_SYMLINKS '
 	)
 '
 
+test_lazy_prereq UNZIP_AUTOTEXT '
+	(
+		mkdir unzip-autotext &&
+		cd unzip-autotext
+		"$GIT_UNZIP" -a "$TEST_DIRECTORY"/t5003/infozip-text.zip &&
+		test -f text
+	)
+'
+
 check_zip() {
 	zipfile=$1.zip
 	listfile=$1.lst
@@ -39,27 +48,27 @@ check_zip() {
 	extracted=${dir_with_prefix}a
 	original=a
 
-	test_expect_success UNZIP " extract ZIP archive with EOL conversion" '
+	test_expect_success UNZIP_AUTOTEXT " extract ZIP archive with EOL conversion" '
 		(mkdir $dir && cd $dir && "$GIT_UNZIP" -a ../$zipfile)
 	'
 
-	test_expect_success UNZIP " validate that text files are converted" "
+	test_expect_success UNZIP_AUTOTEXT " validate that text files are converted" "
 		test_cmp_bin $extracted/text.cr $extracted/text.crlf &&
 		test_cmp_bin $extracted/text.cr $extracted/text.lf
 	"
 
-	test_expect_success UNZIP " validate that binary files are unchanged" "
+	test_expect_success UNZIP_AUTOTEXT " validate that binary files are unchanged" "
 		test_cmp_bin $original/binary.cr   $extracted/binary.cr &&
 		test_cmp_bin $original/binary.crlf $extracted/binary.crlf &&
 		test_cmp_bin $original/binary.lf   $extracted/binary.lf
 	"
 
-	test_expect_success UNZIP " validate that diff files are converted" "
+	test_expect_success UNZIP_AUTOTEXT " validate that diff files are converted" "
 		test_cmp_bin $extracted/diff.cr $extracted/diff.crlf &&
 		test_cmp_bin $extracted/diff.cr $extracted/diff.lf
 	"
 
-	test_expect_success UNZIP " validate that -diff files are unchanged" "
+	test_expect_success UNZIP_AUTOTEXT " validate that -diff files are unchanged" "
 		test_cmp_bin $original/nodiff.cr   $extracted/nodiff.cr &&
 		test_cmp_bin $original/nodiff.crlf $extracted/nodiff.crlf &&
 		test_cmp_bin $original/nodiff.lf   $extracted/nodiff.lf
diff --git a/t/t5003/infozip-text.zip b/t/t5003/infozip-text.zip
new file mode 100644
index 0000000..a019acb
Binary files /dev/null and b/t/t5003/infozip-text.zip differ
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 11201e9..9907b3f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1102,8 +1102,8 @@ test_lazy_prereq SANITY '
 
 GIT_UNZIP=${GIT_UNZIP:-unzip}
 test_lazy_prereq UNZIP '
-	"$GIT_UNZIP" -v
-	test $? -ne 127
+	"$GIT_UNZIP" "$TEST_DIRECTORY/t5003/infozip-text.zip" &&
+	test -f text
 '
 
 run_with_limited_cmdline () {
