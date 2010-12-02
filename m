From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/10] parse-options: clearer reporting of API misuse
Date: Wed, 1 Dec 2010 22:57:07 -0600
Message-ID: <20101202045707.GA32125@burratino>
References: <20101201232728.GA31815@burratino>
 <20101201232923.GC31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 05:57:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO1ET-0006gf-Op
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 05:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756982Ab0LBE5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 23:57:19 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61647 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756869Ab0LBE5S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 23:57:18 -0500
Received: by gyb11 with SMTP id 11so3888664gyb.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 20:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=k9wAP9EOOTOk00S+OnN+rinpXd2byvIhLdgu8QA8Dqs=;
        b=NFuQ9J5hP/rSdQZeJsoNp4YW2t48UKFbez0FxCXTdgd+lmVcOEKwhMZI5DceOqOdpN
         pRrnadhoUYPoPss/XKMQNjRZBhT5SCvRi1UmHIqvb2Sjn0flQ8+cawPrTkza2+lstVLD
         G+AKAOVLC28kcrUbbhFD2I3yj1u6j5qqeG0WY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lMvl9PWWKducFWhUo8/mK1BBX+3wHTSyCPRZcQ/Fp4OUkPU+l1HuvbloLiV3ZPIKhF
         Dtmu0tzlwngsQh9pUapLcRFCepEXjqMlQE7I6dj/65AIMzoE7vc7uxkW6W4CK6ZyHBWU
         Ot5+Z4gna3KczDRv3YQrvD3rmqDOo57MT0OnE=
Received: by 10.151.150.11 with SMTP id c11mr607679ybo.413.1291265837862;
        Wed, 01 Dec 2010 20:57:17 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id g25sm19163yhc.22.2010.12.01.20.57.16
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 20:57:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201232923.GC31815@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162666>

Jonathan Nieder wrote:

> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -316,24 +323,12 @@ static void check_typos(const char *arg, const struct option *options)
>  
>  static void parse_options_check(const struct option *opts)
>  {
> -	int err = 0;
> -
>  	for (; opts->type != OPTION_END; opts++) {
>  		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
> -		    (opts->flags & PARSE_OPT_OPTARG)) {
> -			if (opts->long_name) {
> -				error("`--%s` uses incompatible flags "
> -				      "LASTARG_DEFAULT and OPTARG", opts->long_name);
> -			} else {
> -				error("`-%c` uses incompatible flags "
> -				      "LASTARG_DEFAULT and OPTARG", opts->short_name);
> -			}
> -			err |= 1;
> -		}
> +		    (opts->flags & PARSE_OPT_OPTARG))
> +			optbug(opts, "uses incompatible flags "
> +				"LASTARG_DEFAULT and OPTARG");
>  	}
> -
> -	if (err)
> -		exit(129);

Hmph, this is simpler but it does not report all errors any more.
So it would be better to do:

	int err = 0;

	for (; opts->type != OPTION_END; opts++) {
		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
		    (opts->flags & PARSE_OPT_OPTARG))
			err |= optbug(opts, "uses incompatible flags "
						"LASTARG_DEFAULT and OPTARG");
	}
	if (err)
		exit(128);

Sorry about that.
