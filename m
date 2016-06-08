From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Wed, 08 Jun 2016 12:48:36 -0700
Message-ID: <xmqq37onlawb.fsf@gitster.mtv.corp.google.com>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
	<xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
	<20160606203901.GA7667@Messiaen>
	<xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
	<20160606225847.GA22756@sigill.intra.peff.net>
	<xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
	<20160607090653.GA4665@Messiaen> <575845D9.2010604@alum.mit.edu>
	<20160608191918.GB19572@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:49:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAjTK-0006X2-9c
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425773AbcFHTsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:48:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1425770AbcFHTsk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:48:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F1813204A7;
	Wed,  8 Jun 2016 15:48:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XTrN0dt4uQQwS7THLXMD5ROlKCs=; b=doYqBh
	/4ziDD4vDRiXgivAcyxq08dvsDfcYfCFJZ7hLEm7pCSFmf84cm2encens0KUFoaW
	rY5qCblHYOXp7LIaP7RlUUIqv03UbHV0lWBSYvWr/gqOXJDRxNurEywk7juZGC0c
	TX/QHCDGYzV4otwbSeqmOwMR1qYGCEH9KJDU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RLqwvcw7KeBaTm4fRDUbKSlsXyeJDBdF
	l1xo+ZaEnvEqwm2ivID2ri5yB47lNpkHNcoNzydt3lgpNla3y9oUxNGmzuNaCD4j
	6Ff7aNbkooEeCIg1NNC0QGRx6OAXZ/n4ZwXAYObGpfMzxXeJPAcHbW3qMU4fza27
	nUhwzHie848=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E8C34204A6;
	Wed,  8 Jun 2016 15:48:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 736B9204A5;
	Wed,  8 Jun 2016 15:48:38 -0400 (EDT)
In-Reply-To: <20160608191918.GB19572@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 8 Jun 2016 15:19:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE9C44D6-2DB1-11E6-AD60-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296847>

Jeff King <peff@peff.net> writes:

> That made me wonder if we could repeatedly reuse a buffer attached to
> the file descriptor. And indeed, isn't that what stdio is? The whole
> reason this buffer exists is because we are using a direct descriptor
> write. If we switched this function to use fprintf(), we'd avoid the
> whole buffer question, have a fixed cap on our memory use (since we just
> flush anytime the buffer is full) _and_ we'd reduce the number of
> write syscalls we're making by almost a factor of 100.

The primary reason why we avoid stdio in the lower level part of I/O
is that the error reporting and handling is horrible.

e.g. c.f. http://article.gmane.org/gmane.comp.version-control.git/27019

Otherwise, I'd agree with your "Why aren't we using stdio if
counting and avoiding overflow is so hard?".
