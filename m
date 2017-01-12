Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012E91FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 20:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750808AbdALUSm (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 15:18:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51765 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750762AbdALUSi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 15:18:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11221607BF;
        Thu, 12 Jan 2017 15:18:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ds+9X0N/ix3WBi78/ijnspk1rJ8=; b=kfzmPv
        a7nsq9JlCLEd0uttHinzF31NHvankgHL25a95aI8F93cm4mmrZt1GU3wrGun0pBh
        GFWiNpquMhEme9SkMtvzSTbe6oZ9MxCkq+sNFjOLxHgJ1u99CySaRNJgNqv/xeZv
        sks832eiAwDVZjcIcUulIYn7hIYfNz8I3vlco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TRmo4tQuQhitanNWZAFpEMz9rtqHT3Ve
        nyXvbEhnEWM5Kidfyl8U1qgJci1JsUghzicCE3EtRp+ZNl6rM2mkhcQ9db3RTd/Y
        gEce75z2vGOj3AQ5kRem0xt3mD94MxGoiPdLMvlXCw9EniQKqn46w61XTO8WlF2K
        HH+U888eQZ0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 096D5607BE;
        Thu, 12 Jan 2017 15:18:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5AEC4607BD;
        Thu, 12 Jan 2017 15:18:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew Wilcox <mawilcox@linuxonhyperv.com>
Cc:     git@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] mailinfo: Understand forwarded patches
References: <1484212824-14108-1-git-send-email-mawilcox@linuxonhyperv.com>
        <1484212824-14108-2-git-send-email-mawilcox@linuxonhyperv.com>
Date:   Thu, 12 Jan 2017 12:18:32 -0800
In-Reply-To: <1484212824-14108-2-git-send-email-mawilcox@linuxonhyperv.com>
        (Matthew Wilcox's message of "Thu, 12 Jan 2017 01:20:24 -0800")
Message-ID: <xmqqfukojalj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B10ED0A-D904-11E6-92C9-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew Wilcox <mawilcox@linuxonhyperv.com> writes:

> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> Extend the --scissors mechanism to strip off the preamble created by
> forwarding a patch.  There are a couple of extra headers ("Sent" and
> "To") added by forwarding, but other than that, the --scissors option
> will now remove patches forwarded from Microsoft Outlook to a Linux
> email account.
>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  mailinfo.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

To be quite honest, I am not enthused to even having to think about
this kind of change.  There seems to be no standard way MUAs produce
"forwarded" messages, and this adds support for only one specific
MUA, that happens to say "Original Message".  Why should such a thing
hardcoded in this codepath?

I think I am OK with a patch that lets users customize
is_scissors_line(), perhaps accepting a regexp that ought to match a
line to consider a scissors line.  When such a regexp is given,
check for a match before doing the "do we have a line filled with
'-' with the scissors marker and is the mark long enough?" check.

Then you can do

	mailinfo --scissors='^-{5}Original Message-{5}$'

or something like that.  Perhaps allow multiple regexps, or even
allow them to come from a multi-valued configuration variable.

> diff --git a/mailinfo.c b/mailinfo.c
> index 2059704a8..fc1275532 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -332,7 +332,7 @@ static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
>  
>  #define MAX_HDR_PARSED 10
>  static const char *header[MAX_HDR_PARSED] = {
> -	"From","Subject","Date",
> +	"From","Subject","Date","Sent","To",
>  };

This array lists fields whose value we _care_ about.  Do not put
random garbage whose value we do not use in it.

Even though I am not enthused to see support for messages forwarded
by Outlook bolted onto this codepath, I think it may make sense to
allow random garbage that looks like an e-mail header to appear
immediately after a scissors line (and ignore them).  For that,
perhaps you would instead want to extend is_inbody_header() so that
after it decides that the given line is *NOT* one of the header
field we care about, return a value that is not 0 or 1.  Its caller
currently expects to see 1 if it is a relevant in-body header line,
or 0 if the line signals the end of the in-body header block.  You'd
be adding another class of lines that are not a header line with a
meaning but do not terminate the in-body header block.


>  static inline int cmp_header(const struct strbuf *line, const char *hdr)
> @@ -685,6 +685,13 @@ static int is_scissors_line(const char *line)
>  			c++;
>  			continue;
>  		}
> +		if (!memcmp(c, "Original Message", 16)) {
> +			in_perforation = 1;
> +			perforation += 16;
> +			scissors += 16;
> +			c += 15;
> +			continue;
> +		}
>  		in_perforation = 0;
>  	}
