From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Try to remove the given path even if it can't be opened
Date: Fri, 01 Apr 2011 15:37:44 +0200
Message-ID: <4D95D528.6050409@drmicha.warpmail.net>
References: <AANLkTikfmXiZQquWi4STTCUy0qoY9J_waJ44nrPAvB1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 15:41:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5ebQ-00067v-CW
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 15:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756394Ab1DANlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 09:41:16 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:49006 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756294Ab1DANlO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 09:41:14 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 880DD20A65;
	Fri,  1 Apr 2011 09:41:14 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 01 Apr 2011 09:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=fD58mNTEUu4P7uSiVv2OWlYVrgM=; b=m5dVwuc7wsWGSoiSQl500oTe+puF1Voqd0CNCzwb+z14c1FZvK9mTHSrDZfmQfC8uAzOoQqUEuapFoHwdLjmU8ATlcho/SPO99oLf4rBUliWO2RPG2C/qhOT22gkkLwJKo6UgiJua+MkdYSLEdIHkUE/WfpYSFLYFzh55ERhP0E=
X-Sasl-enc: tWI5n1Lk1sifHZdxDsFTyuhWFKQBOIpzgWdt8Qzf+cH6 1301665274
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AD757403522;
	Fri,  1 Apr 2011 09:41:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTikfmXiZQquWi4STTCUy0qoY9J_waJ44nrPAvB1d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170582>

Alex Riesen venit, vidit, dixit 01.04.2011 10:29:
> Consider unreadable empty directories. rmdir(2) will remove
> them just fine, assuming the parent directory is modifiable.
> 
> Noticed by Linus.
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> On Fri, Apr 1, 2011 at 00:01, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> Which is kind of understandable, but at the same time, if it's empty,
>> a "rmdir()" will just work. So git gave up a bit too soon.
> ...
>> Now, I realize that if the directory isn't empty, and is unreadable,
>> we really should give up (although a better error message about _why_
>> we failed may be in order) rather than try to chmod it or anything
>> like that. But the simple "try to rmdir it" might be a good addition
>> for the trivial case.
> 
> It is not tested, but looks trivial. The system I made it on is a Cygwin

Famous last words...

> machine, and a test from last master pull is still running (since two days).
> And sorry, it is not based on master. Should apply without problems, though.
> 
> ---
>  dir.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/dir.c b/dir.c
> index 325fb56..7251426 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1191,8 +1191,11 @@ int remove_dir_recursively(struct strbuf *path, int flag)
>  		return 0;
> 
>  	dir = opendir(path->buf);
> -	if (!dir)
> +	if (!dir) {
> +		if (rmdir(path->buf) == 0)
> +			return 0;
>  		return -1;
> +	}
>  	if (path->buf[original_len - 1] != '/')
>  		strbuf_addch(path, '/');
> 

How about simply

if (!dir)
	return rmdir(path->buf);

like we do later on in that function?

Michael
