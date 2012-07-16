From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Mon, 16 Jul 2012 18:39:51 +0200
Message-ID: <vpq7gu3wtgo.fsf@bauges.imag.fr>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
	<1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vtxxcc36v.fsf@alter.siamese.dyndns.org>
	<vpq1ukgai4e.fsf@bauges.imag.fr>
	<7vwr28agcq.fsf@alter.siamese.dyndns.org>
	<vpq1ukg82st.fsf@bauges.imag.fr>
	<20120713130021.GA2553@sigill.intra.peff.net>
	<vpqliin6bva.fsf@bauges.imag.fr> <87hatboiwr.fsf@thomas.inf.ethz.ch>
	<vpq1ukf68ow.fsf@bauges.imag.fr>
	<7vy5mn8v2k.fsf@alter.siamese.dyndns.org>
	<vpqmx3011la.fsf@bauges.imag.fr>
	<7vipdn4qbk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 18:43:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqoOG-0007q2-8N
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 18:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab2GPQnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 12:43:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41195 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab2GPQnP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 12:43:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6GGcHu6014507
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 18:38:17 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SqoKu-00085c-Qr; Mon, 16 Jul 2012 18:39:52 +0200
In-Reply-To: <7vipdn4qbk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 16 Jul 2012 09:35:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jul 2012 18:38:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GGcHu6014507
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343061500.94736@EFS+MBGhFZ26xtdt+Fyyqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201528>

Junio C Hamano <gitster@pobox.com> writes:

> I would think that it is plausible that the user wanted to write
> into XDG one and used "unset HOME" as a way to signal that wish. 

I didn't think of this case, but it makes sense.

Anyway, I don't really care either way, so I leave it up to you (either
your patch below, or the fixup in pu).

> -		if (user_config && access(user_config, R_OK) &&
> +		if (!user_config)
> +			/*
> +			 * We do not know HOME/.gitconfig exists or
> +			 * not, hence we do not know if we should
> +			 * write to XDG location, so we error out even
> +			 * if XDG_CONFIG_HOME is set and points at a
> +			 * sane location.
> +			 *
> +			 * In other words, we forbid the user from
> +			 * telling us to write to XDG location,
> +			 * pretending that $HOME/.gitconfig does not
> +			 * exist, by temporarily unsetting HOME.
> +			 */
> +			die("$HOME not set");
> +
> +		if (access(user_config, R_OK) &&
>  		    xdg_config && !access(xdg_config, R_OK))
>  			given_config_file = xdg_config;
> -		else if (user_config)
> -			given_config_file = user_config;
>  		else
> -			die("$HOME not set");
> +			given_config_file = user_config;

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
