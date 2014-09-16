From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] credential-cache: close stderr in daemon process
Date: Tue, 16 Sep 2014 11:10:29 -0700
Message-ID: <xmqqtx47308a.fsf@gitster.dls.corp.google.com>
References: <20140914073506.GA19667@peff.net>
	<xmqqoaug4la4.fsf@gitster.dls.corp.google.com>
	<20140916002825.GD5019@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 16 20:10:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTxD2-00026y-EJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 20:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609AbaIPSKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 14:10:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62784 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754250AbaIPSKc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 14:10:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E761386C7;
	Tue, 16 Sep 2014 14:10:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mVgTngvCDSrPRdASXsx3H2ezFlk=; b=jL46f8
	XKr/sxU+Tq5qtBk0I4tf9iHyfm4HTTAIYd8PEO6PaBXwNbHlH+x7FaQ77YjVhy57
	HgP9iefp7EXZxt+3aLDCTAldzw0NHLQ5Hg/FMPKc53EuVZCliB0/QRp0P+og2vIz
	4d8tBA5ey52wU6WshH4YX7PRlw2SoRGnkLSfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TdoDTpIgPdMFdnFM37/tE7wg7uJqVMfC
	XuVthF20wmSdXBhi0kYoFi74wiGxA329WXdVO3HlrpLk1m7zVYKApfKF0iERln43
	wGDazodbb4r26QBteJtlf74h8xzvpZq7OzFE1ZIePB0EDbV55ovRhyymwpwGlj8d
	NK6wCeHIF9I=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C91A386C6;
	Tue, 16 Sep 2014 14:10:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D50E3386C5;
	Tue, 16 Sep 2014 14:10:30 -0400 (EDT)
In-Reply-To: <20140916002825.GD5019@peff.net> (Jeff King's message of "Mon, 15
	Sep 2014 20:28:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BEA16130-3DCC-11E4-9D6E-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257135>

Jeff King <peff@peff.net> writes:

> Squash this in?

Yeah, I did a crude one without _errno() while sending the report;
will replace.

Thanks.

>
> diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
> index c07a67c..c2f0049 100644
> --- a/credential-cache--daemon.c
> +++ b/credential-cache--daemon.c
> @@ -212,8 +212,10 @@ static void serve_cache(const char *socket_path, int debug)
>  
>  	printf("ok\n");
>  	fclose(stdout);
> -	if (!debug)
> -		freopen("/dev/null", "w", stderr);
> +	if (!debug) {
> +		if (!freopen("/dev/null", "w", stderr))
> +			die_errno("unable to point stderr to /dev/null");
> +	}
>  
>  	while (serve_cache_loop(fd))
>  		; /* nothing */
