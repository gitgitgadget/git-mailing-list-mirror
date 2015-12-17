From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: emulate write(2) that fails with a EPIPE
Date: Thu, 17 Dec 2015 08:40:55 -0800
Message-ID: <xmqqegelc9k8.fsf@gitster.mtv.corp.google.com>
References: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de>
	<xmqq7fkedyx7.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1512171037310.6483@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 17 17:41:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9bcI-00074M-CY
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 17:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967194AbbLQQk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 11:40:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965052AbbLQQk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 11:40:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41473300BA;
	Thu, 17 Dec 2015 11:40:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eJ+Jty9QC+bS78LbSHlbuS+x8CE=; b=ih01Ri
	0C/noU/GBPvMMTUfPqevFMjFe5V4Ie4p/fQVWQL6JwUeaaodDFcJQ2lQVwwBqHCE
	0SWP8DduVOtNQIduUTZxaSNaXqAzTOMghim8tCpw2gSd5qxpimMUHDgPSY3c47oZ
	qUHwsRKk2VU8sBSXLrW1reuvIxkk0lzDftDfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oJH0aQStBFZo81e2plORMcutGDJhdm0Z
	IWMJNcmAno0OjQoksXLZMKj7UlM4le993w1gy17rjtot/F90ie2MkYlp6rHXvvyG
	Y76LkA/YScsfsd835O/pPnIu64vxohgTAIVS4ZZe9A70b1PHTxu1Qm/s4vmB4Uk5
	OcJqIf1KNXs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 380D6300B9;
	Thu, 17 Dec 2015 11:40:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B1CF5300B7;
	Thu, 17 Dec 2015 11:40:56 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1512171037310.6483@virtualbox> (Johannes
	Schindelin's message of "Thu, 17 Dec 2015 10:39:43 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F22C1040-A4DC-11E5-841E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282656>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> My intuition (which I honestly did not verify using performance tests) was
> that write() is called *much* more often than, say, open(),...

My gut feeling agrees with yours, but I do not think the frequency
at which write() is called should be the primary factor when you
decide to make its wrapper inlined.  Once you call write(2), you
will hit either the disk or the network doing I/O, and at that point
I'd expect that the cost of making an extra layer of wrapper call
would be lost in the noise.  I'd worry a lot more about from how
many callsites write() is called---by inlining the extra code that
is run only when the underlying write(2) returns an error to many
callsites, we would make the program as a whole bigger, and as the
result other code needs to be evicted out of the instruction cache,
which also would hurt performance.
