From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Wed, 27 Apr 2011 18:18:12 -0500
Message-ID: <20110427231748.GA26632@elie>
References: <20110427225114.GA16765@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Apr 28 01:18:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFE01-0003C2-0V
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 01:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757154Ab1D0XSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 19:18:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60034 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396Ab1D0XST (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 19:18:19 -0400
Received: by iyb14 with SMTP id 14so1767805iyb.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 16:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4wTvBVIt9NeR+Hts0eE3rcq+GtCbbq7grb2U6H4DdPo=;
        b=mgHry5iN7jOgdUEZw3fuZNoJocJxiUFHC0ndfj5kbxBpdkEYuKR/9fcb8uZ12JLaEL
         WRkG3u5pcxYlYfNxDQxNBIlPr4ptllX/RgcmAZLm3j8XNGKtrcSYOOAO1ZZKz/iRNtcO
         WWMRgp7mR3CbxA5PxnRUFnDW+mC7QzJDhfTco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SDHchVWkqrMBXSfpW5ZWjmUSHo1HNN/TucAEHDC70zh14QArAw79/mcRRJBEeshkaE
         m2PlD88cexYrubcmSm3LZSr64FdXVARJcFBDYJ3DZJgWIzyq/pbB3Wa5TM2f+a97o2jh
         msU/BT1hx50YsBFqQzdFvHcBusbaGZ2bw/b0g=
Received: by 10.42.162.10 with SMTP id v10mr2658526icx.8.1303946298595;
        Wed, 27 Apr 2011 16:18:18 -0700 (PDT)
Received: from elie (adsl-69-209-61-200.dsl.chcgil.sbcglobal.net [69.209.61.200])
        by mx.google.com with ESMTPS id a8sm469406ibg.65.2011.04.27.16.18.16
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 16:18:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110427225114.GA16765@elte.hu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172289>

Ingo Molnar wrote:

> Most overhead is in hashcmp(), which uses memcmp(), which falls back to 
> assembly string operations.
>
> But we know that hashcmp() compares hashes, which if they do not match, the first byte
> will differ in 99% of the cases.
>
> So i tried the patch below: instead of relying on GCC putting in the string 
> ops, i used an open-coded loop for this relatively short comparison, which does 
> not go beyond the first byte in 99% of the cases.
[...]
> --- a/cache.h
> +++ b/cache.h
> @@ -675,14 +675,33 @@ extern char *sha1_pack_name(const unsigned char *sha1);
[...]
> +static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>  {
> -	return memcmp(sha1, sha2, 20);
> +	int i;
> +
> +	for (i = 0; i < 20; i++, sha1++, sha2++) {

Hm.  This would be very sensitive to the compiler, since a too-smart
optimizer could take this loop and rewrite it back to memcmp!  So I
wonder if it's possible to convey this to the compiler more precisely:

	return memcmp_probably_differs_early(sha1, sha2, 20);

E.g., how would something like

	const unsigned int *start1 = (const unsigned int *) sha1;
	const unsigned int *start2 = (const unsigned int *) sha2;

	if (likely(*start1 != *start2)) {
		if (*start1 < *start2)
			return -1;
		return +1;
	}
	return memcmp(sha1 + 4, sha2 + 4, 16);

perform?

I suspect we don't have to worry about endianness as long as hashcmp
yields a consistent ordering, but I haven't checked.

Thanks, that was interesting.

Regards,
Jonathan
