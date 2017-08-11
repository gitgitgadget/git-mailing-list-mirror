Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6836620899
	for <e@80x24.org>; Fri, 11 Aug 2017 22:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753905AbdHKWSO (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 18:18:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64104 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753861AbdHKWSM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 18:18:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD92E942DF;
        Fri, 11 Aug 2017 18:18:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+9ch1MU0ZxbgdYgKMkmPES2ZUoM=; b=nqa7Ct
        GPDHuRCpp0INDEghLIWS3JNb1Opv1PrzGMEt50W3PnP/RMg/PoTKTwNOt3oAZDqD
        5UL0y6JLcp4H+2bhacQE9DFB/QTJMuUTaJELaSbYuDB+ji9Tht1ecgkorQ+m3+k9
        jUw0IiO3tfCXyYYPA65ZQz9g3N9sKrnkhqx00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GmQyZHhZcbxHSHyCubEk3OBg+2+7M6NO
        h+E3o+Wgzy0qXeU/p6Lqal81o/t6/8MwUYUEzHJ2IbTGKBa4WMS+p6pNzPHJDInv
        Adr+FrJ2+YD9x/0pKikjRMTw0jo3cHFcKBwFKNgqJgtFWvyd7/U1gwpquTowqc+V
        KaJHPj+JN8w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D51D6942DE;
        Fri, 11 Aug 2017 18:18:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D146942DB;
        Fri, 11 Aug 2017 18:18:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v2 1/2] format-patch: have progress option while generating patches
References: <20170531150427.7820-1-kewillf@microsoft.com>
        <20170810183256.12668-2-kewillf@microsoft.com>
        <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net>
Date:   Fri, 11 Aug 2017 15:18:09 -0700
In-Reply-To: <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 10 Aug 2017 19:20:34 -0400")
Message-ID: <xmqqwp69ycim.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5F0EDE0-7EE2-11E7-B29F-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 10, 2017 at 02:32:55PM -0400, Kevin Willford wrote:
>
>> @@ -1493,6 +1496,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>>  		OPT_FILENAME(0, "signature-file", &signature_file,
>>  				N_("add a signature from a file")),
>>  		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
>> +		OPT_BOOL(0, "progress", &show_progress,
>> +			 N_("show progress while generating patches")),
>
> Earlier I suggested allowing --progress="custom text" since this may be
> driven as plumbing for other commands. But I don't think there's any
> need to worry about it now. It can be added seamlessly later if we find
> such a caller.
>
>> @@ -1752,8 +1757,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>>  		start_number--;
>>  	}
>>  	rev.add_signoff = do_signoff;
>> +
>> +	if (show_progress)
>> +		progress = start_progress_delay(_("Generating patches"), total, 0, 1);
>
> I don't really have an opinion on a 1 second delay versus 2. I thought
> we used 2 pretty consistently, though grepping around I do see a couple
> of 1's. It probably doesn't matter, but just a curiosity.

Yeah, I also thought 2-second was what we used by default.  Perhaps
we would want to bring others in line?
