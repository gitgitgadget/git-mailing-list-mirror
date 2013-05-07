From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 06 May 2013 18:59:22 -0700
Message-ID: <7vmws7o8hx.fsf@alter.siamese.dyndns.org>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
	<20130506123111.GB3809@sigill.intra.peff.net>
	<7v7gjctabm.fsf@alter.siamese.dyndns.org>
	<CAMP44s2rdkND40QDQA9T7MNGoKPtnr50nV98aExUe4bCOXZGyA@mail.gmail.com>
	<7vppx3q0z6.fsf@alter.siamese.dyndns.org>
	<CAMP44s2wh71vW6GaCfyCO398BWvVbYnwSE76bO=46XVJF3jWNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 07 03:59:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZXBj-0006ub-JD
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 03:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759909Ab3EGB70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 21:59:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759675Ab3EGB7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 21:59:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4B64130B6;
	Tue,  7 May 2013 01:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4RzYWulW9esoGgPGz4/AH/ZS0R4=; b=vH5WZs
	nnAazCRVXRyUDJWSCK89wgVk79xlx610fcfRzTvIsQXdE7/oRiiIo1qQWvqtbmJE
	H57gz99s3vBaE54AZ6NXWfkVNPnN1AIOG/7maL/VAiBfVEkomTJXhKyL0HKntW1/
	bkAkk60JVPcfgYiYJcwD4jtro1mKlJnVHjY1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b2AS6DuwrmKdskqugPc0+av6Ka61TYLF
	0+2OO/Vnj3kZnltVesJlXOekquRdgeA+i42Ahbuwjaiz8Yqpj/Wbv/4rMjLrGcKR
	UF3noEpRGL9NEo1vOuVc0a3TgCe9KDYe+glE9KuY7quFtUUZHCi+ttFESJfZOuej
	59LgwQzl9hM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB5BD130B4;
	Tue,  7 May 2013 01:59:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E491130B3;
	Tue,  7 May 2013 01:59:24 +0000 (UTC)
In-Reply-To: <CAMP44s2wh71vW6GaCfyCO398BWvVbYnwSE76bO=46XVJF3jWNg@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 6 May 2013 16:30:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDA32656-B6B9-11E2-ADA0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223521>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>>> How?
>>
>>  * if we teach fast-import to optionally not write marks for blobs
>>    and trees out, your remote-bzr can take advantage of it,
>
> I already said remote-bzr is irrelevant. *Everybody* benefits.

Everybody who does _not_ need to look at marks for non-commits from
previous run does.  What about the others who do?

Surely, some lucky ones may get the benefit of a new optimization
for free if you turn it on uncondtionally without an escape hatch,
but that goes against our goal of not to knowingly introduce any
regression.  Michael's cvs2git might have a way to work the breakage
around (I will let him comment on your suggested workaround), but as
long as he has been coding it using the documented feature, why
should he even change anything for no gain at all in the first
place?  Even if you have a workaround, that does not change the fact
that a removal of a feature that somebody has been depending on is a
regression.

What's so difficult to understand that by default the responsibility
of making sure an optimization applies safely to a program that uses
a new optmization lies on that program, in other words, a new
feature is by default an opt-in?
