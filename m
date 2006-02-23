From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] fix warning from pack-objects.c
Date: Thu, 23 Feb 2006 23:51:00 +0100
Message-ID: <43FE3C54.2080103@op5.se>
References: <200602232242.k1NMgdAJ018406@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 23:51:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCPIg-00028T-O0
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 23:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWBWWvD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 17:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWBWWvD
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 17:51:03 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55688 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751798AbWBWWvB
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 17:51:01 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 838076BCBE; Thu, 23 Feb 2006 23:51:00 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <200602232242.k1NMgdAJ018406@agluck-lia64.sc.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16672>

Luck, Tony wrote:
> When compiling on ia64 I get this warning (from gcc 3.4.3):
> 
> gcc -o pack-objects.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  pack-objects.c
> pack-objects.c: In function `pack_revindex_ix':
> pack-objects.c:94: warning: cast from pointer to integer of different size
> 
> A double cast (first to long, then to int) shuts gcc up, but is there
> a better way?
> 

Make ui and i unsigned long and cast p to unsigned long (or perhaps 
ptrdiff_t is preferred?). On 32-bit archs it's no difference, but 64-bit 
archs can work with their native size. It's slightly faster (although I 
expect the compiler takes care of that anyways).

I noticed this earlier on my shiny AMD FX2 64-bit. The tests run just 
fine with my solution. I expect they will with yours as well.

> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> 
> diff --git a/pack-objects.c b/pack-objects.c
> index 8f352aa..c985fab 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -91,7 +91,7 @@ static int reused_delta = 0;
>  
>  static int pack_revindex_ix(struct packed_git *p)
>  {
> -	unsigned int ui = (unsigned int) p;
> +	unsigned int ui = (unsigned int)(long)p;
>  	int i;
>  
>  	ui = ui ^ (ui >> 16); /* defeat structure alignment */
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
