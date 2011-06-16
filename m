From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] help.c: Fix detection of custom merge strategy on
 cygwin
Date: Thu, 16 Jun 2011 15:24:34 -0700
Message-ID: <7v1uyth0t9.fsf@alter.siamese.dyndns.org>
References: <4DFA65F8.5010806@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jun 17 00:24:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXKzT-00053P-9i
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 00:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422628Ab1FPWYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 18:24:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932993Ab1FPWYh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 18:24:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75E215A9B;
	Thu, 16 Jun 2011 18:26:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=4hSm6O66o/5I5wouKSs05uEueo8=; b=o5BpTvErtu1WWp7Uiaaz
	Tqz27gyesoK2sJKknUj1riGaVXqDJWGcp/btN4vCBELfDXzZGHX16qCyPskC4ISS
	194Zy/bGLPYrJ5VtOzDcDnW/yI7IQvZq4zZ5TlMDZR8m0lftFtJGgLcvfj8yxAW4
	NH52yjp0m/tCpOpTdsxCDws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Xs8xPIsQ9W3niPV5P5vwZN5LJOEPhSNSav4tdPpsdI1O7t
	nkga3cd6yo95o9X3DNYkGsjL0ZA1M+haiCTQOZVZ+etn5iJXIwOPn6ceCgK0GMd5
	eyBaBp3RUd70hM5sE1J0dKrRPVWTrsPP7TesoIdaIQ3oMe4Fof7/iNI6wn/+k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B6505A9A;
	Thu, 16 Jun 2011 18:26:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C4ACF5A99; Thu, 16 Jun 2011
 18:26:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B80EB61E-9867-11E0-8CB1-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175939>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> -#ifdef WIN32
> +#if defined(WIN32) || defined(__CYGWIN__)
> +#if defined(__CYGWIN__)
> +if ((st.st_mode & S_IXUSR) == 0)
> +#endif
>  {	/* cannot trust the executable bit, peek into the file instead */
>  	char buf[3] = { 0 };
>  	int n;

This looks somewhat ugly.

I guess we could make the inner #if/#endif slightly more readable by
letting the compiler do more work, like this:

	#if defined(WIN32) || defined(__CYGWIN__)
        if (!defined(__CYGWIN__) || !(st.st_mode & S_IXUSR)) {
        	...
	}
        #endif

I dunno.
