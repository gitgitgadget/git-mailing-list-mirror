From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Empty directories...
Date: Tue, 17 Jul 2007 23:53:25 -0700
Message-ID: <7vhco28aoq.fsf@assigned-by-dhcp.cox.net>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<7v8x9ea1rg.fsf@assigned-by-dhcp.cox.net>
	<85d4yqz24s.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 08:53:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB3Pg-0007dm-H8
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 08:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbXGRGx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 02:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbXGRGx1
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 02:53:27 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:40950 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbXGRGx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 02:53:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070718065326.OQXM1349.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Jul 2007 02:53:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QutR1X0051kojtg0000000; Wed, 18 Jul 2007 02:53:25 -0400
In-Reply-To: <85d4yqz24s.fsf@lola.goethe.zz> (David Kastrup's message of "Wed,
	18 Jul 2007 07:56:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52834>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> No objections as long as a patch is cleanly made without
>> regression.  It's just nobody agreed that it is "quite serious"
>> yet so far, and no fundamental reason against it.
>
> Thanks.  It certainly is not serious for the Linux kernel source, but
> seems awkward for quite a few situations.  Anyway, what is your take
> on the situation I described?

Didn't I say I do not have an objection for somebody who wants
to track empty directories, already?  I probably would not do
that myself but I do not see a reason to forbid it, either.

The right approach to take probably would be to allow entries of
mode 040000 in the index.  Traditionally, we allowed only 100644
(blobs as regular files) and 120000 (blobs as symlinks).  We
recently added 160000 (commit from outer space, aka subproject).

And we do that for all directories, not just empty ones.  So if
you have fileA, empty/, sub/fileB tracked, your index would
probably have these four entries, immediately after read-tree
of an existing tree object:

	100644 15db6f1f27ef7a... 0	fileA
	040000 4b825dc642cb6e... 0	empty
	040000 e125e11d3b63e3... 0	sub
	100644 52054201c2a872... 0	sub/fileB

Making sure that empty/ directory exists in the working tree is
probably done in entry.c; we have been touching that area in an
unrelated thread in the past few days.

If you add sub/fileC, with "update-index" (and "add"), you
invalidate the SHA-1 object name you stored for "sub" (because
there is no point recomputing the tree object until you know you
need a subtree for "sub" part, which does not happen until the
next "write-tree"), and end up with something like:

	100644 15db6f1f27ef7a... 0	fileA
	040000 4b825dc642cb6e... 0	empty
	040000 00000000000000... 0	sub
	100644 52054201c2a872... 0	sub/fileB
	100644 705bf16c546f32... 0	sub/fileC

These "missing" SHA-1 would need to be recomputed on-demand.

We have had necessary infrastructure to do this "keeping
untouched tree object names in the index" for quite some time,
but it is not a part of the index proper (it is stored in an
extension section in the index file, to keep the index
compatible with older versions of git).

Having made it sound so easy, here are the issues I would expect
to be nontrivial (but probably not rocket surgery either).

 * unpack-trees, which is the workhorse for twoway merge (aka
   "switching branches") and threeway merge, has a convoluted
   logic to avoid D/F conflicts; it can probably be cleaned up
   once we do the above conversion so that the index starts
   saying "Hey, I have a directory here" more explicitly.  The
   end result would probably be a code easier to follow.

 * status, update-index --refresh, and diff-files cares about
   the information cached in the index from the last time
   lstat(2) is run on each entry.  What we should store there
   for "tree" entries is very unclear to me, but probably we
   should teach them to ignore the stat-matching logic for
   these entries.

 * diff-index walks the index and a tree in parallel but does
   not currently expect to see a tree object in the index.  It
   needs to be taught to ignore these "tree" entries.

 * merge-recursive and merge-index walk the index, coming up
   with the merge results one path at a time.  They also need to
   be taught to ignore these "tree" entries.

 * diff-index and "read-tree -m" should be taught to take
   advantage of the "tree" entries in the index.  For example,
   if diff-index finds the "tree" entry in the index and the
   subtree found from the tree object exactly match, it does not
   even have to descend into the tree, which would be a huge
   performance win (because you do not have to open the subtree
   and its subtrees from the tree side; you already have read
   everything on the index side, and still have to skip the
   entries in the directory).  "read-tree -m" also should be
   able to optimize two identical subtrees in the 2 or 3 trees
   involved.

   Even if we follow the "lazy invalidate" strategy to maintain
   the "tree" entries in the normal codepath, we could have a
   special operation that says "now update all the tree entries
   by recomputing the tree object names as needed".  Perhaps we
   might want to initiate such an operation before "read-tree
   -m" automatically.
