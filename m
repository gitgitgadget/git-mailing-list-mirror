From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: respect "core.ignorecase"
Date: Sun, 09 Sep 2012 12:24:58 -0700
Message-ID: <7v7gs3q9rp.fsf@alter.siamese.dyndns.org>
References: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 21:25:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAn86-0007HA-FX
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 21:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab2IITZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 15:25:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49729 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754197Ab2IITZC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 15:25:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43C6A8648;
	Sun,  9 Sep 2012 15:25:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SaPeBAh5vkzQXnsI8z2F+3g66Q8=; b=bhhpX4
	B9HBILlSbikDVfwZsNKGh1hWYtfItXOEZYbvUOWhB312+H/udJaEdWOOeUR7Ct/t
	r4O6DWBSTW0EMkcQJNSwmCbiPuryql3DZYR+BJXph6Qs/kRtRzLNsrCLL326mumD
	ucW0kqXOAf+pblY9dY1pTI6w+m3cMnQLsMOBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s91Ii52CyOL3LpxDRbUcYVJPVXVuouEL
	MhCtQoC/kxpH3RjLRuwaC0BpKLMvyGZQ9ZuwA7hy5tDoHzpUDF94lfc1M2qdWKRC
	ZA8ZgVEYpE9yhcY2DAFTLpmt64BHG4je6yEQYYWGFw62xuO1oWc8QhjL4gMsDtMR
	gu9sLiWLDSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3088B8647;
	Sun,  9 Sep 2012 15:25:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36FFE8645; Sun,  9 Sep 2012
 15:25:00 -0400 (EDT)
In-Reply-To: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Sun, 9 Sep 2012 19:01:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C20580C-FAB4-11E1-8F26-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205088>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> If "core.ignorecase" is true, "git blame" fails
> when the given path differs to the real path in case
> sensitivity.

It is rather hard to respond to this request for comment because you
are describing the behaviour you perceive as a problem only fuzzily
(i.e. "fails"---what does it do?) without describing the expectation
(i.e. what should it do instead?).

> +test-path-ignorecase$X: builtin/blame.o

Yuck.  If it is a helper function that deserves its own unit test
helper executable, shouldn't it live with somewhere more appropriate
to be shared across commands?

