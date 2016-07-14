Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490E120196
	for <e@80x24.org>; Thu, 14 Jul 2016 20:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbcGNUDl (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:03:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751160AbcGNUDj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:03:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C4A52A87F;
	Thu, 14 Jul 2016 16:03:38 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=paili13D/hnraYiDCLwkwJovugs=; b=uavFQj
	8CZ4NkWyfKdCTRE95P3tHwpf2fi1HDEi28Ew+h4T3Qy6n5VXxMNxpoZNexvGW8Aa
	dHATN/g3Bme5FIcUdpV1n1/IkZ4L2DHXpoA0f76n2L8+94I3BCQt9HmxAJs5jiti
	BpCwSqxYS9jhvrv8IsCPQ8DSHpAOwXw7sciN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m3XdONbvWB03g/1VYbAID3csgVHiDJ04
	QpXTifT7e8vmF7+pUfCBmyOd0df3oPj5ihHg7yuHgLS+cm2K5JqX6y6Hh5qE/1+4
	8H8RYJjfUYcSvsmnLPJDveQgkARHnhdiWdZLl/o+sBHypO+aT3998dnDvu26F53U
	zV5SHw2TWVg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42F8A2A87E;
	Thu, 14 Jul 2016 16:03:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AEAEE2A87D;
	Thu, 14 Jul 2016 16:03:37 -0400 (EDT)
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
	<xmqqshvcourb.fsf@gitster.mtv.corp.google.com>
Date:	Thu, 14 Jul 2016 13:03:35 -0700
In-Reply-To: <xmqqshvcourb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 14 Jul 2016 13:00:08 -0700")
Message-ID: <xmqqoa60oulk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D6EFEE6-49FE-11E6-9B0D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> OK, how about this on top of a replacement for js/t0006-for-v2.9.2
> that I'll send out as a reply to this message?

which is this one, which is largely from your $gmane/299310.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Mon, 11 Jul 2016 19:54:18 -0400
Subject: [PATCH] t0006: skip "far in the future" test when unsigned long is
 not long enough

Git's source code refers to timestamps as unsigned longs.  On 32-bit
platforms, as well as on Windows, unsigned long is not large enough
to capture dates that are "absurdly far in the future".

While we can fix this issue properly by replacing unsigned long with
a larger type, we want to be a bit more conservative and just skip
those tests on the maint track.

Signed-off-by: Jeff King <peff@peff.net>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 help.c          | 7 +++++++
 t/t0006-date.sh | 6 +++---
 t/test-lib.sh   | 9 +++++++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index 19328ea..0cea240 100644
--- a/help.c
+++ b/help.c
@@ -419,6 +419,13 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	 * with external projects that rely on the output of "git version".
 	 */
 	printf("git version %s\n", git_version_string);
+	while (*++argv) {
+		if (!strcmp(*argv, "--build-options")) {
+			printf("sizeof-unsigned-long: %d",
+			       (int)sizeof(unsigned long));
+			/* maybe also save and output GIT-BUILD_OPTIONS? */
+		}
+	}
 	return 0;
 }
 
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 04ce535..a0b8497 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -31,7 +31,7 @@ check_show () {
 	format=$1
 	time=$2
 	expect=$3
-	test_expect_${4:-success} "show date ($format:$time)" '
+	test_expect_success $4 "show date ($format:$time)" '
 		echo "$time -> $expect" >expect &&
 		test-date show:$format "$time" >actual &&
 		test_cmp expect actual
@@ -50,8 +50,8 @@ check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
 
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
-check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
-check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
+check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" 64BIT
+check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" 64BIT
 
 check_parse() {
 	echo "$1 -> $2" >expect
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0055ebb..211f1a8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1111,3 +1111,12 @@ run_with_limited_cmdline () {
 }
 
 test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
+
+build_option () {
+	git version --build-options |
+	sed -ne "s/^$1: //p"
+}
+
+test_lazy_prereq 64BIT '
+	test 8 -le "$(build_option sizeof-unsigned-long)"
+'
-- 
2.9.1-545-g8c0a069

