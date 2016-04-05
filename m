From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Triangular workflows and some anecdotes from the trenches
Date: Tue, 05 Apr 2016 15:24:17 -0700
Message-ID: <xmqq37qz1ypa.fsf@gitster.mtv.corp.google.com>
References: <CAFOYHZARoEXkT6kVy7+wMSqUxSVVHHMV5KfhU6FON3tB6XEuMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 00:24:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anZOg-0001JT-2u
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 00:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760707AbcDEWYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 18:24:22 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752305AbcDEWYV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 18:24:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 64757528BE;
	Tue,  5 Apr 2016 18:24:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rsLSKZBQIblfDVB/gn121OG2kIA=; b=ftE4QO
	vIGOPcpT9XUQtBHfPFm7336BM5/LAbrDhsdQO1PUM8QONG/u5+7xvZTqnQFRUjZb
	U4RsNPErAua7YQXmX1Svk4LHzGqDGXSihPfteXEk9s1h/RhuI73L+tsFKjtePJ4G
	0J3hOzvicszseI7MevcVowIDmHOKVMXRTa8uA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H5aWb5NgMkrdxka3llv4FyalAnuL3QA1
	7QZWibFLIvzoxcGyCY4zYLLi3rt30oBp83c8CCafrDGwTz7u62yiutgFW31XLtoq
	meZ4pdoEovuyiDxF7noEoVQFoGaZusZ9773kB8fDylyzpbmR8UT/WsqKWbD65/18
	y/LOz4gptyU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B3F7528BD;
	Tue,  5 Apr 2016 18:24:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CB937528BC;
	Tue,  5 Apr 2016 18:24:18 -0400 (EDT)
In-Reply-To: <CAFOYHZARoEXkT6kVy7+wMSqUxSVVHHMV5KfhU6FON3tB6XEuMg@mail.gmail.com>
	(Chris Packham's message of "Tue, 5 Apr 2016 23:06:06 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 236C566E-FB7D-11E5-BD2B-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290816>

Chris Packham <judge.packham@gmail.com> writes:

> We ran into something at $dayjob the other day. The actual problem was
> a developer ended up amending a commit that had already been pushed.
> It happens occasionally and is usually recoverable with a simple
> rebase and is generally a learning experience. In this particular case
> however things were a bit more complicated.

Developer ending up amending is not an issue per-se, unless the
result is pushed back to the public.

However, it would be nicer if "git commit --amend", "git rebase",
"git branch -f", and "git checkout -B" notices the situation and
warns about what would happen.

>   git config alias.amend '!git merge-base --is-ancestor HEAD
> @{upstream} || git commit --amend'
>
> I'm just wondering if something more official can be added to git
> commit --amend (and probably git rebase).

A bigger problem may be how you make sure everybody sets up
@{upstream} correctly.  You may fork your own copy of a branch from
the target branch, start working on it, further fork other branches
on your work to experiment different approaches, with the intention
to later use the best one to update your first fork.

At which point, the @{upstream} of the secondary branches are your
own first branch, not the public one--which is not a problem per-se,
because your first branch (whose @{upstream} is the remote one) is
not yet public and you should be allowed to freely update it to
polish it by rewriting.  But then after you push out your first
branch as an interim snapshot to the public, you no longer want to
rewrite the commits reachable from it.  So (to put it mildly) it
would be quite complex to get all the corner cases right, and the
definition of "right" would probably depend on the exact workflow.
