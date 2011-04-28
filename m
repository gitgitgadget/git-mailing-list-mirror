From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 13:20:54 -0700
Message-ID: <7v8vuu3z6h.fsf@alter.siamese.dyndns.org>
References: <20110427225114.GA16765@elte.hu>
 <7voc3r5kzn.fsf@alter.siamese.dyndns.org> <20110428062717.GA952@elte.hu>
 <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu>
 <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
 <20110428101902.GA17257@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Apr 28 22:21:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFXiK-0000CN-Qc
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 22:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933482Ab1D1UVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 16:21:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933479Ab1D1UVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 16:21:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DCA534FA1;
	Thu, 28 Apr 2011 16:23:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9BKGO72qFR4H+8cOmCnGlsifObo=; b=HGGIIL
	hud/CfM/SbGBofoluEvecbVuxMc+J5dEAUidgsFcXuPZRk/oxOtafP8Ypy+HVL9w
	InR0nDFIL+HLOTRpXjRjNynaD1v8fLScYSJTnu9D931+K4Bnxm9PYaQleaSsNckE
	N/r66aL4YxSnrm8bB30r026vaJ6OWS2q3FATk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iCY7+KFaO3yyscqab5OCZd3mZcjTMQt6
	/+mHe6U8touV/oTalUspWqIgCjlRKoOUHpbij9Wo0eqKiqv5NS7lSrGzS/PdtRnC
	3UVPmnAkeMORcYK6TXncHS0Sc5goGmtFFXsYthRbQ86oOFMvDGt24Re/5tndOwkp
	YY5PRK+/0qI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4121F4F99;
	Thu, 28 Apr 2011 16:23:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3AFAB4F95; Thu, 28 Apr 2011
 16:22:59 -0400 (EDT)
In-Reply-To: <20110428101902.GA17257@elte.hu> (Ingo Molnar's message of "Thu,
 28 Apr 2011 12:19:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 578BA102-71D5-11E0-9D90-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172400>

Ingo Molnar <mingo@elte.hu> writes:

> In any case, i'll retract the null case as it really isnt called that often in 
> the tests i've done - updated patch below - it simply falls back on to hashcmp.
>
> Thanks,
>
> 	Ingo
>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Thanks, will queue this version.

> diff --git a/cache.h b/cache.h
> index 2674f4c..39fa9cd 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -675,14 +675,24 @@ extern char *sha1_pack_name(const unsigned char *sha1);
>  extern char *sha1_pack_index_name(const unsigned char *sha1);
>  extern const char *find_unique_abbrev(const unsigned char *sha1, int);
>  extern const unsigned char null_sha1[20];
> -static inline int is_null_sha1(const unsigned char *sha1)
> +
> +static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>  {
> -	return !memcmp(sha1, null_sha1, 20);
> +	int i;
> +
> +	for (i = 0; i < 20; i++, sha1++, sha2++) {
> +		if (*sha1 != *sha2)
> +			return *sha1 - *sha2;
> +	}
> +
> +	return 0;
>  }
> -static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
> +
> +static inline int is_null_sha1(const unsigned char *sha1)
>  {
> -	return memcmp(sha1, sha2, 20);
> +	return !hashcmp(sha1, null_sha1);
>  }
> +
>  static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
>  {
>  	memcpy(sha_dst, sha_src, 20);