> +const char* get_path_ignorecase(const char *path)
> +{
> +	struct strbuf res = STRBUF_INIT;
> +	struct strbuf p = STRBUF_INIT;
> +	int offset = 0;
> +
> +	if (!ignore_case || has_string_in_work_tree(path))
> +		return path;

If the problem you are trying to solve is that the HEAD and the
history has Makefile but the user said "git blame MAKEFILE"
(i.e. start traversing from the contents in the working tree), then
has_string_in_work_tree("MAKEFILE") will return true, and this
function will tell us to find the contents for "MAKEFILE" not
"Makefile" in the next revision (i.e. HEAD:MAKEFILE).

As you didn't describe what you perceive as the problem, I do not
know if the above analysis matters for the case you are trying to
fix, though.

Step back a bit and write down what problem you are trying to solve,
including what existing behaviour you should *not* alter.

Suppose we have this history (time flows from bottom to top), and
our HEAD is at commit F.  We may or may not have modifications to
Makefile in the working tree:

    F  Add Makefile again
    E  Remove Makefile
    D  Modify Makefile
    C  Remove MAKEFILE, add Makefile with related or unrelated contents
    B  Modify MAKEFILE
    A  Add MAKEFILE

What should happen to the following?

    $ git blame Makefile
    $ git blame MAKEFILE
    $ git blame MakeFILE

    $ git blame HEAD -- Makefile
    $ git blame HEAD -- MAKEFILE
    $ git blame HEAD -- MakeFILE

    $ git blame E -- Makefile
    $ git blame E -- MAKEFILE
    $ git blame E -- MakeFILE

    $ git blame B -- Makefile
    $ git blame B -- MAKEFILE
    $ git blame B -- MakeFILE

Git should see the pathname that was given by the user literally for
any of the latter 9 cases (i.e. if we are not starting from the
contents of the working tree) regardless of ignorecase.  If the user
tells us to blame MAKEFILE starting from B, "fixing" the path to the
version you can read from the working tree that may be similar to
what you have at commit F (i.e. HEAD) and turn it to a blame for
Makefile is a wrong thing to do, no?

Another potential problem with the approach your patch takes may be
that the case insensitive filesystem you are dealing with might be
not just case insensitive, but also be case destroying.  The user
may say "edit Makefile && git add Makefile", the filesystem may say
there is MAKEFILE there, and core.ignorecase is designed to handle
this case well by treating that the user really meant Makefile and
that it is the filesystem that is lying to us.

Now that we established that the "fixing" of the path we got from
the user, should _never_ look at the working tree.  Also, if such a
"fixing" ever is useful, it should be done only in the first three
cases where the user tells us to start blaming from the working
tree.

So what should happen to the first three cases?  When doing

    $ git add Makefile
    $ git add MAKEFILE
    $ git add MakeFILE

we infer the case the user really meant by attempting to match the
path against what is recorded in the index.  If there is no matching
entry, we use what we got from the user, but if there is a matching
one (and core.ignorecase affects how this matching is done), we fix
the path by using the path recorded in the index instead.  Then we
will turn the top three cases to "git blame Makefile".

That brings us back to the case where we start blaming from a commit
(the latter 9 cases).  It might make sense to grab the path in the
tree of the named commit that matches in the core.ignorecase sense
to the path given by the user.  Even though commit F does not have
MAKEFILE nor MakeFILE, we turn the path given by the user to Makefile
because that is the only path that the user _could_ have meant in
the context of the command (similarly, MAKEFILE for a blame starting
at B).  When starting to blame at E that does not have Makefile or
MAKEFILE, we would use whatever the user threw at us.

I said "might make sense" for the last paragraph for a reason,
though.  In the history A..F above, if the user is aware of the fact
that the history _is_ case sensitive (and setting core.ignorecase is
a signal that she does---it is an admission that the filesystem she
happens to have her working tree is incapable of interacting with
such a history natively and needs a bit of help from Git) and that
some commit have Makefile and others have MAKEFILE, it will look
inconsistent if she asked "git blame D -- MAKEFILE" and gets the
result for "git blame D -- Makefile" instead.

Having said all that, I am not sure if the "fixing" is really the
right approach to begin with.  Contrast these two:

    $ git blame MakeFILE
    $ git blame HEAD -- MakeFILE

The latter, regardless of core.ignorecase, should fail, with "No
such path MakeFILE in HEAD".  The former is merely an extension to
the latter, in the sense that the main traversal is exactly the same
as the latter, but on top, local modifications are blamed to the
working tree.

If we were to do anything, I would think the most sane thing to do
is a smaller patch to fix fake_working_tree_commit() where it calls
lstat() and _should_ die with "Cannot lstat MakeFILE" on a sane
filesystem.  It does not currently make sure the path exists in the
HEAD exactly as given by the user (i.e. without core.ignorecase
matching), and die when it is not found.

And that can be done regardless of core.ignorecase.  Currently on a
case sensitive filesystem without core.ignorecase, this will give a
useless result:

    $ git rm Nakefile || :;
    $ git commit --allow-empty -m 'Made sure there is no Nakefile'
    $ >Nakefile
    $ git blame -- Nakefile
    00000000 (Not Committed Yet 2012-09-09 12:21:42 -0700 1) 

and such a change to verify that the path exists in HEAD will give
us "No such path Nakefile in HEAD" in such a case.

It is a behaviour change, but I think it is a good change,
regardless of the "What I have is Makefile, but my filesystem lies
to us saying yes when I ask if MAKEFILE exists" issue.
    
