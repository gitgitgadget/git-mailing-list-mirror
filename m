From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Thu, 05 Feb 2009 15:06:16 -0800
Message-ID: <7v63jobi1j.fsf@gitster.siamese.dyndns.org>
References: <200902021948.54700.jnareb@gmail.com>
 <20090202202424.GG14762@mit.edu> <200902040304.05028.jnareb@gmail.com>
 <20090204235436.GA8945@mit.edu> <7v4oz9lpes.fsf@gitster.siamese.dyndns.org>
 <20090205024333.GH8945@mit.edu> <7vmyd1ieo6.fsf@gitster.siamese.dyndns.org>
 <20090205132814.GK8945@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 06 00:07:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVDK9-0007va-Nn
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 00:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbZBEXGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 18:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbZBEXG3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 18:06:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbZBEXG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 18:06:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 35BFA97A9F;
	Thu,  5 Feb 2009 18:06:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E5F8897A9D; Thu,
  5 Feb 2009 18:06:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9C9A9DBA-F3D9-11DD-9419-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108632>

Theodore Tso <tytso@mit.edu> writes:

> The argument would be that for SCM that properly tracked user
> intentions, you did the wrong thing.  If the SCM properly understood
> directory renames, there is a big differene between this:
>
> 	scm mvdir db innodb
>
> and this
>
> 	scm mv db/* innodb
>
> You see?  The first moves the *directory* db to innodb.  The second

Then please s/scm mv/scm mvdir/ before reading my example.  The
hypothetical "scm mv" command in my example just knew it was fed an
directory and interpreted it as an intention to move the directory, not
all its contents.

> Of course, this distinction does not exist in git, because we track
> content only.  And a number of other SCM's like Hg, which only track
> file renames, wouldn't get this right either.  In order to get this
> right, you need to treat directory renames as separate and distinct
> operations from file renames, because they have different merge
> implications.
> ...
>> See how that argument is flawed?  The point of my example is that the line
>> between your example (1) and (2) in the previous message is blurry.
>
> It's blurry if you don't properly make the distinction between file
> and directory renames, yes.

My point was even if you (in the example, who said "I want to move db
directory to innodb directory") had two different operations, it is not
enough, because you cannot capture that "I want to move db directory to
innodb directory" was contingent on "because I know everything in my db
directory should belong to innodb -- in fact in my history of db/, there
is nothing but innodb support".  The other person you will eventually be
merging with may not share that precondition, as the project started out
to hold anything databasey in db/ and between the two branches being
merged, only you changed the semantics of what each directory means.

> However, your argument that it's not possible to determine whether the
> new file should appear as db/gdbm.c or innodb/gdm.c is an argument
> content-tracking alone isn't enough. 

Yes, but it is stronger than that. It is not just "content-tracking alone"
is not enough.  Even systems that have distinction between "scm mv" and
"scm mvdir" are not enough.  That is what I was trying to illustrate.

Your plug-in example differentiates two cases, one of which is that the
renaming branch would move the directory and the other is the branch moved
files under one directory to a new directory while keeping the original
directory, and two cases should produce different results.  If I
understand your argument correctly, it is that in the latter case the
outcome may be ambiguous, but in the former case, it is clear that the
intention of the remaning branch is to rename the directory itself and the
addition to the directory done in the other branch being merged should
automatically be done to the renamed directory while merging.  Most
importantly, the argument makes the assumption that the intention of the
non-renaming branch (iow, why he added the new files in the directory)
does not matter and does not affect the outcome.

The source tree restructuring example I brought in questions that
assumption.  It illustrates that the intention of the side that added the
new file matters.  Is it an innodb support enhancement?  Then it should
follow the renamer's intention to move rename db/ to innodb/.  Is it
adding something unrelated to the new meaning of "innodb" directory given
by the renaming side?  Then it is very likely that it should not go to the
renamed innodb/ directory, even though we may not be able to decide where
it *should* go automatically.  The point to consider is that recording the
renamer's intention to rename the directory and not just its contents is
not enough and does not help the merge.

> Personally, I think the scenario I used of renaming plugins is more
> likely that the sort of source reorganization which you've posited,
> but I agree they are both possible scenarios.  The question for git
> development is whether these sorts of issues ar ones that we should
> try to handle or not?

That entirely depends on your definition of "handle", I think.

I personally think that it is better for the tool to make its best effort
but stop and let the human inspect the result if the validitly of the
result is not so cut-and-dried, than blindly saying "the user said move
the directory, so I'll move the directory and move any and all new files
to it" and produce a potentially wrong result.  My comment in the previous
message about <db/gdbm.c> was not that it is 100% correct to leave it
there, nor it is 100% correct to move it elsewhere.  The point was it is a
case you cannot say what is correct even with help from "scm mvdir", and
the tool should stop and ask for confirmation.

Boasting that "unlike git that does not record renames, we correctly
resolve this case automatically, because our superiour design records the
user's intention to rename directory" is simply embarrassing yourself.
You may be silently producing a wrong result, which is nothing to boast
about.

I think it is Ok to assume that most of the time it is correct to move the
new file if the other branch "renamed" the directory in the situation the
example depicts, and I do not mind if the "best effort" the tool makes is
to move it to make it easy for the user to say "Yup, that is the right
outcome" and conclude the merge, but I think a tool is broken if it does
not give the user an opportunity to examine the situation and say "Oh, no,
that is not correct in *this* case" and fix it up.
