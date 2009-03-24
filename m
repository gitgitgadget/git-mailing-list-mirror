From: Peter <vmail@mycircuit.org>
Subject: Re: fatal: unable to write sha1 file git 1.6.2.1
Date: Tue, 24 Mar 2009 22:05:06 +0100
Message-ID: <49C94B02.5010604@mycircuit.org>
References: <49C9246E.3030508@mycircuit.org> <alpine.LFD.2.00.0903241226570.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 22:08:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmDqg-0001P9-Bs
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 22:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbZCXVFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 17:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZCXVFO
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 17:05:14 -0400
Received: from mailfe08.tele2.ch ([212.247.154.232]:45575 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751675AbZCXVFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 17:05:12 -0400
X-Cloudmark-Score: 0.000000 []
X-Cloudmark-Analysis: v=1.0 c=1 a=rOj5MoUHdesA:10 a=zs1h1pAyPHAA:10 a=Qy6mu5jw0WABpOr/wumM4A==:17 a=AHvsvx32olLRwaW_TNQA:9 a=AW0juINgy0BqnJh9MXwA:7 a=T3-pevd-SnePxCFtZmtWGndfT7QA:4 a=gi0PWCVxevcA:10
Received: from mail.mycircuit.org (account cxu-8g8-ypb@tele2.ch [83.180.79.156] verified)
  by mailfe08.swip.net (CommuniGate Pro SMTP 5.2.6)
  with ESMTPA id 1213514091 for git@vger.kernel.org; Tue, 24 Mar 2009 22:05:08 +0100
Received: from [192.168.1.192] (unknown [192.168.1.192])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "p_email", Issuer "192.168.2.2" (verified OK))
	by mail.mycircuit.org (Postfix) with ESMTP id 865E8D0360
	for <git@vger.kernel.org>; Tue, 24 Mar 2009 22:05:07 +0100 (CET)
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
In-Reply-To: <alpine.LFD.2.00.0903241226570.3032@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114492>

I consolidate from Nicolas and Linus, thanks for your help:


Currently, Git is unable to deal with files that it cannot load entirely 
in memory.

What is the size of your largest file?

The biggest is 51 Mb , followed by one that is 23 MB. I was able to add 
and commit a part of the dir tree where the biggest file was 14 Mb. So 
there seems to be a threshold between 23 Mb and 14 Mb.

> If that is the only error message you got, then afaik the only way that 
> can happen is if "close(fd)" returns an error.
>   
Yes thats the only message I got.
> The only other "unable to write sha1 file" message happens if 
> write_buffer() fails, but if that happens then you should also have gotten 
> a
>
> 	file write error (<error message goes here>)
>
> message in addition to the "unable to write sha1 file".
>
> What OS? What filesystem? Are you perhaps running out of space?
>   
Its Lenny Debian 5.0.0, Diskspace is ample . Filesystem is cifs ( this 
is a windows 2000 share mounted with samba in a VMware Workstation 
Debian client ( yes, I know ... )). Memory usage, according to htop, is 
constant = 140/504 MB during the whole process until git fails.
> You could also try to apply this patch to get more information (Junio, 
> maybe worth doing regardless? We should try to avoid ambiguous error 
> messages that don't give full error information)
>
> 		Linus
> ---
>  sha1_file.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 4563173..54972f9 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2287,7 +2287,7 @@ static void close_sha1_file(int fd)
>  		fsync_or_die(fd, "sha1 file");
>  	fchmod(fd, 0444);
>  	if (close(fd) != 0)
> -		die("unable to write sha1 file");
> +		die("error when closing sha1 file (%s)", strerror(errno));
>  }
>  
>  /* Size of directory component, including the ending '/' */
> --
>   
Will try it, thanks
Peter
