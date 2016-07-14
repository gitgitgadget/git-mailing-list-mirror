Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB21F20196
	for <e@80x24.org>; Thu, 14 Jul 2016 20:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbcGNUAQ (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:00:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751246AbcGNUAO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:00:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F3C932A700;
	Thu, 14 Jul 2016 16:00:11 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=55nqV7zw4QUfWM0mjZpE3Y9Gbqo=; b=EjSCCR
	x6BjEsJYIlqKbZKcWPwIBnxaB9EN/4bzEtP4h5/zwh6OSoU0GyDNbeEinAKuBHa4
	yEboNl6nWwDDNZaZ2HebgDHdi+JFhTsw4M06vg64v3HSSXUnE0Wn06pREz68k3UF
	mkZ9Wk9SWsc7eMKgZB4bCS/IBeMdP61OAX7p4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ln+ObgNK7fiXrSaEE+HSodVjD0gqYzFg
	RTTN4xEGfHv/9j0bxOs2DLPeju99Pb+IvMnx7HS4kl1t1Wew6UclsgSU+QytCEmu
	zls013Dhc4J1O5ihwXBO+JFtwFQRHxAhnLJhQJcQhgPj/7vYlwo8wfqVMIDJLTxb
	PqMhHJBkEqk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EBFEE2A6FE;
	Thu, 14 Jul 2016 16:00:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 776042A6FD;
	Thu, 14 Jul 2016 16:00:10 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
References: <20160630090614.GA16725@sigill.intra.peff.net>
	<20160630090857.GB17463@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607141745420.6426@virtualbox>
	<20160714182108.GB16497@sigill.intra.peff.net>
Date:	Thu, 14 Jul 2016 13:00:08 -0700
In-Reply-To: <20160714182108.GB16497@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Jul 2016 14:21:08 -0400")
Message-ID: <xmqqshvcourb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91EAEBFE-49FD-11E6-9142-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 14, 2016 at 05:47:41PM +0200, Johannes Schindelin wrote:
>
>> On Thu, 30 Jun 2016, Jeff King wrote:
>> 
>> > The ustar format only has room for 11 (or 12, depending on
>> > some implementations) octal digits for the size and mtime of
>> > each file. For values larger than this, we have to add pax
>> > extended headers to specify the real data, and git does not
>> > yet know how to do so.
>> >
>> > [...]
>> >  t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a | Bin 0 -> 2048 bytes
>> 
>> It appears that this blob cannot be read when sizeof(unsigned long) == 4.
>> This happens to break the t5000 test on Windows, where that comparison
>> holds true.
>> 
>> I am sure that I missed some other discussion about this issue... could
>> you point me to it?
>
> There's tons of discussion in:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/297409
>
> but frankly it is not worth your time to read it. These tests are about
> overflowing the tar limits, which can only happen with times and sizes
> greater than 32-bits. The right thing to do is to skip the tests
> entirely on systems where sizeof(unsigned long) is less than 8 (the
> actual value is 64GB+1, so technically a 37-bit system would work, but I
> think it is OK for the test-skipping to be less specific).

OK, how about this on top of a replacement for js/t0006-for-v2.9.2
that I'll send out as a reply to this message?




 archive-tar.c       |  5 +++++
 t/t5000-tar-tree.sh | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 7ea4e90..4d2832c 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -25,8 +25,13 @@ static int write_tar_filter_archive(const struct archiver *ar,
  *
  * Likewise for the mtime (which happens to use a buffer of the same size).
  */
+#if ULONG_MAX == 0x7FFFFFFF
+#define USTAR_MAX_SIZE ULONG_MAX
+#define USTAR_MAX_MTIME ULONG_MAX
+#else
 #define USTAR_MAX_SIZE 077777777777UL
 #define USTAR_MAX_MTIME 077777777777UL
+#endif
 
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 96d208d..9c97789 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -360,7 +360,7 @@ test_expect_success 'set up repository with huge blob' '
 
 # We expect git to die with SIGPIPE here (otherwise we
 # would generate the whole 64GB).
-test_expect_success 'generate tar with huge size' '
+test_expect_success 64BIT 'generate tar with huge size' '
 	{
 		git archive HEAD
 		echo $? >exit-code
@@ -369,13 +369,13 @@ test_expect_success 'generate tar with huge size' '
 	test_cmp expect exit-code
 '
 
-test_expect_success TAR_HUGE 'system tar can read our huge size' '
+test_expect_success TAR_HUGE,64BIT 'system tar can read our huge size' '
 	echo 68719476737 >expect &&
 	tar_info huge.tar | cut -d" " -f1 >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'set up repository with far-future commit' '
+test_expect_success 64BIT 'set up repository with far-future commit' '
 	rm -f .git/index &&
 	echo content >file &&
 	git add file &&
@@ -383,11 +383,11 @@ test_expect_success 'set up repository with far-future commit' '
 		git commit -m "tempori parendum"
 '
 
-test_expect_success 'generate tar with future mtime' '
+test_expect_success 64BIT 'generate tar with future mtime' '
 	git archive HEAD >future.tar
 '
 
-test_expect_success TAR_HUGE 'system tar can read our future mtime' '
+test_expect_success TAR_HUGE,64BIT 'system tar can read our future mtime' '
 	echo 4147 >expect &&
 	tar_info future.tar | cut -d" " -f2 >actual &&
 	test_cmp expect actual
