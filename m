From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 3/4] Provide a dirname() function when
 NO_LIBGEN_H=YesPlease
Date: Wed, 13 Jan 2016 00:55:19 +0000
Message-ID: <5695A077.7070606@ramsayjones.plus.com>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
 <cover.1452585382.git.johannes.schindelin@gmx.de>
 <04a7a497f9a5771d4dbf5fd605f138607b2bae0a.1452585382.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 01:55:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ9io-0002O0-FE
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 01:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbcAMAza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 19:55:30 -0500
Received: from avasout04.plus.net ([212.159.14.19]:57378 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbcAMAz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 19:55:29 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id 5CvS1s0014mu3xa01CvTMj; Wed, 13 Jan 2016 00:55:27 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=CvRCCSMD c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=EBOSESyhAAAA:8
 a=N659UExz7-8A:10 a=kirKd-dCyu_35vZKvnYA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <04a7a497f9a5771d4dbf5fd605f138607b2bae0a.1452585382.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283865>



On 12/01/16 07:57, Johannes Schindelin wrote:
> When there is no `libgen.h` to our disposal, we miss the `dirname()`
> function.
> 
> So far, we only had one user of that function: credential-cache--daemon
> (which was only compiled when Unix sockets are available, anyway). But
> now we also have `builtin/am.c` as user, so we need it.
> 
> Since `dirname()` is a sibling of `basename()`, we simply put our very
> own `gitdirname()` implementation next to `gitbasename()` and use it
> if `NO_LIBGEN_H` has been set.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/basename.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  git-compat-util.h |  2 ++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/compat/basename.c b/compat/basename.c
> index 0f1b0b0..96bd953 100644
> --- a/compat/basename.c
> +++ b/compat/basename.c
> @@ -1,4 +1,5 @@
>  #include "../git-compat-util.h"
> +#include "../strbuf.h"
>  
>  /* Adapted from libiberty's basename.c.  */
>  char *gitbasename (char *path)
> @@ -25,3 +26,46 @@ char *gitbasename (char *path)
>  	}
>  	return (char *)base;
>  }
> +
> +char *gitdirname(char *path)
> +{
> +	static struct strbuf buf = STRBUF_INIT;
> +	char *p = path, *slash = NULL, c;
> +	int dos_drive_prefix;
> +
> +	if (!p)
> +		return ".";
> +
> +	if ((dos_drive_prefix = skip_dos_drive_prefix(&p)) && !*p)
> +		goto dot;
> +
> +	/*
> +	 * POSIX.1-2001 says dirname("/") should return "/", and dirname("//")
> +	 * should return "//", but dirname("///") should return "/" again.
> +	 */
> +	if (is_dir_sep(*p)) {
> +		if (!p[1] || (is_dir_sep(p[1]) && !p[2]))
> +			return path;
> +		slash = ++p;
> +	}
> +	while ((c = *(p++)))
> +		if (is_dir_sep(c)) {
> +			char *tentative = p - 1;
> +
> +			/* POSIX.1-2001 says to ignore trailing slashes */
> +			while (is_dir_sep(*p))
> +				p++;
> +			if (*p)
> +				slash = tentative;
> +		}
> +
> +	if (slash) {
> +		*slash = '\0';
> +		return path;
> +	}
> +
> +dot:
> +	strbuf_reset(&buf);
> +	strbuf_addf(&buf, "%.*s.", dos_drive_prefix, path);
> +	return buf.buf;
> +}

Again, I find my version much easier to read:

char *gitdirname(char *path)
{
	char *p, *start;

	if (!path || !*path)
		return ".";
	start = path;
	/* skip drive designator, if any */
	if (has_dos_drive_prefix(path))
		start += 2;
	/* check for // */
	if (strcmp(start, "//") == 0)
		return path;
	/* check for \\ */
	if (is_dir_sep('\\') && strcmp(start, "\\\\") == 0)
		return path;
	/* trim trailing directory separators */
	p = path + strlen(path) - 1;
	while (is_dir_sep(*p)) {
		if (p == start)
			return path;
		*p-- = '\0';
	}
	/* find begining of last path component */
	while (p > start && !is_dir_sep(*p))
		p--;
	/* terminate dirname */
	if (p == start && !is_dir_sep(*p))
		*p++ = '.';
	else if (p == start)
		p++;
	*p = '\0';
	return path;
}

> diff --git a/git-compat-util.h b/git-compat-util.h
> index fbb11bb..5f72f1c 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -253,6 +253,8 @@ struct itimerval {
>  #else

Also, when compiling on Cygwin with NO_LIBGEN_H, I need to
include the following here:

#undef basename

in order to suppress approx 230 warnings about the redefinition
of the basename macro.

(I suppose that should go in the previous commit. dunno)

>  #define basename gitbasename
>  extern char *gitbasename(char *);
> +#define dirname gitdirname
> +extern char *gitdirname(char *);
>  #endif
>  
>  #ifndef NO_ICONV
> 

ATB,
Ramsay Jones
