From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Fri, 05 Oct 2012 23:26:47 -0700
Message-ID: <7v8vbkru8o.fsf@alter.siamese.dyndns.org>
References: <201210051420.q95EKjj3008300@netbook1.inf.utfsm.cl>
 <op.wlp1lws70aolir@keputer> <7vsj9ssgcp.fsf@alter.siamese.dyndns.org>
 <20121005225758.GA1202@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Conrad Irwin <conrad.irwin@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 06 08:27:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKNqn-0000gZ-UY
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 08:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932Ab2JFG0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 02:26:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753Ab2JFG0v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 02:26:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49C9F4C2E;
	Sat,  6 Oct 2012 02:26:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0EqMOqAwrkGs3CTawr77WZjF3K0=; b=goBKix
	+EYgAinzb+mp8QdBAGmCZfeZl6sNSDUyB4iszwm48CmFkvLlJxZm6qOoUpEpIUQ4
	Nsp7VtZQyOvH1nZl5FxvHcDLsae7D0Yf98Vb+si3IG8c/FgTikI6c0pYpcb68g6G
	GJUdolnjIe9JsV8Q5YBG++WC+ZNhdOVZLCtmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XaRvH+PmL02To+A+P8ruJUqdPUBaAAFI
	460cs19lzAIbFxkRV8byckfnCnjZzJPXfsULeuCbClvZ55H+uv1wGQywmEVOkpta
	PHvvo0fM4T/YMabMsJQvzpxg7bSzw0HTzcB9CpaINchnm77h/PtDAXyflKdcjkgD
	YCkHQlKqAUI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3680F4C2D;
	Sat,  6 Oct 2012 02:26:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 262904C2C; Sat,  6 Oct 2012
 02:26:49 -0400 (EDT)
In-Reply-To: <20121005225758.GA1202@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 5 Oct 2012 18:57:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF3BFD30-0F7E-11E2-A106-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207132>

Jeff King <peff@peff.net> writes:

> Actually, I am not sure that thread or feature is to blame. Certainly it
> would have been an opportune time to notice the problem. But this issue
> goes back much further for "git commit --interactive", which has always
> assumed "-i" rather than "-o". This even predates the switch from shell
> to C; you can see the same behavior from 6cbf07e (git-commit: add a
> --interactive option, 2007-03-05).

Yes.  That was after we started defaulting to "only" (not "also")
semantics when the command is run with paths, and it should also
have raised a red flag to reviewers.

In the case of "add/commit --interactive", it is much more clear
what state the index is in when the command gave interactive control
to the user.  The short-cut "add/commit -p" interface, however, does
not give you an access to its s)tatus subcommand, making the user
experience somewhat different.

That makes the problem much more severe for "-p" compared to
"--interactive", but the fundamental UI consistency it introduces is
the same as the issue under discussion in this thread.

>> I think the right thing to do is to fix "git commit -p" so that it
>> starts from the HEAD (on a temporary index), just like how partial
>> commits are made with "git commit file1 file2".   Or just forbid it
>> when the index does not match HEAD.
>
> Agreed. I am inclined to call this a bugfix, though it does worry me
> slightly that we would be changing a behavior that has existed for so
> many years.

I agree it will be a bugfix, but I am afraid that the fix may have
to be much more involved than "start from a temporary index that
matches HEAD when we are doing the '--only' semantics".

Suppose you have two paths E and F, both of which have differences
between HEAD and the index, and the index and the working tree file
(i.e. you earlier edited E and F, did "git add E F" and further
edited them).

You say "git commit -p F".

What should happen?  It is clear that the resulting commit should
record no change since its parent commit at path E (that is what
"only" semantics mean).

What state should the "add -p" interaction start from for path F?
Should you be picking from a patch between the state you previously
"git add"ed to the index and the working tree, or should the entire
difference between HEAD and the working tree eligible to be picked
or deferred during the "add -p" session?  Starting from a temporary
index that matches HEAD essentially means that you lose the earlier
"git add F" [*1*].

Another case to consider is to start from the same condition, and
instead to say "git commit -p" without any pathspec.  What should
happen?

Just doing "use a temporary index that is initialized to HEAD" may
be an expedient thing to do, but I suspect that I will be saying the
same "I should have said 'You cannot have a pony' back then" again
in a not so distant future if we did so without thinking these
things through.

As I do not see any practical value in "commit -p", I do not think
it is worth my time thinking these things through thoroughly myself.

Unless somebody who cares about "commit -p" does so to come up with
reasonable semantics, and updates the code to match that desired
behaviour, the responsible thing to do is to error out "-p" when
your index is different from HEAD, I think.


[Footnote]

*1* A not-so-deep thinking of the above might lead to "start from
the index that match HEAD, except for paths specified on the
pathspec given to the -p option".  But I do not think it is
satisfactory, either.  With "add -i" (or "commit --interactive"),
you have an option to selectively discard parts of your previous,
overzealous "git add F" with its r)evert action, but because "commit
-p" does not give an option to switch to "reset -p", you can only
add hunks, People who did "git add E F" earlier and then wants to
amend that earlier add with "git commit -p F", but it does not allow
them to fully amend their earlier action. That is the one of the
reasons why I think "commit -p" is a mistaken "we can save one
command invocation" false economy that adds confusion without adding
much value to the UI.
