From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Thu, 12 Sep 2013 16:13:14 +0200
Message-ID: <5231CBFA.3070806@web.de>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com> <0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>, Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 16:13:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK7eA-0002LF-Kt
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 16:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab3ILONW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 10:13:22 -0400
Received: from mout.web.de ([212.227.15.14]:63034 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528Ab3ILONW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 10:13:22 -0400
Received: from [192.168.209.26] ([217.208.218.204]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0MRiZt-1VUnyz0DsX-00SzSJ for <git@vger.kernel.org>;
 Thu, 12 Sep 2013 16:13:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
X-Provags-ID: V03:K0:edsHKXePX4JeGdhlGz3ovu6D0YKapqi+YyQ5cHBhLlnBWteQFNL
 ObfYNAPI6HEgstyo1n2UWR3nCXjs2n09b8G4igYKPAU0e392N9SSt1+mQ9LVXX1sU5UfG3a
 xkG81S7fxNGBDPezcSX/sV0/5Lg+erGSlVE9H7WtqhMcltn2ORAfwuvFCJVgyC2fXRrzVlw
 LwE2vos3J4bUWcReRPXDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234651>

On 2013-09-12 11.12, Jiang Xin wrote:
> Tvangeste found that the "relative_path" function could not work
> properly on Windows if "in" and "prefix" have dos driver prefix.
> ($gmane/234434)
> 
> e.g., When execute: test-path-utils relative_path "C:/a/b" "D:/x/y",
> should return "C:/a/b", but returns "../../C:/a/b", which is wrong.
> 
> So make relative_path honor dos_drive_prefix, and add test cases
> for it in t0060.
> 
> Reported-by: Tvangeste <i.4m.l33t@yandex.ru>
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  path.c                | 20 ++++++++++++++++++++
>  t/t0060-path-utils.sh |  4 ++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/path.c b/path.c
> index 7f3324a..ffcdea1 100644
> --- a/path.c
> +++ b/path.c
> @@ -441,6 +441,16 @@ int adjust_shared_perm(const char *path)
>  	return 0;
>  }
>  
> +static int have_same_root(const char *path1, const char *path2)
> +{
> +	int is_abs1, is_abs2;
> +
> +	is_abs1 = is_absolute_path(path1);
> +	is_abs2 = is_absolute_path(path2);
> +	return (is_abs1 && is_abs2 && !strncasecmp(path1, path2, 1)) ||
                                       ^^^^^^^^^^^
I wonder: should strncasecmp() be replaced with strncmp_icase() ?

See dir.c: 
int strncmp_icase(const char *a, const char *b, size_t count)
{
	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
}
/Torsten











> +	       (!is_abs1 && !is_abs2);
> +}
> +
>  /*
>   * Give path as relative to prefix.
>   *
> @@ -461,6 +471,16 @@ const char *relative_path(const char *in, const char *prefix,
>  	else if (!prefix_len)
>  		return in;
>  
> +	if (have_same_root(in, prefix)) {
> +		/* bypass dos_drive, for "c:" is identical to "C:" */
> +		if (has_dos_drive_prefix(in)) {
> +			i = 2;
> +			j = 2;
> +		}
> +	} else {
> +		return in;
> +	}
> +
>  	while (i < prefix_len && j < in_len && prefix[i] == in[j]) {
>  		if (is_dir_sep(prefix[i])) {
>  			while (is_dir_sep(prefix[i]))
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 76c7792..c3c3b33 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -208,6 +208,10 @@ relative_path a/b/	a/b		./
>  relative_path a		a/b		../
>  relative_path x/y	a/b		../../x/y
>  relative_path a/c	a/b		../c
> +relative_path a/b	/x/y		a/b
> +relative_path /a/b	x/y		/a/b	POSIX
> +relative_path d:/a/b	D:/a/c		../b	MINGW
> +relative_path C:/a/b	D:/a/c		C:/a/b	MINGW
>  relative_path a/b	"<empty>"	a/b
>  relative_path a/b 	"<null>"	a/b
>  relative_path "<empty>"	/a/b		./
> 
