From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/11] run-command: report failure for degraded output just once
Date: Wed, 04 Nov 2015 13:01:53 -0800
Message-ID: <xmqq4mh1a37i.fsf@gitster.mtv.corp.google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<1446597434-1740-3-git-send-email-sbeller@google.com>
	<xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
	<563A6C3D.2050805@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:02:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu5Bx-0006q2-1q
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 22:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030567AbbKDVB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 16:01:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030298AbbKDVB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 16:01:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 665C9267F8;
	Wed,  4 Nov 2015 16:01:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qiz1/JNJJ3UxJ8gJbsIDApSe4/Q=; b=gnvn+Q
	kejvHk2KBuKkgu5NNVsm/wLaLcV1ahHvqtC55r18KXE9815VNuB4qFZHZKOrEouS
	/5Z8ufur1gk8z0WwhudrGIQiWtlyGsLmmuOL3toPS8JB+b3/FJ9KsanBzaAx3u86
	NFbeFmM4VwFYgoAKXNHCbxEWH63StcLcJL4kU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BpSi7OJfibYyF+qg/zbkDEkVZK2ufbow
	SfPZW9d//NGuZc25xMmbqR/nuOLOOWw14rL2H1HLP4uL0E/6q0hjsSE/nMq/UVBO
	LuAYy4sXMUSdtp7WoMouSDROKDmFcjLb98nJvM7eXA7af+YMbt6riVDi9L8MQ1av
	c8FTnYe/yok=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5AEA0267F7;
	Wed,  4 Nov 2015 16:01:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CC2F6267F2;
	Wed,  4 Nov 2015 16:01:54 -0500 (EST)
In-Reply-To: <563A6C3D.2050805@kdbg.org> (Johannes Sixt's message of "Wed, 4
	Nov 2015 21:36:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 47690F44-8337-11E5-9209-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280884>

Johannes Sixt <j6t@kdbg.org> writes:

> I think that a scenario where A and B are communicating is rather
> far-fetched. We are talking about parallelizing independent tasks. I
> would not worry.

I wouldn't worry too much if this were merely a hack that is only
applicable to submodules, but I do not think it is a healthy
attitude to dismiss potential problem as far-fetched without
thinking things through, when you are designing what goes into
the run-command API.

I'd grant you that a complete deadlock is unlikely to be a problem
on its own.  Somewhere somebody will eventually time out and unblock
the deadlock anyway.

But the symptom does not have to be as severe as a total deadlock to
be problematic.  If we block B (and other tasks) by not reading from
them quickly because we are blocked on reading from A, which may
take forever (in timescale of B and other tasks) to feed us enough
to satisfy strbuf_read_once(), we are wasting resource by spawning B
(and other tasks) early when we are not prepared to service them
well, on both our end and on the other side of the connection.

By the way, A and B do not have to be directly communicating to
deadlock.  The underlying system, either the remote end or the local
end or even a relaying system in between (think: network) can
throttle to cause the same symptom without A and B knowing (which
was the example I gave).
