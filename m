From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fix has_action
Date: Fri, 05 Aug 2011 09:59:30 -0700
Message-ID: <7v62mb4wwd.fsf@alter.siamese.dyndns.org>
References: <1312450780-5021-1-git-send-email-nrubinstein@proformatique.com>
 <7vliv93r9g.fsf@alter.siamese.dyndns.org>
 <CAGdFq_j2wRw-gB109VypZkG1u=fm7yynkn2-Gu8AzNpVOrun8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Noe Rubinstein <nrubinstein@proformatique.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 18:59:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpNkG-0005Ly-Vz
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 18:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab1HEQ7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 12:59:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956Ab1HEQ7d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 12:59:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 033894BCD;
	Fri,  5 Aug 2011 12:59:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p8JAgAmom8RKm9HACohM1nvxmRI=; b=fAQB1/
	ObGkzUZYZOf1Pwy0UVgqUZIwACIoCrcIdoDzls5j2TNvAgchpoMCmde/sNzHHK/j
	hLTAsXWu5rjai5v5L9DMwYlQJ0dGRYlrEs5q47CAQV9EXbJCNxJSSSkL90gQwbZ5
	14lH2csmDt5FzwCUIoxS3fRZ7EN9TK3sImDwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yCgFaCZkk01DFdaVnSq13O9Lx2QLzEKs
	oXwFpIYognNLC7/Jc7CLrRWv8ART7Ek2FHmGBJ+9iWqPiuvgi7FfegCGoaIRKAi+
	y1fVdKDG1yUJ989SMIx2LMWqMWXMCQVH+mBbNk3/xHUTXBI35MoUTETAtak0caHc
	8COXZdcVlOo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EED824BCC;
	Fri,  5 Aug 2011 12:59:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 823D84BCB; Fri,  5 Aug 2011
 12:59:31 -0400 (EDT)
In-Reply-To: <CAGdFq_j2wRw-gB109VypZkG1u=fm7yynkn2-Gu8AzNpVOrun8w@mail.gmail.com> (Sverre
 Rabbelier's message of "Fri, 5 Aug 2011 14:36:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49C6723E-BF84-11E0-8714-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178802>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Thu, Aug 4, 2011 at 21:34, Junio C Hamano <gitster@pobox.com> wrote:
>>        has_action () {
>>          test -s "$1"
>>        }
>
>>        has_action () {
>>          sane_grep -v -e '^#' -e '^[   ]*$' "$1" >/dev/null
>>        }
>
> I think the former more correctly checks what the function name
> implies, is there any downside to that which makes you suggest this
> second approach?

I vaguely recall the original reason we didn't do the most straightforward
thing was something like what J6t said already.

As we are not interested in _adding_ new feature, I would say that,
strictly speaking, this *should* become a two-patch series whose first one
uses

	sane_grep -v -e '^#' -e '^$' "$1" >/dev/null

that is, "do we have anything aside from comments and blanks?", which is
the original semantics, with Noe's "safety" change as the second patch in
the series that uses

	sane_grep -v -e '^#' -e '^[	 ]*$' "$1" >/dev/null

to say "let's count a line that solely consists of whitespaces also as a
blank".

But of course in practice it can and should be just a single patch that 
squashes these two "conceptually separate" steps.
