From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Wed, 08 Jun 2016 13:17:33 -0700
Message-ID: <xmqqy46fjuzm.fsf@gitster.mtv.corp.google.com>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160608130142.29879-1-samuel.groot@grenoble-inp.org>
	<20160608130142.29879-5-samuel.groot@grenoble-inp.org>
	<xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
	<CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
	<fb7795c4-60db-94b3-a584-8fadd0440773@grenoble-inp.org>
	<CAPig+cQ5OKFTA8pEge=0e2RMT3ghmat-szw73aO_3WVW1=eAFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Git List <git@vger.kernel.org>, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>, aaron@schrab.com,
	Eric Wong <e@80x24.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 22:18:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAjva-0002kO-Gc
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 22:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757681AbcFHUSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 16:18:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751842AbcFHURh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 16:17:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51BE6219C5;
	Wed,  8 Jun 2016 16:17:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8jXXOvZ2kqzgwdIrDXETi/FLyUk=; b=dTsESG
	9j4buttdBFA69lERhzLeQa+UEREgdGabGerI3Wj8tsNZCZAhDUXIh7pQlWZ7EW/L
	95bU3HSxW8CPcFU+hmfk+LEnL0Bm0CmTcVMukb6B8bSJ8QtXt/7PWIo1sSBgbB7F
	soE0VKqWHiGdAJnPDqpFTitvszpCZLwfuPYjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CuE5Sokp3ZLE0piqIVq0arsNw29zo3ZI
	uGtRpT6OqJ9xA1Z4xaQPyHTVaQNLBz780MOcvmIDuQ71oFnuFdkX4qzWVTuHK7qD
	dM+FRrnBSTY0xXX/m0+nEvim4Sol6e6FYV32xSXiENHLYp3YLixSmCz6jH5ii4ja
	vZOYNYbNn/E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4881E219C4;
	Wed,  8 Jun 2016 16:17:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BDFC3219C3;
	Wed,  8 Jun 2016 16:17:34 -0400 (EDT)
In-Reply-To: <CAPig+cQ5OKFTA8pEge=0e2RMT3ghmat-szw73aO_3WVW1=eAFQ@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 8 Jun 2016 16:13:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 098757B0-2DB6-11E6-BA85-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296850>

Eric Sunshine <sunshine@sunshineco.com> writes:

> An embedded CR probably shouldn't happen, but I'm not convinced that
> folding it out is a good idea. I would think that you'd want to
> preserve the header's value verbatim. If anything, I'd expect to see
> the regex tightened to:
>
>     s/\r?\n$//;

Yes, that would be more sensible than silently removing \r in the
middle which _is_ a sign of something funny going on.

> Alternately, consider using 'chop' or 'chomp'.

Even if you use chomp(), you'd still need to worry about possible \r
at the end, no?
