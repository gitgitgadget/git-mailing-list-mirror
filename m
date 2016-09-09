Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8D031F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 16:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753240AbcIIQIP (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 12:08:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62966 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752605AbcIIQIO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 12:08:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF2043969A;
        Fri,  9 Sep 2016 12:08:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/O+DchXelTk3z198ar0SJE1MOsc=; b=FI4uc9
        xrG8trNtaErxNZj+SXEuP1Hnl80qPZb1wrhEhiNkL17DoLyRweh1INCNDVmA3lLy
        3Oye+i4o7p3qVeDlAMwr7WJDcStlbci4if50NxlotXGfzUQ3xeDVdPPJFDyJSxwJ
        7cSApp12jIcvQVRacz5J7eFdCFMalNtDUGu68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g0hN0330FLa0gVDaejDIQakh5hF2IHeu
        EwEXJ5ed3G2K69SCC1vxJLjlRR0DSTBZt0nwXl54k30XD8V+T6JteCif01pZh9O4
        AKcPAJkq+BSK1k38iVgZrpdah+vab2lcjqQHYA0GuMx3XC0Mz9UixeLqcPQ+fzI9
        DYZ/iu+lFrc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B701B39698;
        Fri,  9 Sep 2016 12:08:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B6EC39696;
        Fri,  9 Sep 2016 12:08:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] cat-file: introduce the --filters option
References: <cover.1472041389.git.johannes.schindelin@gmx.de>
        <cover.1473415827.git.johannes.schindelin@gmx.de>
        <084088ba86c0af3636d960276c0bfdf7f5d2cfde.1473415827.git.johannes.schindelin@gmx.de>
        <xmqqfup9ds9p.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609091800020.129229@virtualbox>
Date:   Fri, 09 Sep 2016 09:08:10 -0700
In-Reply-To: <alpine.DEB.2.20.1609091800020.129229@virtualbox> (Johannes
        Schindelin's message of "Fri, 9 Sep 2016 18:01:21 +0200 (CEST)")
Message-ID: <xmqqbmzxdpjp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B8143B2-76A7-11E6-99D3-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +	if (type != OBJ_BLOB) {
>> > +		free(*buf);
>> > +		return error(_("blob expected for %s '%s'"),
>> > +			sha1_to_hex(sha1), path);
>> > +	}
>> > +	if (S_ISREG(mode)) {
>> > +		struct strbuf strbuf = STRBUF_INIT;
>> > +		if (convert_to_working_tree(path, *buf, *size, &strbuf)) {
>> > +			free(*buf);
>> > +			*size = strbuf.len;
>> > +			*buf = strbuf_detach(&strbuf, NULL);
>> > +		}
>> > +	}
>> 
>> This needs to error out when mode is not ISREG just like it errors
>> out when type is not BLOB.
>
> Are you sure that this is desirable in batch mode?

I do not quite see a reason why we should not diagnose a bad input
that does not produce a filtered result.  In batch mode or not, it
diagnoses when the user feeds it a non-blob, and I think it should
do so for non-regular, too. Both are "you asked me to filter, but
you shouldn't have".



