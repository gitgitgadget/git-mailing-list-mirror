Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DEEA1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 17:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbcIIRQp (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 13:16:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51766 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750938AbcIIRQo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 13:16:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4424C3B37E;
        Fri,  9 Sep 2016 13:16:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=spbqpJ1G5oyqJ/7qTdytdYoR5zE=; b=dRDJeO
        4r8d4ey4tEKRGwwuT63rxqszs47oczLNqfNZ62pIAkQmfEEXk3eYvS4E5j73L3yf
        JrzY84uucWPyCoVbYi9bOHaKbfA5n6Msvn8C6ne7V3KFB0VBx33lkPrRnW4//VSu
        +ta2PqDh4wgvRGfAIU+TV6cceHfrRC3+yCy3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nxjubp90BnGjw27D1Gw7f247x7CK9XpS
        ReJToLricxwXKKQa4HQN2F1f5v4j/Kd4l1EbVyIdmBfJ1B9z+gXy5v8NYzk/Db4l
        pWKwq83lsvwsUnezYb6KEp/jCIUMwgBpMpuzrbElObDvYwwGKejY/ORhO+StH6e4
        CVQql89fjLg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C9CF3B37B;
        Fri,  9 Sep 2016 13:16:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AED023B37A;
        Fri,  9 Sep 2016 13:16:42 -0400 (EDT)
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
        <xmqqbmzxdpjp.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 09 Sep 2016 10:16:40 -0700
In-Reply-To: <xmqqbmzxdpjp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 09 Sep 2016 09:08:10 -0700")
Message-ID: <xmqqvay5c7t3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D931E5C-76B1-11E6-8C89-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> > +	if (type != OBJ_BLOB) {
>>> > +		free(*buf);
>>> > +		return error(_("blob expected for %s '%s'"),
>>> > +			sha1_to_hex(sha1), path);
>>> > +	}
>>> > +	if (S_ISREG(mode)) {
>>> > +		struct strbuf strbuf = STRBUF_INIT;
>>> > +		if (convert_to_working_tree(path, *buf, *size, &strbuf)) {
>>> > +			free(*buf);
>>> > +			*size = strbuf.len;
>>> > +			*buf = strbuf_detach(&strbuf, NULL);
>>> > +		}
>>> > +	}
>>> 
>>> This needs to error out when mode is not ISREG just like it errors
>>> out when type is not BLOB.
>>
>> Are you sure that this is desirable in batch mode?
>
> I do not quite see a reason why we should not diagnose a bad input
> that does not produce a filtered result.  In batch mode or not, it
> diagnoses when the user feeds it a non-blob, and I think it should
> do so for non-regular, too. Both are "you asked me to filter, but
> you shouldn't have".

Stepping back a bit, I can also see a use case that would be helped
if this filter_object() function by default gives the contents of
the requested object as-is, unless the object is a regular blob with
a path for which filtering is defined.  Driving such a mechanism via
the batch interface will allow you to first ask about the top-level
tree object (given back to you as-is), and you can iterate over its
entries recursively and get the blobs to be placed in a new working
directory (i.e. "git archive" piped to "tar xf" but regular files
are passed thru convert_to_working_tree()).  In such an application,
after you learn the mode from the containing tree object and know
that RelNotes is a symbolic link blob, you still would want the
contents out of the pipe going to the same batch interface process
that is not filtered.

So I would not mind if we define the semantics of "--filters" as
such (as long as it is clearly documented, of course).  AFAICS, the
batch interface does not call filter_object() for non-blobs, and by
returning successfully without doing anything special for a symbolic
link from filter_object() automatically gives us the "by default
return as-is, but give processed output only for regular file blobs"
semantics to the batch mode.

But for a non-batch mode, it feels somewhat funny to be giving the
as-is output without saying anything to symbolic links; we can argue
that it is being consistent with what we do in the batch mode,
though.

Thanks.
