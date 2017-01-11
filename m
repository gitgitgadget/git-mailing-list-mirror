Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15B0E1F4F8
	for <e@80x24.org>; Wed, 11 Jan 2017 22:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750902AbdAKWL6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 17:11:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55226 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751866AbdAKWL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 17:11:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF8E7606EE;
        Wed, 11 Jan 2017 17:11:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dCuWNS3vvu5bj9QDDTSZY+EgVZU=; b=DqJoFx
        7m3rBL83td2J41fHSHK9Y+7zLv0bTkxCojO+CgbEzTtP6tTniy7UYaAaizL3XXCd
        ta+jI9F0zIBK/SvhTfGyli6hjW03eOsPA9a/EF+MteStEVfncs6DkLP/L115Hheb
        hiSAa8qeVtkuSbAkVUxFtcTtdZC5ICDreVMl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HcfNjt/X2Wk/NkwbNwN9+AayFRWxuNSF
        xosCLk/RzrnFoGl6IfnW//lkYnUNL/KLN61sy12/EZP07pGTZObHwK1z86ARa5pL
        CAoEZ9QsisFIPO++B28KaL32uj7drnS1E/TDG6kB5nQ8gVjGdHlfA7MwBC5E/XzO
        ORPHFE4Oa78=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6560606ED;
        Wed, 11 Jan 2017 17:11:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F394D606EC;
        Wed, 11 Jan 2017 17:11:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/2] vreportf: add prefix to each line
References: <20170111140138.5p647xuqpqrej63b@sigill.intra.peff.net>
        <20170111140758.yyfsc3r3spqpi6es@sigill.intra.peff.net>
Date:   Wed, 11 Jan 2017 14:11:42 -0800
In-Reply-To: <20170111140758.yyfsc3r3spqpi6es@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 11 Jan 2017 09:07:58 -0500")
Message-ID: <xmqqpojtmeld.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF9624D6-D84A-11E6-BB36-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 11, 2017 at 09:01:38AM -0500, Jeff King wrote:
>
>>   [1/2]: Revert "vreportf: avoid intermediate buffer"
>>   [2/2]: vreport: sanitize ASCII control chars
>
> We've talked before about repeating the "error:" header for multi-line
> messages. The reversion in patch 1 makes this easy to play with, so I
> did. I kind of hate it. But here it is, for your viewing pleasure.

Thanks.

>
> -- >8 --
> Subject: vreportf: add prefix to each line
>
> Some error and warning messages are multi-line, but we put
> the prefix only on the first line. This means that either
> the subsequent lines don't have any indication that they're
> connected to the original error, or the caller has to make
> multiple calls to error() or warning(). And that's not even
> possible for die().
>
> Instead, let's put the prefix at the start of each line,
> just as advise() does.
>
> Note that this patch doesn't update the tests yet, so it
> causes tons of failures. This is just to see what it might
> look like.
>
> It's actually kind of ugly.  For instance, a failing test in
> t3600 now produces:
>
>    error: the following files have staged content different from both the
>    error: file and the HEAD:
>    error:     bar.txt
>    error:     foo.txt
>    error: (use -f to force removal)
>
> which seems a bit aggressive.  

I agree that it is ugly, but one reason I was hoping to do this
myself (or have somebody else do it by procrastinating) was that I
thought it may help i18n.  That is, for an original

	error(_("we found an error"))

a .po file may translate the string to a multi-line string that has
LFs in it and the output would look correct.  The translator already
can do so by indenting the second and subsequent lines by the same
column-width as "error: " (or its translation in their language, if
we are going to i18n these headers), but that (1) is extra work for
them, and (2) makes it impossible to have the same message appear in
different contexts (i.e. "error:" vs "warning:" that have different
column-widths).

> It also screws up messages which indent with tabs (the prefix eats
> up some of the tabstop, making the indentation smaller).

This is unavoidable and at the same time is a non-issue, isn't it?
Messages that indent the second and subsequent lines with tabs are
compensating the lack of the multi-line support of vreportf(), which
this RFC patch fixes.  They may need to be adjusted to the new world
order, but that is a good thing.  New multi-line messages no longer
have to worry about the prefix that is added only to the first line
when continuing the message to multiple lines.

> And the result is
> a little harder if you need to cut-and-paste the file lines
> (if your terminal lets you triple-click to select a whole
> line, now you have this "error:" cruft on the front).

This might be an issue, but I personally do not care (as I know how
to drive my "screen", namely, use 'c' while cutting) ;-).

> It may be possible to address some of that by using some
> other kind of continuation marker (instead of just repeating
> the prefix), and expanding initial tabs.

Yes indeed.  The "some other kind of continuation marker" could just
be a run of spaces that fill the same column as the "error: " or
other prefix given to the first line.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  usage.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/usage.c b/usage.c
> index ad6d2910f..8a1f6ff4e 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -8,18 +8,30 @@
>  
>  static FILE *error_handle;
>  
> +static void show_line(FILE *fh, const char *prefix, const char *line, int len)
> +{
> +	fprintf(fh, "%s%.*s\n", prefix, len, line);
> +}
> +
>  void vreportf(const char *prefix, const char *err, va_list params)
>  {
>  	char msg[4096];
>  	FILE *fh = error_handle ? error_handle : stderr;
> +	const char *base;
>  	char *p;
>  
>  	vsnprintf(msg, sizeof(msg), err, params);
> +
> +	base = msg;
>  	for (p = msg; *p; p++) {
> -		if (iscntrl(*p) && *p != '\t' && *p != '\n')
> +		if (*p == '\n') {
> +			show_line(fh, prefix, base, p - base);
> +			base = p + 1;
> +		} else if (iscntrl(*p) && *p != '\t')
>  			*p = '?';
>  	}
> -	fprintf(fh, "%s%s\n", prefix, msg);
> +
> +	show_line(fh, prefix, base, p - base);
>  }
>  
>  static NORETURN void usage_builtin(const char *err, va_list params)
