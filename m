From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge-file: correctly find files when called in subdir
Date: Sun, 17 Oct 2010 11:05:46 -0500
Message-ID: <20101017160546.GD301@burratino>
References: <33ab2f03ed522e1a9be202017b7bbfe35e6d7a99.1287228637.git.trast@student.ethz.ch>
 <AANLkTimzuF3Ku_Jjnq0qKFtrDfAfz8YxChomZr8+Shm1@mail.gmail.com>
 <20101017011111.GA26656@burratino>
 <201010171239.13990.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 17 18:09:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Vnd-0007rw-0M
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 18:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab0JQQJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 12:09:21 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46671 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757020Ab0JQQJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 12:09:20 -0400
Received: by gwaa18 with SMTP id a18so19167gwa.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JSQEDaOqpEZ/x6a+8z35+PVku8LO0PF+AmIbdCIkaA8=;
        b=XKiQdx1WCx/VpcCwj9TtpUYYBZXxf8AzrCtgBwCgoKHBw3TqkGqzZR4wZsZhpBr8kl
         3LJe09W/qFhSIVB7mC9CutNNXpcKUmgVNaq1+nD/WNOHj/tQXPtBeDkJEIUnlsLUvF4Q
         vlhP4AwOEo9AP7qu7PT3cB9Bd8m2d0hqWZZ94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DeKgDxzNTvSo60Mu41lAjeXM44+gsPGyWMZwBGfUVS7VQvykHMcZHUXU5Omn5vdjDd
         YcXQTweGx7OqJiiezZSRF1lRxyJ7GYgjTKPzj6POr3Mvt19SG2n9Ov9aja/1YPBjL/gy
         SvD+Z/2QT453GXHFweyf7XjvCK19qStkakHv4=
Received: by 10.150.55.40 with SMTP id d40mr5336163yba.283.1287331759957;
        Sun, 17 Oct 2010 09:09:19 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id z16sm12832361ybm.4.2010.10.17.09.09.18
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 09:09:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010171239.13990.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159207>

Thomas Rast wrote:

> I was ready to say "you're right" to Bert's suggestion.  So maybe, for
> the sake of foolproof-ness, we should do something like the patch
> below?
> 
> diff --git i/setup.c w/setup.c
> index a3b76de..7c8906d 100644
> --- i/setup.c
> +++ w/setup.c
> @@ -55,7 +55,7 @@
>  	/* don't add prefix to absolute paths, but still replace '\' by '/' */
>  	if (is_absolute_path(arg))
>  		pfx_len = 0;
> -	else
> +	else if (pfx && *pfx)
>  		memcpy(path, pfx, pfx_len);
>  	strcpy(path + pfx_len, arg);
>  	for (p = path + pfx_len; *p; p++)

Yes, please!  But I'd write it as

	if (pfx_len)
		memcpy(...)

and rely on the commit message to explain that this is about the !pfx
case (so callers with pfx_len == 3, !pfx get a nice, quick segfault
instead of heisenbugs from uninitialized data).
