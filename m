From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] do not depend on signed integer overflow
Date: Mon, 4 Oct 2010 17:33:31 -0500
Message-ID: <20101004223331.GB9994@burratino>
References: <1286227522-5468-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 00:36:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2teT-0002PG-Pq
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441Ab0JDWgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 18:36:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33490 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079Ab0JDWgw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 18:36:52 -0400
Received: by wyb28 with SMTP id 28so5458155wyb.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 15:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=71G47BV/jcRAXm9UVs+K9aREU8jWcrWj4IB+6Ta5Wlg=;
        b=e+8QmZEJK6od9FXsxf9BRJ2r7g2kilGJS3tzjVXF981v/kpZHVNSibfibXjfRNkVl2
         Qom19iakvtGGmFsYSK3wQrO/JNwiI4UqxTD6Ztj5nwzvtR/Sy7NkqOdG8dmv3yuMLn1G
         KsHYuzux9HGpBdOGmPt5oav2P3h/p4EME5SY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=t36BH6o9K24lPXAwzDFMLM5M+/N/1EssSPuebSAV2PmRf5J6SURaLnb1K3loeoJ4Ma
         UWgigCW5uSuh3dujvBhm/xiI2kHf0WDRgkqaeNbo8VC4HddpPLbxSpVLLdLjV35m+jnm
         rLLuLrFjERot/AQOAS7eVlkl0USm/T/CU7eE8=
Received: by 10.216.188.197 with SMTP id a47mr8338133wen.70.1286231811124;
        Mon, 04 Oct 2010 15:36:51 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id w29sm3395449weq.18.2010.10.04.15.36.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 15:36:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286227522-5468-1-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158135>

Erik Faye-Lund wrote:

> +++ b/git-compat-util.h
> @@ -28,6 +28,15 @@
>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
>  #define bitsizeof(x)  (CHAR_BIT * sizeof(x))
>  
> +/*
> + * Signed integer overflow is undefined in C, so here's a helper macro
> + * to detect if the sum of two integers will overflow. The bitsize to
> + * overflow at is taken from the first parameter, which must be zero
> + * or positive.
> + */
> +#define signed_add_overflows(a, b) \
> +    ((b) > ((INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a))) - (a)))

Yes, I still like it.  This could be made closer to self-documenting
like so:

#define maximum_signed_value_of_type(a) \
	(INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a)))

/*
 * Signed overflow is undefined in C, so here's a helper macro
 * to detect if the sum of two signed integers will overflow.
 *
 * Requires: a >= 0, typeof(a) equals typeof(b)
 */
#define signed_add_overflows(a, b) \
	((b) > maximum_signed_value_of_type(a) - (a))
