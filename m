From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete for refs we know are packed only
Date: Wed, 28 May 2014 09:58:06 -0700
Message-ID: <xmqqk395et7l.fsf@gitster.dls.corp.google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-42-git-send-email-sahlberg@google.com>
	<537F67DD.5010101@alum.mit.edu>
	<xmqqzji3f55i.fsf@gitster.dls.corp.google.com>
	<5385F0E5.4010306@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 28 18:58:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WphBG-00054u-8U
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 18:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbaE1Q6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 12:58:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63732 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbaE1Q6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 12:58:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F28D31993B;
	Wed, 28 May 2014 12:58:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hiAI/rRq12E9R9bhV7MKlLj0l/4=; b=NtOctW
	wgKy0xBAi5b0zpcJb7JDWIKxE/K/vgtfuxRexNzue0ipbf4A5LjxplwrP85qX6gL
	oQIyTxCfRF6AdfSzWlbqmdhfEiY3nenN8mjxH5imjeRKRwQ6TQU53j5W24rOOe6F
	BNwoGF7B3LjBfzXzPs9rD01ULO6NkhsiHW6AA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HVJqb8WqP4tLcyACu/1xPfJiZO/F33r7
	MSZ4GVDJfqmFtqm3J+uf7YDN1oZ3wwZpZNFQLrVQMj5rCGBPrPyN7UY4DolLEba8
	fT6LlK/0LF3SnSQzGxkCauRC6zoGNj+HBq/i/oYQoRZeQpk+2zwfzaw+013ec8yl
	hrv3RdXc0jw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8F461993A;
	Wed, 28 May 2014 12:58:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 81D6819935;
	Wed, 28 May 2014 12:58:08 -0400 (EDT)
In-Reply-To: <5385F0E5.4010306@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 28 May 2014 16:21:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3E8ABD2E-E689-11E3-A50A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250294>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I think for any two backends that are stacked, you would need to break
> down a transaction as follows (here generalized to include not only
> deletions):
>
>     packed->begin_transaction()
>     loose->begin_transaction()
>
>     # And this part is done within stacked->commit_transaction():
>     for entry in many_ref_updates():
>         if have_old:
>             stacked->verify_reference(ref, old_sha1)
>
>         if entry is a delete:
>             packed->delete_reference(entry)
>         loose->update_reference(entry)
>
>     if (!packed->commit_transaction())
>         loose->commit_transaction()

Ugggly.  In general you would need to worry about the case where the
first commit succeeds and then the second commit fails, wouldn't
you?

The above happens not to break horribly wrong for the "Loose on top
of Packed" layering, in that the refs you wanted to delete are only
gone from Packed but still are in Loose, and the end result would be
some of them are really gone (because they weren't in Loose) and
some others remain (because they were in Loose), and at least you
did not lose any ref you did not want to discard.  But it still is
not what should happen in a proper "transaction".

>> But the above would not quite work, as somebody needs to remove logs
>> for refs that were only in the Packed backend, and "repack without
>> these refs" API supported by the Packed backend cannot be that
>> somebody---"repack packed-refs without A B C" cannot unconditionally
>> remove logs for A B C without checking if A B C exists as Loose.
>
> Correct.  That's another reason that logging has to be the
> responsibility of something at the "stacked" level of abstraction or higher.
>
> I think the logging should be done by yet another outer layer of
> wrapper that only does the logging, while also passing all updates
> down 1:1 to the backend that it wraps (which in our case would be
> a stacked backend). ... Then the loose and packed backends could
> remain completely ignorant of the fact that reference updates can
> be logged.

That would mean that Loose (or Packed) class cannot be used as-is
and always needs to be wrapped with the layer that does the logging,
no?  In a system with "only packed-refs, no loose", you would want
Packed.deleteRefs() to remove the named refs ref and their reflogs,
but that would mean that the Layered wrapper that uses Loose
overlayed on Packed cannot call that method, because it does not
want reflogs of the refs in Packed covered by the ones in Loose.
