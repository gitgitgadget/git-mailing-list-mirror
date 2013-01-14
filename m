From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] convert some config callbacks to match_config_key
Date: Mon, 14 Jan 2013 08:55:28 -0800
Message-ID: <20130114165527.GB3121@elie.Belkin>
References: <20130114145845.GA16497@sigill.intra.peff.net>
 <20130114150322.GC16828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 14 17:55:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TunKE-0006or-Jm
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 17:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756970Ab3ANQze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 11:55:34 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:51375 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756876Ab3ANQzd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 11:55:33 -0500
Received: by mail-pb0-f53.google.com with SMTP id jt11so2252933pbb.40
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 08:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=yKuQB7L2rdT3upy+mvoR9lnkFYL7Ahy2xZDG6nSQ4dU=;
        b=a+78JLgPEDU9IC9EuL19GnKZC1wl9rsER6Ec+C1da/nbBVC8CI2WgkjLR1uGz+O+vs
         VJlmfWB4cNey8KFe4hhyZLFSff3lF28NzkCd0YCR25XjV9lsC52VW2SVzM7OUWBixgpd
         l8Y266975KTomCuW6ssDujl2VOK/hb/AJzYlAMm2ve9fB27nFHPg5bQm0qkeHpj1g1tv
         p2WZOBzONuNbDAJ+54mYhp57PBr9Vc8mYFE1UapSRJvdbmmaaFEm7Jk8xQodSAx+neCe
         0TrOcpCiHt1BIl3M7MNpn80L7lEuozfuPN4Ev8t/6lME62Eocx5ehZ4Smxat7fc0ziKY
         lR0g==
X-Received: by 10.66.76.37 with SMTP id h5mr233095819paw.33.1358182532974;
        Mon, 14 Jan 2013 08:55:32 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id bi8sm9048882pab.15.2013.01.14.08.55.30
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jan 2013 08:55:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130114150322.GC16828@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213500>

Jeff King wrote:

> --- a/convert.c
> +++ b/convert.c
> @@ -465,10 +465,8 @@ static int read_convert_config(const char *var, const char *value, void *cb)
>  	 * External conversion drivers are configured using
>  	 * "filter.<name>.variable".
>  	 */
> -	if (prefixcmp(var, "filter.") || (ep = strrchr(var, '.')) == var + 6)
> +	if (match_config_key(var, "filter", &name, &namelen, &ep) < 0 || !name)
>  		return 0;

Hm, I actually find the preimage more readable here.

I like the idea of having a function to do this, though.  Here are a
couple of ideas for making the meaning obvious again for people like
me:

Rename match_config_key() to something like parse_config_key()?
match_ makes it sound like its main purpose is to match it against a
pattern, but really it is more about decomposing into constituent
parts.

Rename ep to something like 'key' or 'filtertype'?  Without the
explicit string processing, it is not obvious what ep is the end of.

[...]
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -188,20 +188,13 @@ static struct userdiff_driver *parse_driver(const char *var,
>  		const char *value, const char *type)
>  {
>  	struct userdiff_driver *drv;
> -	const char *dot;
> -	const char *name;
> +	const char *name, *key;
>  	int namelen;
>  
> -	if (prefixcmp(var, "diff."))
> -		return NULL;
> -	dot = strrchr(var, '.');
> -	if (dot == var + 4)
> -		return NULL;
> -	if (strcmp(type, dot+1))
> +	if (match_config_key(var, "diff", &name, &namelen, &key) < 0 ||
> +	    strcmp(type, key))
>  		return NULL;
>  
> -	name = var + 5;
> -	namelen = dot - name;
>  	drv = userdiff_find_by_namelen(name, namelen);

What happens in the !name case?  (Honest question --- I haven't checked.)

Generally I like the cleanup.  Thanks for tasteful patch.

Jonathan
