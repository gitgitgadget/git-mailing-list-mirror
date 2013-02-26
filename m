From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH ] t4210-log-i18n: spell encoding name "UTF-8" correctly
Date: Tue, 26 Feb 2013 07:47:39 +0100
Message-ID: <512C5A8B.9070302@viscovery.net>
References: <7vobfuxrns.fsf@alter.siamese.dyndns.org> <20130209002710.GA5570@sigill.intra.peff.net> <7vfw16xqvj.fsf@alter.siamese.dyndns.org> <7va9rexqii.fsf@alter.siamese.dyndns.org> <20130211191607.GA21269@sigill.intra.peff.net> <7v621ymxfv.fsf@alter.siamese.dyndns.org> <20130211205958.GA32740@sigill.intra.peff.net> <512B22DE.9070603@viscovery.net> <20130225151916.GA7725@sigill.intra.peff.net> <7vmwusxlfm.fsf@alter.siamese.dyndns.org> <20130225203100.GA15932@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Haller <thom311@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 07:48:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAEKi-0005vy-Nc
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 07:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab3BZGrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 01:47:47 -0500
Received: from so.liwest.at ([212.33.55.24]:10879 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434Ab3BZGrr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 01:47:47 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UAEKB-0006mF-Ql; Tue, 26 Feb 2013 07:47:40 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6CD6D1660F;
	Tue, 26 Feb 2013 07:47:39 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <20130225203100.GA15932@sigill.intra.peff.net>
X-Enigmail-Version: 1.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217128>

Am 2/25/2013 21:31, schrieb Jeff King:
> Subject: [PATCH] utf8: accept alternate spellings of UTF-8
> ...
> JSixt, can you double-check that this passes t4210 for you?

Yes, t4210 and all other *i18n* and *log* tests pass with this patch.

Thanks,
-- Hannes

> 
>  utf8.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/utf8.c b/utf8.c
> index 1087870..8f6e84b 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -507,9 +507,25 @@ char *reencode_string(const char *in, const char *out_encoding, const char *in_e
>  
>  	if (!in_encoding)
>  		return NULL;
> +
>  	conv = iconv_open(out_encoding, in_encoding);
> -	if (conv == (iconv_t) -1)
> -		return NULL;
> +	if (conv == (iconv_t) -1) {
> +		/*
> +		 * Some platforms do not have the variously spelled variants of
> +		 * UTF-8, so let's fall back to trying the most official
> +		 * spelling. We do so only as a fallback in case the platform
> +		 * does understand the user's spelling, but not our official
> +		 * one.
> +		 */
> +		if (is_encoding_utf8(in_encoding))
> +			in_encoding = "UTF-8";
> +		if (is_encoding_utf8(out_encoding))
> +			out_encoding = "UTF-8";
> +		conv = iconv_open(out_encoding, in_encoding);
> +		if (conv == (iconv_t) -1)
> +			return NULL;
> +	}
> +
>  	out = reencode_string_iconv(in, strlen(in), conv);
>  	iconv_close(conv);
>  	return out;
