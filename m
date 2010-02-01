From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Mon, 01 Feb 2010 12:40:49 -0800
Message-ID: <7vhbq0wuy6.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 01 21:41:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc354-0001Wa-Q2
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 21:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756217Ab0BAUk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 15:40:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821Ab0BAUk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 15:40:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73AA296121;
	Mon,  1 Feb 2010 15:40:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=pbhIjBXPRBcHsX5RCBgF6NIekoE=; b=sE7PH3CoTwph/NptoGVe9nX
	fCGW69rY1/fvB0Zh577YWQHuRya+uhe+90zvA/+1jy64BqhoV7iUCj/+VfYBuasy
	U/VANIfKnzu4mUnRUb/V8DlJpB7+Ud8DpTUCKHpQDqelgmDyv0JrDqCDxaM4I5h4
	PuX9UG3N7YMf1EAnSfzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=oZNEH9SLVPJdzCdl2p5VXyO9k0qSax3I0UXWWz/1qHuv/sh5d
	F0JndHuQ9RbqzSWNhcByFvqh1K5jlLme2dVAsyLF6DxisEO8W3gP0Yy9d4YEMRAy
	hzemyEWBTK/IvKE34qnDFRnjTVIURcXGszgMjKE5n7FUuuz1XoK8kIIo8w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 515109611F;
	Mon,  1 Feb 2010 15:40:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75BDB9611E; Mon,  1 Feb
 2010 15:40:51 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 17B821C0-0F72-11DF-B927-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138645>

Markus Elfring <Markus.Elfring@web.de> writes:

> The content control tool "Git" maintains a single file system view that can be
> actively worked on. It can be switched to different topic branches by the
> command "git checkout". If the current active working copy contains "dirty"
> changes, they need to be stashed away before each switch to a different issue.
> http://ariejan.net/2008/04/23/git-using-the-stash/
>
> I imagine that there are opportunities for further improvements.
> - How do you think about the feature that a checkout performs also a stash
> operation before by default and a stash would offer the option to checkout a
> branch afterwards in one step?

If you are starting from "if your work tree is dirty, you MUST stash
before checking out another branch", the suggestion is understandable.
But the thing is, that starting point is not quite correct.  And the end
result is that such a change you are suggesting would inconvenience people
greatly, I am afraid, if not designed carefully (I'll outline at the end).

Checking out another branch (branch switching) is designed to carry your
local modification across with you.  This is to allow you to start working
on something, realize that your changes are better suited for another
branch, and at that point after the fact "git checkout" that other branch,
while keeping what you have done so far.

If the original branch you started your work from and the branch you are
checking out have different contents in files you have changed (aka "your
changes conflict at the paths level"), without -m option, "git checkout"
refuses to check out the other branch, because it will need a three-way
merge to carry your changes forward, and you might not be prepared to
resolve conflicts resulting from such a merge.

In practice, however, your changes often don't conflict with the changes
between the branches at the paths level, and "git checkout" lets you carry
your local changes across just fine.  I'd say this is the majority of the
case especially for experienced git users, as they tend to commit in
smaller and more logical units than those from other SCM background.

Forcing auto-stash on them would mean they now have to pop the stash,
after checking out the other branch, which is not an improvement for them
(and remember, soon you will be part of "them" after getting used to git).
Doing an auto-pop in addition to your auto-stash "to help them" is even
worse, as you essentially made "git checkout other-branch" to always use
"-m" option.

I actually have explained this at least a few times here in the past:

 http://thread.gmane.org/gmane.comp.version-control.git/77700/focus=77708
 http://thread.gmane.org/gmane.comp.version-control.git/135661/focus=135663

but I don't see anything that states clearly that "checkout" is designed
to carry your local changes across in any documentation (I gave a cursory
look to the user manual, tutorial and checkout manual page).  Probably
"git checkout --help" needs a "Switching branches" section, just like the
planned enhancement for "Detached HEAD" section.

We _can_ start experimenting with an option (similar to "checkout -m"),
which does:

 - Internally try 'git checkout other-branch' without disturbing the user
   with any error message; if it does not fail due to paths level
   conflicts, we have successfully checked out the other branch and we are
   done;

 - If the above trial would fail for some other reason (perhaps your index
   was unmerged), then don't do anything---just fail as before;

 - Internally run 'git stash', then run 'git checkout other-branch'.  If
   either of these steps fail, you are in deep trouble.  Design what you
   have to do carefully in this case (I won't do that in this message);

 - Then finally run 'git stash pop'.
