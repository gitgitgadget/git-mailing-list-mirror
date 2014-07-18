From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/12] wrapper.c: simplify warn_if_unremovable
Date: Fri, 18 Jul 2014 15:21:46 -0700
Message-ID: <xmqqlhrql345.fsf@gitster.dls.corp.google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
	<1405549392-27306-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 00:22:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8GXO-00019s-Oa
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 00:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756242AbaGRWVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 18:21:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55648 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755462AbaGRWVy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 18:21:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A24032853D;
	Fri, 18 Jul 2014 18:21:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AdFgmjNUn1RcGwlHUM8zs1N0pAw=; b=Ie/Vsb
	/EqQ/caTUXAKT7TukFh//2V0I39EWXbs399XfCq+4k4JMEgCvp2NO1aaNkFNVMWN
	PHmLex6SJ6+uL1D9C64zMy7W5ddMWLepA0Uo+wbatTQ09FIgunNBS6L0gue91REA
	RJ3rr371H0qcuCTkM5/XV6dlb4CNOHD6HRjMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oXd9OEA1T8snynogMFvhFz3ln8G2UBF4
	3SvkCAvouofcFeKdOO9qfLtp51NPSyTq0O2hly72A/q7z264uKHv+d+KR9tjswYp
	ogyWv67sQ+JcR8mj2JPlScjcx/YCmrcy1TxSzSltW3+HjnjYzWZ+uMds4PjIty7X
	yRfgIn2dB2M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9915F2853C;
	Fri, 18 Jul 2014 18:21:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CB0E428536;
	Fri, 18 Jul 2014 18:21:47 -0400 (EDT)
In-Reply-To: <1405549392-27306-2-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 16 Jul 2014 15:23:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E869BECC-0EC9-11E4-99EF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253853>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  wrapper.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/wrapper.c b/wrapper.c
> index bc1bfb8..740e193 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -429,14 +429,12 @@ int xmkstemp_mode(char *template, int mode)
>  
>  static int warn_if_unremovable(const char *op, const char *file, int rc)
>  {
> -	if (rc < 0) {
> -		int err = errno;
> -		if (ENOENT != err) {
> -			warning("unable to %s %s: %s",
> -				op, file, strerror(errno));
> -			errno = err;
> -		}
> -	}
> +	int err;
> +	if (rc >= 0 || errno == ENOENT)
> +		return rc;
> +	err = errno;
> +	warning("unable to %s %s: %s", op, file, strerror(errno));
> +	errno = err;
>  	return rc;
>  }

Looks sensible.
