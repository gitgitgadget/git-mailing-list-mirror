From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Sat, 28 Jan 2012 23:50:19 -0800
Message-ID: <7vsjizvtfo.fsf@alter.siamese.dyndns.org>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 29 08:50:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrPXH-0002fW-NO
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 08:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358Ab2A2HuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 02:50:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64245 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab2A2HuW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 02:50:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C1207305;
	Sun, 29 Jan 2012 02:50:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tNTFMpYmjlIY8GpSJS8cWa6iJ2w=; b=VAsxDm
	DeLk+mLaBczcKKH7UB4eI9Q02E23kCCQq86mviTX83QrB2pIlqzc4TWz5esMtij8
	k5cRkjjypnbjrk5ByvBKhAk899fTNwu8e9UGZMtWwmd1qerJR6nW5sbPVH4Z0/el
	auDT755zhNtXw9IyEOFgiZt1GCiPur/xeIjVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yW3BEYq12+mKyRqSkhmW2Yb6CMzQEv1L
	TF04PzsO5umezxhq38KTRK8buX72FBdONwcNHS7+Td+BZgPhricrmB2QcuBevFL7
	9wdze5DxD2WLZmOAQW2by4Qi7hiyL6s81sXxOJ34cvUvbhqW5SdjXb0aZA1lMpco
	tN+WoUKnnUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43B5B7304;
	Sun, 29 Jan 2012 02:50:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7F497303; Sun, 29 Jan 2012
 02:50:20 -0500 (EST)
In-Reply-To: <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 28 Jan 2012 22:56:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4B22618-4A4D-11E1-BEE6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189283>

Junio C Hamano <gitster@pobox.com> writes:

> ...
> Such a behaviour indeed is *curious* and very *different* from the normal
> case of being on an existing branch, but is that a bug?
>
> You need to first admit that the state immediately after "git init" (or
> for that matter, "checkout --orphan") where you are on an unborn branch
> *is* special.  Some things that would normally make sense would not.

[sorry for having sent an incomplete message without conclusion]

The question then becomes this: what do you want to do about it with this
specific case, and more importantly what do you want to do about other
commands and options that would not make sense when HEAD knows what branch
the user wants to put the first commit on but there is no commit yet?

For some commands, we _do_ try to come up with a special case codepath so
that a command issued in the unborn state mimics the behaviour of the
command issued in the normal case to various different degrees. "git pull"
into an unborn branch simply resets to the other branch, for example, and
while technically speaking that is not merging the other branch into the
current commit (which does not exist), we do so because it was deemed to
be the most sensible behaviour to parallel the normal case.

I am not sure "git checkout -b foo" (without explict HEAD [*1*]) should
special case and degenerate to "symbolic-ref HEAD refs/heads/foo" when
HEAD points to a nonexistent branch.  The mimicking does not go far enough
to satisfy people who are pedantic enough to expect "git checkout -b foo"
to work when you haven't even instantiated your current branch (when you
are on an already instantiated branch, after "git checkout -b foo", "git
branch" output will show both foo and the branch you were on, but if you
start from an unborn branch, the behaviour will be different and a pedant
will notice the difference).

It may make sense to let

    $ git branch -m trunk

or even

    $ git branch -m master trunk

move away from an unborn "master'"after "git init", with a special case
codepath.  When you start from an instanticated branch, after a successful
such renaming, the original branch will not exist, and the new branch will
exist.  This property would also hold true if you start from an unborn one,
so it would be much better mimickery than "git checkout -b foo" case you
brought up in this thread.


[Footnote]

*1* Given HEAD or $(git symbolic-ref HEAD) as the starting commit
explicitly, the command should error out.
