From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/11] run-command: report failure for degraded output just once
Date: Wed, 04 Nov 2015 18:05:17 -0800
Message-ID: <xmqqvb9h8ale.fsf@gitster.mtv.corp.google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<1446597434-1740-3-git-send-email-sbeller@google.com>
	<xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
	<563A6C3D.2050805@kdbg.org>
	<xmqq4mh1a37i.fsf@gitster.mtv.corp.google.com>
	<20151104225618.GA18805@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 03:05:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu9vZ-0002IW-Ue
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 03:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbbKECFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 21:05:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756325AbbKECFV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 21:05:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ABE002A829;
	Wed,  4 Nov 2015 21:05:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FZIqzbSdwz/amL/6tIiCPkn79fQ=; b=Mi1cvx
	2or1qOxSERQENOZRKDq9vKFYxAnfeL+2k1k8EvK4xax8mhd3btS0C8MusW8DmSjB
	YXsZwrA6nmtEiZmD2mpfUO5mEaUB7ZuiB8dG46m1rVUAHBBVhWfcOKWaoHnQXBET
	ibDTGfjHgox/3XF6duAi5TqNI2DL6KgQdUwa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p0HuTCSXXiO1u31UZ5Rt8CKMYOWB+mJe
	QcHGC7dSA4LTr0rekI35kJ0Dh1Q/EUNz1ytSOKYL0CDj6c1ss6REHiXq58S7xNvh
	OLI35nRF6jzLaXgaD7PsckAnCYnuq+mERanSsmgrRENqY4SV6TfRo/Pb7iUqSyAG
	Vlkf59akqcE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A291A2A828;
	Wed,  4 Nov 2015 21:05:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 167652A827;
	Wed,  4 Nov 2015 21:05:19 -0500 (EST)
In-Reply-To: <20151104225618.GA18805@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 Nov 2015 17:56:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A9FDF9EC-8361-11E5-8C35-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280894>

Jeff King <peff@peff.net> writes:

> So I'm not sure I see why we need to be non-blocking at all here, if we
> are correctly hitting poll() and doing a single read on anybody who
> claims to be ready (rather than trying to soak up all of their available
> data), then we should never block, and we should never starve one
> process (even without blocking, we could be in a busy loop slurping from
> A and starve B, but by hitting the descriptors in round-robin for each
> poll(), we make sure they all progress).
>
> What am I missing?

I've always assumed that the original reason why we wanted to set
the fd to nonblock was because poll(2) only tells us there is
something to read (even a single byte), and the xread_nonblock()
call strbuf_read_once() makes with the default size of 8KB is
allowed to consume all available bytes and then get stuck waiting
for the remainder of 8KB before returning.

If the read(2) in xread_nonblock() always returns as soon as we
receive as much as there is data available without waiting for any
more, ignoring the size of the buffer (rather, taking the size of
the buffer only as the upper bound), then there is no need for
nonblock anywhere.

So perhaps the original reasoning of doing nonblock was faulty, you
are saying?
