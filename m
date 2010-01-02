From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/5] reset: make "reset --merge" discard work tree
 changes on unmerged entries
Date: Sat, 02 Jan 2010 11:46:45 -0800
Message-ID: <7vzl4w8f2y.fsf@alter.siamese.dyndns.org>
References: <20100102053303.30066.26391.chriscool@tuxfamily.org>
 <20100102053934.30066.95746.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jan 02 20:47:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR9wa-0005xL-8S
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 20:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330Ab0ABTrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 14:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236Ab0ABTrP
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 14:47:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab0ABTrO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 14:47:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6B9B8DD98;
	Sat,  2 Jan 2010 14:47:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=5ycr2UvGwluVXohUnwaXgjLKqII=; b=MnSzgXQLBZUUY8dpUVaPymV
	iSK8ls6RpoaXK8JZNnRpFr0ghvQIABlCZBj4Tt5HSRCSdzbkFtLX2f6WZvVpkuj3
	LiP7KJwgnUuyCawUAImriw8G/Vj6GwmV0elzreWhgGnBH5N9YQmm8L7eDGWKc2wP
	fkw+8Yuf59PaSiN/a/Ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=aq+8sklNKPFBksegVIdjjDks/r2wKmNfX9DUYwfOK1GuwIZ5H
	1GUAN3So3zUX5G5VkKrstcFcQq/bJOx8Id+m85AQC3jgDAZjUot0/z4gGh4nBymc
	bL9nS1oUYB3rnVhRgM4vIu6rg4OzrH+4sYxkmMcRaKu22Mr/yS7DCVbRX4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03CF58DD8D;
	Sat,  2 Jan 2010 14:46:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42E908DD8B; Sat,  2 Jan
 2010 14:46:47 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9785FE3E-F7D7-11DE-8179-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136042>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> Commit 9e8ecea (Add 'merge' mode to 'git reset', 2008-12-01) disallowed
> "git reset --merge" when there was unmerged entries. It acknowledged
> that this is not the best possible behavior, and that it would be better
> if unmerged entries were reset as if --hard (instead of --merge) has
> been used.
>
> Recently another commit (reset: use "unpack_trees()" directly instead of
> "git read-tree", 2009-12-30) changed the behavior of --merge to accept
> resetting unmerged entries if they are reset to a different state than
> HEAD, but it did not reset the changes in the work tree. So the behavior
> was kind of improved, but it was not yet as if --hard has been used.

It would be more honest if we said something like:

	It changed a safer "I can't do as asked, please do it by hand"
	into a more dangerous "I pretend that I did so but I didn't do the
	full job; you need to fix up the result but I am not telling you
	that you have to", which is a lot worse.

here instead (that is one reason why I said my fix-up was "squashable").

But that is a minor issue.

I have been thinking about two issues on this --merge change.  

>  - Updates merged_entry() and deleted_entry() so that they pay attention
>    to cache entries with null sha1 (note that we _might_ want to use a
>    new in-core ce->ce_flags instead of using the null-sha1 hack).  They
>    are previously unmerged entries, and the files in the work tree that
>    correspond to them are resetted away by oneway_merge() to the version
>    from the tree we are resetting to.

One is the use of ce_flags instead of relying on the 20-byte comparison I
said above, for both performance (minor) and future maintainability (much
bigger) concern.  I have a feeling that we will regret later that we used
the null_sha1 trick here, when we want to express another "special" kind
of cache entry in unrelated situations.  The use of null_sha1 hack was
expedient but I fell victim of the same mentality of declaring that this
is the _last_ such kind of special index entry and closing the door to
others who want to extend the system later with different kind of special
cache entry, which I often complain about myself to patches from other
people.

Another is that it _might_ make sense to use two-tree form of read-tree
machinery (but using a different version of unpack-trees.c::twoway_merge()
function), instead of the one-tree form of "we don't bother checking if
the index is consistent with HEAD and assume it is, and jump to the
target."

"git reset --merge $there" is about the situation where you started a
"mergy" operation (e.g. "git merge", "git am -3", "git rebase", ...) while
you had unrelated local changes in the work tree, and you want to go back
to the state before that operation $there (which is HEAD if the mergy
operation is "merge", but is different from HEAD if it was "am -3" and you
have successfully applied a patch or more already).  Linus may know and
won't use "reset --merge" in a situation where it is not suitable, but not
everybody is Linus.  Even though "reset --merge" may "correctly" work with
respect to the table you added to "git reset" documentation, it would do
something that may not "make sense" from the end-user's point of view when
used in a situation that it wasn't designed for.  Using the two-tree form
allows the machinery to inspect the difference between HEAD and the index,
and detect cases where "reset --merge" was attempted when it shouldn't.
For example, if stage #2 of an unmerged path does not match HEAD, we know
there is something wrong.

This latter issue is much bigger and needs a lot more thought, and I don't
think it should block the series from going forward at all.  But I think
it is worth keeping in the back of our heads.
