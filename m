From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] make color.ui default to 'auto'
Date: Wed, 15 May 2013 09:09:22 -0700
Message-ID: <7vtxm4cjil.fsf@alter.siamese.dyndns.org>
References: <CALKQrgdVf_rfsLu1NnXGk+LCTV34T-4doJ+2yyi69ZER8vTAfg@mail.gmail.com>
	<1368624095-15738-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed May 15 18:09:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UceGf-0003oD-Sl
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 18:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758951Ab3EOQJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 12:09:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48532 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758844Ab3EOQJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 12:09:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A97FC1F1B4;
	Wed, 15 May 2013 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cxp5TQIet/0qW79wjAJZh0P1Zcc=; b=iLD7pT
	I/IxbMD2xC9EU3T9YnIwgA5z7Wooxt5HmM2gZejGhKEugXqBPSK+8AM+qBo7OZ7g
	0F8ipuhLOwxgtsECop2qJRFa8zaib6whv9deaFvm9S2m96pcTH3uAvel6KH+0Oks
	Xn3zYfD8lcD/2eo5ZXOMD+mWqHuo6DPenOOtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qqeY8P6oAIdUbhGQTqKiYxurxbSzrkfl
	TaI8brt6ouZwLnebe36dn8wGwkbX67Gpr9kelBCuKnOuNI63aYuK0eoYtPAS8QU2
	1uujMCOQy+ZVPVK9pz+1XZWj2x1PxCoi+mAJuGlNEju3L8l6orG2vpP03TpxbuqE
	jN3NgJFRvxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A11771F1B3;
	Wed, 15 May 2013 16:09:24 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FF3F1F1AD;
	Wed, 15 May 2013 16:09:23 +0000 (UTC)
In-Reply-To: <1368624095-15738-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Wed, 15 May 2013 15:21:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF46E110-BD79-11E2-938E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224420>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/builtin/config.c b/builtin/config.c
> index 000d27c..ecfceca 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -316,7 +316,7 @@ static void get_color(const char *def_color)
>  
>  static int get_colorbool_found;
>  static int get_diff_color_found;
> -static int get_color_ui_found;
> +static int get_color_ui_found = GIT_COLOR_AUTO;

It is curious to notice that we have these three and only one is
initialized to the new default value, while the other two get -1
at the beginning of get_colorbool().

I wonder if it would be cleaner to statically initialize all three
to -1 here, drop the assignment of -1 to two of them from the
beginning of get_colorbool(), and then have a final fallback inside
the want_color() call itself, i.e.

	get_colorbool_found = want_color(get_colorbool_found < 0
        				? GIT_COLOR_AUTO
                                        : get_colorbool_found);

so that it is clear that -1 consistently mean "We haven't read any
value from the configuration file for this variable", instead of
making get_color_ui_found mean slightly different thing (the value
read from the configuration; GIT_COLOR_AUTO means we cannot tell if
we saw this variable or the user specified auto) from the other two
(the value read from the configuration; -1 means we did not find
any).
