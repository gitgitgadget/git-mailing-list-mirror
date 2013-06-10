From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Mon, 10 Jun 2013 14:43:27 -0700
Message-ID: <7vsj0pej5s.fsf@alter.siamese.dyndns.org>
References: <7v61xt7gej.fsf@alter.siamese.dyndns.org>
	<1370724291-30088-1-git-send-email-apelisse@gmail.com>
	<7vsj0roxnr.fsf@alter.siamese.dyndns.org>
	<CALWbr2zLTUYRnaYxbjyU80zpa3Q6WGcquTPAHqWCJnbEZ7RNPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 23:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um9sO-0005ii-P9
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 23:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab3FJVnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 17:43:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61624 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726Ab3FJVna (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 17:43:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC4AA1FDD3;
	Mon, 10 Jun 2013 21:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q3FwBHP69WN0YhHl9PpcUbvOVio=; b=Guafcn
	lnJNoWYOmS9kzenHaCI3Yrp41qXRnxz7g6JfR+/V2BXZSevHn8f3Omxz6FXKxooB
	O6kkYLVu6ri693EAXLxE2qT2cwZCP12x8UcPqdJ97tRULkrVi5bg7RLfSrUNlIgg
	JJZ7qRzKS4V1xz4XeQ9Qt34qvyRT1r8AjOIdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wglcHVCzcP2XG4jQ6XbJ0daIPGJiro5h
	NjSAoYeA1ie7pf8//hOE53ORlw7HkWWgH/TIyMhF6vUCbFxg/jOjJngQGz448ers
	fUODumziDjqlbP9IkO2FmchbE+1qWI74E3LH43H8GPekLPzJXGOSgh7fmJVtU2MJ
	6ZBzTOCXuOo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0E771FDD1;
	Mon, 10 Jun 2013 21:43:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C1BF1FDCC;
	Mon, 10 Jun 2013 21:43:28 +0000 (UTC)
In-Reply-To: <CALWbr2zLTUYRnaYxbjyU80zpa3Q6WGcquTPAHqWCJnbEZ7RNPQ@mail.gmail.com>
	(Antoine Pelisse's message of "Mon, 10 Jun 2013 23:03:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9C20A2E-D216-11E2-BB12-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227388>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Sun, Jun 9, 2013 at 10:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> When any ignore blank option is used, there will be lines that
>> actually has changes (hence should be shown with +/-) but we
>> deliberately ignore their changes (hence, if they ever appear in the
>> hunk, they do so as context lines prefixed with SP not +/-).  When
>> we do so, we show the lines from the postimage in the context.
>
> Don't we actually use preimage (see below) ? I think using pre-image
> allows the patch to be applicable to another tree (but ignoring the
> space changes).

But the result of such patch application is not usually what you
want to use.  If we use postimage (which by the way was a deliberate
design decision we made earlier), at least the review of the patch
is easier because you would see the end result more clearly.

> If we actually hide new blank lines that are in the context, it means
> that we won't be able to apply a patch with 2 new blank lines in the 3
> line context.

Yes, but I do not think the point of --ignore-blank-lines is to
produce a patch that can be applied in the first place.  It is to
allow easier eyeballing.

> Anyway, I'm starting to think that "show blank lines changes near
> other changes" makes sense more and more sense.

Probably.
