From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/2] Verify index file before we opportunistically update it
Date: Sat, 12 Apr 2014 00:05:45 -0700
Message-ID: <7v1tx3m3hy.fsf@alter.siamese.dyndns.org>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com>
	<xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
	<CACsJy8A5VJM4gnJGazkzniv5YxRx0xR7YEFpQbU+kVGofQ1b_g@mail.gmail.com>
	<xmqqtx9zsm8p.fsf@gitster.dls.corp.google.com>
	<xmqqmwfrr3zw.fsf@gitster.dls.corp.google.com>
	<CACsJy8ASAvopmyhawmUkuFk4DjBd2opL1kxu_jtopTDr80BWPg@mail.gmail.com>
	<7vmwfrmb6a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 09:04:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYrzf-0006it-Cj
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 09:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbaDLHEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 03:04:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbaDLHEO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 03:04:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BADFE6A099;
	Sat, 12 Apr 2014 03:04:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YPIP9fIySqTpxIurprE4KEvIASk=; b=YXcAgS
	8Hqt9vOVjupztjn7019rYrAftMx8e5ySq5LfBG5OoD4w5uJOSaUiAF5x7Fbe9mEf
	QYBVL0pDQumNXWEFQF/eA6NIUA6j2A3xNJJLLo3iYleJqZS72jH4/6/3mfg0mY5A
	nSuYQsJfE+nE2QNN7Nkq6RgnN9JzfwaqN3rAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x/X9++QpyRkvdLmF3Kq3HMkIpoWvCrdW
	uwpP6OX+JTyOD/LjWL7/BwdCHhdL9rjvmDzRowWqA0EdPlleKDT5yiYHKlM3wHBc
	p9sb5MCgv6lOFzq6lY7I9NJ+ZLLQI28CRuj7GHe8gUrUpOvfpOrpymX38edROij1
	ZqvJ38zH73s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E49A6A096;
	Sat, 12 Apr 2014 03:04:13 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51DA16A095;
	Sat, 12 Apr 2014 03:04:12 -0400 (EDT)
In-Reply-To: <7vmwfrmb6a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 11 Apr 2014 21:19:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: A6B840E4-C210-11E3-9688-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246164>

Junio C Hamano <gitster@pobox.com> writes:

> What is the race under discussion about?  It is about the index,
> which corresponds one-to-one to the working tree, so in order for
> the "race" to matter, you need to be racing against another process
> that is not cooperating with you (e.g. a continuous and uncontrolled
> "git add" updating the index while you are doing a real work),
> mucking with the index in the same working tree.  How could such a
> workflow any useful in the real life?
>
> In the spectrum between useful and insane, there is a point where we
> should just tell the insane: don't do it then.
>
> Having said that...
>
>>> So in that sense that can be done as a less urgent follow-up for this topic.
>>
>> Yeah if racing at refresh time is a real problem, sure we should solve it first.
>
> ... In order to solve the write-vs-write competition in a useful
> way, you must serialize the competing accesses.  E.g. "git add"
> would first take a write lock on the index before read_cache(), and
> then do its operation and finally release the lock by the usual
> write-to-lock-close-then-rename dance.

Extending on this a bit.

Here I didn't mean the traditional ".lock" we create via the
lockfile() API.  Rather, we would want to use fcntl/flock style lock
that lets others _wait_, not _fail_.  Because...

> The lazy "read and refresh in-core first, hoping that we did not
> compete with anybody, and then check just before writing out after
> taking the lock" is a very good solution for the opportunistic
> update codepath, because it is an option not to write the result out
> when there actually was an update by somebody else.  But such an
> opportunistic locking scheme does not work for write-vs-write
> competition.  Upon a real conflict, you need to fail the entire
> operation.

...having multiple conflicting writers on the single index file is
what you thought about worth protecting against.  When somebody else
is pounding on the index file you are trying to prepare your next
commmit in, with his writing that can unexpectedly overwrite what
you prepared, you would at least want the accesses serialized,
without getting half of your attempt to "git add" fail (and having
to redo).  For that, you would want your "git add" to wait while the
other party is mucking with the index under lock, instead of
failing, which is what you would get from the traditional lockfile
API based locking.

But that still takes us back to the "don't do it then".  It is true
that, with serialization, you may be able to guarantee that one "git
add" you do would start from one state (which may record the state
of your previous "git add", or which may have further been modified
by the other process) and ends with whatever that "git add" added,
without any other change.  But even in that case, when you finally
do a "git commit", can you say you know what is in the index?  I do
not think so.  After all, the root cause of the "race" issue is that
the other process pounds at the same index while you are working on
it, without any coordination with you.

So...
