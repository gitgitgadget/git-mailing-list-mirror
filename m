From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG ? git-log omits changesets if the file is identical between
 revs
Date: Fri, 02 Jul 2010 15:10:28 -0700
Message-ID: <7vocepzga3.fsf@alter.siamese.dyndns.org>
References: <4C2E3511.902@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, u.kleine-koenig@pengutronix.de,
	"Hansen\, Dave" <haveblue@us.ibm.com>,
	Will Schmidt <willschm@us.ibm.com>
To: Darren Hart <dvhltc@us.ibm.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 00:10:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUoRe-0000DR-Ib
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 00:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209Ab0GBWKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 18:10:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab0GBWKn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 18:10:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 47831C1AC4;
	Fri,  2 Jul 2010 18:10:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uhnSEMuiTISYAisKzsoUFE9dakc=; b=FaK5b3
	iXhPwqipEvFakmzwUwAylESwFwk5Z66ua0AfHbpJr8gNUOzREB347XyXtr2nseWH
	oXQ1fdBYNJnrQegT8r8Dm+6EqBN5AL4DUAGnDMjv3mnNy7oWCF7PMP25H2M7JKdG
	9a4CMc5fEwAwXpCWl93ElwvRbsVY2/Hl7x3aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rBhcrlr+MiXyvdf8YK0vOSevyShyvepG
	gJeay4JCh6hL4QOHRJrQxBaEEJ4cQt49G0gYwb3ixShxMFqt5h92Mhx8Tfj1iZoy
	Q6CwtSFae6lE84whdffNv0BIREduejIVzXHvu8fajFs0/i1XgkItD2BvT6BlKxA3
	F8gAUe5e1U8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49291C1AC3;
	Fri,  2 Jul 2010 18:10:36 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 294B6C1AC1; Fri,  2 Jul
 2010 18:10:30 -0400 (EDT)
In-Reply-To: <4C2E3511.902@us.ibm.com> (Darren Hart's message of "Fri\, 02
 Jul 2010 11\:50\:57 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3FFCE14-8626-11DF-BEA4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150171>

Darren Hart <dvhltc@us.ibm.com> writes:

> $ git checkout -b 2.6.33.5-rt23 v2.6.33.5-rt23
> $ git log --pretty=oneline v2.6.33.5.. arch/powerpc/kernel
> ef4afcc4401e92982f4ffd3fae6a9a6745a98596 Merge stable/linux-2.6.33.y into rt/2.6.33
> ...
> 92bfe2d63ed46764b0b0a6e9b63bb9e81023ab80 powerpc: realtime support
> ...
> $ git whatchanged 92bfe2d6 -n1
> commit 92bfe2d63ed46764b0b0a6e9b63bb9e81023ab80
> ...
> :100644 100644 43e0734... 4bb9ce4... M  arch/powerpc/kernel/entry_64.S
> ...
> $ git log --pretty=oneline v2.6.33.5.. arch/powerpc/kernel/entry_64.S
> <null>

This is expected, and it is by design.

$ git log --oneline --simplify-merges --full-history --graph \
  v2.6.33.5..v2.6.33.5-rt23 -- arch/powerpc/kernel/entry_64.S

will give you a less simplified history.  The first commit we find in its
output is:

* ef4afcc Merge stable/linux-2.6.33.y into rt/2.6.33

and if you look at that commit:

$ git show --pretty=short --stat -m ef4afcc -- arch/powerpc/kernel/

you will notice that:

 - ef4afcc is a merge between ac43be5 and a00123d;

 - arch/powerpc/kernel/entry_64.S has not changed between a00123d and this
   merge result ef4afcc;

 - There are many changes made to this path in the history leading to the
   other parent of the merge, ac43be5.

 - When Thomas created ef4afcc, after looking at ac43be5 and a00123d, he
   took the version from a00123d.  Effectively, what happend on the side
   branch that led to ac43be5 did _not_ contribute to the end result at
   all.

 - There was no change to the path between v2.6.33.5 and a00123d (as they
   are the same commit ;-).

 - Hence there is nothing noteworthy to report when explaining how the
   path came about since v2.6.33.5 and v2.6.33.5-rt23.

BTW, this has nothing to do with the path being the same between your HEAD
and v2.6.33.5.  You can try:

  $ git checkout v2.6.33.5-rt23
  $ echo >>arch/powerpc/kernel/entry_64.S
  $ git commit -m 'random change' arch/powerpc/kernel/entry_64.S
  $ git log --oneline v2.6.33.5.. -- arch/powerpc/kernel/entry_64.S
  b736245 random change

and notice that the change you just made is the only one that is needed to
explain how the file came into its current shape since the named bottom
version (v2.6.33.5).

If you look for "history simplification" in the list archive you will find
Linus explaining why this simplification is the right thing to do number
of times, but the short version is that "git log $path" by default gives
you _one_ possible and simplest explanation of how the $path came about
into its current shape, and "one possible and simplest" is what you want
most of the time, because "all possible explanations" is very expensive to
compute and often unreadable.

But the "--simplify-merges --full-history" trick I showed above may also
be another good thing to know.
