Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2946BC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 17:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350648AbiCORoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239523AbiCORoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 13:44:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E3F22B3D
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 10:43:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26F04185B93;
        Tue, 15 Mar 2022 13:43:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zTIIANIn5wj0JQXB2XmnOaOG6f70KxsnknrYQv
        CD7Zk=; b=Cq78NVCiKO011UWEZlWkA/jFx3QRq11sQr8th2HYcxdgo1oe6DZae+
        FihzvARjF3DqFg3fBDncL2cgNYvlgdyOj/4T3RTumbp4ytdJhtXdor1CFlZg7ZYy
        qgXNx9DdcyrWeXsOVA2GZk0LxiZSxW5BJkiD2QezZYNENDZ+I4f1o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 209E5185B92;
        Tue, 15 Mar 2022 13:43:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9EC3F185B8E;
        Tue, 15 Mar 2022 13:43:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 2/4] terminal: don't assume stdin is /dev/tty
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
        <20220315105723.19398-1-phillip.wood123@gmail.com>
        <20220315105723.19398-3-phillip.wood123@gmail.com>
Date:   Tue, 15 Mar 2022 10:42:59 -0700
In-Reply-To: <20220315105723.19398-3-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Tue, 15 Mar 2022 10:57:21 +0000")
Message-ID: <xmqqzglrdsd8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BA41D00-A487-11EC-867A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> diff --git a/compat/terminal.c b/compat/terminal.c
> index da2f788137..bfbde3c1af 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -23,21 +23,28 @@ static void restore_term_on_signal(int sig)
>  static int term_fd = -1;

The variable can be -1 to signal "no valid file descriptor".

>  static struct termios old_term;
>  
> +static void close_term_fd(void)
> +{
> +	if (term_fd)
> +		close(term_fd);
> +	term_fd = -1;
> +}
> +

And we use that negative value after closing it.

The check before closing it is wrong.  It should be

	if (0 <= term_fd)

instead.  Or we could mimick the beginning of restore_term(), i.e.

	if (term_fd < 0)
		return;
	close(term_fd);
	term_fd = -1;

>  void restore_term(void)
>  {
>  	if (term_fd < 0)
>  		return;
>  
>  	tcsetattr(term_fd, TCSAFLUSH, &old_term);
> -	close(term_fd);
> -	term_fd = -1;
> +	close_term_fd();

Because we come this far only when term_fd is valid, this change is
a no-op.  If we are adding more calls to close_term_fd(), it may be
a good abstraction.

>  	sigchain_pop_common();
>  }
>  
>  int save_term(enum save_term_flags flags)
>  {
>  	if (term_fd < 0)
> -		term_fd = open("/dev/tty", O_RDWR);
> +		term_fd = (flags & SAVE_TERM_STDIN) ? 0
> +						    : open("/dev/tty", O_RDWR);

We can avoid overly long line by wrapping differently:

		term_fd = ((flags & SAVE_TERM_STDIN)
			   ? 0
			   : open("/dev/tty", O_RDWR));

We can turn our head sideways to see the parse tree this way.

> @@ -66,8 +73,7 @@ static int disable_bits(enum save_term_flags flags, tcflag_t bits)
>  
>  	sigchain_pop_common();
>  error:
> -	close(term_fd);
> -	term_fd = -1;
> +	close_term_fd();

OK.

> @@ -362,7 +368,7 @@ int read_key_without_echo(struct strbuf *buf)
>  	static int warning_displayed;
>  	int ch;
>  
> -	if (warning_displayed || enable_non_canonical(0) < 0) {
> +	if (warning_displayed || enable_non_canonical(SAVE_TERM_STDIN) < 0) {
>  		if (!warning_displayed) {
>  			warning("reading single keystrokes not supported on "
>  				"this platform; reading line instead");

The validity of this change is harder to see with only what we have
in the patch, but the control flow is

   enable_non_canonical(bits)
   -> disable_bits(bits, ...)
      -> save_term(bits)

And we are passing SAVE_TERM_STDIN to say "reuse fd #0 and save the
terminal settings of it, instead of opening /dev/tty anew".

What happens if FD#0 is *not* connected to a tty, by the way?
tcgetattr() in save_term() would fail, without clearing term_fd
(i.e. term_fd is still 0 when save_term() returns a failure), and
goes to the error code path, where close_term_fd() is called.

Because we have the "if (term_fd)" bug in save_term(), this bug is
hidden, but I think save_term() upon seeing a failure from tcgetattr()
should clear term_fd to limit the damage, especially when it is trying
to futz with caller supplied FD#0, not the tty it opened itself?

> diff --git a/compat/terminal.h b/compat/terminal.h
> index aeb24c9478..79ed00cf61 100644
> --- a/compat/terminal.h
> +++ b/compat/terminal.h
> @@ -4,6 +4,8 @@
>  enum save_term_flags {
>  	/* Save input and output settings */
>  	SAVE_TERM_DUPLEX = 1 << 0,
> +	/* Save stdin rather than /dev/tty (fails if stdin is not a terminal) */
> +	SAVE_TERM_STDIN  = 1 << 1,
>  };
>  
>  /*
