From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Thu, 27 Jun 2013 14:04:37 -0700
Message-ID: <7vip0zqn8a.fsf@alter.siamese.dyndns.org>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C6BC4B.9030905@web.de>
	<51C8BF2C.2050203@ramsay1.demon.co.uk>
	<7vy59y4w3r.fsf@alter.siamese.dyndns.org>
	<51C94425.7050006@alum.mit.edu> <51CB610C.7050501@ramsay1.demon.co.uk>
	<20130626223552.GA12785@sigill.intra.peff.net>
	<51CBD2FD.5070905@alum.mit.edu>
	<20130627195827.GB17601@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 27 23:04:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsJN0-00054b-AC
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 23:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865Ab3F0VEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 17:04:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab3F0VEl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 17:04:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98DBE29F94;
	Thu, 27 Jun 2013 21:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zn2tpjKUtAYgznoYzOiwjNkd6uw=; b=is+Qny
	m22q8qCyUpkEOpNyADZqZ4HjTgONzYZxrRNHGe12V1hI1inSpzw4xp9Nf6Sexh9V
	iJ0GtoTRmCukcjWT0bqS4/GBhkRw3hYLsAtnYsNLulb4qPeRXbg8pNkBgCNOVKxA
	BVEqZ6zKi4uPxXY5ErwLyh4zAUoW7QtAMShSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hb9yRfAPaPe8wLL6XWIp+ba03jzlZEja
	9dJhgsM4Zs+DsRPDkFWY9ESXhUCibe/C6cDiynO/QSK4pGddqqK+YTxOHOr+pfyT
	HggTNk06PibJb1f1tmB/AACdjW8JeHDweZsHoHsrALqFfMI2alIgb/rpoqQ2SIcR
	xJwIc0XLRKU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8084429F93;
	Thu, 27 Jun 2013 21:04:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A48129F90;
	Thu, 27 Jun 2013 21:04:39 +0000 (UTC)
In-Reply-To: <20130627195827.GB17601@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 27 Jun 2013 15:58:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E277982-DF6D-11E2-A319-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229159>

Jeff King <peff@peff.net> writes:

>> But, taking a step back, I think it is a bad idea to have an unreliable
>> stat() masquerading as a real stat().  If we want to allow the use of an
>> unreliable stat for certain purposes, let's have two stat() interfaces:
>> 
>> * the true stat() (in this case I guess cygwin's slow-but-correct
>> implementation)
>> 
>> * some fast_but_maybe_unreliable_stat(), which would map to stat() on
>> most platforms but might map to the Windows stat() on cygwin when so
>> configured.
>
> Yeah, that makes sense to me. I don't have a particular opinion on which
> way to go, as I do not use cygwin at all (and on most platforms, the
> two stat interfaces would just both call stat()).
>
> I will leave it up to Cygwin folks whether they want to do something
> like my patch as a band-aid while working up the two-stat() solution.

I think in the longer term two-stat solution is a good thing.  

0117c2f0 (Make core.sharedRepository work under cygwin 1.7,
2013-03-23) introduced get_st_mode_bits() to work around another
glitch in the fast-but-cheating-and-unreliable replacement, which
we may be able to revert once it is done.
