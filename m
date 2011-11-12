From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git: Unexpected behaviour?
Date: Sat, 12 Nov 2011 11:37:05 -0800
Message-ID: <7vlirlp1y6.fsf@alter.siamese.dyndns.org>
References: <1321044904175-6986736.post@n2.nabble.com>
 <4EBD9428.3030506@gmail.com> <4EBDBCA2.7070603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 12 20:37:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPJO9-0002X8-FS
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 20:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab1KLThJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 14:37:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50716 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557Ab1KLThI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 14:37:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7585F6AB2;
	Sat, 12 Nov 2011 14:37:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cdscy71QlB8V+f9bzlRmMB3IYvk=; b=qhRy1x
	59EdSaTYUvq5b77k9Qst82BnpWUfveZyHVYFQdxblzDGfXpA3/LHE/MkjQ/BK1zm
	R5SnY2sUIMF/CzXQb3P2iUjT6JFnoivcRTtkB9zami33oYYgDFWcBe3IpW/JlIi5
	VCtpTI4T9Li9iTeIWoOEPvORH+AxLhEb/Rj18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MoiNZsSzxFcgkS+G/+j+6g9IeZ+2wIre
	ZC3efNFcnbfEcjzUIv1hOFqzVyM4+6HVKFeOUp764vkdDxKGri1QWcPGvGD0+7m6
	k490t73Yie6Ti3mRir0uiPX5BoKsBI1ep8/pXDwICArWFcWDK1MLXK5ldglIMDbj
	yKcvKOY+qd4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D7A36AB1;
	Sat, 12 Nov 2011 14:37:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE33B6AB0; Sat, 12 Nov 2011
 14:37:06 -0500 (EST)
In-Reply-To: <4EBDBCA2.7070603@gmail.com> (J. V.'s message of "Fri, 11 Nov
 2011 17:24:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B47990E6-0D65-11E1-91DE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185313>

"J.V." <jvsrvcs@gmail.com> writes:

> OK so "work tree" is a new term for me.  I thought we were in isolated
> sandboxes called "branches" and changes made in a branch would stay in
> that branch regardless.

Do not think of "branches" as isolated _sandboxes_.

Rather, "branches" are where the independent states are to be _recorded_.

The recorded states only exist in the git repository, and to use its
contents (e.g. view in the pager or browser, edit in the editor, run the
compiler on,...), you need to materialize the contents of the branch
somewhere on the filesystem. Such a set of files on the filesystem form
the working tree. The act of doing so is called "checking out a branch".

After you check out a branch, your working tree can be used to record an
updated state to the branch, but notice the "can be" part. Changes you
make to the working tree are _not_ associated to the branch until you make
them so by committing. They are floating on top of the branch you have
currently checked out in your working tree, and "floating" was the key
part lacking in your understanding that started this thread. You are
allowed to check out another branch while you have a local change in the
working tree, and this is deliberately so. People often start working on a
branch (that is, they want to make a change and check out a branch, or
they happen to have a check-out of a branch and then the find something
they want to change), and then realize that the change logically does not
belong to the currently checked-out branch but some other branch. They
need to be able to check out another branch without losing the change they
already made in their working tree, and for such usage, the workflow
should look like:

    $ git checkout master ;# on master branch
    $ edit hello.c ;# some feature being added
    ... realize that this change does not belong to the master
    ... branch but is part of the "hello" branch you have been
    ... working on for the past few days
    $ git checkout hello ;# check out the correct branch
    ... this keeps the local modification in hello.c (as long as
    ... the file you modified are the same between master and hello
    ... branches). Keep working on it and then finally...
    $ git commit ;# on hello branch.

There is another unrelated use case in which people have local changes in
their working tree, but need to check out a different branch. The most
common is while you are working on a large feature that is not finished
yet on your "feature" branch, you hear from your boss that one trivial fix
for an urgent bug must be committed and pushed out on the "master" branch.
The feature you have in your working tree does not have anything to do
with the bug or the fix you are going to make for your boss. In such a
case, you would want to save away the changes for the feature, check out
the "master" branch and commit the fix, i.e.

    $ git checkout feature ;# on feature
    $ edit foo bar baz ;# some complicated change
    ... boss comes

    $ git stash ;# stash away the current change
    or
    $ git commit -a -m 'wip'

    $ git checkout master ;# emergency
    $ edit ... ;# quickfix
    $ git commit -m 'urgent fix...'
    ... emergency dealt with

    $ git checkout feature
    ... back to what was being worked on

    $ git stash pop
    or
    $ git reset HEAD^
