From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCHv7 1/4] Read (but not write) from $XDG_CONFIG_HOME/git/config
 file
Date: Thu, 14 Jun 2012 18:31:54 +0100
Message-ID: <4FDA200A.8080200@ramsay1.demon.co.uk>
References: <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr> <1339469396-29677-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 14 19:33:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfDv9-0004NY-3w
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 19:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256Ab2FNRdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 13:33:19 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:58933 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932210Ab2FNRdS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2012 13:33:18 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1SfDv2-0005CN-ot; Thu, 14 Jun 2012 17:33:17 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <1339469396-29677-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200024>

Huynh Khoi Nguyen Nguyen wrote:
> Git will be able to read from $XDG_CONFIG_HOME/git/config, a new
> configuration file following XDG specification. In the order of
> reading, this file is between global configuration file and system
> wide configuration file. Git currently does not write to this new
> configuration file. If $XDG_CONFIG_HOME is either not set or empty,
> $HOME/.config/git/config will be used.
> 
> Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
> Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
> Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
> Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
> Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---
>  Documentation/git-config.txt |   12 +++++--
>  builtin/config.c             |   28 +++++++++++-----
>  cache.h                      |    3 ++
>  config.c                     |   23 ++++++++-----
>  path.c                       |   41 ++++++++++++++++++++++++
>  t/t1306-xdg-files.sh         |   70 ++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 156 insertions(+), 21 deletions(-)
>  create mode 100755 t/t1306-xdg-files.sh

[...]

> diff --git a/path.c b/path.c
> index 6f2aa69..66acd24 100644
> --- a/path.c
> +++ b/path.c
> @@ -87,6 +87,21 @@ char *git_pathdup(const char *fmt, ...)
>  	return xstrdup(path);
>  }
>  
> +char *mkpathdup(const char *fmt, ...)
> +{
> +	char *path;
> +	struct strbuf sb = STRBUF_INIT;
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	strbuf_vaddf(&sb, fmt, args);
> +	va_end(args);
> +	path = xstrdup(cleanup_path(sb.buf));
> +
> +	strbuf_release(&sb);
> +	return path;
> +}
> +

As expected, this version avoids re-introducing the bug on Cygwin.

I tested the series on Cygwin, MinGW and Linux and it passes it's
own tests (t1306-xdg-files.sh) on all platforms. (Well, on MinGW
I had to run it thus:

    $ GIT_TEST_CMP='diff -ub' ./t1306-xdg-files.sh

otherwise the first two tests fail because of CRLF vs LF issues).

Thanks!

ATB,
Ramsay Jones
