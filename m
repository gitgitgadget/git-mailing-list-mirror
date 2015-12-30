From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit message
Date: Wed, 30 Dec 2015 14:56:44 -0800
Message-ID: <xmqqfuyjczpv.fsf@gitster.mtv.corp.google.com>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
	<20151220074559.GF30662@sigill.intra.peff.net>
	<xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com>
	<20151221065944.GA3550@sigill.intra.peff.net>
	<xmqqio3rhg2f.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1512301535550.14434@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 30 23:56:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEPfn-0002Gh-Fq
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 23:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbbL3W4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 17:56:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751387AbbL3W4q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 17:56:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6CC536232;
	Wed, 30 Dec 2015 17:56:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C1ctVTYytVeOgmHDzxaL2/aWRgw=; b=dilh1U
	doc2wE7M138zNkE2y4+bIkfWSHOW+x5OpHfAaX6smpbGB88LcVxduyIicBBZcGtt
	xa6CuRKCM8ISE+xaEhbVUyERlsRPPyXWx8EeNs8K2oxbEY0Hj3HFddopsJkyZqG8
	j7hp37W+b6z55fiPaXsrPAOGk/RoeyAP2VD6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uYhc5YjMNC+nFwr/Rg5tdNt3VxHCjMXH
	TldW77jORazusLNGV7h6UcW3YxITdCopEA/Hn9hVsBJqAtgzR5S3bRXz8y7lnM7o
	yoAV+pDrKl9dNMuLEva9PxXUJTVOOO70F1cc6czKtgMzwhtkUpldn7nUAgsDM9WS
	RZzNCGHkFR4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DECE436231;
	Wed, 30 Dec 2015 17:56:45 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 61AE836230;
	Wed, 30 Dec 2015 17:56:45 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1512301535550.14434@virtualbox> (Johannes
	Schindelin's message of "Wed, 30 Dec 2015 15:50:09 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 999966E6-AF48-11E5-AA68-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283213>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So maybe
>
> 	fcreate_or_truncate(const char *path)
> 	{
> 		 FILE *ret = fopen(path, "w");
>
> 		 if (!ret && errno == EPERM) {
> 			 if (!unlink(path))
> 				 ret = fopen(path, "w");
> 			 else
> 				 errno = EPERM;
> 		 }
> 		 return ret;
> 	 }
>
> ?

I do not know fcreate_or_truncate() is a good name, though.  Looking
for "fcreate(3)" seems to find something quite obscure and unrelated
to what we want (http://linux.die.net/man/3/fcreate).  Also we call
a function X_or_Y to mean "try to do our primary thing X, and do Y
instead when it fails", but what we want to do here is not that.  We
are not interested in creating (i.e. we can happily live with an
existing file opened for writing), and we do not just truncate if we
cannot open the original for writing (i.e. we do return a writable
file handle) [*1*].

In any case, obviously the return value of the function needs to be
of type "FILE *".

Other than that, the code inside the function looks exactly like
what I had in mind.

Thanks.


[Footnote]

*1* We tend to call a function sane_X() when we are fixing an
    undesirable behaviour in the underlying function X (e.g.
    sane_execvp()).  In that sense it is very tempting to call this
    sane_fopen() but our use is limited to fopen(path, "w"), i.e.
    "open for writing, while truncating if existing" use case of
    fopen().
