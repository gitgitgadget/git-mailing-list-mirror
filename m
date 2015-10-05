From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] Consolidate code to close a pack's file descriptor
Date: Mon, 05 Oct 2015 13:57:33 -0700
Message-ID: <xmqqio6lxcci.fsf@gitster.mtv.corp.google.com>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
	<cover.1444076827.git.johannes.schindelin@gmx.de>
	<a1f0d9339a9de95ba3f5eaaaf2e1a712629ad5d4.1444076827.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:57:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCpI-0005ni-3N
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbbJEU5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:57:36 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33472 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbJEU5f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:57:35 -0400
Received: by pacex6 with SMTP id ex6so187125529pac.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=MoFdYqmDPSGikDVZ6RoR3Ji3ThV7s6Kx8EP1B0/DdH0=;
        b=xDxHY3YxxR1gBR5g4HXDRiCYhkq4OURgB0tWz8+zkOEEsX2Bp9smMkg7VEyokEBLq1
         nLkUiY6NPtP8rp5jSNPBljJCdnrCfQTlxHLUGnjl1ZALiizJzkYTSWQ7stITSQmRxOv7
         0B+D2kgwjBoUBklsTPTnG4pKFGSdSaTSl6xZUkOrkPEeBvglPP3qNoKsGWFuwJ/pbguW
         3wptu3qKUgiaQReR2G0PBf6Pp7LorwdiRZroqP9ZugC+xP/PIbV4mHT8Lpv/5rAig1nZ
         pIk7BEEKWQuaYTh/fn0iWCB48dKrq4Pw6TWoUmO4z9R7RLNGDV114qEr7RumV8Ihz5uJ
         RJhQ==
X-Received: by 10.66.151.203 with SMTP id us11mr25681789pab.54.1444078654808;
        Mon, 05 Oct 2015 13:57:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:60e8:cc09:ddf4:4eed])
        by smtp.gmail.com with ESMTPSA id gj10sm29282259pbc.68.2015.10.05.13.57.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 13:57:34 -0700 (PDT)
In-Reply-To: <a1f0d9339a9de95ba3f5eaaaf2e1a712629ad5d4.1444076827.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 05 Oct 2015 22:30:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279093>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> There was a lot of repeated code to close the file descriptor of
> a given pack. Let's just refactor this code into a single function.

That is a very good idea, but...

> +static int close_pack_fd(struct packed_git *p)
> +{
> +	if (p->pack_fd < 0)
> +		return 0;

Is this "return 0" compatible with ...

> +	close(p->pack_fd);
> +	pack_open_fds--;
> +	p->pack_fd = -1;
> +
> +	return 1;
> +}
> +
>  /*
>   * The LRU pack is the one with the oldest MRU window, preferring packs
>   * with no used windows, or the oldest mtime if it has no windows allocated.
> @@ -853,12 +865,8 @@ static int close_one_pack(void)
>  		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
>  	}
>  
> -	if (lru_p) {
> -		close(lru_p->pack_fd);
> -		pack_open_fds--;
> -		lru_p->pack_fd = -1;
> -		return 1;
> -	}
> +	if (lru_p)
> +		return close_pack_fd(lru_p);

... what is returned from here?

It seems to me that it would be a bug if (p->pack_fd < 0) in this
codepath, so in practice nobody will receive a newly invented return
value 0 from this function, but it feels wrong.

>  	return 0;
>  }
> @@ -899,10 +907,7 @@ void free_pack_by_name(const char *pack_name)
>  		if (strcmp(pack_name, p->pack_name) == 0) {
>  			clear_delta_base_cache();
>  			close_pack_windows(p);
> -			if (p->pack_fd != -1) {
> -				close(p->pack_fd);
> -				pack_open_fds--;
> -			}
> +			close_pack_fd(p);

And here, the closer _must_ be (and it currently is) very aware that
the pack chosen may not be open anymore.  By giving a function that
conditionally closes if the pack is still open too bland a name,
that distinction is lost at these two call sites.

Also closing "fd" is not the only thing the new helper does, so in
that sense its name is suboptimal, too.

Perhaps a new helper function that is close_pack(), which is
unconditional, with another close_pack_if_open() around it?

>  			if (!win->offset && win->len == p->pack_size
> -				&& !p->do_not_close) {
> -				close(p->pack_fd);
> -				pack_open_fds--;
> -				p->pack_fd = -1;
> -			}
> +				&& !p->do_not_close)
> +				close_pack_fd(p);

I wonder how this do_not_close bit should interact with "we are
shutting down (or we are spawning another to do the real work, while
we won't do anything useful anymore), so close everything down".

I'd imagine we'll see the answer in the next patch ;-)
