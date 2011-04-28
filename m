From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 07:36:17 -0500
Message-ID: <20110428123617.GA2062@elie>
References: <20110427225114.GA16765@elte.hu>
 <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu>
 <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu>
 <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
 <4DB93D16.4000603@cs.helsinki.fi>
 <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>
 <4DB941CD.2050403@cs.helsinki.fi>
 <BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Ingo Molnar <mingo@elte.hu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 14:36:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFQSS-00084b-9L
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 14:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757404Ab1D1Mga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 08:36:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62461 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757274Ab1D1MgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 08:36:24 -0400
Received: by iyb14 with SMTP id 14so2165198iyb.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 05:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3rusJ9YkotLc1938X6iGSoUlJK3CnWwyIbErP6LqUGA=;
        b=GSTEfzY5WvRapTcLikA8fl6DHr6jBwFM0rHUYlfP1uzHu63x2ZzSJS3mH1Pp1oZsZy
         zXm9CgmjtPgN6PYA8Nsx+MdU68SNxDsgTx4aXSAlMuh8JJunYM21X+cKo+81WleZ4ruC
         u0LjJFeOV8nCbORO6g8EwnT+2yPIasibHaRIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=D1HJjOUNYQqmBXsFTyZDjO0ghde2Ig7eyn+oUIYuVeUG3wdiZcNTN6lkASBquyuL5k
         n2HyTSCSjzokPs5xrOAZtHq6gyD/Sz9FOm9kPdLlVtnxMXT28xMQ/luWnc9gJQbeYw3a
         tngTTr6IDdU0vLrVt177r7cDAaBORf//kFrFY=
Received: by 10.42.239.6 with SMTP id ku6mr3953290icb.189.1303994183137;
        Thu, 28 Apr 2011 05:36:23 -0700 (PDT)
Received: from elie (adsl-69-209-62-211.dsl.chcgil.ameritech.net [69.209.62.211])
        by mx.google.com with ESMTPS id gy41sm707016ibb.22.2011.04.28.05.36.21
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 05:36:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172362>

Hi,

A side note for amusement.

Erik Faye-Lund wrote:

> --- a/cache.h
> +++ b/cache.h
> @@ -681,13 +681,17 @@ extern char *sha1_pack_name(const unsigned char *sha1);
>  extern char *sha1_pack_index_name(const unsigned char *sha1);
>  extern const char *find_unique_abbrev(const unsigned char *sha1, int);
>  extern const unsigned char null_sha1[20];
> -static inline int is_null_sha1(const unsigned char *sha1)
> +static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>  {
> -	return !memcmp(sha1, null_sha1, 20);
> +	/* early out for fast mis-match */
> +	if (*sha1 != *sha2)
> +		return *sha1 - *sha2;
> +
> +	return memcmp(sha1 + 1, sha2 + 1, 19);
>  }

On the off-chance that sha1 and sha2 are nicely aligned, a more
redundant

	if (*sha1 != *sha2)
		return *sha1 - *sha2;

	return memcmp(sha1, sha2, 20);

would take advantage of that (yes, this is just superstition, but it
somehow seems comforting anyway).

Anyway, assuming it does not kill performance for some reason, the
above sounds good to me.  Thanks for spelling it out.

Jonathan
