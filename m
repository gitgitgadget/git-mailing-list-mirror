From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Sharing merge conflict resolution between multiple developers
Date: Mon, 11 Aug 2014 11:44:11 -0700
Message-ID: <xmqqd2c67tok.fsf@gitster.dls.corp.google.com>
References: <CAFOYHZCiKC4TR4jFVUB=W5qbDG8XvB2Obx1ZfTH8OF3E_c5BnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 20:44:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGuaA-0000x8-D6
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 20:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbaHKSoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 14:44:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58340 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799AbaHKSoV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 14:44:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 61ACE2FA7D;
	Mon, 11 Aug 2014 14:44:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p5XJISYHa5XOC2nQmwrZQRx6aWE=; b=B1YTbV
	F9yVQLSQ160+fp+NNnL+atA0lQV2onzKNyV2UBJvV7KA4qTQD/+dnCQF+tAify1K
	/ck5s6qaL8h/t85JAVpc504qGo7LVozYwGQI9HnvSk9ThgL94dlQumnEQix8Bn0q
	JvKVzJJA6Jvxk8y4O9GN1c6K5G6/sT34dgqTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BP+dEBcovtInVPowviFK/Xi0RuhV5aUX
	j/Y6wjS5+SB/55a1qz2h7S8wAw0q3y/05qXpqdk+VaQvbxeGsueN+8+FqsmYi2Og
	NBbf0WoRV7Psw8LyRdhRrKMV93L740YBmuCFuUn/sN7Qylwcf05glnSx0umSw2sE
	FH6G7yj4iKw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 588712FA7C;
	Mon, 11 Aug 2014 14:44:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6D1692FA71;
	Mon, 11 Aug 2014 14:44:13 -0400 (EDT)
In-Reply-To: <CAFOYHZCiKC4TR4jFVUB=W5qbDG8XvB2Obx1ZfTH8OF3E_c5BnA@mail.gmail.com>
	(Chris Packham's message of "Mon, 11 Aug 2014 16:59:15 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7D4ECBF2-2187-11E4-B2AC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255129>

Chris Packham <judge.packham@gmail.com> writes:

> Is there any way where we could share the conflict resolution around
> but still end up with a single merge commit.

One idea that immediately comes to me is to use something like
"rerere" (not its implementation and storage, but the underlying
idea) enhanced with the trick I use to fix-up merges in my daily
integration cycle (look for "merge-fix" in howto/maintain-git.txt
in Documentation/).

> developer A:
>   git merge $upstream
>   <conflicts>

And then commit this immediately, together with conflict markers
(i.e. "commit -a"), and discard it with "reset --hard HEAD^" *after*
storing it somewhere safe.  And then redo the same merge, resolve
the conflicts and commit the usual way.

The difference between the final conflict resolution and the
original conflicted state can be used as a reference for others to
redo the same conflict resolution later elsewhere.  That can most
easily be done by creating a commit that records the final state
whose parent is the one you recorded the initial conflicted state.

So, the "recording" phase may go something like this:

    git checkout $this
    git merge $that
    git commit -a -m 'merge-fix/$this-$that preimage'
    git branch merge-fix/$this-$that
    git reset --hard HEAD^
    git merge $that
    edit
    git commit -a -m 'merge $that to $this'
    git checkout merge-fix/$this-$that
    git read-tree -m -u HEAD $this
    git commit -a -m 'merge-fix/$this-$that postimage'

The rough idea is "git show merge-fix/$this-$that" will show the
"patch" you can apply on top of the conflicted state other people
would get by running "git merge $that" while on "$this" branch.

"rerere" essentially does the above recording (and replaying)
per-path and it comes with a clever indexing scheme to identify
which previous conflict resolution would apply to the conflicts you
see in your working tree.
