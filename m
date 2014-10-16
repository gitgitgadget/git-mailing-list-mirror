From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git describe oddity with GIT_DIR
Date: Thu, 16 Oct 2014 09:57:20 -0700
Message-ID: <xmqq1tq8uf4f.fsf@gitster.dls.corp.google.com>
References: <543FC965.7040600@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Thu Oct 16 18:57:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeoMh-0003iH-BN
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 18:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbaJPQ5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 12:57:23 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751633AbaJPQ5X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 12:57:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9537613474;
	Thu, 16 Oct 2014 12:57:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6svwJVW6bna0e+6jQHWc6Zr1iZA=; b=F79hxG
	GNqg64UNYk9FcGFP49ljelfecZJXgyUHYJvdoQlxqCnB5yRsJVBpudTR15ZbSimp
	JxrFjRgyga987dYbi63+mtpVS3PibU/JM1vtInjAVBKzcSDHrvGHnPjw8w7UIfUe
	qIrnmFl/eU/hIQjHirAzd7hoBwXWDtTYy2Gsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nsl3U7ydtEHhLbR9tn52f/MqoTpvtzn7
	QrGJ3J9miH5wJrdkMHLpOFWQLyeU8SaN2JBxpEMwEpxt9AmFXK4ZeET5QNkwSM38
	rg0GS7CAtsiRV3EJNZOhGwkAVE/7mVLdPZIIua+dPpwpepIwVD+SjEnkQutZglfY
	Rmr7douvt/0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BB6A13473;
	Thu, 16 Oct 2014 12:57:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09D8013470;
	Thu, 16 Oct 2014 12:57:21 -0400 (EDT)
In-Reply-To: <543FC965.7040600@virtuell-zuhause.de> (Thomas Braun's message of
	"Thu, 16 Oct 2014 15:34:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7F15CC7C-5555-11E4-A20E-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> I've encountered an oddity with git describe.
> Consider the following snippet:
> -----
> mkdir test
> cd test
> git init
> echo 1 > file
> git add file
> git commit -m "changes"
> $ git describe --always --dirty
> 8ad486e
> $ cd ..
> $ git --git-dir=test/.git describe --always --dirty
> 8ad486e-dirty
> $ GIT_DIR=test/.git git describe --always --dirty
> 8ad486e-dirty
> -----
>
> The "-dirty" suffix appears if invoking git not from the worktree
> itself, but should actually never appear.

This is not oddity with describe.  You are using --git-dir incorrectly.

When you tell Git where its repository resides with the $GIT_DIR
environment variable or the --git-dir command-line option, unless
you tell it where the top-level of your working tree is, you are
telling that your current working directory is the top-level of your
working tree.

You are asking "git describe" to describe the state of the HEAD
including the dirtyness of the working tree in various ways.  With
the first invocation, you do not tell Git where things are and let
it correctly figure it out, i.e. you are in 'test' directory and
relative to where you are, ".git" is the repository and "." is the
top of the working tree.  The commit recorded in the ".git/HEAD",
i.e. 8ad486e, is used, and its compared with the working tree to
determine dirtiness.  Specifically, the blob object 8ad486e:file is
the same as "./file" (that is "test/file" relative to where you
started with "mkdir test" above).

With the latter two, you are asking the same question but you go one
level up and then tell Git that the repository is "test/.git"
(correct) and the top of the working tree is "." (a lie).  Again,
"test/.git/HEAD" records the same commit, but when trying to compare
the contents of its tree, e.g. "file" at the top-level in the
commit, you do not have "file" in the working tree.  Git is led to
believe that you removed "file", hence your working tree state is
dirty.

Make it a habit to always specify GIT_WORK_TREE when you use
GIT_DIR, unless you know you will always start from the top of the
working tree.
