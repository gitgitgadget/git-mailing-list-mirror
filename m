From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/9] bisect: allow git bisect to be used with repos
 containing damaged trees.
Date: Mon, 25 Jul 2011 11:14:56 -0700
Message-ID: <7vhb6arzvj.fsf@alter.siamese.dyndns.org>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
 <7v1uxfwmq3.fsf@alter.siamese.dyndns.org>
 <CAH3AnrrVwodvtwWfaJCJqjuHThtv75jaWeDjvwRgdFbgXA3ziA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 20:15:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlPgH-0004RA-VK
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 20:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab1GYSPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jul 2011 14:15:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153Ab1GYSO7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2011 14:14:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 594DA4323;
	Mon, 25 Jul 2011 14:14:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vMjPAnIFdFb9
	JLiPKbx9JjwXQAg=; b=IDo5keFYvRvaKLLMp6h0y2yaPgxf4FWRWYcjC5lx/+02
	Hoy1GeSt0OEiXKF6BIzSyKbJqlgiAOONitxy1ojVC6UUv4kKOrq0sC18ddIhEkll
	W6Y+jbuA1YgTYLvbdvhX7rxMkmgum2F80iGdI7OeAoepv+sQ3NNwSA0o1OuX2pk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TEeiti
	CJczkQEjM+0n+a2n4Qjiweo9NoGiqFrayWxVtRyrylH9yMAL55mR5RAAWqRdeTQ/
	GFO6L1oe+TzuYHsLgiusUnZh8GlX7HmlQitE0V0cwi30Iz4zDaKloixAjOwQNztB
	q2/LMju1RiRs54Q8kgwgLrJRm6uLqGor8Bbro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50E904322;
	Mon, 25 Jul 2011 14:14:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C137E4320; Mon, 25 Jul 2011
 14:14:57 -0400 (EDT)
In-Reply-To: <CAH3AnrrVwodvtwWfaJCJqjuHThtv75jaWeDjvwRgdFbgXA3ziA@mail.gmail.com> (Jon
 Seymour's message of "Mon, 25 Jul 2011 19:28:12 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01172468-B6EA-11E0-BDCE-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177805>

Jon Seymour <jon.seymour@gmail.com> writes:

> I don't think you understood my intention. Suppose, I have
>
> B4 - B5 - B6' - B7' - B8' - B9
>
> such that B6 and B7 and B8 all contain a damaged tree, but B4, B5 and=
 B9 don't
> since it contains a different tree, then:

What prevents your disk from corrupting a blob that was in B6, modified=
 by
commit B7, and then _reverted_ by commit B8? Then your checkout would f=
ail
at B6 and B8 but B7 will be fine.

As I wrote in my footnote, if your test is to find the most recent comm=
it,
starting from which all the objects reachable from it are not corrupt (=
by
using "rev-list --objects $commit | pack-objects"), you could run your
bisect by somehow first finding a good commit (B5) that passes the test=
,
and after knowing a bad commit (B8) that does not pass (because it is
missing the single blob that is unreadable for B6 and B8), and then bis=
ect
using a slightly less expensive test

	rev-list --objects B5..$commit | pack-objects

to find it in theory, but "Being unable to check-out" is not an isolate=
d
event and cannot be used as the check as you seem to think.

>> Having said that, an option to bisect that does _not_ touch the inde=
x nor
>> the working tree at all may be a useful thing to have. The test you =
want
>> to run on the candidate revisions bisect suggests may not need a wor=
king
>> tree (e.g. it may be built around "git grep -e foo $revision -- $pat=
h"),
>> and it may work just as well for the bisection you wanted to do in y=
our
>> broken repository.
>
> I am happy to do this, since clearly enables a superset of the cases
> handled by --ignore-checkout-failure.
>
> I propose to do this with a new ref (perhaps BISECT_CURSOR) which wil=
l
> be used in place of HEAD for the purposes of driving the bisection
> algorithm if --no-checkout has been specified on the git bisect start
> command.

Pros of using HEAD (i.e. the only change under the new mode would be th=
at
we do not touch the index nor the working tree) is that the test you wo=
uld
need to run in each step of bisection can use the familiar HEAD ref
instead of a strange BISECT_CURSOR, "bisect reset" will take you back f=
rom
the tentative detached HEAD state the usual way, and most likely the
necessary change to git-bisect.sh would be smaller. Cons of using HEAD
would be that the index and the working tree will be totally out-of-syn=
c
with respect to HEAD during the bisection (by definition---as that is t=
he
point of this new mode). One could argue that a na=C3=AFve user might g=
et
confused, but I am not sure how big a practical downside it would be.
