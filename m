From: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Subject: Re: [PATCH] Fix ptrdiff_t vs. int
Date: Fri, 27 May 2005 19:42:55 +0200
Organization: oberhumer.com
Message-ID: <42975C1F.8070102@oberhumer.com>
References: <42971EB4.2050403@oberhumer.com> <Pine.LNX.4.58.0505271013260.17402@ppc970.osdl.org> <Pine.LNX.4.58.0505271024280.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 19:44:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbirl-00060J-23
	for gcvg-git@gmane.org; Fri, 27 May 2005 19:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVE0RoC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 13:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVE0RnE
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 13:43:04 -0400
Received: from mail.servus.at ([193.170.194.20]:32264 "EHLO mail.servus.at")
	by vger.kernel.org with ESMTP id S261923AbVE0Rlv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 13:41:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.servus.at (Postfix) with ESMTP id 2EF541E961B;
	Fri, 27 May 2005 19:42:03 +0200 (CEST)
Received: from mail.servus.at ([127.0.0.1])
 by localhost (aarh.servus.at [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 00341-19; Fri, 27 May 2005 19:41:59 +0200 (CEST)
Received: from [83.164.47.228] (unknown [83.164.47.228])
	by mail.servus.at (Postfix) with ESMTP id 6BF8F1E9607;
	Fri, 27 May 2005 19:41:59 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2-1.4.1.centos4 (X11/20050323)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505271024280.17402@ppc970.osdl.org>
X-no-Archive: yes
X-Oberhumer-Conspiracy: There is no conspiracy. Trust us.
X-Virus-Scanned: amavisd-new at servus.at
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-Gmane-Expiry: 2005-06-10

Linus Torvalds wrote:
> 
> On Fri, 27 May 2005, Linus Torvalds wrote:
> 
>>I can compile a kernel with "-m64", but since I don't have any 64-bit
>>libraries installed, user space doesn't work that well ;)
> 
> 
> Btw, since this was the piece of code that I didn't bother simplifying 
> last time it was discussed (then it was just "ugly"), I took a different 
> approach instead, and committed the following..

Many thanks. BTW, this is probably completely irrelevant on all 
real-world machines and calling conventions, but still, lying on the 
number of arguments in vararg-functions is not my favourite practice.

~Markus

> 
> 		Linus
> 
> ---
> diff-tree 84c1afd7e7c69c6c3c0677d5ee01925d4c70d318 (from a9c9cef161b26ca610783dd0b180d18956c7b119)
> Author: Linus Torvalds <torvalds@ppc970.osdl.org>
> Date:   Fri May 27 10:22:09 2005 -0700
>     
>     git-diff-tree: simplify header output with '-z'
>     
>     No need to make them multiple lines, in fact we explicitly don't want that.
>     
>     This also fixes a 64-bit problem pointed out by Markus F.X.J. Oberhumer,
>     where we gave "%.*s" a "ptrdiff_t" length argument instead of an "int".
> 
> diff --git a/diff-tree.c b/diff-tree.c
> --- a/diff-tree.c
> +++ b/diff-tree.c
> @@ -269,18 +269,11 @@ static int call_diff_flush(void)
>  		return 0;
>  	}
>  	if (header) {
> -		if (diff_output_format == DIFF_FORMAT_MACHINE) {
> -			const char *ep, *cp;
> -			for (cp = header; *cp; cp = ep) {
> -				ep = strchr(cp, '\n');
> -				if (ep == 0) ep = cp + strlen(cp);
> -				printf("%.*s%c", ep-cp, cp, 0);
> -				if (*ep) ep++;
> -			}
> -		}
> -		else {
> -			printf("%s", header);
> -		}
> +		const char *fmt = "%s";
> +		if (diff_output_format == DIFF_FORMAT_MACHINE)
> +			fmt = "%s%c";
> +		
> +		printf(fmt, header, 0);
>  		header = NULL;
>  	}
>  	diff_flush(diff_output_format, 1);
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
