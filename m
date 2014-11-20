From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] parse_color: support 24-bit RGB values
Date: Thu, 20 Nov 2014 11:44:26 -0800
Message-ID: <xmqqh9xt3bdx.fsf@gitster.dls.corp.google.com>
References: <20141120151418.GA23607@peff.net>
	<20141120152539.GE23680@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Baker <bakers@canbytel.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 20:44:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrXec-0007sZ-9I
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 20:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868AbaKTToa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 14:44:30 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756313AbaKTTo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 14:44:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8ED41E514;
	Thu, 20 Nov 2014 14:44:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mf6aTgj1DGphf4LYOafSGo0XOrw=; b=JEsT/w
	g6h2j+gE53brfd4AngbwLwCGWpni5KjHnuWocIDNxFDJ2u55A4uWLZlu2IDnng29
	SCzTN/rVAVyapcvsd49UNNi+Mhrfi6iJK5u8pFMz+z9kSHuqtkUzCFZbKsnOwlD0
	FTSH28R2Hf2OXBMGF3tbH6Obh7pFfgj+3FX/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ycClZosVKf95L9p6yQYkrKb0aiEqVBAm
	hilReVULZA51xY+4NBfIxUTAOjjwlAjzWT3xYSE6/aiy10aI40O+iZQOU9fY2cqy
	+uLkwezzqXtrG8mbgs+yHkl38ZJXnrzzphmUy9ZaH9jpdUyOPG2iR4E/7ocQ1oed
	EsEeitvFGbM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DDC651E513;
	Thu, 20 Nov 2014 14:44:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4466B1E511;
	Thu, 20 Nov 2014 14:44:28 -0500 (EST)
In-Reply-To: <20141120152539.GE23680@peff.net> (Jeff King's message of "Thu,
	20 Nov 2014 10:25:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A3A3146A-70ED-11E4-8ECC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Some terminals (like XTerm) allow full 24-bit RGB color
> specifications using an extension to the regular ANSI color
> scheme. Let's allow users to specify hex RGB colors,
> enabling the all-important feature of hot pink ref
> decorations:
>
>   git log --format="%h%C(#ff69b4)%d%C(reset) %s"
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Also no clue on which terminals support it. I did all of my testing on
> a recent version of XTerm. It looks like it doesn't provide true 24-bit
> support, though. It is happy to accept the 24-bit colors, but if you do:
>
>   for b in $(seq 255); do
>     h=$(printf %02x $b)
>     git --no-pager log -1 --format="%C(#0000$h)$b%C(reset)"
>   done
>
> the gradient seems to "jump" in discrete steps. That's fine, though.
> It's a quality-of-implementation issue for the terminal, and I still
> think that the RGB spec is way more readable than the 256-color mode
> ones.
>
>  Documentation/config.txt |  3 ++-
>  color.c                  | 29 ++++++++++++++++++++++++++++-
>  color.h                  |  6 +++---
>  t/t4026-color.sh         |  4 ++++
>  4 files changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f615a5c..a237b82 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -842,7 +842,8 @@ doesn't matter.
>  +
>  Colors (foreground and background) may also be given as numbers between
>  0 and 255; these use ANSI 256-color mode (but note that not all
> -terminals may support this).
> +terminals may support this).  If your terminal supports it, you may also
> +specify 24-bit RGB values as hex, like `#ff0ab3`.
>  
>  color.diff::
>  	Whether to use ANSI escape sequences to add color to patches.
> diff --git a/color.c b/color.c
> index 6edbcae..78cdbed 100644
> --- a/color.c
> +++ b/color.c
> @@ -32,10 +32,13 @@ struct color {
>  		COLOR_UNSPECIFIED = 0,
>  		COLOR_NORMAL,
>  		COLOR_ANSI, /* basic 0-7 ANSI colors */
> -		COLOR_256
> +		COLOR_256,
> +		COLOR_RGB
>  	} state;
>  	/* The numeric value for ANSI and 256-color modes */
>  	unsigned char value;
> +	/* 24-bit RGB color values */
> +	unsigned char red, green, blue;

Do value and rgb have to be both valid at the same time, or is this
"we are not wasting a byte by not using a union because it will be
in the padding of the outer struct anyway"?

Not a satirical and/or rhetorical question.
