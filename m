From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Porcelain scripts: Rewrite cryptic "needs update"
 error message
Date: Sun, 03 Oct 2010 16:34:07 -0700
Message-ID: <7vhbh2etqo.fsf@alter.siamese.dyndns.org>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
 <1285877017-8060-3-git-send-email-artagnon@gmail.com>
 <7vzkuzgcs6.fsf@alter.siamese.dyndns.org> <20101001051426.GF20098@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:34:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Y4Z-000625-Om
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab0JCXeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 19:34:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46469 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab0JCXeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 19:34:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BA68DB24B;
	Sun,  3 Oct 2010 19:34:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=fuJMjNr429aLHqB+0rOhLGHB0y4=; b=Gt9ND623G3TOUP7xK9n4cA7
	LILS0Ltu8mL3wqW4e+wTi//cajB9OXXdEwTlD7Mttyt0O0jqPY7NoLiKp9J2JCEu
	nDC8jgFUwK0rSVeNboWobnH/+U66nd0G6m9JNSfmRjmTji9TGu3vHC+WapygLxC9
	fXrpaSvEhUMBFwfhb/u0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=uGqbLdF4A2hLsa74U9RGEvLSwn7hVYSd3m1QJ7dEANHadyL30
	VKayHwVVDKCChcaZ36IQg/0yDwGP2DxiXONmorB42ADbN0JY5mgVMLivtU74VLbp
	dZd0Lup4BEX2T2WojtJ3YCqjdHTuZb71/fUtu1UEHSSJPeG+BCQEE9pq1g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CE993DB247;
	Sun,  3 Oct 2010 19:34:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF00ADB246; Sun,  3 Oct
 2010 19:34:08 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BBB3CD1C-CF46-11DF-80D5-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157949>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> This is one of the concerns I had while creating this iteration. What
> do you suggest? Should we limit the number of paths listed like this?

Personally, I do not think you should list any paths.  If the program
states clearly that it does not like to see a dirty working tree (or a
dirty working tree is likely to be a mistake by a forgetful user), the
user already has enough tools such as "git status" and "git diff" to
figure out which ones are dirty.

> - If it's an "edit", "squash" or "fixup" interactive rebase step, the
>   staged changes are automatically committed to the current commit:
>   you don't have to explicity commit --amend.

It might be somewhat irritating to see "you haven't committed the amend"
against "rebase --continue" after running "git add" or "git add -p" to
shape what should be the final commit, and that is why the codepath runs
"commit --amend" for the user, but I personally think this is an attempt
to help users that is ill-thought-out.  The codepath stops when there are
changes to the working tree files that are not added, to avoid mistakes by
a forgetful user, but what if the change the user forgot to add was an
addition of a new file?

Also, this is one special case that the user has to remember.

It is too late to change this now, but it would have been a lot nicer if
we insisted that the "commit --amend" is always done by the user, and
never automatically by "rebase-i --continue" codepath.

> - If it's a "reword" step, staged changes/ dirty working tree don't
>   mean anything. The use should simply stash everything and continue
>   in this case.

Why would "reword" involve _any_ local changes?

> I suppose I can come up with a way to check which path was taken and
> print more targeted advice. Will do in the next iteration.

In general, I am mildly against giving advices like "commit or stash",
especially when the program does not know the workflow the end user in
each situation is using better than the end user.
