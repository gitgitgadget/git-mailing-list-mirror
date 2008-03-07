From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Thu, 06 Mar 2008 22:03:52 -0500
Message-ID: <47D0B098.9040707@gmail.com>
References: <47AAA254.2020008@thorn.ws>	<20080207063020.GP24004@spearce.org>	<200802071056.19370.robin.rosenberg.lists@dewire.com>	<20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>	<20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>	<18368.41742.689290.877767@cargo.ozlabs.ibm.com>	<47C190E3.6000407@gmail.com> <18383.57540.26282.526111@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 04:04:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXSt3-00045x-Hb
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 04:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbYCGDD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 22:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753115AbYCGDD4
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 22:03:56 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:55695 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbYCGDDz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 22:03:55 -0500
Received: by an-out-0708.google.com with SMTP id d31so63302and.103
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 19:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=O14OlMoiD092N/Ejb+qbVQuH5rRKZj/I/bEpjiRQ0zA=;
        b=F/vxKueBdo34T/Esbso5tYut4JVSeML8Ye9y1CjSd4LbcbXoQZPzFuhiFUI+piWtMdNG5xxKmpUPkJU3tF2scYeAhAOm5ucrYmmS2j2WRa7Sh+1U0KXqxcpVXsrYhwVGpBB2KTV8nODipel+uzSTmB/+T3nfKFOQLPD1BsTZpUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cZEdSJGNW4LXb4uYsmKcVWLA0/jpoY4vPSTlxBsRJNVW0TEot8A9/TapdpDRvHF8Y5Gpi0D3vApjf63+lnNZDjSJhmC7tzRbQEGXHX9/9+Xe6aebBgaVvLYNKRzpPUMoJq1jND8GEWKDdhg8kn6sxNobF5WRRC/0XC477oF16S0=
Received: by 10.100.107.7 with SMTP id f7mr1578247anc.74.1204859034894;
        Thu, 06 Mar 2008 19:03:54 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.29.241])
        by mx.google.com with ESMTPS id d24sm7063678and.12.2008.03.06.19.03.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Mar 2008 19:03:53 -0800 (PST)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <18383.57540.26282.526111@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76459>

Paul Mackerras wrote:
> Here's a patch for people to test.  It only restores the width and
> height, and limits the width and height to be at most the width and
> height of the screen.  It seems to work fine under X; I would be
> interested to know what happens under macos and windows.
>
> Paul.
> ---
> diff --git a/gitk b/gitk
> index f1f21e9..f8f006f 100755
> --- a/gitk
> +++ b/gitk
> @@ -930,9 +930,17 @@ proc makewindow {} {
>      .pwbottom add .bright
>      .ctop add .pwbottom
>  
> -    # restore window position if known
> +    # restore window width & height if known
>      if {[info exists geometry(main)]} {
> -        wm geometry . "$geometry(main)"
> +	if {[scan $geometry(main) "%dx%d" w h] >= 2} {
> +	    if {$w > [winfo screenwidth .]} {
> +		set w [winfo screenwidth .]
> +	    }
> +	    if {$h > [winfo screenheight .]} {
> +		set h [winfo screenheight .]
> +	    }
> +	    wm geometry . "${w}x$h"
> +	}
>      }
>  
>      if {[tk windowingsystem] eq {aqua}} {
>   
This works fine on Cygwin: the size restores properly across sessions, 
the window and widgets all behave as expected. So, you can add a  
"Tested-by: Mark Levedahl <mlevedahl@gmail.com" if you wish to this.

Mark
