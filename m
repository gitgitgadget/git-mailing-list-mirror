Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09DC1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 20:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbcGTUKv (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 16:10:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753404AbcGTUKq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 16:10:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20E282D04C;
	Wed, 20 Jul 2016 16:10:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5NDdeqCC0FjprHiIr7TOWlG9qmA=; b=KhUesm
	KrSPLTXorMrOkgXUOFD+Qk4a7i7eOMF2TQkwMSGKWRq7ACAaMuMV34oZOuK6do1G
	80WeIgB0xeLOC4WhB8n4kqsXqudFIBhfdX0GSQM3zSuqFPR8z9SBlDSWfxRK0nSa
	ydhWfh7dvND3nKwW+dUOuGanAZNmbfpV/0poA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PDhkXyJII2BaUP4Arlnk1gJbmx+GyIOu
	0raY+J2OfGh9W/9Fw4Pd35EypBcyJ9FTY3UZ5zTy8vcbW0x6JB7RfBXEoNFhapMv
	E1KDdrGS71NyMuASOO5ULOL5pE49/zToLgtskX7z/zHiEb7OV2HJZwG3jA11Tr86
	3X22yJPIsw4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 17D9D2D049;
	Wed, 20 Jul 2016 16:10:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8893E2D046;
	Wed, 20 Jul 2016 16:10:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Richard Soderberg <rsoderberg@gmail.com>, git@vger.kernel.org
Subject: Re: git-prompt.sh incompatible with non-basic global grep.patternType
References: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
	<20160720134211.GA19359@sigill.intra.peff.net>
Importance: high
Date:	Wed, 20 Jul 2016 13:10:42 -0700
In-Reply-To: <20160720134211.GA19359@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 20 Jul 2016 07:42:12 -0600")
Message-ID: <xmqqwpkgcbp9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A549222-4EB6-11E6-9168-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 18, 2016 at 03:56:09PM -0700, Richard Soderberg wrote:
>
>> ps. git log --basic-regexp does not fix the issue, as for unknown
>> reasons (I'll start another thread) the command-line option doesn't
>> override grep.patternType.
>
> Dscho gave a fix for your immediate issue, but this "ps" definitely
> seems like a bug to me. Command-line options should always take
> precedence over config.

This may fix it.  I think the root cause is that logic to smear
"pattern type" into various broken-down fields in grep_opt for the
short-hands like --basic-regexp option needs to leave "I am setting
this short-hand" mark to allow the grep_commit_pattern_type() that
is done as the final step of the set-up sequence before we call
compile_grep_patterns() can take notice.  The calls currently made
to grep_set_pattern_type_option() when we parse "--basic-regexp" and
friends forgets to override the "source of truth" field and only
updates the broken-down fields.

An alternative may be to update places that parse "--basic-regexp"
and friends to just write to .pattern_type_option without calling
grep_set_pattern_type_option(); that might be a cleaner, but I am
not feeling well today so I won't be able to do a deeper analysis
right now.

 grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/grep.c b/grep.c
index 394c856..908ed3d 100644
--- a/grep.c
+++ b/grep.c
@@ -203,6 +203,7 @@ void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct gr
 		opt->regflags &= ~REG_EXTENDED;
 		break;
 	}
+	opt->pattern_type_option = pattern_type;
 }
 
 static struct grep_pat *create_grep_pat(const char *pat, size_t patlen,

