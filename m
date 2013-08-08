From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Thu, 08 Aug 2013 09:56:38 -0700
Message-ID: <7v61vgazp5.fsf@alter.siamese.dyndns.org>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
	<CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
	<7v61vihg6k.fsf@alter.siamese.dyndns.org>
	<CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
	<7va9ksbqpl.fsf@alter.siamese.dyndns.org>
	<CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 18:56:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7TW2-0004sL-M9
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 18:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757932Ab3HHQ4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 12:56:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757864Ab3HHQ4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 12:56:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51D3036225;
	Thu,  8 Aug 2013 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/hc8LSrBrgEp6Ff8KxJ8KxZHBRU=; b=kIGA7z
	Q1cmXwTwd5nzBK4E2F3Th5WgF/6lWxa0C4ICWHs0nARHvI2E+3XeaI23TnU0PL6I
	7jSgUnCHbdoXWRb7Ojh0fsxSNwbtkAmyxFjY/R/Y8m2Kaie/jgtXaYEAMElzZk6Y
	hexKapQ/zEEQ+FyQGU5T0BUJLaWbmRdgvL45A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dZmOMe0Vuc0Ph60saoLNg0RmGNPx5LJQ
	JWp1W6qc4vhBNrMHS3udx2FU4XnRkJvfv1dX+VttTlV8WjiQE0US0Q1t0LQg11np
	Bh1W5tzoXw0aN88FqqW1oWn2VZonMSeY8u4ZUI6f3mJyvDbsCV9ZeVDOHy0OOshf
	7QtzDiekrho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4629E36224;
	Thu,  8 Aug 2013 16:56:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A285936221;
	Thu,  8 Aug 2013 16:56:40 +0000 (UTC)
In-Reply-To: <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 8 Aug 2013 13:14:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F2268C0-004B-11E3-B095-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231902>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> it is
>> not a problem for the pack that consolidates young objects into a
>> single pack to contain some unreachable crufts.
>
> So far, we have never considered putting unreachable objects in packs.
> Let me ask the obvious question first: what happens when I push? Do I
> pack up all the loose objects quickly (without bothering about
> reachability) and send unreachable cruft to the server?

No.

I thought the discussion was about making the local gc cheaper, and
the "Imagine we have a cheap way" was to address it by assuming that
the daily "pack young objects into a single pack" can be sped up if
we did not have to traverse history.  More permanent packs (the
older ones in "set of packs staggered by age" Martin proposes) in
the repository should go through the normal history traversal route.

And of course we do not transfer objects that are not asked for from
or to a repository over pack tranfer.

Most importantly, it is not about butchering the pack machinery in
such a way that we can create _only_ such "non history traversal"
packs.

So I do not see how that question is "obvious".  The question
obviously pointless and misses the mark by wide margin?  The
question makes it obvious that whoever asks it does not understand
how Git works?
