From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] macos: lazily initialize iconv
Date: Fri, 10 Aug 2012 18:43:10 +0200
Message-ID: <50253A1E.20706@web.de>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org> <7v1ujrkc9p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 18:43:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzsJ0-000144-Us
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 18:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988Ab2HJQnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Aug 2012 12:43:18 -0400
Received: from mout.web.de ([212.227.15.4]:51298 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502Ab2HJQnR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 12:43:17 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MX0lw-1TBzo23qFQ-00WHlp; Fri, 10 Aug 2012 18:43:14 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7v1ujrkc9p.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:1L0MGrPTuIa8/qa4a+7GZ2y5XDm5U/xzrBB/iQcWqdi
 D2xFiWG2hTT3dHJhMyHfMVET36Q/iLNDn2MNzdc6Oci3JRNgei
 joa37rTCllH9L0zek/+iMDDRlf1xAIZQtTDCiPbnUWpXF37vM4
 dE4v7tFnnKIA2+yIpxe5A7KNe2ShEZiSLSXBGGB58PP3VkgAed
 BP4B8SzNsgkrnuwWzLrWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203234>

On 31.07.12 20:37, Junio C Hamano wrote:
> In practice, the majority of paths do not have utf8 that needs
> the canonicalization. Lazily call iconv_open()/iconv_close() to
> avoid unnecessary overhead.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Ralf Thielow <ralf.thielow@gmail.com>
> Helped-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
>  * This is not even compile tested, so it needs testing and
>    benchmarking, as I do not even know how costly the calls to
>    open/close are when we do not have to call iconv() itself.
>
>    This reroll corrects an obvious thinko pointed out by Ralf, and
>    gets rid of an extra iconv_opened field added unnecessarily in
>    the previous round.
>
>    This was brought up by Linus in http://goo.gl/INWVc
>
>  compat/precompose_utf8.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
> index d40d1b3..79b5528 100644
> --- a/compat/precompose_utf8.c
> +++ b/compat/precompose_utf8.c
> @@ -67,7 +67,7 @@ void probe_utf8_pathname_composition(char *path, in=
t len)
> =20
>  void precompose_argv(int argc, const char **argv)
>  {
> -	int i =3D 0;
> +	int i;
>  	const char *oldarg;
>  	char *newarg;
>  	iconv_t ic_precompose;
> @@ -75,11 +75,19 @@ void precompose_argv(int argc, const char **argv)
>  	if (precomposed_unicode !=3D 1)
>  		return;
> =20
> +	/* Avoid iconv_open()/iconv_close() if there is nothing to convert =
*/
> +	for (i =3D 0; i < argc; i++) {
> +		if (has_utf8(argv[i], (size_t)-1, NULL))
> +			break;
> +	}
> +	if (argc <=3D i)
> +		return; /* no utf8 found */
> +
>  	ic_precompose =3D iconv_open(repo_encoding, path_encoding);
>  	if (ic_precompose =3D=3D (iconv_t) -1)
>  		return;
> =20
> -	while (i < argc) {
> +	for (i =3D 0; i < argc; i++) {
>  		size_t namelen;
>  		oldarg =3D argv[i];
>  		if (has_utf8(oldarg, (size_t)-1, &namelen)) {
> @@ -87,7 +95,6 @@ void precompose_argv(int argc, const char **argv)
>  			if (newarg)
>  				argv[i] =3D newarg;
>  		}
> -		i++;
>  	}
>  	iconv_close(ic_precompose);
>  }
> @@ -106,8 +113,7 @@ PREC_DIR *precompose_utf8_opendir(const char *dir=
name)
>  		return NULL;
>  	} else {
>  		int ret_errno =3D errno;
> -		prec_dir->ic_precompose =3D iconv_open(repo_encoding, path_encodin=
g);
> -		/* if iconv_open() fails, die() in readdir() if needed */
> +		prec_dir->ic_precompose =3D (iconv_t)-1;
>  		errno =3D ret_errno;
>  	}
> =20
> @@ -136,6 +142,9 @@ struct dirent_prec_psx *precompose_utf8_readdir(P=
REC_DIR *prec_dir)
>  		prec_dir->dirent_nfc->d_type =3D res->d_type;
> =20
>  		if ((precomposed_unicode =3D=3D 1) && has_utf8(res->d_name, (size_=
t)-1, NULL)) {
> +			if (prec_dir->ic_precompose =3D=3D (iconv_t)-1)
> +				prec_dir->ic_precompose =3D
> +					iconv_open(repo_encoding, path_encoding);
>  			if (prec_dir->ic_precompose =3D=3D (iconv_t)-1) {
>  				die("iconv_open(%s,%s) failed, but needed:\n"
>  						"    precomposed unicode is not supported.\n"
Hi Junio,

thanks for the optimization.
Tested-by: Torsten B=F6gershausen <tboegi@web.de>

We can optimize the optimization with another 0.01 %  ;-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 79b5528..93ae5de 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -112,9 +112,7 @@ PREC_DIR *precompose_utf8_opendir(const char *dirna=
me)
                free(prec_dir);
                return NULL;
        } else {
-               int ret_errno =3D errno;
                prec_dir->ic_precompose =3D (iconv_t)-1;
-               errno =3D ret_errno;
        }
