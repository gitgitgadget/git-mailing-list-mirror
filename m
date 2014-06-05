From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH] mingw: redefine the wrapper macro after the
 corresponding function
Date: Thu, 05 Jun 2014 18:56:25 +0200
Message-ID: <5390A139.2090406@kdbg.org>
References: <20140605080519.GB28029@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 05 18:56:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsaxy-0001w9-IN
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 18:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbaFEQ43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 12:56:29 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:43736 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbaFEQ42 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 12:56:28 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 876C7A7EB8;
	Thu,  5 Jun 2014 18:56:25 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1DD0219F463;
	Thu,  5 Jun 2014 18:56:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140605080519.GB28029@camelia.ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250851>

Am 05.06.2014 10:05, schrieb Stepan Kasal:
> mingw.c defines several wrapper functionsi, like mingw_unlink().
> These wrappers are deployed by macros like this:
> 	#define unlink mingw_unlink
> The function itself is preceded by #undef, leaving the wrapper out
> of the game for the rest of mingw.c.
> 
> This was not probably intentional; for example, there are three
> calls to open() below the definition mingw_open() that probably
> have no reason to circumvent the wrapper.
> OTOH, there is one call to gethostbyname() before it was undefined;
> probably happy that it actually calls mingw_gethostbyname().
> 
> This patch adds back the #define after each wrapper definition.
> 
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>  compat/mingw.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index a0e13bc..e7193c0 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -224,6 +224,7 @@ int mingw_unlink(const char *pathname)
>  	       ret = unlink(pathname);
>  	return ret;
>  }
> +#define unlink mingw_unlink
(etc...)

I don't particularly like this approach: It robs the precise control of
which function we can invoke from other places in mingw.c.

Within mingw.c, if some other function inside mingw.c wants to use
mingw_unlink, then it should be written as 'mingw_unlink(foo)', not
'unlink(foo)'.

So, IMO the macros should be #undef'ed at the top of the file, and all
users (like the open() and gethostbyname() invocations that you
identified) should be audited and changed to call the function they
actually need (i.e., the system open vs. mingw_open).

-- Hannes
