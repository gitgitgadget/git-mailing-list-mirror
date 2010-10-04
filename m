From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 1/3] Add bidirectional_transfer_loop()
Date: Mon, 4 Oct 2010 06:19:04 -0500
Message-ID: <20101004111904.GC4738@burratino>
References: <1286190258-12724-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1286190258-12724-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Oct 04 13:22:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2j7r-0005Kq-CW
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 13:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776Ab0JDLWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 07:22:22 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58090 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab0JDLWV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 07:22:21 -0400
Received: by qwh6 with SMTP id 6so3051753qwh.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 04:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=lAmlAfAx3xU7M8q2DCMrM9GoV2h9VwgzbytL8rTOT8A=;
        b=rEvbvNN7kCJUSsi2F0NKLn2WltBrWhm+yksoCSKrK7NRMxzS8sqO/pn9QxMnakkitm
         jYOz3NH+Pr5JawjU7R71DBy6C9tJUDCtSD4ErEZCpiplSxEj56Mg/K/KtQZktcwOUJcd
         Jd6u36ylJSKpW8g6XhFAOE+x4ixA5aqEq/szU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wEmScbwwo3GQ0Kk8b2xjkPo44pPzU8PuCStZTAfngQw2dJveYZ/3q/sKnjsteHWYsv
         VJ0X/6NNT2NU2TR1gYp/BgpLkSDICJgd1jbHKcVgeAt1QKp2azcUAQegD1Xi9jSmGKgE
         2kWkOy41DJ0+7kLeAfAWgg/u0OukbAuQYnKao=
Received: by 10.224.60.213 with SMTP id q21mr6686458qah.353.1286191340502;
        Mon, 04 Oct 2010 04:22:20 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t24sm5417167qcs.11.2010.10.04.04.22.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 04:22:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286190258-12724-2-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158031>

Ilari Liusvaara wrote:

> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -862,3 +862,327 @@ int transport_helper_init(struct transport *transport, const char *name)
[...]
> +/* Unidirectional transfer. */
> +struct unidirectional_transfer
> +{
> +	int src;
> +	int dest;
> +	int dest_is_sock;
> +	int state;
> +	char buf[BUFFERSIZE];
> +	size_t bufuse;
> +	const char *src_name;
> +	const char *dest_name;
> +};

Nice. :)

(I would have written

	int src;
	int dest
	unsigned dest_is_sock:1;
	enum unidirectional_transfer_state state;
	char buf[BUFFERSIZE];
	...

to make the types more obvious, but I think that's more of a matter of
style.)

[...]
> +/* State of bidirectional transfer loop. */
> +struct bidirectional_transfer_state
> +{
> +	struct pollfd polls[4];
> +	int polls_active;
> +	int stdin_index;
> +	int stdout_index;
> +	int input_index;
> +	int output_index;
> +	/* Direction from program to git. */
> +	struct unidirectional_transfer ptg;
> +	/* Direction from git to program. */
> +	struct unidirectional_transfer gtp;
> +};

Sensible.

> +int bidirectional_transfer_loop(int input, int output)
> +{
> +	struct bidirectional_transfer_state state;
> +
> +	/* Fill the state fields. */
> +	state.ptg.src = input;
> +	state.ptg.dest = 1;
> +	state.ptg.dest_is_sock = 0;
> +	state.ptg.state = SSTATE_TRANSFERING;
> +	state.ptg.bufuse = 0;
> +	state.ptg.src_name = "remote input";
> +	state.ptg.dest_name = "stdout";
> +
> +	state.gtp.src = 0;
> +	state.gtp.dest = output;
> +	state.gtp.dest_is_sock = (input == output);
> +	state.gtp.state = SSTATE_TRANSFERING;
> +	state.gtp.bufuse = 0;
> +	state.gtp.src_name = "stdin";
> +	state.gtp.dest_name = "remote output";
> +
> +	while (1) {
> +		int r;
> +		load_poll_params(&state);
> +		if (!state.polls_active) {
> +			transfer_debug("Transfer done");
> +			break;
> +		}
> +		transfer_debug("Waiting for %i file descriptors",
> +			state.polls_active);
> +		r = poll(state.polls, state.polls_active, -1);
> +		if (r < 0) {
> +			if (errno == EWOULDBLOCK || errno == EAGAIN ||
> +				errno == EINTR)
> +				continue;
> +			error("poll failed: %s", strerror(errno));
> +			return -1;
> +		} else if (r == 0)
> +			continue;
> +
> +		r = transfer_handle_events(&state);
> +		if (r)
> +			return r;
> +	}
> +	return 0;
> +}

Yes, that's much clearer.

Linux's scripts/checkpatch.pl would have a few things to say, but
I have no complaint myself except the density of comments (which is a
matter of taste).

Thanks!
