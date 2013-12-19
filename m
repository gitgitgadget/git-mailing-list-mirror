From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RLIMIT_NOFILE fallback
Date: Thu, 19 Dec 2013 09:39:55 -0800
Message-ID: <xmqqmwjwg2ok.fsf@gitster.dls.corp.google.com>
References: <20131218171446.GA19657@kitenet.net>
	<xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
	<20131218191702.GA9083@sigill.intra.peff.net>
	<xmqq61qmhrb3.fsf@gitster.dls.corp.google.com>
	<20131218212847.GA13685@sigill.intra.peff.net>
	<xmqqd2kthmcr.fsf@gitster.dls.corp.google.com>
	<20131218214001.GA14354@sigill.intra.peff.net>
	<xmqqzjnxg3zz.fsf@gitster.dls.corp.google.com>
	<20131219001519.GB17420@sigill.intra.peff.net> <52B32D18.80400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Joey Hess <joey@kitenet.net>,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 19 18:40:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VthZv-0000Lm-1a
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 18:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389Ab3LSRkA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Dec 2013 12:40:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49295 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752749Ab3LSRj7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Dec 2013 12:39:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC2B15A387;
	Thu, 19 Dec 2013 12:39:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=esgI0U5VJGei
	KStN/oTyL55Ij7w=; b=Lw7EJKN6DQvr0oOmtyIZDBDif+fhFzU9ThLhxeuVltml
	XtEk4ycHs0wBRz0Nq1k10pTYm1+VQgi2fizTanb17PQCNLLnGnbwg2VOpJqWq3SJ
	R1sNmN7mqwwmyaHrMRK3+B1ztbHggIFYl8BJm9pPlDlPWefxDQ4UMYta+t+eWwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gNpCzL
	tcw9OrfEYcmPyUNXQeHa8yMYTk1zHko1kTvAZdrYxFtxn24L48Fg/5VgoUBKqH8l
	OBVnwOZC16Iggbyt/EPJv7mwxjbebu0nsbANUrFlOtvonPf5y9HVzfUtSbnDsDo0
	9gzc/kMVIHuStT8DsQHkkSWADYey9t37dVbVE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3DAA5A386;
	Thu, 19 Dec 2013 12:39:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E75515A384;
	Thu, 19 Dec 2013 12:39:57 -0500 (EST)
In-Reply-To: <52B32D18.80400@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Thu, 19 Dec 2013 18:30:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 942CEBE0-68D4-11E3-8B47-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239527>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Thanks for an interesting reading,
> please allow a side question:
> Could it be, that "-1 =3D=3D unlimited" is Linux specific?
> And therefore not 100% portable ?
>
> And doesn't "unlimited" number of files call for trouble,
> having the risk to starve the machine ?
>
> BTW: cygwin returns 256.

If you look at the caller, you will see that we do cap the value
returned from this helper function down to a more reasonable and not
so selfish maximum, exactly for the purpose of avoiding the risk of
starving other processes.

>
> ------------
> http://pubs.opengroup.org/onlinepubs/007908799/xsh/sysconf.html
> RETURN VALUE
>
>     If name is an invalid value, sysconf() returns -1 and sets errno =
to indicate the error. If the variable corresponding to name is associa=
ted with functionality that is not supported by the system, sysconf() r=
eturns -1 without changing the value of errno.=20

That is a rather dated document.  POSIX.1-2013 (look for the URL to
the corresponding page in an earlier message from me) has a bit
tighter wording than that to clarify the "there is no limit" case.

In addition, the final version Peff and I worked out does not even
look at the value of errno, in order not to rely on possibly
ambiguous interpretations of negative return values.  So I think we
are good.

Thanks.

> ---------- Mac OS, based on BSD (?): ----------=20
> RETURN VALUES
>      If the call to sysconf() is not successful, -1 is returned and e=
rrno is
>      set appropriately.  Otherwise, if the variable is associated wit=
h func-
>      tionality that is not supported, -1 is returned and errno is not=
 modi-
>      fied.  Otherwise, the current variable value is returned.
>
> ERRORS
>      The sysconf() function may fail and set errno for any of the err=
ors spec-
>      ified for the library function sysctl(3).  In addition, the foll=
owing
>      error may be reported:
>
>      [EINVAL]           The value of the name argument is invalid.
> [snip]
>      The sysconf() function first appeared in 4.4BSD.
>
> -----------
> Linux, Debian:
>       OPEN_MAX - _SC_OPEN_MAX
>               The  maximum number of files that a process can have op=
en at any
>               time.  Must not be less than _POSIX_OPEN_MAX (20).
> [snip]
> RETURN VALUE
>        If name is invalid, -1 is returned, and errno is set to EINVAL=
=2E  Other=E2=80=90
>        wise, the value returned is the value of the system resource a=
nd  errno
>        is  not  changed.  In the case of options, a positive value is=
 returned
>        if a queried option is available, and -1 if it is not.  In the=
 case  of
>        limits, -1 means that there is no definite limit.
