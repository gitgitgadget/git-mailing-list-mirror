From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Refactor recv_sideband()
Date: Tue, 14 Jun 2016 11:11:12 -0700
Message-ID: <xmqqa8inaben.fsf@gitster.mtv.corp.google.com>
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<alpine.LFD.2.20.1606131704060.1714@knanqh.ubzr>
	<alpine.LFD.2.20.1606141245490.1714@knanqh.ubzr>
	<CsLdb3qLMBok7CsLebwX38@videotron.ca>
	<alpine.LFD.2.20.1606141347310.1714@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 20:11:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCso4-0007Tg-4u
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 20:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbcFNSLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 14:11:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752541AbcFNSLP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 14:11:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24AF123020;
	Tue, 14 Jun 2016 14:11:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cuMGpI3k1frFNjDMk9DHbz2HWio=; b=AFkJky
	hiNmLsyiBDEFyHYSTyBsntkoeG295lUQX+TwetRAuQyh8UsVp46n56UCU92g6zg4
	+9DKpvcxCSMxL3m1pbovnTR/l69t9uzdT+OjIfu8cllJeaQfSn02K9gNd5v6fbMv
	WRdt0j1gMwPXcDJGLuLW95YKUlIciL7DaMLic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XdJaFHs7vGH9MxrNGUwmc2mdHATS/1Lp
	vIN2Id/AB2IMZ3k6ZPSigwcaSR0IaigWfwPjgMWRohc8O04/DISd6nJuZ1s9COU6
	YCNml5gk2fl9h8yiDfEj7RwM1I+o4HxMrO35usyI/a9s1Uu4d3MLGRi1y81J3ucz
	MvyiRja0uJU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DBEA2301F;
	Tue, 14 Jun 2016 14:11:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A5EC42301E;
	Tue, 14 Jun 2016 14:11:13 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.20.1606141347310.1714@knanqh.ubzr> (Nicolas Pitre's
	message of "Tue, 14 Jun 2016 13:55:06 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 61480A0E-325B-11E6-9523-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297315>

Nicolas Pitre <nico@fluxnic.net> writes:

> It is not buffered as it writes to stderr. And some C libs do separate 
> calls to write() for every string format specifier. So "%s%s%c" may end 
> up calling write() 3 times depending on the implementation.  The example 
> I gave in commit ed1902ef5c is real and I even observed it with strace 
> back then.

I think you meant 9ac13ec9 (atomic write for sideband remote
messages, 2006-10-11).

IIRC, back then we did't use to make as much use of strbuf API as we
do today; if we were doing that commit today, we would be doing
strbuf, I would suspect.
