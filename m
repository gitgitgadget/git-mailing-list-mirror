Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47E1B20196
	for <e@80x24.org>; Thu, 14 Jul 2016 19:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbcGNTHV (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 15:07:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57425 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751388AbcGNTHT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 15:07:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B9312BFDE;
	Thu, 14 Jul 2016 15:07:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WQU0Xiqkb88S3xlBfuoL/SiXTMs=; b=NdxQ1f
	60zthMnIn9EIiRb5ojiXcI8uvDFKdRF4vBtSMtosTJShQn4zhWWG+jFMHjjkVliE
	YkzDwRbN9ILr68a/QLe6mBc88LdPMhXD/5bAjYbfbdohw5OIGlTkn71M7jAmPahO
	7xB/4PiDziJ8Ms2CzFyY6GpFy/l5slxi2PvbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iGAVLImsHCPxFBmj/yjhm1zifi9ZhU12
	PyoxQ5cZRfc9sLZAC80iPfVCCWjheLA0Oz9Sm3jk96xkUtAj+1q6cocX/xrFZ+Og
	eMDEul4p1bNpSx/CIbrUQTYhlrpp/4HsVe9Q/TMv4h8+bQ/NTa4wrdUwTVDwHqkn
	hZdONrkXIWc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 61C042BFDD;
	Thu, 14 Jul 2016 15:07:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB9162BFDB;
	Thu, 14 Jul 2016 15:07:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>, Eric Wong <e@80x24.org>,
	Jeff King <peff@peff.net>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving push options
References: <20160714173920.22001-1-sbeller@google.com>
	<20160714173920.22001-3-sbeller@google.com>
	<xmqqk2goqd4l.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZgJ_6fxZ19Hx6zd6KoTAd_+oMjb4fj1twY2ZGUHP7wHA@mail.gmail.com>
Date:	Thu, 14 Jul 2016 12:07:15 -0700
In-Reply-To: <CAGZ79kZgJ_6fxZ19Hx6zd6KoTAd_+oMjb4fj1twY2ZGUHP7wHA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 14 Jul 2016 12:00:48 -0700")
Message-ID: <xmqqfurcqbrw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EE7DED8-49F6-11E6-BC3D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>> +             lf = strchr(line, '\n');
>>> +             if (lf)
>>> +                     *lf = '\0';
>>
>> packet_read_line() -> packet_read_line_generic() calls packet_read()
>> with PACKET_READ_CHOMP_NEWLINE flag bit; do we need this check?
>
> This check was not about "option with lf at end\n", but rather we want to chop
> off "option\nover\nmultiple\nlines" ?

Ahh, I did misread the check.

> Although as you remarked in another email, this would not pose a problem for
> the shell variable, so we could also drop it to allow multi line
> options. will do.

One thing to note is that I do not think there is a guarantee that
packet_buf[] is NUL-terminated, and when len == LAGE_PACKET_MAX, you
do not have room to NUL-terminate it yourself.

string_list_append(ret, line) that assumes the "string" is NUL
terminated may become an issue that you need to solve by appending
the result of xmemdupz() into a non-duping string list.


