From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: Improve compiler header dependency check
Date: Sat, 27 Aug 2011 11:26:54 -0500
Message-ID: <20110827162645.GA10476@elie.gateway.2wire.net>
References: <1314434470-7988-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 18:27:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxLiv-0004xf-Ly
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 18:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030Ab1H0Q1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 12:27:05 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:59645 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab1H0Q1C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 12:27:02 -0400
Received: by yie30 with SMTP id 30so2429368yie.19
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=h6iIRn4pl+CEpuA9j+CQADcnWYhSSyJh0ZGrsN43Uzc=;
        b=hMMbpMviQMfYjDiQNCYowPJzaV+XvWD7K8qBi6Umq/h3YIY7cfTxMsZpCSiHVfY6na
         VyeOoSh/xT9CL8hrHdbfnzebcd0Qy2E5D0Vf3aDLK+MP/hq41pNKc4nKo8N6dlMFCXAB
         IcPoYwW+zGpwl9096urd9WILFaIOfXxprI/PY=
Received: by 10.42.136.199 with SMTP id v7mr2681747ict.81.1314462421678;
        Sat, 27 Aug 2011 09:27:01 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-108-66.dsl.chcgil.ameritech.net [68.255.108.66])
        by mx.google.com with ESMTPS id h5sm3095895icy.21.2011.08.27.09.26.59
        (version=SSLv3 cipher=OTHER);
        Sat, 27 Aug 2011 09:27:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1314434470-7988-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180235>

David Aguilar wrote:

> I fired up git's next branch on a mac laptop where I
> have a config.mak that builds universal git binaries:
>
> CFLAGS = -arch i386 -arch x86_64
>
> This configuration broke when 111ee18c31f9bac9436426399355facc79238566
> was merged into next.

Good catch; thanks.  This information would be useful for the commit
message.

> gcc cannot generate header dependencies when
> multiple -arch statements are used

Sounds like a bug.  Any idea why it behaves that way?  What error message
does it write?

If it is a bug, it might be worth reporting this to the gcc devs while
at it.

[...]
> --- a/Makefile
> +++ b/Makefile
> @@ -1251,7 +1251,8 @@ USE_COMPUTED_HEADER_DEPENDENCIES =
>  else
>  ifndef COMPUTE_HEADER_DEPENDENCIES
>  dep_check = $(shell sh -c \
> -	'$(CC) -c -MF /dev/null -MMD -MP -x c /dev/null -o /dev/null 2>&1; \
> +	'$(CC) -c -MF /dev/null -MMD -MP -x c /dev/null -o /dev/null \
> +	$(ALL_CFLAGS) $(EXTRA_CPPFLAGS) 2>&1; \
>  	echo $$?')

EXTRA_CPPFLAGS is a target-specific variable and would always be empty,
So I think this would be clearer without.

While we're touching this line, do you know if the "sh -c" is
necessary?  I would expect $(shell ...) to run its arguments in a
shell.

Thanks --- despite the nitpicks above, this one looks good.
Jonathan
