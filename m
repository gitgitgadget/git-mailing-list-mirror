From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] daemon: print "access denied" if a service does not work
Date: Mon, 3 Oct 2011 14:54:44 -0500
Message-ID: <20111003195444.GB18153@elie>
References: <20111003111331.GA12707@elie>
 <1317670109-16919-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 21:54:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAobJ-0000K9-Fg
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453Ab1JCTyw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 15:54:52 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49864 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757444Ab1JCTyw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 15:54:52 -0400
Received: by gyg10 with SMTP id 10so3758789gyg.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 12:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KGoJU9M3jcHgE4uKmyTOXrRLXvPnAeRCYJkYFEfplXw=;
        b=nWGejODpKwN7o6f/7r/uxVRCzBPPjPUyJ1JWrWxabxL/SB5Fv6gcTa4ni0ymS8/0iv
         89DcPktGSAW9iQiurscRePdX8cwEu8BW72inpaQmUFm8wGoWTeqePToYTlI1qWAYYpRW
         fohmQrVT4YcomoY6+1zKMmEoJMXGzZB0NnWtg=
Received: by 10.236.182.201 with SMTP id o49mr2098681yhm.57.1317671691581;
        Mon, 03 Oct 2011 12:54:51 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id o48sm16818052yhl.4.2011.10.03.12.54.50
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 12:54:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317670109-16919-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182707>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/daemon.c
> +++ b/daemon.c
> @@ -562,7 +562,10 @@ static int execute(void)
>  			 * Note: The directory here is probably context sensitive,
>  			 * and might depend on the actual service being performed.
>  			 */
> -			return run_service(line + namelen + 5, s);
> +			if (!run_service(line + namelen + 5, s))
> +				return 0;
> +			packet_write(1, "ERR %s: access denied", line + namelen + 5);
> +			return -1;
>  		}

At first I liked the simplification relative to the patch I sent.
This means the error message is shown when

 1. the service is not enabled at all
 2. path not allowed (for example because it doesn't exist, because
    of permission problems, or because it is blacklisted)
 3. the repository is not exported
 4. the service is not enabled for $path
 5. the service command exited with nonzero status

Unfortunately I think that last case (#5) would be confusing and would
break protocol, especially when the command dies at an inconvenient
moment.  Better for the service command to send an appropriate error
indicator and to just hang up when it fails to do so.
