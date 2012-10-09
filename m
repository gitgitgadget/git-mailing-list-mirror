From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Inconsistency in specifying commit & path for git diff
Date: Tue, 09 Oct 2012 14:03:37 -0700
Message-ID: <7vliffe4t2.fsf@alter.siamese.dyndns.org>
References: <50747E48.3060203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arthur Etchells <adetchells@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 23:03:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLgy0-0007yl-1w
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 23:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab2JIVDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 17:03:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51331 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292Ab2JIVDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 17:03:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1C1898F3;
	Tue,  9 Oct 2012 17:03:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hLvBG8CZFB1DL7Ni8c/DzrEdeQQ=; b=D0vcrT
	pbMgeJr0iwu90U+S/zwk8XGN7bHq/lmkODs9rkE4m+PEKcxOeOd/bPwfMXCyAcz6
	0rrapMFwCM1gMwbarTm+fAWTM1EV6sbgP0Vq6ydMCt8FXSpqy1Iqdi+iCJpXlbDP
	LgGOI/aHn71qVatrpAPRuBXhvPlY2p6dI+uYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VqOSs/L7Gdkz8x1Muij9jODB6UUibLLa
	a6+scL69iNDK7oAsypSlECgmlqGqZk8oZD7u0qoGG/rcyquJ7axCAHRlmVTVa4cT
	YZ8cc3CY6gD3Migah0JMegq9sd5WpuijQwwzpBkmBjNfi+5Mm8pViZ2nfmjOrlVD
	Avc0vvNVb4g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FF5298F2;
	Tue,  9 Oct 2012 17:03:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E65398EE; Tue,  9 Oct 2012
 17:03:39 -0400 (EDT)
In-Reply-To: <50747E48.3060203@gmail.com> (Arthur Etchells's message of "Tue,
 09 Oct 2012 15:43:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCBB265C-1254-11E2-B7B5-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207346>

Arthur Etchells <adetchells@gmail.com> writes:

> git diff <commit>..<commit>
> and
> git diff <commit> <commit>
> both succeed
> however
> git diff <commit>:<path>..<commit>:<path>
> fails while
> git diff <commit>:<path> <commit>:<path>
> succeeds
> ...
> It seems logical to support the '..' syntax in both for consistency.

"git diff A..B" is an illogical thing to say in the first place.  It
only happens to work by historical accident, and for that "it used
to work like so from the beginning, do not break backward
compatibility" reason, we have kept it working.

But you are better off unlearning it to keep your sanity when
learning git as a new user.

The dot notation is about a range.  A..B talks about the set of
commits that are ancestors of B but not ancestors of A.

    $ git log A..B

makes perfect sense to show such a range.

But "diff" is about "comparing two endpoints".  There is nothing
"range" about such a comparison.  When you compare the state at A
and at B, you do not even look at anything in between.  That is why
the canonical way to say it is

    $ git diff A B

and not

    $ git diff A..B ;# WRONG. DO NOT DO THIS.

And <commit>:<path> is a way to name an entity at <path> in the tree
recorded in the <commit>.  Typically you name a blob, not a tree
that represents a subdirectory, with this syntax.

Now, B1..B2, when B1 and B2 are blobs (or anything that is not
commit-ish), does not make sense even as a range, and such a request
is detected as an error at the syntactic level (i.e. without even
starting to "compare").

    $ git diff HEAD:Makefile..HEAD~4:Makefile ;# WRONG. DO NOT DO THIS.

If you want to compare two blobs, you can do so with the canonical
"compare two things" syntax.

    $ git diff HEAD:Makefile HEAD~4:Makefile
