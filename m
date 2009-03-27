From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: add support for an extended revision syntax
Date: Fri, 27 Mar 2009 10:36:15 -0700
Message-ID: <7vvdpudg1c.fsf@gitster.siamese.dyndns.org>
References: <1237803348-9329-1-git-send-email-davvid@gmail.com>
 <m33acz2byv.fsf@localhost.localdomain> <20090327162849.GA2853@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org, Christian Couder <chriscool@tuxfamily.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 18:38:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnG0R-0003a3-A3
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 18:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbZC0Rgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 13:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbZC0Rgk
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 13:36:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbZC0Rgj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 13:36:39 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C63E9982;
	Fri, 27 Mar 2009 13:36:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 01F4F997E; Fri,
 27 Mar 2009 13:36:26 -0400 (EDT)
In-Reply-To: <20090327162849.GA2853@gmail.com> (David Aguilar's message of
 "Fri, 27 Mar 2009 09:28:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D061306C-1AF5-11DE-82EC-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114916>

David Aguilar <davvid@gmail.com> writes:

> I'm still interested in the file~<n> idea [though maybe not
> that exact syntax] and have been reading revision.c (as Junio
> suggested) to see if it can be done in a good way.

Modern git programs use setup_revisions() to parse object names and range
notation given on the command line, and leave results in revs->pending
array.  This array holds pointers to "struct object" instances, and they
are often (always?) already parsed.  This gives the caller an easy access
to the parse results.

Recently there have been two topics that made me suspect that solving them
cleanly may require breaking this model.  I haven't thought things through
for the second one yet, so please do not take this as a criticism or
pointing-out-concrete-problems in the latter series.  At least for the
latter one, it is still an unsubstantiated fear.

(1) "The commit that touched this path the last time"

The objective of this extension is to accept a pathspec and come up with
the name of the commit object that touched the given pathspec recently.
There can be some variations to the parameter the feature could take, and
in the most generic form, the query would be:

 * set of commits: start digging from these;
 * pathspecs: find commits whose change touches some path that matches them;
 * N: do not stop at the latest change, but find the Nth one.

I am not good at coming up with a notation, so I'll leave the actual
syntax to other people, but you can say things like:

	git diff <<--all, Documentation t, 4>>
	git log <<master, Makefile, 10>>..next -- Makefile

The problem with this feature is this.  In order to come up with the
answer, you need to internally run:

	git rev-list --all -- Documentation t
	git rev-list master -- Makefile

and in order to compute this, the revision traversal machinery has to
not only open and parse commit objects but _rewrite_ the parent field of
these commits for history simplification purposes.  This is a destructive
operation, and after it comes back, we would need to clean them up by
unparsing these commits so that the original command that asked for its
command line arguments to be parsed can operate correctly.

At least, this can be fixed by unparsing all the objects parsed so far
when the revision command line parser finishes each such argument, and
force the caller parse them again when they read from rev->pending.


(2) "refs/replace/SHA-1 holds name of the object that replaces SHA-1"

The objective of this extension is to generalize the graft mechanism, so
that they can be shared across the usual object transfer mechanism, the
ordinary revision traversal mechanism can honor the replacement just like
they honor grafts file, while reachability machinery used by object
transfer, fsck and prune can ignore the replacement.  When refs/replace/A
has value B, a commit C that records A as its parent would behave as if B
is its parent (so "git log C" will show B as the second entry in its
output), while pushing C will notice C's true parent is A and sends A to
the other end.  By pushing refs/replace/A to the other end, you can share
the same "fake" history across repositories.

This feature has similar problem as (1).  If you say

	git rev-list master..next^^

how should next^^ be interpreted?  Because it is an input coming from the
user, we may want to honor the "graft/replace", and we need to read and
parse next, next^, and next^^ while possibly reading from refs/replace/
hiearchy.  But after getting the end result, the name of the commit object
the notation refers to, we would need to unparse the objects involved so
that the main parts of the command can start from the clean slate.

There are three issues with this:

 (1) When you ask for the data for a concrete SHA-1 (i.e. not "next^", but
     something like "9856dd811ee0f256d067b89cbccb58d944aa9c8c"), with and
     without grafts/replacements, the actual object data changes.

     This again needs at least unparsing of all the objects as in the
     <<commits, pathspecs, Nth>> case above to deal with.

 (2) Depending on the use of grafts/replacements, the interpretation of
     "next^^" changes; should we follow the true parenthood, or the
     replaced one?

     In order to give Porcelains the same freedom to honor or ignore the
     replacements, we would eventually need to expose --ignore-replace
     option to "git rev-list":

	git rev-list --ignore-replace master..next^^

     It gets tricky when --ignore-replace should take effect.  Before or
     after master..next^^ is interpreted?

 (3) Depending on the use of replacements, even the type of the object an
     extended SHA-1 expression refers to can change.  tag-foo may point at
     an object 9856dd811ee0f256d067b89cbccb58d944aa9c8c, and without
     replacements it may be a commit but the replacement mechanism is
     allowed to say it is another tag that points at a commit.

Not that the "replacement" feature is bad, it is just that the feature is
too flexible for the current codebase to handle sanely.

In order to solve these issues safely (not necessarily efficiently nor
cleanly), I think we might need to change the setup_revisions() to:

 (1) operate the way it currently does, leaving the parsed objects in
     revs->pending;

 (2) remember the objects' SHA-1 and flags in the revs->pending array;

 (3) discard all parsed objects, as revision traversals may have rewritten
     commits for history simplification purposes; and

 (4) rebuild revs->pending list by parsing the objects again, using the
     SHA-1 values we remembered in step (2)

or something like that.
