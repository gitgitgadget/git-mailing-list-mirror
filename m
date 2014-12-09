From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/7] parse_color: refactor color storage
Date: Tue, 09 Dec 2014 21:52:10 +0100
Message-ID: <548760FA.50209@kdbg.org>
References: <20141120151418.GA23607@peff.net> <20141120151704.GD23680@peff.net> <54875825.7060008@kdbg.org> <20141209202135.GB12001@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Scott Baker <bakers@canbytel.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:52:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRld-0001hu-HM
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbaLIUwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:52:15 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:58787 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbaLIUwN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:52:13 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jxtqb44jVz5tlC;
	Tue,  9 Dec 2014 21:52:11 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C975419F828;
	Tue,  9 Dec 2014 21:52:10 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141209202135.GB12001@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261166>

Am 09.12.2014 um 21:21 schrieb Jeff King:
> On Tue, Dec 09, 2014 at 09:14:29PM +0100, Johannes Sixt wrote:
> 
>> Am 20.11.2014 um 16:17 schrieb Jeff King:
>>> +#define COLOR_FOREGROUND '3'
>>> +#define COLOR_BACKGROUND '4'
>>
>> This (COLOR_BACKGROUND) causes an ugly redefinition warning on Windows,
>> because we inherit a definition from a Windows header. How would you
>> like it fixed? A different name or #undef in front of it?
> 
> I think a different name would be fine. The constants are actually only
> used once each. Their main function is to avoid a confusing parameter
> '3' to the color_output function. But we could use the literal
> constants with a parameter, like:
> 
> diff --git a/color.c b/color.c
> index e2a0a99..809b359 100644
> --- a/color.c
> +++ b/color.c
> @@ -144,9 +144,6 @@ int color_parse(const char *value, char *dst)
>  	return color_parse_mem(value, strlen(value), dst);
>  }
>  
> -#define COLOR_FOREGROUND '3'
> -#define COLOR_BACKGROUND '4'
> -
>  /*
>   * Write the ANSI color codes for "c" to "out"; the string should
>   * already have the ANSI escape code in it. "out" should have enough
> @@ -245,12 +242,14 @@ int color_parse_mem(const char *value, int value_len, char *dst)
>  		if (!color_empty(&fg)) {
>  			if (sep++)
>  				*dst++ = ';';
> -			dst = color_output(dst, &fg, COLOR_FOREGROUND);
> +			/* foreground colors are all in the 3x range */
> +			dst = color_output(dst, &fg, '3');
>  		}
>  		if (!color_empty(&bg)) {
>  			if (sep++)
>  				*dst++ = ';';
> -			dst = color_output(dst, &bg, COLOR_BACKGROUND);
> +			/* background colors are all in the 4x range */
> +			dst = color_output(dst, &bg, '4');
>  		}
>  		*dst++ = 'm';
>  	}
> 
> We could also pass in integer "30" and "40", and then format it with %d
> inside color_output. I don't know if that would be more obvious or not.

This patch would actually be my personal preference. The comment near
the literal makes it all clear.

-- Hannes
