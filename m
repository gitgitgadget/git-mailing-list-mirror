Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822D41F597
	for <e@80x24.org>; Tue, 31 Jul 2018 10:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbeGaLmC (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 07:42:02 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:21039 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeGaLmC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 07:42:02 -0400
Received: from [192.168.2.240] ([92.22.0.63])
        by smtp.talktalk.net with SMTP
        id kRU3fkMZ5bZX5kRU4f0btH; Tue, 31 Jul 2018 11:02:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533031349;
        bh=BaZA5JJBeBvXb/W7ZBNXyLezTXZqGGo3OW/jyKtrjQs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KdDi8BcyXy7ahI5rXaDLlAKiS1NbazNQVdvu4tGoX3mL80PtgqGPY0rqY4SFHjyUe
         OHDZvwftJdMWTMKsOXuiRLCZTLiAijvRp+PX3q1dIVSdIt1u+S1USASl2aVvR3tDBW
         g4fOE6ZBH3Llhf8Mh4Pm1yt1LAAKwfGsmxOJPR38=
X-Originating-IP: [92.22.0.63]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=ohMtzhKkgcX7CUCE/LoB2A==:117
 a=ohMtzhKkgcX7CUCE/LoB2A==:17 a=IkcTkHD0fZMA:10 a=BCjA09oAAAAA:8
 a=SMEl95f983h6fXUsAA4A:9 a=QEXdDO2ut3YA:10 a=jYKBPJSq9nmHKCndOPe9:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] sequencer: don't die() on bogus user-edited
 timestamp
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@idaemons.org>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731073331.40007-5-sunshine@sunshineco.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <71924f65-1890-0460-55a1-987354807c7d@talktalk.net>
Date:   Tue, 31 Jul 2018 11:02:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731073331.40007-5-sunshine@sunshineco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHQ3TaGwOh1p8/s+gvmq2WpelgXuybBH/RNJkC42PpCHfd8jNTonx+FG3VR5Zwy/g82FNzSUGoXMFGXi2+1grAo5fhC6sLMi4ZzxnwIDGe/gxIVgzTIV
 Gl0D1scEd2cLBNBGYFFvzSkiqYq9kquoEsoFmjLqzHvftuWS6T6lsH9Uz6IsP/S22AcQxm4E4FMacal3HF2RCsfY9JZYMiSwsSZMjjMUGoGhX6lWhJjbhiot
 XC0g+3oKNBKuInRpi13u+gYpCej9jRcAnO0/ptK5g+C9XG48dpVUedxAz9GCgRyGRcaafgiF1v15lYnh3er+pg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/07/18 08:33, Eric Sunshine wrote:
> read_author_ident() is careful to handle errors "gently" when parsing
> "rebase-merge/author-script" by printing a suitable warning and
> returning NULL; it never die()'s. One possible reason that parsing might
> fail is that "rebase-merge/author-script" has been hand-edited in such a
> way which corrupts it or the information it contains.
> 
> However, read_author_ident() invokes fmt_ident() which is not so careful
> about failing "gently". It will die() if it encounters a malformed
> timestamp. Since read_author_ident() doesn't want to die() and since
> it's dealing with possibly hand-edited data, take care to avoid passing
> a bogus timestamp to fmt_ident().
> 
> A more "correctly engineered" fix would be to add a "gentle" version of
> fmt_ident(), however, such a change it outside the scope of the bug-fix
> series. If fmt_ident() ever does grow a "gentle" cousin, then the manual
> timestamp check added here can be retired.
> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>   sequencer.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 15a66a334c..9b6cdb6ff8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -742,6 +742,15 @@ static const char *read_author_ident(struct strbuf *buf)
>   		return NULL;
>   	}
>   
> +	/* validate date since fmt_ident() will die() on bad value */
> +	if (parse_date(val[2], &out)){
> +		warning(_("invalid date format '%s' in '%s'"),
> +			val[2], rebase_path_author_script());
> +		strbuf_release(&out);
> +		return NULL;
> +	}

I think if you're going to do this then the caller needs to be changed 
to treat NULL as an error

> +	strbuf_reset(&out);
>   	strbuf_addstr(&out, fmt_ident(val[0], val[1], val[2], 0));
>   	strbuf_swap(buf, &out);
>   	strbuf_release(&out);
> 

