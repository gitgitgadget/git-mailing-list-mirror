From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [RFC/PATCH v2] merge-base: teach "git merge-base" to accept more
 than 2 arguments
Date: Sun, 27 Jul 2008 13:47:22 -0700
Message-ID: <7vk5f7yrz9.fsf_-_@gitster.siamese.dyndns.org>
References: <20080727053324.b54fe48e.chriscool@tuxfamily.org>
 <alpine.DEB.1.00.0807271631470.5526@eeepc-johanness>
 <7vljzn2o51.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 27 22:48:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNDAR-0004LJ-FC
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 22:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757724AbYG0Ure (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 16:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757727AbYG0Ure
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 16:47:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757693AbYG0Urd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 16:47:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 317C53EC4E;
	Sun, 27 Jul 2008 16:47:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 299E23EC4D; Sun, 27 Jul 2008 16:47:25 -0400 (EDT)
In-Reply-To: <7vljzn2o51.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 27 Jul 2008 11:11:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3AD621B6-5C1D-11DD-B139-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90369>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> BTW I seem to recall that get_merge_bases_many() was _not_ the same as 
>> get_merge_octopus().  Could you please remind me what _many() does?
>
> I explained what merge-bases-many gives in a separate message last night
> with pictures.
>
> get_merge_octopus() is a more or less useless function.  It is there only
> because the protocol between "merge" and strategies requires that the
> former have to pass _some_ bases to the latter.  In fact, the octopus
> strategy implementation completely ignores the heads given by "merge";
> a single set of merge base given from outside is not even useful when you
> build octopus by repeatedly running pairwise three-way merges.

This part may benefit from a bit of clarification, so I'll borrow the
picture from my other message.

               o---o---o---o---C
              /
             /   o---o---o---B
            /   /
        ---1---2---o---o---o---A

Suppose you have this topology, and you are trying to make an octopus
across A, B and C (you are at C and merging A and B into your branch).
The protoccol between "git merge" and merge strategies is for the former
to pass common ancestor(s), '--' and then commits being merged.

I think "merge", both in scripted version and Miklos's C version, gives
"1" because that is the common across all the heads.  This choice of merge
base in itself is correct (that is why I said that git_merge_octopus() is
"more or less useless", not "totally pointless").  If an implementation of
strategy that is capable of producing an octopus wanted to merge arbitrary
number of trees using a single merge base in one-go, that is the merge
base it would want to use.

HOWEVER.

The particular implementation of git-merge-octopus does not produce the
final merge in one-go.  It iteratively produces pairwise merges.  So the
first step might be to come up with a merge between B and C:

               o---o---o---o---C
              /                 :
             /   o---o---o---B..(M)
            /   /
        ---1---2---o---o---o---A

and for that, "1" is used as the merge base, not because it is the base
across A, B and C but because it is the base between B and C.  For this
merge, A does not matter.

I drew M in parentheses and lines between B and C to it in dotted line
because we actually do _not_ create a real commit --- the only thing we
need is a tree object, in order to proceed to the next step.

Then the final merge result is obtained by merging tree of (M) and A using
their common ancestor.  For that, we _could_ still use "1" as the merge
base.

But if you imagine a case where you started from A and M, you would _not_
pick "1" as the merge base; you would rather use "2" which is a better
base for this merge.

That is why git-merge-octopus ignores the merge base given by "merge" but
computes its own.

        Side note.  If your first step merge is between A and B, then you
        would also use "2" as the merge base.

                   o---o---o---o---C
                  /
                 /   o---o---o---B..(M)
                /   /               : 
            ---1---2---o---o---o---A

The comment at the end of git-merge-octopus talks about "merge reference
commit", that we used to update it to common found in this round, and that
that updating was pointless.  After the first round of merge to produce
the tree for M (but without actually creating the commit object M itself),
in order to figure out the merge base used to merge that with A in the
second round, we used to use A and "1" (which was merge base between B and
C).  That was pointless --- "merge-base A 1" is guaranteed to give a base
that is no better than either "merge-base A B" or "merge-base A C".  So
the current code keeps using the original head (iow, MRC=Ci, because n
this case we are starting from C and merging B and then A into it).

This trickerly was necessary only because we avoided creating the extra
merge commit object M.

	Side note.  An alternative implementation could have been to
	actually record it as a real merge commit M, and then let the
	two-commit merge-base compute the base between A and M when
	merging A to the result of the previous round, but we avoided
	creating M, at the expense of potentially using suboptimal base in
	the later rounds.

But we do not have to be that pessimistic.  We can instead accumulate the
commits we have merged so far in MRC, and have merge_bases_many() compute
the merge base for the new head being merged and the heads we have
processed so far, which can give a better base than what we currently do.

That is what Christian's patch enables us to do.

In other words, we can do something like this.

 git-merge-octopus.sh |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 645e114..1dadbb4 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -61,7 +61,7 @@ do
 		exit 2
 	esac
 
-	common=$(git merge-base --all $MRC $SHA1) ||
+	common=$(git merge-base --all $SHA1 $MRC) ||
 		die "Unable to find common commit with $SHA1"
 
 	case "$LF$common$LF" in
@@ -100,14 +100,7 @@ do
 		next=$(git write-tree 2>/dev/null)
 	fi
 
-	# We have merged the other branch successfully.  Ideally
-	# we could implement OR'ed heads in merge-base, and keep
-	# a list of commits we have merged so far in MRC to feed
-	# them to merge-base, but we approximate it by keep using
-	# the current MRC.  We used to update it to $common, which
-	# was incorrectly doing AND'ed merge-base here, which was
-	# unneeded.
-
+	MRC="$MRC $SHA1"
 	MRT=$next
 done
 
