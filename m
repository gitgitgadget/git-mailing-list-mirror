From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Sun, 21 Jul 2013 13:58:58 -0700
Message-ID: <7vmwpfsk8d.fsf@alter.siamese.dyndns.org>
References: <51E84F4E.3050600@ramsay1.demon.co.uk>
	<20130721173936.GA10647@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 21 22:59:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V10ij-0006xJ-7s
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 22:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096Ab3GUU7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 16:59:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756064Ab3GUU7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 16:59:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9223E32DFD;
	Sun, 21 Jul 2013 20:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cHAgZTS+j1f1yvPSiL7MqxkcomM=; b=EGNDcK
	DD4Qjkvzn25KDyenzC9j4BY+WHTCuossadfNKfKYiLKJhZoyvKOg0/39DMQkUS1D
	YgKAFE8NG7lAsUwfn3WBWngbx+ZH2N8AuoEnZOTPedsn+nm33fRULNmpE4NDxE5z
	fAs7TqMiow/uj+GZPeD4wCJtkF2GnZsJS896E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JVv8RSBWpWGJvSgJop7Pri1Y2kSNfprI
	a3foW+WW8CoS0WVp6zlOTzzJYUsa7xMjFXjvMi4D2SnjOEXV6qhvj75ZfSIxk0CP
	p0uTG8Do/j7eJdPMkxeG+qqfvYnIw/SN+h78r2JQYVQ1gdxt4ah+HMfr5oARtiax
	hqqq1VAh3/o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8553A32DFC;
	Sun, 21 Jul 2013 20:59:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D13AB32DF8;
	Sun, 21 Jul 2013 20:58:59 +0000 (UTC)
In-Reply-To: <20130721173936.GA10647@elie.Belkin> (Jonathan Nieder's message
	of "Sun, 21 Jul 2013 10:39:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5DBB5806-F248-11E2-BCA5-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230943>

Jonathan Nieder <jrnieder@gmail.com> writes:

> How about something like the following?
>
> diff --git i/cache.h w/cache.h
> index f2915509..ba028b75 100644
> --- i/cache.h
> +++ w/cache.h
> @@ -1124,6 +1124,7 @@ struct object_info {
>  		} packed;
>  	} u;
>  };
> +#define OBJECT_INFO_INIT { NULL, NULL, OI_CACHED, { { NULL, 0, 0 } } }

There are quite a many hits from

	$ git grep '= { *NULL *};'

only some of which are "char *var[] = { NULL }", which is perfectly
fine, but others are to initialise "struct foo" (or "foo_t" which is
typedef'ed) that share the same "writing NULL means the initialiser
knows the order of the fields".

I doubt if the above #define is a maintainable solution, and worse
yet, thinking about the fact that such a macro is necessary only for
a structure whose first field happens to be of a pointer type, it
strongly suggests me that it is not conceptually the right thing to
do.

Can't we have sparse fixed (or skip this specific warning) instead?
