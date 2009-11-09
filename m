From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 4/4] Add explicit Cygwin check to guard WIN32 header
 inclusion
Date: Mon, 09 Nov 2009 08:20:38 +0100
Message-ID: <4AF7C2C6.5070307@viscovery.net>
References: <4AF5D6F8.40608@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Nov 09 08:20:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7OYT-0005cG-EL
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 08:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbZKIHUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 02:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbZKIHUi
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 02:20:38 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:34762 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753610AbZKIHUh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 02:20:37 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N7OYI-0001hs-JB; Mon, 09 Nov 2009 08:20:38 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 35EB34E4; Mon,  9 Nov 2009 08:20:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AF5D6F8.40608@ramsay1.demon.co.uk>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132445>

Ramsay Jones schrieb:
> Since commit 435bdf8c ("Make usage of windows.h lean and mean",
> 16-9-2009), the amount of code potentially including the WIN32
> API header files has greatly increased. In particular, the Cygwin
> build is at greater risk of inadvertently including WIN32 code
> within preprocessor sections protected by the WIN32 or _WIN32
> macros.

Thanks, this makes the problem pretty clear that you want to solve.

> The previous commit message, along with comments elsewhere, assert
> that the WIN32 macro is not defined on Cygwin. Currently, this is
> true for the cygwin build. However, the cygwin platform can be
> used to develop WIN32 GUI, WIN32 console, and POSIX applications.
> Indeed it is possible to create applications which use a mix of
> the WIN32 API and POSIX code (eg git!).

In this paragraph, you are only saying that cygwin comes with headers and
libraries that can be used to write code using the Windows API in addition
to the POSIX headers and libraries. (I'm just asking, not complaining;
perhaps this could be stated differently.)

> Unlike native WIN32 compilers, gcc on cygwin does not automatically
> define the _WIN32 macro. However, as soon as you include the
> <windows.h> header file, the _WIN32 and WIN32 macros are defined.
> 
> In order to reduce the risk of problems in the future, we protect
> the inclusion of the windows header with an explicit check for
> __CYGWIN__. Also, we move the other use of the <windows.h> header
> from compat/win32.h to compat/cygwin.c

But I sense a contradiction here. Above you are arguing that much more
WIN32 code is included, but here you are saying that the explicit check
for __CYGWIN__ is just a safety measure to protect us from failures in
future changes. Indeed, looking at the code it seems that this extra check
is *currently* not necessary:

- Cygwin does not define WIN32, hence, in the original code of this hunk,

> diff --git a/git-compat-util.h b/git-compat-util.h
> index ef60803..c4b9e5a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -65,10 +65,10 @@
>  #define _NETBSD_SOURCE 1
>  #define _SGI_SOURCE 1
>  
> -#ifdef WIN32 /* Both MinGW and MSVC */
> -#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
> -#include <winsock2.h>
> -#include <windows.h>
> +#if defined(_WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
> +# define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
> +# include <winsock2.h>
> +# include <windows.h>
>  #endif
>  
>  #include <unistd.h>

windows.h is not included in cygwin. (Nor is it in the changed version.)

- The other files that include windows.h are compat/win32.h and nedmalloc.
The latter isn't used on cygwin.

- win32.h is included only from cygwin.c, mingw.c, and msvc.c. Only the
first one is used by cygwin, and since it is a .c file, pulling in
windows.h can only concern code in cygwin.c, but not code.

IOW, I disagree with your analysis that a lot of code suffers from
windows.h pollution. What am I missing?

-- Hannes
