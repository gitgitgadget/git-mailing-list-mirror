From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Comparing the working tree with a commit should be independent
 of the index
Date: Sat, 18 Aug 2012 14:19:17 -0700
Message-ID: <7vvcgfrj8q.fsf@alter.siamese.dyndns.org>
References: <502FE0C6.6050106@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar@seznam.cz>
X-From: git-owner@vger.kernel.org Sat Aug 18 23:19:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2qQa-0002U8-JW
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 23:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab2HRVTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 17:19:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61341 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349Ab2HRVTV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 17:19:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AF9F8535;
	Sat, 18 Aug 2012 17:19:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uYMvuwlWir2jNKasNTo9aJxqxK4=; b=ZKS8od
	rDnQXwY6LNkGmVGZXajyOMKldfl+lV7PQWA1f5d6gNHuz48y8l0mzmUI8hmMmWhk
	50XtWqpp4zOonyOzLaS/tL7KuQRCpwHxbzsSi0UExagdkvfSSfEBh5iaz2wlgG0s
	IwknN8PsqvETYx/Ls2ifpt07QHhW6u7ip6wdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OjcXFLsRInxe2gRFsaKF+uaw8ixolQ5Y
	oOVnIEqG06YzzEGhbiZFfn4dDB8bYsFKmTkQsOrH7cokl2ojdyRF9fyI7o59G+z2
	8h766NYsd9V4yjIG5Bgiz6LD7tN3EE8eoVoAY6Ek5y9HMzIyVfGTQEkJ3IJHAFB6
	CWeDHE5l7BE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19FB38534;
	Sat, 18 Aug 2012 17:19:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72C2D8533; Sat, 18 Aug 2012
 17:19:19 -0400 (EDT)
In-Reply-To: <502FE0C6.6050106@seznam.cz> (Maaartin's message of "Sat, 18 Aug
 2012 20:36:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F77885E-E97A-11E1-A696-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203702>

Maaartin <grajcar@seznam.cz> writes:

> Instead I get "deleted file". Adding the file to the index changes
> it. This is IMHO a bug.

There are 7 interesting combinations for the state of a path.  It
either exists in or missing from the commit you are gving to "git
diff", it either exists in or missing from the index, and it either
exists in or missing from the working tree.  Missing from all is
totally uninteresting, so it leaves 7 combinations.

Among the 7 interesting cases, a path missing from the index have 3
interesting cases.

    In $commit	On filesystem

    Yes		Yes
    Yes		No
    No		Yes

and your case is the first one.  What do you want to see happen for
other two cases?  I would guess "deleted" and "added", as anything
else would not be internally consistent.

"git diff" compares contents in the index and in the working tree.
"git diff HEAD" compares contents in HEAD and in the working tree.

The definition of paths in the working tree in these sentences is
not "all files on the filesystem", or "all files on the filesystem,
filtered with the ignore mechanism".  It is "all files on the
filesystem that are in the index", and that is why you see a path
that is in the commit and on the filesystem but not in the index
as deleted.

This definition worked well for us, because that will give a clean
semantics to "git diff HEAD": what change would I be recording if I
said "git commit -a" at this point?

And that is why "git add" on the path changes the output as you
observed in your message.  It is an intended behaviour.  If you did
not tell Git that you want a path that does not exist in the index
with "git add", the path will not participate in the next commit
created by "git commit -a", and "git diff HEAD" should not talk
about it.  If the path is only in the index, not showing it as
deletion as you saw is actually dangerous.  "git commit -a" will
record the deletion of the path in the commit, even though you
checked with the "git diff HEAD" before you commit to make sure you
didn't change it.

Of course, our definition of the set of working tree files does not
have to be the only one.  Instead, it could be something that
changes the semantics of "git diff HEAD" output to: what change
would I be recording if I said "git add -A && git commit" at this
point?

The updated semantics will be far less useful than the current one,
but it still is an understandable one.  You could introduce a new
option (mode of operation to "git diff") to make it include
untracked but not ignored paths to the set of paths on the working
tree side of the comparison, but I do not think it is useful.

In short, I do not think there is a bug in the current behaviour.
