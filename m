From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git checkout -b: unparent the new branch with -o
Date: Tue, 16 Mar 2010 15:56:36 -0700
Message-ID: <7v634v27vf.fsf@alter.siamese.dyndns.org>
References: <1268763584-14164-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 23:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrfgy-0000qT-C8
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 23:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929Ab0CPW4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 18:56:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab0CPW4q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 18:56:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 127D7A2858;
	Tue, 16 Mar 2010 18:56:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=x62iYUQPOp3SchCFJ0LQQAxsUb8=; b=DuZHPGrlSmxRjSNv7Y96XNS
	HP3KjTSrhJ0d9M7dGG4JCyHs2HkK9COuA68b0iW5IYgoGlGQWmNXjA0ifnyLIixf
	ObSdKvngyZ4x8RJgEOJnPta4s9Y3R9rfrR1SbsNb157WpNpR6L5BrSAa6A+xou3K
	xDlVLDPnIfBC/byfRRes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=JkdleMN2cvUH+0MZhdVSwUgVpZDhYATT/e6MCC7SVX6kkN+Gn
	MpnQNO2wcapcn/0/tcnFxOMZsMT0SRU5YXZduW+gMznSPGy1zO9LVJUkQ6F/w5lj
	owJLqC3uxc1YUSmYBJaNhqu/V+PbyCwWvp4RiWwALPtEi1RbLE50G2h1L0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFA17A2853;
	Tue, 16 Mar 2010 18:56:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EDC3A2852; Tue, 16 Mar
 2010 18:56:37 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F385AE6-314F-11DF-A3B3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142358>

Erick Mattos <erick.mattos@gmail.com> writes:

> Sometimes it is interesting to start a new unparented branch in an
> existing repository.
>
> The new -o/--orphan is intended to solve this situation allowing the
> creation of a new branch unparented to any other.
>
> After the 'checkout -o -b' the new branch is not saved until committed.
> Before committing you should 'git rm -rf' anything which is not going to
> take part in the new branch and change the work tree and index the way
> you want it to be since they remain untouched as before checkout
> command.

This paragraph makes the patch incoherent.  It talks as if "no common
paths" is the majority case, and everybody inconveniently has to perform
an extra step that shouldn't be needed if the implementation were done
right.  If "no common paths" is indeed the assumed primary target, why
doesn't the implementation empty both index and files in the working tree
so that users don't have to do so themselves?

My _only_ complaint was that your version that _only_ emptied the index
without touching the working tree made things difficult for everybody,
both "no common paths" people and "mostly common paths" people.

You need to at least qualify the above paragraph with something like "if
you want to create an unrelated branch whose contents do not resemble the
original branch at all, then you should ...".

Better yet, try to advertise what you are giving your users in a positive
way, instead of in a way that only scares users, perhaps like this:

    After 'checkout --orphan', your HEAD will point at an unborn branch,
    and the next commit will start a new history without any prior commit.
    To help create such a new history that has contents mostly the same as
    that of the original branch, the command does not touch the index nor
    the working tree, and "checkout --orphan" immediately followed by
    "commit -a" would record a tree very similar to what you had in the
    original branch.  This is useful when you want to ... [insert a
    summary of "going open source" example from my previous message if you
    want here].

    If on the other hand you want to start a new branch whose contents do
    not resemble the original branch at all, you may want to start from an
    empty index and the working tree, with "git rm -rf ." immediately
    after running this command.

The same comment applies to the documentation part.

By the way, I wouldn't mind if you believe "no common paths" is the
majority case; if that is the case, then the code and behaviour would be
different, and the presentation would say something like this:

    After 'checkout --orphan', your HEAD will point at an unborn branch,
    and the next commit will start a new history without any prior commit.
    To help create such a new history that has contents totally different
    from the original branch, the command empties the index and removes
    all tracked files from the working tree.  The command refuses to work
    if you have uncommitted changes, so that you won't lose them.
    Conclude the work in progress on your current branch first by first
    recording the changes in commits (or "git stash save") before
    re-running the command.

    After "checkout --orphan" you can immediately start preparing the
    files to be tracked in this new branch, without files unrelated to
    this branch getting in the way.  This is useful when you want to
    ... [I don't think any "no commmon paths" workflow makes sense to be
    done in the same repository, but you seem to do do so, so give readers
    such an example here].

    If on the other hand you want to start a new branch whose contents
    mostly match the original branch, you may need to start from an
    index and the working tree files from the original branch, by running
    "git checkout <original-branch-name> ."  after running this command.
