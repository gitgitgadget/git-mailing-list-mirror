From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Refactor recv_sideband()
Date: Mon, 13 Jun 2016 17:07:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1606131704060.1714@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Mon Jun 13 23:30:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCZJw-0003go-Mp
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 23:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423358AbcFMVWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 17:22:48 -0400
Received: from alt22.smtp-out.videotron.ca ([70.80.0.73]:10599 "EHLO
	alt22.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423106AbcFMVWr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2016 17:22:47 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jun 2016 17:22:46 EDT
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id CZ5DbiK1C3PUJCZ5EbN8Qk; Mon, 13 Jun 2016 17:07:45 -0400
X-Authority-Analysis: v=2.1 cv=cb1y1i3M c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=dg4UtMH5AAAA:8 a=VwQbUJbxAAAA:8 a=u-5gfMQP8x_Wrre-QY0A:9
 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=byNfn09xH3PuSfgbYLsR:22
 a=AjGcO6oz07-iQ99wixmX:22
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 8DAD22DA03BF;
	Mon, 13 Jun 2016 17:07:43 -0400 (EDT)
In-Reply-To: <20160613195224.13398-1-lfleischer@lfos.de>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
X-CMAE-Envelope: MS4wfOTbyzOlAoW5PLH+jICysDarXdLr/cS3dBrjTSOjdWs0Ms8WqsrTRSQCxPWzOs51a49Iw+QZ0npYbwaMwi73xejX0QAddPJqVAjm1ioXZE2CnsU3EO2z
 trYy601V2SMLrvSBgdDtJ7P2G9V3YuU1YG/YAEW4/f3pUqGwd54YsP4hNaXF7d7Pz+0LTkicV+m0oYjG0aHeiSdVyvm7PIhyxgc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297245>

On Mon, 13 Jun 2016, Lukas Fleischer wrote:

> Improve the readability of recv_sideband() significantly by replacing
> fragile buffer manipulations with more sophisticated format strings.
> Also, reorganize the overall control flow, remove some superfluous
> variables and replace a custom implementation of strpbrk() with a call
> to the standard C library function.
> 
> Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>

The previous code was a total abomination, even if I happen to know who 
wrote it.

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> I had a really hard time reading and understanding this function when I
> came up with my last patch. What I ended up with is almost a complete
> rewrite of recv_sideband() and I find the end result to be much more
> readable than what we have now. Given that this is quite invasive, it
> would be good to have some more eyes and opinions...
> 
> If you want me to split this patch into smaller changes, please let me
> know. However, finding a good way to split this into logical changes
> might not be easy given that the new code does not have much in common
> with what we had before.

Indeed. Anyway, numbers speak for themselves:

>  1 file changed, 30 insertions(+), 64 deletions(-)
> 
> diff --git a/sideband.c b/sideband.c
> index fde8adc..0a078c3 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -13,103 +13,69 @@
>   * the remote died unexpectedly.  A flush() concludes the stream.
>   */
>  
> -#define PREFIX "remote:"
> +#define PREFIX "remote: "
>  
>  #define ANSI_SUFFIX "\033[K"
>  #define DUMB_SUFFIX "        "
>  
> -#define FIX_SIZE 10  /* large enough for any of the above */
> -
>  int recv_sideband(const char *me, int in_stream, int out)
>  {
> -	unsigned pf = strlen(PREFIX);
> -	unsigned sf;
> -	char buf[LARGE_PACKET_MAX + 2*FIX_SIZE];
> -	char *suffix, *term;
> -	int skip_pf = 0;
> +	const char *term;
> +	const char *prefix = PREFIX, *suffix;
> +	char buf[LARGE_PACKET_MAX + 1];
> +	const char *b, *brk;
>  
> -	memcpy(buf, PREFIX, pf);
>  	term = getenv("TERM");
>  	if (isatty(2) && term && strcmp(term, "dumb"))
>  		suffix = ANSI_SUFFIX;
>  	else
>  		suffix = DUMB_SUFFIX;
> -	sf = strlen(suffix);
>  
>  	while (1) {
>  		int band, len;
> -		len = packet_read(in_stream, NULL, NULL, buf + pf, LARGE_PACKET_MAX, 0);
> +		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
>  		if (len == 0)
>  			break;
>  		if (len < 1) {
>  			fprintf(stderr, "%s: protocol error: no band designator\n", me);
>  			return SIDEBAND_PROTOCOL_ERROR;
>  		}
> -		band = buf[pf] & 0xff;
> +		band = buf[0] & 0xff;
> +		buf[len] = '\0';
>  		len--;
>  		switch (band) {
>  		case 3:
> -			buf[pf] = ' ';
> -			buf[pf+1+len] = '\0';
> -			fprintf(stderr, "%s\n", buf);
> +			fprintf(stderr, "%s%s\n", PREFIX, buf + 1);
>  			return SIDEBAND_REMOTE_ERROR;
>  		case 2:
> -			buf[pf] = ' ';
> -			do {
> -				char *b = buf;
> -				int brk = 0;
> -
> -				/*
> -				 * If the last buffer didn't end with a line
> -				 * break then we should not print a prefix
> -				 * this time around.
> -				 */
> -				if (skip_pf) {
> -					b += pf+1;
> -				} else {
> -					len += pf+1;
> -					brk += pf+1;
> -				}
> +			b = buf + 1;
>  
> -				/* Look for a line break. */
> -				for (;;) {
> -					brk++;
> -					if (brk > len) {
> -						brk = 0;
> -						break;
> -					}
> -					if (b[brk-1] == '\n' ||
> -					    b[brk-1] == '\r')
> -						break;
> -				}
> +			/*
> +			 * Append a suffix to each nonempty line to clear the
> +			 * end of the screen line.
> +			 */
> +			while ((brk = strpbrk(b, "\n\r"))) {
> +				int linelen = brk - b;
>  
> -				/*
> -				 * Let's insert a suffix to clear the end
> -				 * of the screen line if a line break was
> -				 * found.  Also, if we don't skip the
> -				 * prefix, then a non-empty string must be
> -				 * present too.
> -				 */
> -				if (brk > (skip_pf ? 0 : (pf+1 + 1))) {
> -					char save[FIX_SIZE];
> -					memcpy(save, b + brk, sf);
> -					b[brk + sf - 1] = b[brk - 1];
> -					memcpy(b + brk - 1, suffix, sf);
> -					fprintf(stderr, "%.*s", brk + sf, b);
> -					memcpy(b + brk, save, sf);
> -					len -= brk;
> +				if (linelen > 0) {
> +					fprintf(stderr, "%s%.*s%s%c", prefix,
> +						linelen, b, suffix, *brk);
>  				} else {
> -					int l = brk ? brk : len;
> -					fprintf(stderr, "%.*s", l, b);
> -					len -= l;
> +					fprintf(stderr, "%s%c", prefix, *brk);
>  				}
>  
> -				skip_pf = !brk;
> -				memmove(buf + pf+1, b + brk, len);
> -			} while (len);
> +				b = brk + 1;
> +				prefix = PREFIX;
> +			}
> +
> +			if (*b) {
> +				fprintf(stderr, "%s%s", prefix, b);
> +				/* Incomplete line, skip the next prefix. */
> +				prefix = "";
> +			}
>  			continue;
>  		case 1:
> -			write_or_die(out, buf + pf+1, len);
> +			write_or_die(out, buf + 1, len);
>  			continue;
>  		default:
>  			fprintf(stderr, "%s: protocol error: bad band #%d\n",
> -- 
> 2.8.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
