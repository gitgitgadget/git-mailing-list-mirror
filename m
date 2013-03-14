From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-tag: Allow --points-at syntax to create a tag
 pointing to specified commit
Date: Thu, 14 Mar 2013 08:48:25 -0700
Message-ID: <7v38vyyoc6.fsf@alter.siamese.dyndns.org>
References: <4150f65f3e425d6120ed80c6bec36c1fe209a876.1363264398.git.minovotn@redhat.com>
 <20130314133629.GA4256@serenity.lan> <5141E056.3090808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Michal Novotny <minovotn@redhat.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 16:49:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGAOt-0008LS-H4
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 16:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806Ab3CNPsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 11:48:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51141 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933909Ab3CNPs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 11:48:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6A82B27F;
	Thu, 14 Mar 2013 11:48:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZOMEsy1QbivanAO0NeGx/SejTjo=; b=Rryykc
	gwyDdV/scd6nI/1i5mU55fDI/wKKvvn3WhP571BhWAkulTfjUFXk1GocEiuGaTjE
	ABg3C9g0DmwvIyZTW9t6/mlFgYiinQkkhhdLzXSiQzX5BcXIhtBOmyKvNWEYrtzP
	Iz8cbZ8Y9wtJiKw1ODCPn7ovMpk92VI3wXuRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SEirhJ8rQaS+4/FmiMBXoYWYClKO2b1n
	bcawQO+0s9bBrFymhHKDkUD0xdv81wNr2uyta4H9DLyBpl+YVXGAcRizmvx0t1FU
	/Mi7NrGrznXJW0//jUAFU8qvj7jeCugy759gFcLjP/Y/GVZTwy0rpjUO1krQGzc3
	KCUM6C0sAHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB046B27E;
	Thu, 14 Mar 2013 11:48:27 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E269B27D; Thu, 14 Mar 2013
 11:48:27 -0400 (EDT)
In-Reply-To: <5141E056.3090808@redhat.com> (Michal Novotny's message of "Thu,
 14 Mar 2013 15:36:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C8BE6E4-8CBE-11E2-8365-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218148>

Michal Novotny <minovotn@redhat.com> writes:

> Oh, interesting. It's working now and I didn't know that as it was not
> working some time ago I've been trying this approach. Maybe it's been
> added recently...

Pretty much from the very beginning "git tag <name> <commit>" has
been the way to create a tag, with missing <commit> defaulting to
HEAD.  In retrospect, it _might_ have been a more consistent UI
organization if the object to point the new tag at were given with a
command line argument like --point-at=<object>, absence of which
defaults to HEAD, but it is a bit too late for that.

By the way, your implementation is wrong and it shows that you are
not aware that a tag, either annotated or lightweight, can point at
any object, not just a commit.

> ... as I also saw several sites having different approach of
> tagging to specified commit (usually creating a new branch, tagging
> there and rebasing etc.).

There are at least two explanations that are more plausible than
that.

When rebasing an existing branch, especially if you are not familiar
with Git and want to be extra cautious, it is not unreasonable to
practice it by running the rebase on a new branch that you are
willing to discard when something goes in an unexpected way.  If the
tip of that throw-away branch happens to be where you want to tag,
it is easier to do

	git checkout -b new-branch <<some long object name>>
        git tag return-here

than

	git checkout -b new-branch <<some long object name>>
        git tag return-here <<the same long object name again>>

So it is understandable that "if untold, default to HEAD" is used in
such a workflow.  After all, we made it to default to HEAD exactly
because that is one of the most common thing to do.

Another plausible explanation is that these "sites" are written by
people who do not know what they are writing, which is not a big
news in the Internet.

It would surely be nice to get these "sites" fixed.
