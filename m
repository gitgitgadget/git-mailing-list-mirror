From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/1] apply: reject input that touches outside $cwd
Date: Fri, 30 Jan 2015 11:07:34 -0800
Message-ID: <xmqqegqcccjt.fsf@gitster.dls.corp.google.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
	<xmqqa914klg0.fsf@gitster.dls.corp.google.com>
	<xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
	<xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
	<xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
	<xmqqzj91cfnl.fsf_-_@gitster.dls.corp.google.com>
	<20150130182456.GA29477@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 20:07:50 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHGuz-0006ao-9N
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 20:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763117AbbA3THo (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 14:07:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760549AbbA3THm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 14:07:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7182630D38;
	Fri, 30 Jan 2015 14:07:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wrjPvRcIx98cgJfjC7eT4ia6ocQ=; b=qDdciv
	jDZpDpYar+PM+LzkpatB9sVwdyE8LkFkmC0UMyLC5ZmcT4Jz+F/mlUPlEz9Q/4r7
	PCIhwCuj8N1/J/y00yWoBbtNEFIKC0NHJdPyOhQ1H7wkJ2Rpoh8MgwppuDqmaa2m
	rasY/U/VLsqRWCLewukJvnUstoFf+0+ofNCH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HTGSrvjW61fH4FRp4Dww4VNWGaNJE6NH
	yoeLO3NoIbJeDXpup7R7bXz0ygczLLcH6e0NOER40rJ8eF2ucK8dFvPY7YHS/IhA
	MZshIpGfuHHojMuwTv9cA8EjzUlLl7LJFifge+PMx2V9hNvd5MGNThoOx9gL/s6o
	MVzbcAA0OLs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 573AB30D37;
	Fri, 30 Jan 2015 14:07:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A443C30D33;
	Fri, 30 Jan 2015 14:07:35 -0500 (EST)
In-Reply-To: <20150130182456.GA29477@peff.net> (Jeff King's message of "Fri,
	30 Jan 2015 13:24:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 402B5232-A8B3-11E4-8C8C-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263187>

Jeff King <peff@peff.net> writes:

> It looks like your new --allow-uplevel goes to verify_path(). So this
> isn't just about "..", but it will also protect against applying a patch
> inside ".git". Which seems like a good thing to me, but I wonder if the
> option name is a little misleading.

True; not just misleading but is incorrect, I would say.
Suggestions?

> I agree they are orthogonal in concept, though I doubt the symlink tests
> here would pass without the previous one...

It won't; "do not apply across symlinks" is unconditional, and the
new codepath introduced by this patch, which is conditional to the
user option, shouldn't have to worry about them.
