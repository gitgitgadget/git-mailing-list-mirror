From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reset respect remote repo (make git idiot proof)
Date: Thu, 04 Oct 2012 20:11:51 -0700
Message-ID: <7vsj9tvci0.fsf@alter.siamese.dyndns.org>
References: <k4hj91$4tt$4@ger.gmane.org>
 <CABURp0qVWg2PvD4PcjJ9q45x9WxJCuJEQL8Rze=qerWXg72Txw@mail.gmail.com>
 <k4jj5n$72b$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geoffrey De Smet <ge0ffrey.spam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 05:12:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJyKb-0006Qs-9p
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 05:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044Ab2JEDL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 23:11:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab2JEDLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 23:11:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBD7B9396;
	Thu,  4 Oct 2012 23:11:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2KccSLF6sPjKwTifB0ClZccah1Q=; b=oVpYMe
	MGLJqM4DARO0WzuboHPog1UqpchFB7006KgvWMX1IT/H1xfYaSryH1OOhFCr/lje
	fyMDIJcJ7F+HJ8ysXAXedXC/8yagUL/o7IVZDI95HQ33FrSIOHIxOKt8GHZWF5Ik
	5/qCrSn1EE+/vmE1GsMOUL3OPanlFvRb0nFck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AHUVpcWuJI6fZUISmW4nLYyvnzM8O/MM
	ibKM1NUMLhKMXprwolf/4PUiATMzhNUMaohATe0eoLpZFqKOYv5TsIS91BAs0QCS
	PJVxs8LRfZnra3pMK9DbBifpPbqeev6BclhtFtcmkT6dANimLrkhhjjdQdVglmXA
	eExJK3dKFdc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9A6C9395;
	Thu,  4 Oct 2012 23:11:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AA8B9394; Thu,  4 Oct 2012
 23:11:53 -0400 (EDT)
In-Reply-To: <k4jj5n$72b$1@ger.gmane.org> (Geoffrey De Smet's message of
 "Thu, 04 Oct 2012 10:59:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6978E2E0-0E9A-11E2-9711-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207067>

Geoffrey De Smet <ge0ffrey.spam@gmail.com> writes:

> Op 03-10-12 18:40, Phil Hord schreef:
>> But I feel your pain.  I think the solution lies in relegating 'reset'
>> to the plumbing or the power-user realm of commands since I feel it is
>> quite overloaded and sometimes dangerous.  There was a thread some
>> months back heading in this direction, but I failed to keep it going.
>>
>>      http://comments.gmane.org/gmane.comp.version-control.git/185825
>
> I personally use git reset a lot:
> - Try an experiment
> - Commit a few commits as the experiment progresses
> - figure out that the experiment is a dead end
> - git reset all those _local_ commits
>
> The point is: they are local commits, so no harm done.
> But there's nothing preventing me from resetting pushed commits too,
> which would mean harm.

Even if you reset your local branch beyond the point you pushed out,
no harm is caused, as "git push" will catch that mistake, e.g.

	: on 'master' that integrates with 'master' at remote
	$ git reset --hard HEAD~4
        : work work work and commit commit commit
        $ git push origin master
        ... will result in refusal due to non-fast-forward

And then you can recover from it easily; one workflow may go like
this:

	: update refs/remotes/origin/master, among other things
	$ git fetch origin
        : recover the "work work ... commit commit" part
        $ git rebase origin/master

Another thing we could think about doing is to warn at the point you
reset your head away.  The above "reset --hard HEAD~4", before doing
what it was told to do, could perform:

	git rev-list HEAD~4..HEAD

(replace "HEAD~4" with whereever you are attempting to go) and see
if any of the listed commits is an ancestor of @{upstream} of the
current branch.  And if that is true, then your updated "reset" can
issue a warning, just like "git checkout branchname" to leave the
detached HEAD state gives you a friendly warning.
