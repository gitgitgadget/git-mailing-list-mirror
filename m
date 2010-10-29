From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add support for the SUA layer (interix; windows)
Date: Thu, 28 Oct 2010 17:50:31 -0700
Message-ID: <7veib99608.fsf@alter.siamese.dyndns.org>
References: <1288168793-11159-1-git-send-email-markus.duft@salomon.at>
 <1288168793-11159-2-git-send-email-markus.duft@salomon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Duft <mduft@gentoo.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: mduft@s01en22.salomon.at
X-From: git-owner@vger.kernel.org Fri Oct 29 02:50:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBdBE-00004s-3m
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 02:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758438Ab0J2Auq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 20:50:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756174Ab0J2Aup (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 20:50:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1A961DDF;
	Thu, 28 Oct 2010 20:50:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R/CdNb1nxKy/6MnmSJSGpV8Zq3A=; b=PaqzRu
	e4lZVAtjT0CBw0ySx+vRsq3RACKRqH1X2y6FS9oIAxV3eBUN8hlmtpB+Rk3toj+0
	uyfpIWxPlbkrmCV3NHpAni8U3FxcbphahpIXoHJ3DRe6J2stFB4+l8+qqb5tpmBP
	lmLoF5Jdu/2bIJZp+1tv0Q917YkCpNBvkJ6O0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dikCwSIcO6OL30gp+R0WHF+HCnFjzx/B
	qOLUBYsga7oTzpwy5VjdRwH6d8jhvD07jLB+seuElOrB6zyXP3ONurWnx0LgvGjh
	pkUNJUrVSEByA2u/ENsBnDp7rLRa6crRPKgLW3TJn1FOh5c3wgslFGPTU0I+TX6t
	78+JvZtvSo4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83FB21DDE;
	Thu, 28 Oct 2010 20:50:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8B8E1DDD; Thu, 28 Oct
 2010 20:50:33 -0400 (EDT)
In-Reply-To: <1288168793-11159-2-git-send-email-markus.duft@salomon.at>
 (mduft@s01en22.salomon.at's message of "Wed\, 27 Oct 2010 10\:39\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8C1E7A20-E2F6-11DF-B4C4-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160257>

mduft@s01en22.salomon.at writes:

> diff --git a/daemon.c b/daemon.c
> index 9326d3a..d68a31f 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -956,7 +956,11 @@ static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t
>  		    listen_addr, listen_port);
>  
>  	if (pass && gid &&
> -	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
> +	    (
> +#ifndef NO_INITGROUPS
> +		    initgroups(pass->pw_name, gid) || 
> +#endif
> +	     setgid (gid) ||
>  	     setuid(pass->pw_uid)))
>  		die("cannot drop privileges");
>  

It would be much nicer to do this:

        #ifdef NO_INITGROUPS
        #define initgroups(x,y) (0) /* nothing */
        #endif

near the beginning of the file.  That would make life of people who have
changes in flight that would touch the same area of the code a lot easier.
