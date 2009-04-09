From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Add a simple getpass() for MinGW
Date: Thu, 09 Apr 2009 21:48:48 +0200
Message-ID: <49DE5120.8050904@kdbg.org>
References: <cover.1239154140u.git.johannes.schindelin@gmx.de> <7ba615a300fe2742e8d32f0313c6ee9a1a1aaed3.1239154140u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 09 21:50:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls0Gk-0006Kp-Pg
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 21:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762094AbZDITtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 15:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761603AbZDITtE
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 15:49:04 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:51140 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760194AbZDITtD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 15:49:03 -0400
Received: from [77.118.151.184] (77.118.151.184.wireless.dyn.drei.com [77.118.151.184])
	by bsmtp.bon.at (Postfix) with ESMTP id E5C43CDF89;
	Thu,  9 Apr 2009 21:48:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7ba615a300fe2742e8d32f0313c6ee9a1a1aaed3.1239154140u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116203>

Johannes Schindelin schrieb:
> This should be replaced with a graphical getpass() at some stage.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	I saw it coming that I had to do this.

There are two callers of getpass: One is in imap-send.c, but we don't 
build it on Windows. The other is in http.c. But notice that this is only 
built if NO_CURL is not defined, yet, upstream git defines it in the MinGW 
section, and so this patch alone is not needed in upstream git.

I see you have removed NO_CURL = YesPlease in 4msysgit.git. You should 
make it a part of a series that removes NO_CURL = YesPlease from the MinGW 
section.

>  compat/mingw.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index d50186e..2ab5bbe 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1157,3 +1157,18 @@ int link(const char *oldpath, const char *newpath)
>  	}
>  	return 0;
>  }
> +
> +char *getpass(const char *prompt)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	fputs(prompt, stderr);
> +	for (;;) {
> +		char c = _getch();
> +		if (c == '\r' || c == '\n')
> +			break;
> +		strbuf_addch(&buf, c);
> +	}
> +	fputs("\n", stderr);
> +	return strbuf_detach(&buf, NULL);
> +}

Where do the callers get the prototype from (on MinGW)? Usually, we have 
to have a corresponding function declaration in compat/mingw.h for 
functions that are missing on Windows.

 From http://opengroup.org/onlinepubs/007908775/xsh/getpass.html:

   The return value points to static data whose content may be overwritten
   by each call.

I'm not saying that you should use a fixed-size static character array, 
but only that you should not leak memory on each call ;) (But not even 
that is very important; I'm just summarizing the research I did because I 
was wondering what would happen to the returned buffer.)

Apart from that, the implementation looks good. (_getch(), according to 
the docs on MSDN, doesn't echo the input.)

-- Hannes
