From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to ignore instead?
Date: Tue, 27 Oct 2015 10:52:52 -0700
Message-ID: <xmqqoafkci6j.fsf@gitster.mtv.corp.google.com>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
	<CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
	<xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
	<CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
	<CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
	<xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
	<20151026215016.GA17419@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 27 18:53:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8Qi-0001Xj-6G
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 18:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbbJ0Rw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 13:52:56 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754408AbbJ0Rwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 13:52:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 520CC2695A;
	Tue, 27 Oct 2015 13:52:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0OtN+m/JFv2+IqdWYbo9WOUkP4I=; b=ePIM0x
	BYakFco9eJLK6Pf3wVD6Y4NwAlHOxWWnZ6fBwqB1SROotKgfrX0WOuStN8Vfuyk7
	Yu7KS7usYJTRqjN1ma4lbgWkQgwTi4PgyMvuUubXQrTSW/QcwY28OCMj3fYn9wEd
	ZjoTYJKkQc10Eef3ADeM+Bj38mlDoxDd0vFK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IIlwiK8F0coBZHwNqJKyu27WqXg5ng/I
	qVWPQ0jGZJ/NOo5Er5/NCbYFMtdHgbG++cBBNmRF5oCRA2vARFX5x1PpWZ9A92Y0
	rVpJ/yYLQxV0fF+UgHAfsZW7rbffbecn/VhddSkocXA/pIFzG2ZPEOfHq88JXWfw
	YnqKhJizz5U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4850C26958;
	Tue, 27 Oct 2015 13:52:54 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C381626954;
	Tue, 27 Oct 2015 13:52:53 -0400 (EDT)
In-Reply-To: <20151026215016.GA17419@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 26 Oct 2015 17:50:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8C47D86C-7CD3-11E5-AA6D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280272>

Jeff King <peff@peff.net> writes:

> But these days, people often have several simultaneous sessions open.
> They may have multiple ssh sessions to a single machine, or they may
> have a bunch of terminal windows open, each of which has a login shell
> and will send HUP to its children when it exits. In that case, you have
> a meta-session surrounding those individual terminal sessions, and you
> probably do want to keep the cache going as long as the meta session[1].
> ...
> [1] Of course we have no idea when that meta-session is closed. But if
>     you have a script that runs on X logout, for instance, you could put
>     "git credential-cache exit" in it.

Yes.  Probably the right way forward is to make it a non-issue by
teaching users how to control the lifetime of the "daemon" process,
and wean them off relying on "it is auto-spawned if you forgot to
start", as that convenience of auto-spawning is associated with
"...but how it is auto-shutdown really depends on many things in
your specific environment", which is the issue.
