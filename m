From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 22/67] entry.c: convert strcpy to xsnprintf
Date: Tue, 15 Sep 2015 20:01:01 +0100
Message-ID: <55F86AED.4090500@ramsayjones.plus.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915154012.GV29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 21:01:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbvTQ-00028Z-PG
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 21:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbbIOTA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 15:00:56 -0400
Received: from avasout08.plus.net ([212.159.14.20]:34609 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbbIOTA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 15:00:56 -0400
Received: from [10.0.2.15] ([81.174.177.104])
	by avasout08 with smtp
	id HX0t1r0042FXpih01X0urD; Tue, 15 Sep 2015 20:00:54 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=IMS4QkGEsjO3VZZSAZDX8w==:117 a=IMS4QkGEsjO3VZZSAZDX8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=HGauzE_4p_s7H721VuMA:9
 a=QiFCt2cmwI4qtEZt:21 a=p9rD5CMmF9tA8pZz:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150915154012.GV29753@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277978>



On 15/09/15 16:40, Jeff King wrote:
> This particular conversion is non-obvious, because nobody
> has passed our function the length of the destination
> buffer. However, the interface to checkout_entry specifies
> that the buffer must be at least TEMPORARY_FILENAME_LENGTH
> bytes long, so we can check that (meaning the existing code
> was not buggy, but merely worrisome to somebody reading it).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  entry.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index 1eda8e9..582c400 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -96,8 +96,8 @@ static int open_output_fd(char *path, const struct cache_entry *ce, int to_tempf
>  {
>  	int symlink = (ce->ce_mode & S_IFMT) != S_IFREG;
>  	if (to_tempfile) {
> -		strcpy(path, symlink
> -		       ? ".merge_link_XXXXXX" : ".merge_file_XXXXXX");
> +		xsnprintf(path, TEMPORARY_FILENAME_LENGTH, "%s",
> +			  symlink ? ".merge_link_XXXXXX" : ".merge_file_XXXXXX");
>  		return mkstemp(path);
>  	} else {
>  		return create_file(path, !symlink ? ce->ce_mode : 0666);

Hmm, I was going to suggest strlcpy() again. However, if you expect an overflow to
occur, then xsnprintf() will at least bring it to your attention!  Checking for overflow
with strlcpy() is not rocket science either, and I guess we could add xstrlcpy() ... :-D

dunno.

ATB,
Ramsay Jones
