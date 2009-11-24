From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] Refactor winsock initialization into a separate 
  function
Date: Tue, 24 Nov 2009 08:36:21 +0100
Message-ID: <4B0B8CF5.6080208@viscovery.net>
References: <alpine.DEB.2.00.0911240052440.14228@cone.home.martin.st> <alpine.DEB.2.00.0911240054420.14228@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Tue Nov 24 08:36:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCpwt-0005tK-3j
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 08:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757601AbZKXHgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2009 02:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757540AbZKXHgT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 02:36:19 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24983 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757534AbZKXHgT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2009 02:36:19 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NCpwj-0002Ei-Dk; Tue, 24 Nov 2009 08:36:21 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 29BF89F88; Tue, 24 Nov 2009 08:36:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.DEB.2.00.0911240054420.14228@cone.home.martin.st>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133565>

Martin Storsj=F6 schrieb:
> Signed-off-by: Martin Storsjo <martin@martin.st>

I have used this series in my tree for 6 weeks without negative
sideffects. I haven't tested IPv6, though.

Here's an updated commit message with my ACK:

--- >8 ---
Refactor winsock initialization into a separate function

The winsock library must be initialized. Since gethostbyname() is the
first function that calls into winsock, it was overridden to do the
initialization. This refactoring helps the next patch, where other
functions can be called earlier.

Signed-off-by: Martin Storsjo <martin@martin.st>
Acked-by: Johannes Sixt <j6t@kdbg.org>
--- >8 ---


> ---
>  compat/mingw.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 15fe33e..f9d82ff 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -903,16 +903,25 @@ char **make_augmented_environ(const char *const=
 *vars)
>  	return env;
>  }
> =20
> -/* this is the first function to call into WS_32; initialize it */
> -#undef gethostbyname
> -struct hostent *mingw_gethostbyname(const char *host)
> +static void ensure_socket_initialization(void)
>  {
>  	WSADATA wsa;
> +	static int initialized =3D 0;
> +
> +	if (initialized)
> +		return;
> =20
>  	if (WSAStartup(MAKEWORD(2,2), &wsa))
>  		die("unable to initialize winsock subsystem, error %d",
>  			WSAGetLastError());
>  	atexit((void(*)(void)) WSACleanup);
> +	initialized =3D 1;
> +}
> +
> +#undef gethostbyname
> +struct hostent *mingw_gethostbyname(const char *host)
> +{
> +	ensure_socket_initialization();
>  	return gethostbyname(host);
>  }
> =20
