From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 11:24:24 -0800
Message-ID: <7v3a3h48lz.fsf@alter.siamese.dyndns.org>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com>
 <200912111220.40844.jnareb@gmail.com> <4B223C1E.6010403@drmicha.warpmail.net>
 <200912111500.51982.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 20:24:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJB6a-0006Gb-Co
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 20:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761062AbZLKTYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 14:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761048AbZLKTYc
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 14:24:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761018AbZLKTYb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 14:24:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8894C877F6;
	Fri, 11 Dec 2009 14:24:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bMzC2eF9EyVLEHaOe4OADS7Rpr0=; b=gBuIBJ
	mt++7S9DZY7YFxYmj/Krfu0WW+INDiv6S1239l/wwl3IUyNQgsL/448AsasnF6up
	SjQnoHsi9SCnENzZ/fieEjFNBZn37U6kr+5wn098vj1mJC9XU85csD/I5u7bzlxa
	/KaxP54xXILrcqCq9OIVWUMZb6jiicnw4vyxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YbA/9of3vYFrsW9i2yOqBYLSahQwPcu8
	lVv8ISiQTfr9gcVrmBmMkTFhLeeCnPXT8yEDCsN4zNethXgVtitXjaikq0XnPJhE
	GVSvKmefCq5xKmFn/UJdeaZvUteoYrI0bH5OXhfYmONSJ0KOPZC0XzYXfUl3gyn7
	FNFs5m5C580=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34F51877F3;
	Fri, 11 Dec 2009 14:24:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E419877EF; Fri, 11 Dec
 2009 14:24:25 -0500 (EST)
In-Reply-To: <200912111500.51982.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri\, 11 Dec 2009 15\:00\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF150434-E68A-11DE-B058-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135101>

Jakub Narebski <jnareb@gmail.com> writes:

> I have thought that if there exist stage #0 in index, git simply _ignores_
> higher stages, so git-add simply adds stage #0 and does not delete higher
> stages.

Then you thought wrong ;-).

Leaving resolved cruft in the main index (aka active_cache[]) will make
all the normal operation codepath unnecessarily complex.  They rely on "if
I see stage #0, there is no higher stages for the same path".  And extra
checks will slow things down.

But that does not necessarily mean the index is a wrong place to save away
pre-resolution information on resolved paths (read on).

Before suggesting a possible next move, there are a few things we should
notice while reading ec16779 (Add git-unresolve <paths>..., 2006-04-19):

 - This was done about only one year after git was born.  You should not
   take it granted that the workflow it wanted to support makes sense.

   Considering that using "git add" to mark the resolution is to declare
   that you are _finished_ with that path, using it for other purposes
   (e.g. leaving a note that says "I've looked at and have one possible
   resolution in the file in the work tree, but I haven't verified the
   result yet", which is what the commit talks about) is simply an
   (ab|mis)use of the index.  Lossage of higher stage information by this
   misuse is user's problem, and there is this thing called pen & pencil
   the user can use for taking notes if s/he does not want to lose the
   original conflict information from the index.

 - Even if we for a moment consider that the workflow made some sense, the
   particular implementation is not suitable anymore for today's git.

   Again, this was done only one year after git was born, and back then
   "pull/merge" were the only things that left conflicts in every day
   operations by end users, and not many people didn't expect git to merge
   across renames.  It was sufficient to read the path the end user asked
   for from HEAD and MERGE_HEAD and pretend we "unresolved" in such a
   simpler world.

   But "merge" is not the primary thing that gives you conflicts anymore.
   "rebase", "cherry-pick", "stash apply" are much more widely used by
   ordinary users these days than back then, and reading from MERGE_HEAD
   wouldn't do any good for recreating what these operations did.  Even
   with "merge", stages #2 and #3 can come from a totally different path
   when using recursive and subtree strategies, so reading from
   HEAD/MERGE_HEAD is not as useful as it used to be.

In fact, considering that there are many ways conflicts can be left in the
index and there are only two ways that they are resolved in the index by
the user (and both eventually uses a single function to do so), it would
make perfect sense to do the following:

 - Define a new index extension section to record "unresolve"
   information.

 - Every time add_index_entry_with_check() in read-cache.c records a stage
   0 entry while dropping higher stage entries for the same path, record
   these higher stage entries to the "unresolve" section.

 - An "update-index --unresolve" will use the information from this
   "unresolve" extension to recreate the unmerged state.

 - "rerere forget" that we earlier talked about in a separate thread will
   use exactly the same mechanism to get back the unmerged state to
   recompute the conflict identifier (this is why J6t is addded to the Cc:
   list).

 - "checkout --conflict" _might_ want to also consider unresolving the
   path first using this information, if it finds the path user asked to
   re-checkout with conflict markers has already been resolved.

It is important to think through to decide when we purge the "unresolve"
section.

If you run "read-tree", "checkout" to switch branches, or "reset" (any
option other than "--soft" which does not even touch the index), it is a
good sign that the information in the "unresolve" extension section is no
longer needed, so you can drop the section in these operations.

Optionally, write_index() could notice if there is no unmerged entries and
the cache_tree is fully valid---that is an indication that a tree object
has been written out of the now resolved index, and may (or may not) imply
that the "unresolve" information is no longer needed.  But I haven't
thought this last one through.  You could wish to unresolve even after you
committed your merge (you _could_ wish for anything after all), but I do
not yet know if granting that wish makes much sense.

There may be other cases we _must_ drop "unresolve".
