From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Sat, 28 Jan 2012 22:56:24 -0800
Message-ID: <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
References: <4F24E287.3040302@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 29 07:56:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrOgr-0000Eb-BI
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 07:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab2A2G4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 01:56:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48684 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab2A2G41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 01:56:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A760B6CF8;
	Sun, 29 Jan 2012 01:56:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oU6jXj1Ts1R7ZpMKcjThL8/WjrA=; b=tE6Y81
	SY9A6SnXpoX+TO37dgOGGq23LlozhRqhPg2QpMxejb18Rb/ZFIWCCZrJlKL2UwwY
	ixRqUw7Ab8hhGoq4uDi4hyOrNoaQ8dCtmnv0GzXTWb2mEae8x/cn/5fqoJhcj8r/
	ww82g8yR1321LeeH93OuML3zh1AmoU22zQSvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iDZWZNFnJxySJeOUpmG4qStUpXPY5wYx
	JmK0/8bvMIh6rosWAuDeD+SBfIDOsl+EYdASYi9uZT2WiOxmkUFe4o1DD30T9nTi
	RnWyYEXwI3fAHuzfBW/1vBEqSr8HQQQJILBay/DdyWWwh5Mw86asUQripSLlSy9p
	1JshR8qgBRk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F3B16CF7;
	Sun, 29 Jan 2012 01:56:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2339C6CF6; Sun, 29 Jan 2012
 01:56:26 -0500 (EST)
In-Reply-To: <4F24E287.3040302@alum.mit.edu> (Michael Haggerty's message of
 "Sun, 29 Jan 2012 07:09:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CB7E56A-4A46-11E1-86CB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189282>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> When starting a new repo, git seems to insist that the first commit be
> made on a branch named "master":
>
>     $ git --version
>     git version 1.7.9
>     $ git init git-test
>     Initialized empty Git repository in /home/mhagger/tmp/git-test/.git/
>     $ cd git-test
>     $ git checkout -b foo
>     fatal: You are on a branch yet to be born
>
> I would call this a bug; the last command should be allowed.  The
> plumbing allows it:
>
>     $ git symbolic-ref HEAD refs/heads/foo

Your last sentence is nonsense.  The plumbing equivalent of that command
is *not* what you wrote above, but is more like [*1*]:

	git update-ref refs/heads/foo $(git rev-parse --verify HEAD) &&
        git symbolic-ref HEAD refs/heads/foo

And the first step will fail the same way.  While I share the sense of
annoyance with you, I do not think that it is a bug in "checkout -b".

When you are on an unborn branch, what the "symbolic-ref HEAD" command
reports does *not* appear in the output from the "for-each-ref refs/heads"
command (similarly, that branch name does not appear in the output from
the "git branch" command).

Such a behaviour indeed is *curious* and very *different* from the normal
case of being on an existing branch, but is that a bug?

You need to first admit that the state immediately after "git init" (or
for that matter, "checkout --orphan") where you are on an unborn branch
*is* special.  Some things that would normally make sense would not.


[Footnote]

*1* Because you are not switching to a different commit, there won't be a
need for the third step which is "git read-tree -m -u HEAD@{1} HEAD" that
would usually be necessary if you are giving a starting commit that is
different from HEAD.
