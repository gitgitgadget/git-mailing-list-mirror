Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6CFE1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 18:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfG3SfM (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 14:35:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63042 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbfG3SfM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 14:35:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD835173E9D;
        Tue, 30 Jul 2019 14:35:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IV7sTgLMfsCEWg9tCNsCHhJNjTo=; b=MtAa0w
        wsrgPigpydV6XxCJB+GIPYEHhTRGQ1r2c18OrQspKpxKncde3MCdACtpJ0Ktac7i
        4RLPpPmxkfGSgOol9ybuhCozZwCbMgTnX+7GRi+wjGCXLj+aDMRN6RjT4CRWK9mJ
        FrWr10GSFbZU4JLw7PYSfjprcCm5ivn5D91+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wX2DbZ657KaxLqX4/Tkyl3UjS3T/N9tj
        /QHkVMLxRkWMId2ttcdmug+9d2FaFwNeC9ZEJzI3aaoj+p3yfab5NFY/x55gOo1S
        /aMAUotnlTtjjHOh/GWwoCim+gj98GiV5dbP1ySX2D531qTR3zXMj/n4m/gu0Wuo
        icqS+KUggxU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D50C2173E9C;
        Tue, 30 Jul 2019 14:35:06 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29369173E9B;
        Tue, 30 Jul 2019 14:35:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>, <git-packagers@googlegroups.com>
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
        <xmqq7e7zton5.fsf@gitster-ct.c.googlers.com>
        <04a401d54702$05624290$1026c7b0$@nexbridge.com>
Date:   Tue, 30 Jul 2019 11:35:04 -0700
In-Reply-To: <04a401d54702$05624290$1026c7b0$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 30 Jul 2019 14:10:02 -0400")
Message-ID: <xmqq36intlpj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0724320-B2F8-11E9-9CE4-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On July 30, 2019 1:32 PM, Junio C Hamano wrote:
>> 
>> I wonder if a tool like sparse can help us catch a pattern that feeds
> errno to
>> "%d" format.
>>  ...
> Seems reasonable. Better than trying to use strerror(), which previously
> (I'm not sure whether it was this project or another) had a similar mapping
> issue because the error text does not match either.

Yup, that was also us X-<.

Here is what I queued for now.

-- >8 --
Subject: [PATCH] test-dir-iterator: do not assume errno values

A few tests printed 'errno' as an integer and compared with
hardcoded integers; this is obviously not portable.

A two things to note are:

 - the string obtained by strerror() is not portable, and cannot be
   used for the purpose of these tests.

 - there unfortunately isn't a portable way to map error numbers to
   error names.

As we only care about a few selected errors, just map the error
number to the name before emitting for comparison.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/helper/test-dir-iterator.c | 11 ++++++++++-
 t/t0066-dir-iterator.sh      |  4 ++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index a5b96cb0dc..c7c30664da 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -4,6 +4,15 @@
 #include "iterator.h"
 #include "dir-iterator.h"
 
+static const char *error_name(int error_number)
+{
+	switch (error_number) {
+	case ENOENT: return "ENOENT";
+	case ENOTDIR: return "ENOTDIR";
+	default: return "ESOMETHINGELSE";
+	}
+}
+
 /*
  * usage:
  * tool-test dir-iterator [--follow-symlinks] [--pedantic] directory_path
@@ -31,7 +40,7 @@ int cmd__dir_iterator(int argc, const char **argv)
 	diter = dir_iterator_begin(path.buf, flags);
 
 	if (!diter) {
-		printf("dir_iterator_begin failure: %d\n", errno);
+		printf("dir_iterator_begin failure: %s\n", error_name(errno));
 		exit(EXIT_FAILURE);
 	}
 
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 9354d3f1ed..92910e4e6c 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -55,13 +55,13 @@ test_expect_success 'dir-iterator should list files in the correct order' '
 test_expect_success 'begin should fail upon inexistent paths' '
 	test_must_fail test-tool dir-iterator ./inexistent-path \
 		>actual-inexistent-path-output &&
-	echo "dir_iterator_begin failure: 2" >expected-inexistent-path-output &&
+	echo "dir_iterator_begin failure: ENOENT" >expected-inexistent-path-output &&
 	test_cmp expected-inexistent-path-output actual-inexistent-path-output
 '
 
 test_expect_success 'begin should fail upon non directory paths' '
 	test_must_fail test-tool dir-iterator ./dir/b >actual-non-dir-output &&
-	echo "dir_iterator_begin failure: 20" >expected-non-dir-output &&
+	echo "dir_iterator_begin failure: ENOTDIR" >expected-non-dir-output &&
 	test_cmp expected-non-dir-output actual-non-dir-output
 '
 
-- 
2.23.0-rc0-134-gc2d418fd54


