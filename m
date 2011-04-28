From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 15:12:13 +0300
Message-ID: <4DB9599D.3010208@cs.helsinki.fi>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org> <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com> <20110428093703.GB15349@elte.hu> <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com> <4DB93D16.4000603@cs.helsinki.fi> <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com> <4DB941CD.2050403@cs.helsinki.fi> <BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 28 14:12:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFQ4z-0002wl-Cu
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 14:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978Ab1D1MMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 08:12:15 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:34145 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab1D1MMO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 08:12:14 -0400
Received: from l227.local ([192.100.124.156])
  (AUTH: PLAIN penberg, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Thu, 28 Apr 2011 15:12:13 +0300
  id 0008D33F.4DB9599D.00006933
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172356>

On 4/28/11 2:59 PM, Erik Faye-Lund wrote:
> So my preference is still something like this. Call me conservative ;)
>
> diff --git a/cache.h b/cache.h
> index c730c58..8bc03c6 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -681,13 +681,17 @@ extern char *sha1_pack_name(const unsigned char *sha1);
>   extern char *sha1_pack_index_name(const unsigned char *sha1);
>   extern const char *find_unique_abbrev(const unsigned char *sha1, int);
>   extern const unsigned char null_sha1[20];
> -static inline int is_null_sha1(const unsigned char *sha1)
> +static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>   {
> -	return !memcmp(sha1, null_sha1, 20);
> +	/* early out for fast mis-match */
> +	if (*sha1 != *sha2)
> +		return *sha1 - *sha2;
> +
> +	return memcmp(sha1 + 1, sha2 + 1, 19);
>   }
> -static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
> +static inline int is_null_sha1(const unsigned char *sha1)
>   {
> -	return memcmp(sha1, sha2, 20);
> +	return !hashcmp(sha1, null_sha1);
>   }
>   static inline void hashcpy(unsigned char *sha_dst, const unsigned
> char *sha_src)
>   {

Yup, might be the most reasonable thing to do if it still speeds things up.

			Pekka
