From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH v2] Allow git-shell to be used as a ssh forced-command
Date: Tue, 21 Apr 2009 12:05:59 +0400
Message-ID: <20090421080559.GI25059@dpotapov.dyndns.org>
References: <20090418063100.GA18568@glandium.org> <1240292586-28192-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 10:08:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwB1S-0004lA-Cl
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 10:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbZDUIGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 04:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbZDUIGb
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 04:06:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:29448 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbZDUIGa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 04:06:30 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2314820rvb.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=glbTdDKKox6g4eAU0oP+qW0ztNHrU6mJ9wGfpclx4vs=;
        b=DDeFvnbN3D/17Zcskx6uYzKzh1XhTUI6Q1IMpfcJbeI18VyDQu1AFx4OciOATW/yEb
         N/Moy4kont6Xrlpc5pkJwSnJqcYUl8jreLbsfBiRIAqGAvcUUiCEgfGW0aoBrw8FFhXg
         agwdRN6SR8a9F9ThL1dUAarCjyX1eOh+83eHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sgzjSk4KRGx4TXsL4WY//sZ2sZbneyNuXgeJlOkf2FZxT6UswwRpXxWhGQ916vnjBt
         eQT9E7rBE8CKpyMjRhEsEHb2a4hZK2XojD9c05dkJNFkHV7E22hQeWiamTytYNARYiA2
         KKvPmoFQx5y9KliJ1+o78SXLiqlX2+/FITvk4=
Received: by 10.141.132.3 with SMTP id j3mr2841722rvn.34.1240301190253;
        Tue, 21 Apr 2009 01:06:30 -0700 (PDT)
Received: from localhost ([91.78.50.115])
        by mx.google.com with ESMTPS id k41sm3105398rvb.6.2009.04.21.01.06.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Apr 2009 01:06:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1240292586-28192-1-git-send-email-mh@glandium.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117101>

On Tue, Apr 21, 2009 at 07:43:06AM +0200, Mike Hommey wrote:
> When using a forced-command, OpenSSH sets the SSH_ORIGINAL_COMMAND
> variable to what would otherwise be passed to $SHELL -c. When this
> variable is set and git-shell was given no argument, we use it.
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  shell.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/shell.c b/shell.c
> index b968be7..86c9273 100644
> --- a/shell.c
> +++ b/shell.c
> @@ -72,11 +72,16 @@ int main(int argc, char **argv)
>  	/*
>  	 * We do not accept anything but "-c" followed by "cmd arg",
>  	 * where "cmd" is a very limited subset of git commands.
> +	 * If no argument is given at all, see whether we were run from
> +	 * a ssh forced-command and use the original command if so.
>  	 */
>  	else if (argc != 3 || strcmp(argv[1], "-c"))
> -		die("What do you think I am? A shell?");
> +		if (argc != 1 || !(prog = getenv("SSH_ORIGINAL_COMMAND")))
> +			die("What do you think I am? A shell?");
> +
> +	if (!prog)

It appears to me that 'prog' may be used unitialized here.


Dmitry
