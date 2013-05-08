From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 00/10] interactive git clean
Date: Wed, 08 May 2013 09:08:16 -0700
Message-ID: <7vwqr9fo9b.fsf@alter.siamese.dyndns.org>
References: <cover.1368011946.git.worldhello.net@gmail.com>
	<CAPig+cR6aa+xODi=8DoiBpqQZM1eBHkGBvGzMGB2PSiT3osMEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 08 18:08:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua6up-0007dW-CZ
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 18:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758428Ab3EHQIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 12:08:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757737Ab3EHQIT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 12:08:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E39BB1C3EC;
	Wed,  8 May 2013 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PInoHpADqeWlAluULZh8vzsUyRE=; b=UzVAi7
	dW69djFRwFezJZkPgq7cTRKTkBlyTUT08hDls0SZIQxAQ1TwVB5oHZz4vuP90q4j
	NpE20LTo5HIrRa/thI0EaIgJXuOJ7pY440duYdhenFfqFWdbvAJof1JU83i6kEmJ
	3SVh1MnMAxrmc6Z/4yJSyvhFnuknE8wPWfm3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K9BxYAXP1lDHURoioLorvv4p5Ib7wbia
	dCOwFRWCVT3u96e7BhzN4mNwm46oqFV9cJtR/HWTSZkqulStImYFamIlKo8NPNkK
	lU4sAqKy0z07QaFjaiXiZJmVPY9eXZbdiEWxi5Mibxnz/K2V9FU13GrNqWAlhQWx
	gvf/Byet3ac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D888C1C3EB;
	Wed,  8 May 2013 16:08:18 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 444F51C3EA;
	Wed,  8 May 2013 16:08:18 +0000 (UTC)
In-Reply-To: <CAPig+cR6aa+xODi=8DoiBpqQZM1eBHkGBvGzMGB2PSiT3osMEw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 8 May 2013 11:15:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F2C6694-B7F9-11E2-A8B8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223675>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, May 8, 2013 at 7:38 AM, Jiang Xin <worldhello.net@gmail.com> wrote:
>> When the command enters the interactive mode, it shows the
>> files and directories to be cleaned, and goes into its
>> interactive command loop.
>
> Your current implementation only allows excluding items from the list
> of files to delete. If you accidentally exclude some file which you
> actually want in the deletion list, there is no way to re-add it.

If you accidentally dropped items from the list, is it such a big
deal?  I would imagine, if I were in that situation, that I would
simply continue and concentrate on making sure the remaining list
does not include anything I want to keep, clean them and then run
the command again, at which point the list of untracked paths in the
list will be much smaller.

We cannot make the same argument against the approach to first
present a list and _remove_ items that should not be dropped. That
is a genuine improvement, without which you cannot do a similar
incremental removal, whose first invocation removes only a subset
(but still a subset with no precious files you need to keep) of
files to allow the list subsequent invocations presents to *shrink*.

Cleaning all unneeded files inside a single interactive session
should *never* be the goal---that will lead to an over-engineered
design (e.g. switching "clean -x" flags in the middle? why?).  I
think Jiang's latest series is already way over-engineered, and I
suspect your suggestion leads it more into that direction.
