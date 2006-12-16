X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Subprojects tasks
Date: Sat, 16 Dec 2006 10:32:36 -0800
Message-ID: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 18:32:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34631>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GveKu-0007bc-Rh for gcvg-git@gmane.org; Sat, 16 Dec
 2006 19:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753765AbWLPSci (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 13:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbWLPSci
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 13:32:38 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34657 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751755AbWLPSch (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 13:32:37 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216183237.XBPB20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 13:32:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zWYo1V00R1kojtg0000000; Sat, 16 Dec 2006
 13:32:49 -0500
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Because I am primarily a plumber, I was thinking about the
changes that need to be done at the plumbing level.  I only
looked at the prototype when it was announced, and I do not know
the progress you made since then.  Could you tell us the current
status?

I am assuming that the overall design is based on what Linus
proposed long time ago with his "gitlink" object.  That is,

 * the index and the tree object for the superproject has a
   "link" object that tells there is a directory and the
   corresponding commit object name from the subproject.  Unlike
   my previous "bind commit" based prototype, index does not
   have any blobs nor trees from the subproject.

 * the subproject is on its own, and can exist unaware of the
   existence of its superproject (there is no back-link at the
   object layer).

 * the subproject and the superproject are loosely coupled.  An
   act of committing in one does not automatically make a
   corresponding commit in the other at the plumbing level.

For now, I assume that the representation of the "link" object
is (after the usual object header) 40-byte hexadecimal SHA-1 of
the commit object, plus a LF, but that is a minor detail.

At the object layer, obviously you would need a new object type
allocated, "link", and the mode-bits assigned in the tree
object.  You should be able to cover cat-file, fsck-objects
(connectivity through link->commit), pack-objects and
unpack-objects (they need to know about the new object type) at
that stage.

With the index, in addition to the mode bits and "link" object's
SHA-1, you would need to decide what to do with ce_match_stat(),
to keep track of the information "update-index --refresh" updates.
My recommendation is to:

 (1) Look at the directory the "link" is at, and find .git/
     subdirectory (that is the $GIT_DIR for the subproject) and
     its .git/HEAD;

 (2) If that points at a loose ref, use the file's stat()
     information (e.g stat("$sub/.git/refs/heads/master"));

 (3) Otherwise, use the packed-ref file's stat() information
     (e.g stat("$sub/.git/packed-refs")).

Then ce_match_stat() for a "link" entry can do the same
computation and tell if the subproject has changed its HEAD.

I think "update-index --add $directory" should check if .git/
exists and looks like a valid repository, and make a "link"
object out of "$directory/.git/HEAD".

Another issue with the index is what to put in the cache_tree
structure; I think "link" can be treated just like blob (both
files and symlinks).

Then read-tree (bulk of it is in unpack-trees.c) needs to be
taught to read in "link" and put that into the index -- this
should be straightforward.

After you have a working index, you should be able to do
write-tree (writes the new "link" entry as is, without
descending into the subproject) trivially.

It is debatable what 'checkout-index -f' should do when the
subproject is already checked out and its HEAD points at a
different commit.  I am tempted to say that it should go there
and run "reset --hard", but I feel uneasy about that because it
is a blatant layering violation.  Maybe it should simply ignore
link entries and let the Porcelain layer take care of them.

Then there are three diff- brothers at the plumbing level.  I
think it is reasonable not to make them recurse into "link",
even with the presense of -r (recursive) option (Porcelain "git
diff" might want to recurse into the subproject, perhaps with a
new --recurse-harder option, though).

That means diff-files either skips a "link" entry if
ce_match_stat() says it is clean, or feeds "link" and its
recorded SHA-1 from the index on the left hand side, and 0{40}
on the right hand side with "link" type (after verifying that
"$sub/.git" is still there -- otherwise you would say that the
working tree has lost that subproject).  "Read from the working
tree" done for diff-files for a "link" object would grab the
commit SHA-1 from the tip of the current branch of the
subproject, format it as the value of a "link" object (I am
assuming just a 40-byte commit SHA-1, plus a LF) and would
compare that with the result of read_sha1_file() on the link
object recorded in the index when producing -p (patch) output.

diff-tree would compare "link" entries without descending into
them.  "link" and "blob" would compare just like "symlink" and
"blob" would compare.

diff-index with --cached would work like diff-tree (two concrete
SHA-1), and without --cached would work like diff-files (one
SHA-1 from the tree, another is either from the index if
ce_match_stat() says it is clean, 0{40} otherwise).

I suspect the hardest part is "rev-list --objects" (now most of
it is found in revision.c).  Theoretically, if the code can
handle "tag"s, it should be able to handle "link"s, but I have a
feeling that the ancestry traversal code that walks commits is
not prepared to see "commit" object to appear from somewhere in
the middle of traversal.  A commit so far can be wrapped only by
tags zero or more times, and a tag never appears inside anything
but another tag, so the code can just keep peeling the tag until
it sees a non-tag and after that it will be living in the world
that has only commit->tree->blob hierarchy, and can afford to do
the ancestry based solely on "commit" and can treat reachability
for "tree" and "blob" as afterthought.  But I think the updated
code needs to know that "link" needs to be unwrapped and
contained "commit" needs to be injected back to the ancestry
walking machinery.

Once you have "rev-list --objects", you should be able to drive
pack-objects with its output.  I do not think there is much to
change in that program.

My gut feeling is that it would take about 2-3 weeks for a
competent plumber working on full time to make the above changes
to the plumbing side into presentable shape.

On the Porcelain side, you would need policy design, some of
which were discussed on the list, such as what committing and
fetching in a superproject mean and should do.  I do not have a
guestimate of the amount of work that would involve.
