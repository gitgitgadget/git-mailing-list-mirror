From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Thu, 08 Aug 2013 00:13:10 -0700
Message-ID: <7va9ksbqpl.fsf@alter.siamese.dyndns.org>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
	<CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
	<7v61vihg6k.fsf@alter.siamese.dyndns.org>
	<CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 09:13:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7KPR-00073A-Ej
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 09:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933500Ab3HHHNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 03:13:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64092 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033Ab3HHHNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 03:13:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E409A3391C;
	Thu,  8 Aug 2013 07:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dQCElZ1Hky0YW2JCgaDhAOu5WhE=; b=BoCySi
	nYmIihhNK9EIUzeP0CFMCs2OAv7c1F7n+E15pOnZDSRAK7y+O2S6Z6ojq5ODCliS
	sHq6vAjsoqqvAYKV7bAhJOsfIzPLlg9+/xJwmsYPVDTLpqBUf00o99ufRelGzmxL
	e9UD1ReNCw+urjqUflCKJSC+spQcboJdzDLhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F9mDZLERRIIdN8ZOAQZ3o4HIkHCgI2SP
	dNHY/YjYpHmu7g72g8JmSrw/oK9DN/n1bWqQERlTnCZGqUUA025yeHvgiG6h591Y
	R0xrSrEMtOJvadcGGpNtapWdpIIdIHUVRhB37bj34tD1wHY7Th0P9oBM7GVmiX5D
	0OnSMJYd7AI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D693A3391A;
	Thu,  8 Aug 2013 07:13:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B5A333910;
	Thu,  8 Aug 2013 07:13:13 +0000 (UTC)
In-Reply-To: <CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 7 Aug 2013 10:13:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD43C778-FFF9-11E2-94C0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231868>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Imagine we have a cheap way to enumerate the young objects without
>> the usual history traversal.
>
> Before we discuss the advantages, can you outline how we can possibly
> get this data without actually walking downwards from the roots
> (refs)? One way to do it is to pull data out of a log of ref updates
> (aka. reflog), but we both know how unreliable that can be.

My understanding of the topic is to come up with a way that is much
cheaper than the current "gc --auto" that involves recent history
walk to consolidate both loose objects and small young packs into
one, so that we can use that logic for "gc --auto".

The key phrase is "without the usual history traversal".  We are
talking about young objects, and they are likely to be reachable
from something (like reflog entries, if not refs).  We may include
unreachable cruft in the result in the "let's be quick and collect
them into a single young pack", and you will need to keep them while
reflog entries are alive, and you will need periodic sweeps with the
usual history walking to remove older crufts that recently have
become unreachable due to reflog expiry from packs anyway, so it is
not a problem for the pack that consolidates young objects into a
single pack to contain some unreachable crufts.

If you start from that assumption [*1*], the way to enumerate the
young objects without the usual history traversal should be fairly
obvious.

By definition, loose objects are all young because they were created
since the last "gc --auto".  Also pack .idx files know their own
creation timestamp to let you decide how old they are, you can see
how many objects there are in the corresponding .pack and how big it
is.

By doing an equivalent of "find .git/objects/[0-9a-f][0-9a-f]/", you
can enumerate the loose objects, and an equivalent of "show-ref"
will enumerate the objects in the pack that the .idx file you
determined to be small and young.

Note that *1* is an assumption. I do not know offhand if such a
"consolidate young objects quickly into one to keep the number of
packs small" strategy is an overall win.
