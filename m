Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6251FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 06:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbcIDGnK (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 02:43:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62975 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752163AbcIDGnI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 02:43:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF14732DD5;
        Sun,  4 Sep 2016 02:41:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NbTqHkiUrmDp6Ak5G398FqS4k30=; b=qIVWsL
        GT7N0Hxvwwwh/G6tLT1rpTa0FXW2c+NCOR+sCUwaADyii3H7ZtWS2kiUKqx25dZb
        CzL3QgctESM7DHSVYlJacX+kSQ+3nsdM9ejZmE5zvg/mGf1zHHVOrbcIzoRLY1r5
        Jc4ZT6CORIlm/8qLPA+6kaaIkPWVJ6f9CYllI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wPbsPAnNwJ0zk/ZHhjNXDL+6EusBdBDB
        W5BXse5Dtzdv7etpHJrcU+GnOERBYaNuF0O+pu36phhefDnlsONF1mlnf2eeOCiT
        bd7Q1223Pb7oBEC/nqHe21r9KFFK+WqOYVOlnUBvEbUeJISrrCx/WBSe6JuIAG/m
        a/CBT2+IAWo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C847532DD4;
        Sun,  4 Sep 2016 02:41:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4CB3A32DD3;
        Sun,  4 Sep 2016 02:41:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH 0/2] Color moved code differently
References: <20160903033120.20511-1-sbeller@google.com>
        <xmqqtwdxqxh6.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYGnkcOxviukj9a8gyaERip5aunXcvsdH-UpBCb=vrVeQ@mail.gmail.com>
Date:   Sat, 03 Sep 2016 23:41:47 -0700
In-Reply-To: <CAGZ79kYGnkcOxviukj9a8gyaERip5aunXcvsdH-UpBCb=vrVeQ@mail.gmail.com>
        (Stefan Beller's message of "Sat, 3 Sep 2016 22:23:35 -0700")
Message-ID: <xmqqpookqi8k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A812D186-726A-11E6-81A9-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>  * On 2/2, doing it at xdiff.c level may be limiting this good idea
>>    to flourish to its full potential, as the interface is fed only
>>    one diff_filepair at a time.
>
> I realized that after I implemented it. I agree we would want to have
> it function cross file.
>
> So from my current understanding of the code,
> * diffcore_std would call a new function diffcore_detect_moved(void)
>    just before diffcore_apply_filter is called.
> * The new function diffcore_detect_moved would then check if the
>    diff is a valid textual diff (i.e. real files, not submodules, but
>    deletion/creation of one file is allowed)
>    If so we generate the diff internally and as in 2/2 would
>    hash all added/removed lines with context and store it.

I do not think you should step outside diff_flush().  Only when
producing textual diff, you would have to run the textual diff
twice by going over the q twice:

 * The first pass would run diff_flush_patch(), which would call
   into xdiff the usual way, but the callback from xdiff would
   capture the removed lines and the added lines without making any
   output.

 * The second pass would run diff_flush_patch(), but the callback
   from xdiff would be called with additional information, namely,
   the removed and the added lines captured in the first pass.

 * I suspect that the fn_out_consume() function that is used for a
   normal case (i.e. when we are not doing this more expensive
   "moved to/moved from" coloring) can be used for the second pass
   above (i.e. the "priv" aka "ecbdata" may need to be extended so
   that it can tell which mode of operation it is asked to perform),
   but if there is not enough similarity between the second pass of
   this "moved from/moved to" mode and the normal mode of output, it
   is also OK to have two different callback functions, i.e. the
   original one to be used in the normal mode, the second one that
   knows the "these are moved without modification" coloring.  The
   callback for the first pass is sufficiently different and I think
   it is better to invent a new callback function to be used in the
   first pass, instead of reusing fn_out_consume().

   The fn_out_consume() function working in the "second pass of
   moved from/moved to mode" would inspect line[] and see if it is
   an added or a removed line, and then:

   - if it is an added line, and it appears as a removed line
     elsewhere in the patchset (you obtained the information in the
     first pass), you show it as "this was moved from elsewhere".

   - if it is a removed line, and it appears as an added line
     elsewhere in the patchset (you obtained the information in the
     first pass), you show it as "this was moved to elsewhere".

Or something like that.
