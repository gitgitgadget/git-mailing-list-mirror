From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] Make update refs more atomic
Date: Wed, 16 Apr 2014 12:31:13 -0700
Message-ID: <xmqq1twxgjge.fsf@gitster.dls.corp.google.com>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com>
	<534CD376.7080108@alum.mit.edu>
	<CAL=YDWmm1pDtNuibs5CrPTDkaxT9PUvZscXFicoNsNpXVXJv1A@mail.gmail.com>
	<534D9741.3010404@alum.mit.edu>
	<CAL=YDW=g=jkm4yhBvnZXSvLLm-6ZGhJORKv_evg66v0U=E71FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 21:31:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaVYJ-0003nr-DO
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 21:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbaDPTbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 15:31:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbaDPTbR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 15:31:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 149837DA84;
	Wed, 16 Apr 2014 15:31:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rCSR4CRxfYNpZe0MkbGqeGKoJ6Y=; b=bSu0cA
	Y+DJO5OSIeqtSzVZk65YE9hb5trnbEOD4J/t41VdqqqwQI1Y1Lq/NjAUzShd05OT
	4NfEA1lBu/3zbjMqS5XfrloXJ1T5Ms9vM02rttKzJASoRl1+UFpwn/cUSMixaOWQ
	ipOjsope8nyyJkrwJypruibOYXbcTBZAwrgO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q7+jn3EhEGgo0rDnAtCT8wORQR3d+7vR
	H2lEThg7B2VsQGFur82eT1W9HUBr30VSvLWyRTWICrG9+0xpvM9scaRxoKqAC3RH
	53U60p/vohOMVDkrqph2s+IT7We9p3KZ5jC56zvcDQuVMirVO89AikIEz8rC/nl6
	UnaP/uEz5LA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2D297DA83;
	Wed, 16 Apr 2014 15:31:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 711897DA80;
	Wed, 16 Apr 2014 15:31:15 -0400 (EDT)
In-Reply-To: <CAL=YDW=g=jkm4yhBvnZXSvLLm-6ZGhJORKv_evg66v0U=E71FA@mail.gmail.com>
	(Ronnie Sahlberg's message of "Wed, 16 Apr 2014 10:11:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AD0C1CBE-C59D-11E3-8B31-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246378>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Currently any locking of refs in a transaction only happens during the commit
> phase. I think it would be useful to have a mechanism where you could
> optionally take out locks for the involved refs early during the transaction.
> So that simple callers could continue using
> ref_transaction_begin()
> ref_transaction_create|update|delete()*
> ref_transaction_commit()
>
> but, if a caller such as walker_fetch() could opt to do
> ref_transaction_begin()
> ref_transaction_lock_ref()*
> ...do stuff...
> ref_transaction_create|update|delete()*
> ref_transaction_commit()
>
> In this second case ref_transaction_commit() would only take out any locks that
> are missing during the 'lock the refs" loop.
>
> Suggestion 1: Add a ref_transaction_lock_ref() to allow locking a ref
> early during
> a transaction.

Hmph.

I am not sure if that is the right way to go, or instead change all
create/update/delete to take locks without adding a new primitive.

> A second idea is to change the signatures for
> ref_transaction_create|update|delete()
> slightly and allow them to return errors early.
> We can check for things like add_update() failing, check that the
> ref-name looks sane,
> check some of the flags, like if has_old==true then old sha1 should
> not be NULL or 0{40}, etc.
>
> Additionally for robustness, if any of these functions detect an error
> we can flag this in the
> transaction structure and take action during ref_transaction_commit().
> I.e. if a ref_transaction_update had a hard failure, do not allow
> ref_transaction_commit()
> to succeed.
>
> Suggestion 2: Change ref_transaction_create|delete|update() to return an int.
> All callers that use these functions should check the function for error.

I think that is a very sensible thing to do.

The details of determining "this cannot possibly succeed" may change
(for example, if we have them take locks at the point of
create/delete/update, a failure to lock may count as an early
error).

Is there any reason why this should be conditional (i.e. you said
"allow them to", implying that the early failure is optional)?

> Suggestion 3: remove the qsort and check for duplicates in
> ref_transaction_commit()
> Since we are already taking out a lock for each ref we are updating
> during the transaction
> any duplicate refs will fail the second attempt to lock the same ref which will
> implicitly make sure that a transaction will not change the same ref twice.

I do not know if I care about the implementation detail of "do we
have a unique set of update requests?".  While I do not see a strong
need for one transaction to touch the same ref twice (e.g. create to
point at commit A and update it to point at commit B), I do not see
why we should forbid such a use in the future.

Just some of my knee-jerk reactions.
