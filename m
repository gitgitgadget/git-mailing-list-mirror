Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA88B2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 20:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbcGRUTa (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 16:19:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751601AbcGRUT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 16:19:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BD762D5A3;
	Mon, 18 Jul 2016 16:19:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WD8Gy7+ybnQTRZs7+H6iC5o+MZw=; b=QOGJ/y
	Ytshsj0wU5I5cFdGkOiGSzPwAHmdQi82lo0A0tTPgwFZmYq1fckFxoxF3G+M+f2g
	ltOsAPJFFsTN1NnvnVDxkYAqDu+p/Qcewi+CX2jch47FywYNd397VV6WQmWlUdo0
	i4acTlcULDJL2LTnXGoO82VHo9zV5XGCUQPfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B+Puo8MvE0tGFBNJhr7IZ8nTu44QC/Ig
	xE4CstqMTeEYogAZx2TrK0YqNd967le4J2G8DGoc0Qnd7j1hOzbVo4q4Ae1Dul3Z
	mJHQ5O0WHwlhHCKpQges4a2yRbjfQIlIL7EUTyr//kWEWLaBVqof+eSwLV1B4Ng4
	c9VO6x14QnE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 115772D5A2;
	Mon, 18 Jul 2016 16:19:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 834A12D5A0;
	Mon, 18 Jul 2016 16:19:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	Jeff King <peff@peff.net>, Ren?? Scharfe <l.s.r@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: stricter unzip(1) check
References: <20160718064431.GA10819@starla>
	<20160718130405.GA19751@sigill.intra.peff.net>
	<xmqqshv6ivfk.fsf@gitster.mtv.corp.google.com>
	<20160718200351.GA61232@plume>
Date:	Mon, 18 Jul 2016 13:19:24 -0700
In-Reply-To: <20160718200351.GA61232@plume> (Eric Wong's message of "Mon, 18
	Jul 2016 20:03:51 +0000")
Message-ID: <xmqqk2giitrn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECA0947A-4D24-11E6-A9EB-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> +test_lazy_prereq UNZIP_AUTOTEXT '
>> +	(
>> +		mkdir unzip-autotext &&
>> +		cd unzip-autotext
>> +		"$GIT_UNZIP" -a "$TEST_DIRECTORY"/t5003/infozip-text.zip &&
>> +		test -f text
>> +	)
>
> /usr/bin/unzip actually takes -a on FreeBSD, just not in the
> same way the Info-ZIP version does, so I suspect "test -f"
> here is not enough.

Hmph.  So it only and always does "CRLF -> LF", while Info-ZIP
version does something like autocrlf?

> I would test this, but I can't apply it:
>
>> diff --git a/t/t5003/infozip-text.zip b/t/t5003/infozip-text.zip
>> new file mode 100644
>> index 0000000..a019acb
>> Binary files /dev/null and b/t/t5003/infozip-text.zip differ

Heh.  It was created like so:

	$ printf 'text\r\n' >text && zip -ll infozip-text.zip text
	$ zipinfo infozip-text.zip text
        -rw-r-----  3.0 unx        5 tx stor 16-Jul-18 13:12 text

 t/t5003/infozip-text.zip | Bin 0 -> 163 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/t/t5003/infozip-text.zip b/t/t5003/infozip-text.zip
new file mode 100644
index 0000000000000000000000000000000000000000..7119bbb62699f4cb613f3675f57aa9c9dc021ea0
GIT binary patch
literal 163
zcmWIWW@h1H0D&2qpFGrWy)kD6vO$=IL586uwW1_6gp+~U-l8`ggi9;985mjSu4iOm
z=@4cB%X0;IGcw6B<1$17WHtjM5HDy1u^>jWLX1Q+F2I|W4Wxz<2)%%`Gl;_g0G&b|
AeE<Le

literal 0
HcmV?d00001

