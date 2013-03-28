From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-send-email.perl: implement suggestions made by
 perlcritic
Date: Thu, 28 Mar 2013 13:26:45 -0700
Message-ID: <7vsj3fs22i.fsf@alter.siamese.dyndns.org>
References: <7vfvzgn3ob.fsf@alter.siamese.dyndns.org>
 <1364474835-23416-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 21:27:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULJPq-0005lc-2r
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 21:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab3C1U0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 16:26:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600Ab3C1U0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 16:26:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B450EE69;
	Thu, 28 Mar 2013 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ITf262dOEqC8wLLio31TZJ3YhJk=; b=E7JHw0
	E1+NSNgbq9DP25nPW2Juq/y0t7Q/sNCTgUg+QgBqJKdtJOXvsYJVmMNUcvagiXN5
	KzDLBxYULS70rteXPx2P/1i9rQTfZ1URDGjYi6kShSCYeONhsEcjmXxOYHpsOd16
	zEj6zPhO+FXGCQP0x+1VD4VCujgvzTdm19gRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AyWu+7Kn2i5VUUtetw8FAu4ir0BABRhU
	PwhR7YTJEhKIsoAcKlsNRJ8a+6WdzTTu/NWW3/o5stLYawiDuJESMIXr+yzUaIma
	9PIZSDzghCkd3hhsCmM7tln4eAvSkKCFvI3befQ+EtOYHqdEGFwosmAdZSrw/iA/
	UhvztrDWVVg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3E42EE68;
	Thu, 28 Mar 2013 20:26:47 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CFE4EE64; Thu, 28 Mar 2013
 20:26:47 +0000 (UTC)
In-Reply-To: <1364474835-23416-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 28 Mar 2013 18:17:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D04D4270-97E5-11E2-A3F4-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219458>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Running perlcritic with gentle severity reports six problems.  The
> following lists the line numbers on which the problems occur, along
> with a description of the problem.  This patch fixes them all, 

Thanks.

> after
> carefully considering the consequences.

Hmmmm.....

> 516: Contrary to common belief, subroutine prototypes do not enable
> compile-time checks for proper arguments.  They serve the singular
> purpose of defining functions that behave like built-in functions, but
> check_file_rev_conflict was never intended to behave like one.  We
> have verified that the callers of the subroutines are alright with the
> change.

This, together with the "carefully considering", does not build any
confidence on the part of the reader.  Subroutine prototypes are not
for compile-time checks (correct), and they were introduced to the
language only for the purpose of letting you write subroutine that
emulate built-ins like "pop @ary" (again correct),

The most important fact that is not described in the above is that
by using prototype, the subroutine enforces a non-default context at
the callsite when the arguments are evaluated. That is why you can
write an emulated "pop"; otherwise the first @ary will simply be
flattened and you won't grab an element from the array.

Saying "check_file_rev_conflict is not emulating any Perl built-in
function" is irrelevant as a justification for the change.  A
subroutine that does not emulate a built-in can still be relying on
the non-default context in which its arguments are evaluated.

    sub foo ($) { my ($arg) = @_; print "$arg\n"; }
    sub bar     { my ($arg) = @_; print "$arg\n"; }
    my @baz = (100, 101, 102);
    foo @baz; # says 3
    bar @baz; # says 100

In general, writing subroutines without prototypes is much
preferred. I do not dispute that and would not argue against
perlcritic. But if you blindly _fix_ the above "foo" subroutine by
dropping its prototype, it changes behaviour if the callers passed
an array variable. You need to check the callers and they are not
doing something to cause the prototyped and unprototyped versions
to behave differently.

And that is what needs to be explained in the log message; not these
handwavy "carefully considering consequences" (what consequences did
you consider?), "was never intended to behave like one" (how does
that matter?) and "the callers of the subroutines are alright" (why
do you think so?).

Without that, the reviewer needs to go and check the callers.  Your
log message is _not_ helping them.

Same for the remainder.

In general, you do not have to copy and paste the output from
perlcritic.  Treat it more as a learning tool, and use the knowledge
you learned from its output to explain why your changes are
improvements.  Not just "because perlcritic said so".

For "ask" subroutine, all its callers assign the returned value to a
single scaler variable, so the difference between "return undef" and
just "return" does not matter. If somebody starts doing

	@foo = ask(...);
	if (@foo) { ... we got an answer ... } else { ... we did not ... }

then "return undef;" form will break.  So it is less error prone if
we dropped the explicit "undef".  The same goes for extract_valid_address,
whose current callers all assign the returned value to a single scalar,
or apply "!" operator inside "while" conditional.

The change to validate_address is correct, but it is correct only
because its only caller, validate_address_list, filters out "undef"
returned from map() that calls this subroutine.  By dropping the
explicit "undef" from there, it seems to me that validate_address no
longer returns "undef" so validate_address_list loses any need to
filter its return value.  Seeing a patch that does not change that
caller while changing the callee makes reviewers wonder what is
going on.  Perhaps even with this patch, there still is a need to
filter in validate_address_list, and if so, that needs to be
explained.

If I were doing this change, I would rather leave this subroutine
as-is.  Nothing is broken and we are risking new breakages by
changing it.

> 1441: The three-argument form of `open' (introduced in Perl 5.6)
> prevents subtle bugs that occur when the filename starts with funny
> characters like '>' or '<'.

Correct, and this patch is about using the three-or-more-arg form to
take advantage of its safety.  So why are we still using the shell
invocation form inherited back from the days we used two-arg form?

Again, seeing a patch that only turns "open FILEHANDLE,EXPR" into
"open FILEHANDLE,MODE,EXPR" when EXPR is not a simple command name
and not into "open FILEHANDLE,MODE,EXPR,LIST" form makes reviewers
wonder why the patch stops in the middle.

>  Junio: In future, please tell me explicitly that you're expecting a
>  re-roll with an updated commit message.  It wasn't obvious to me at
>  all.

It wasn't obvious to me, either ;-).

I said the patch was not explained well, but it may not be the only
problem with it.  Other people may have inputs to it, and you may
have been waiting for the input from others before initiating a
reroll.

It wasn't like "please fix these and then the result will be perfect
and I'll promise to apply".  A maintainer cannot work like that.

I try to make sure there aren't leftover bits from time to time by
sweeping archived e-mails, and also I try to handhold newer
contributors by pinging them about their progress every once in a
while (but you are not exactly new).

This patch fell under the cracks, and reminding me with a "what
happened to it?" was the right thing to do.  Literally, that is what
I ask in the "Notes from the maintainer" message.
