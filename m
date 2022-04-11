Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB56C433EF
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 19:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbiDKTcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 15:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiDKTcI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 15:32:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A791020F4F
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 12:29:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BBE7116400;
        Mon, 11 Apr 2022 15:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ogX5oPi6nV3kp5vfSCymxRYXRIfE60vs2UIf11
        F4qVI=; b=Fq/4Av5VuIruQBg8u/rQsIuQdk1KagFKQ0co7utFHCRqt+ZbjE9TpX
        dMopCpnyJBuS3lPyE1iiUm1YmHnV+nY/8qBrKibGv5sxRuLZI1ryMgvasXhrLGE+
        ovUATDrpFSBqaWTtRwLHbNn2Svn9P4FoD3EAbP9IOIPGHk2u7PFY0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40EA41163FF;
        Mon, 11 Apr 2022 15:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DC3C1163F0;
        Mon, 11 Apr 2022 15:29:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julien Palard <julien@palard.fr>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?S=C3=A9bastien?= Helleu <flashcode@flashtux.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] Make a colon translatable
References: <-9xEw4skKJRhRp5v7WmxeS2n5xv-xmM0HWqmoiameagKhpiDOP9y3Yxj7WFy6M-jztxqug8DKopXIr_op09VlGPkUC7iG5V6xXjKh_SxHEg=@palard.fr>
Date:   Mon, 11 Apr 2022 12:29:50 -0700
In-Reply-To: <-9xEw4skKJRhRp5v7WmxeS2n5xv-xmM0HWqmoiameagKhpiDOP9y3Yxj7WFy6M-jztxqug8DKopXIr_op09VlGPkUC7iG5V6xXjKh_SxHEg=@palard.fr>
        (Julien Palard's message of "Mon, 11 Apr 2022 07:02:14 +0000")
Message-ID: <xmqq5ynfh101.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C20BFF12-B9CD-11EC-9BDE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julien Palard <julien@palard.fr> writes:

> In french we use a no-break space before colon, so with formatting
> like:
>
>     printf("... %s: ...", _("some string"))
>
> We can't cleanly add our no-break space, so I think:
>
>     printf("... %s ...", _("some string:"))

Sorry, but I do not quite buy this.  The above is a representative
example of what we call "sentence lego", which is what we absolutely
want to avoid, isn't it?

We'd rather want to see

	printf_like_function(_("Use 'git %s' ...", "string"));

when "string" is something that should not be translated to begin
with (e.g. "add" to form "git add"), and different languages can use
different conventions for quoting the command name (a translation
may want to use something other than single-quotes, for example).

And in a less optimal case,

	printf_like_function(_("%s: ...", _("string")));

would be needed, when "string" is something that is to be translated
(e.g. a phrase used as a label, like "Untracked files" in the code
this patch touches).  I think the case you have is the latter one.

> diff --git a/wt-status.c b/wt-status.c
> index d33f9272b7..ef0c276c3d 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -248,7 +248,7 @@ static void wt_longstatus_print_other_header(struct wt_status *s,
>  					     const char *how)
>  {
>  	const char *c = color(WT_STATUS_HEADER, s);
> -	status_printf_ln(s, c, "%s:", what);
> +	status_printf_ln(s, c, "%s", what);

I.e. this one is better handled by

	status_printf_ln(s, c, _("%s:"), what);

as _(...) in C-locale is original-language centric, where we want
the label to be <phrase> immediately followed by a colon.  And that
allows French translation to have nbsp before the colon.

>  	if (s->show_untracked_files) {
> -		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
> +		wt_longstatus_print_other(s, &s->untracked, _("Untracked files:"), "add");

Then this <phrase>, to be used in the label above, can be without colon.

>  		if (s->show_ignored_mode)
> -			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
> +			wt_longstatus_print_other(s, &s->ignored, _("Ignored files:"), "add -f");

Ditto.

Thanks.
