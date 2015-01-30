From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Fri, 30 Jan 2015 12:20:02 -0800
Message-ID: <xmqqwq44auml.fsf@gitster.dls.corp.google.com>
References: <CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
	<xmqqa914klg0.fsf@gitster.dls.corp.google.com>
	<xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
	<xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
	<xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
	<20150130181153.GA25513@peff.net>
	<xmqq61bocao1.fsf@gitster.dls.corp.google.com>
	<xmqq1tmcc9l9.fsf@gitster.dls.corp.google.com>
	<20150130201620.GA4133@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 21:20:16 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHI32-0001H3-Hg
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 21:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763155AbbA3UUH (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 15:20:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52327 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751769AbbA3UUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 15:20:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 55E2F31F36;
	Fri, 30 Jan 2015 15:20:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u36ry4onzRqiWZhfWOkNV2Ri9nI=; b=CXDJ9o
	fwsrED9olM7QASt1Ju/NHKUd8yjolTA7C+gqn2cNy5NMu0rXLJ+F46/QmIdaXSPU
	vxXqhz8/69CjMncPQGFTcDmStiXe1kG2dOl0o4S7NBxL9JeiRssZEgSnp118RqcY
	PAgcxjf29AEtngTlHXVPKcQc8zktiS/4hkGts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lSgbTQGyrYVlbx6s7l/z7mW/lH2Lq6iC
	xv+FyAr+auEu0Mk2HCnW5IrNBH5KDFl27iDv73VYA+zuoAbpTQh4COg+3NmgNRrq
	rTF3jH+PKzWMmq8PfUxIgKHDnQriOqbogKeRxJk9mu3QbnpZOpRktlA9XpWYzFiS
	K9BADG3AnNQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A51531F35;
	Fri, 30 Jan 2015 15:20:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B69B531F33;
	Fri, 30 Jan 2015 15:20:03 -0500 (EST)
In-Reply-To: <20150130201620.GA4133@peff.net> (Jeff King's message of "Fri, 30
	Jan 2015 15:16:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5FD85C88-A8BD-11E4-9C1A-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263195>

Jeff King <peff@peff.net> writes:

> I had the impression that we did not apply in any arbitrary order that
> could work, but rather that we did deletions first followed by
> additions. But I am fairly ignorant of the apply code.

No, you are thinking about the write-out of the finished result,
which may have to turn existing directory to a file or vice versa on
the filesystem, but that happens _after_ we decide what to turn into
what else, completely in-core.

And the decision to determine what the input _means_ should not
depend on the order of patches in the input.
