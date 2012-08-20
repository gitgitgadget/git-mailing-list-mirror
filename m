From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] precompose-utf8: do not call checks for non-ascii "utf8"
Date: Mon, 20 Aug 2012 21:46:18 +0200
Message-ID: <5032940A.4040005@web.de>
References: <7v393mxkpk.fsf@alter.siamese.dyndns.org> <1345215190-95976-1-git-send-email-robin.rosenberg@dewire.com> <7vobm9v32e.fsf@alter.siamese.dyndns.org> <50311DEB.4050700@web.de> <7vobm5jusz.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 21:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Y1f-0004ld-9J
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 21:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488Ab2HTTwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 15:52:33 -0400
Received: from smtp-out21.han.skanova.net ([195.67.226.208]:46047 "EHLO
	smtp-out21.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751817Ab2HTTwb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2012 15:52:31 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2012 15:52:30 EDT
Received: from wanderer.site (195.67.191.22) by smtp-out21.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4FD624AF013F8F65; Mon, 20 Aug 2012 21:46:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vobm5jusz.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203870>

On 08/20/2012 08:13 PM, Junio C Hamano wrote:
> As suggested by Linus, this function is not checking UTF-8-ness of the
> string; it only is seeing if it is pure US-ASCII.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>   * Just for completeness, this on top.
>
>   compat/precompose_utf8.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
> index 3190d50..8cf5955 100644
> --- a/compat/precompose_utf8.c
> +++ b/compat/precompose_utf8.c
> @@ -13,20 +13,20 @@ typedef char *iconv_ibp;
>   static const char *repo_encoding = "UTF-8";
>   static const char *path_encoding = "UTF-8-MAC";
>
> -static size_t has_utf8(const char *s, size_t maxlen, size_t *strlen_c)
> +static size_t has_non_ascii(const char *s, size_t maxlen, size_t *strlen_c)
>   {
> -	const uint8_t *utf8p = (const uint8_t *)s;
> +	const uint8_t *ptr = (const uint8_t *)s;
>   	size_t strlen_chars = 0;
>   	size_t ret = 0;
>
> -	if (!utf8p || !*utf8p)
> +	if (!ptr || !*ptr)
>   		return 0;
>
> -	while (*utf8p && maxlen) {
> -		if (*utf8p & 0x80)
> +	while (*ptr && maxlen) {
> +		if (*ptr & 0x80)
>   			ret++;
>   		strlen_chars++;
> -		utf8p++;
> +		ptr++;
>   		maxlen--;
>   	}
>   	if (strlen_c)
> @@ -77,7 +77,7 @@ void precompose_argv(int argc, const char **argv)
>   	while (i < argc) {
>   		size_t namelen;
>   		oldarg = argv[i];
> -		if (has_utf8(oldarg, (size_t)-1, &namelen)) {
> +		if (has_non_ascii(oldarg, (size_t)-1, &namelen)) {
>   			newarg = reencode_string_iconv(oldarg, namelen, ic_precompose);
>   			if (newarg)
>   				argv[i] = newarg;
> @@ -130,7 +130,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
>   		prec_dir->dirent_nfc->d_ino  = res->d_ino;
>   		prec_dir->dirent_nfc->d_type = res->d_type;
>
> -		if ((precomposed_unicode == 1) && has_utf8(res->d_name, (size_t)-1, NULL)) {
> +		if ((precomposed_unicode == 1) && has_non_ascii(res->d_name, (size_t)-1, NULL)) {
>   			if (prec_dir->ic_precompose == (iconv_t)-1) {
>   				die("iconv_open(%s,%s) failed, but needed:\n"
>   						"    precomposed unicode is not supported.\n"
>
Thanks Junio,
that partly obsoletes the patch I'm working on.
And as I didn't manage to catch up, may I send the result of my review?

a) in readdir we die() when iconv_open() fails, and we could/should do 
that in void precompose_argv() as well?

b) Should die("txt") be converted into die(_("txt")) to be able to 
translate the message?

c) We can remove the save/restore of errno at one place, similar to this:


@@ -106,11 +106,8 @@ PREC_DIR *precompose_utf8_opendir(const char *dirname)
                 free(prec_dir->dirent_nfc);
                 free(prec_dir);
                 return NULL;
-       } else {
-               int ret_errno = errno;
+       } else
                 prec_dir->ic_precompose = (iconv_t)-1;
-               errno = ret_errno;
-       }
