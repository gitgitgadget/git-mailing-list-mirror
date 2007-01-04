From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Thu, 04 Jan 2007 12:22:01 -0800
Message-ID: <7v8xgileza.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	<Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 04 21:22:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2Z6M-0002vh-TF
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 21:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbXADUWF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 15:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbXADUWF
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 15:22:05 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:53257 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965066AbXADUWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 15:22:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070104202202.HSXK3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Thu, 4 Jan 2007 15:22:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 78NG1W00N1kojtg0000000; Thu, 04 Jan 2007 15:22:17 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35951>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Me too, just wondered why didn't we do this back then.
> Anyway, my "monster-merge" and the builtin tests pass with
> no visible problems.
>
>> However, I was wondering if the index has to be written at all.
>> I expect the written index (except the last one, of course) to have no
>> user...
>
> Good question...

That's most likely because you played safe, and started from the
Python version whose only way to manipulate the index and write
out a tree was to actually write the index out.

So let's step back a bit.

 * The top-level interface is merge() function that takes two
   heads and the ancestor, and is responsible for coming up with
   a merged tree in *result if it can.  The main() calls it to
   see if things merge cleanly, and wants the index populated
   with the final merge result, be it clean or unmerged.

 * merge() in addition to two heads and their ancestor takes
   call-depth because it does the "recursive" business.  When it
   operates with positive call-depth, it is coming up with a
   virtual commit that has the merge result tree of two merge
   bases.  In this case index_only is set to true and what is in
   the working tree does not matter (i.e. usual "your local
   modification will be clobbered, cannot merge" check should
   not apply [*1*]).  It calls setup_index() to read in the true
   index (for the outermost case) or a temporary index (from one
   of the ancestor trees in the recursive case) before passing
   control to the real workhorse, merge_trees().

   What merge() does before its call to setup_index() does not
   depend on what the index is (even in recursive case, because
   the real work done by merge_trees() in the recursively called
   merge() is preceded by the call to setup_index()).  When
   merge() returns, the index contents, both in-core and on the
   filesystem, matter only for the outermost call to merge().

   So that suggests that flush_cache() in main() needs to stay.

 * merge_trees() takes the two heads and the ancestor, and comes
   up with the merge result, using in-core index.  It calls
   git_merge_trees() which is 3-way "read-tree -m", and calls
   git_write_tree() with two purposes: (1) to see if the merge
   was cleanly done, and (2) to get the tree to be used as the
   virtual ancestor (in other words, for the outermost merge,
   writing of the tree is not important -- a tree is produced as
   an unused side effect of seeing if the merge was clean).  If
   it results in a clean merge for the outermost merge, the call
   to flush_cache() in main() is what matters -- the calling
   script of merge-recursive writes a tree out from the index
   written by that call.  I'll address the need for
   git_write_tree() to write the index shortly.

   If the call to git_merge_trees() results in conflicted merge,
   merge_trees() falls into the rename detection codepath.  Most
   of the work is done in process_renames(), which updates the
   index, and then remaining unmatched paths are dealt with by
   calling process_entry(), which also updates the index.  These
   index updates could all be done in-core without writing the
   resulting index file out; we should not discard nor re-read
   the index while they are processing one path at a time.

   In a sense, merge_trees() does what 3-way "read-tree -m"
   could have done if it were rename aware.

 * git_merge_trees() is a bit questionable.  It reads from the
   current_index_file which is the true index for the outermost
   merge or the temporary index populated from the 'head'
   parameter give to it earlier by merge().  I think this use of
   temporary index is not necessary.  In other words, we could
   start from an empty cache if index_only, I think.

   And I think the reason git_write_tree() writes the index out
   is because of this call to read_cache_from() at the beginning
   of git_merge_trees().  It is told to write a tree out of the
   current in-core index -- so I do not know why it needs to
   call read_cache_from() to begin with.

Given the above analysis, it seems to me that the current code
too heavily inherited the invariant that the in-core and on
filesystem index should match at every step from the original
Python version.  I think your patch goes in the right direction
to correct that, but it does not spell out the new invariant the
code assumes cleanly enough.  For example, I do not think you
would want the call to flush_cache() in process_renames() for
the same reason you took out the call from process_entry() --
they both make many calls to update_file() and remove_file() to
touch the index and the working tree.

How about making the invariants to be:

	upon entry of merge(), the in-core cache is populated as
	appropriate for the merge.  That is, it has the contents
	of the true index for the outermost one, and discarded
	for the virtual ancestor merge.

	upon exit from merge(), the in-core cache holds the
	merge result for that round of merge.  That is, it is
	suitable for flush_cache() to leave the final result for
	the outermost merge, and it is a merged index that wrote
	the virtual ancestor tree was written out from for inner
	merges.

The codeflow would then become like this:

	main() {
                hold_lock_file_for_update(lock, git_path("index"), 1);
                merge();
		write_cache() || close || commit_lock_file();
	}

	merge() {
        	while (more than one ancestor) {
			discard_cache();
                        merge(two ancestors using their common);
		}
		discard_cache();
		if (call_depth == 0) {
                	read_cache();
                        index_only = 0;
		}
		else
                	index_only = 1;
                merge_trees();
	}

        merge_trees() {
		if (up to date)
                	return;
		git_merge_trees();
		if (in-core index is unmerged) {
			process_renames();
		}
                if (index_only)
                       	git_write_tree();
        }

        git_merge_trees() {
        	unpack_trees();
        }

        git_write_tree() {
		if (stale cache tree)
                	cache_tree_update();
                lookup_tree();
	}

        process_renames(), process_entry() {
		call remove_file() and update_file() as needed,
		trusting that the caller set up the in-core
                index as appropriate and previous calls to these
                functions left the in-core index to correctly
                reflect what have been done so far.
        }

By the way, Alex, you seem to heavily work on Cygwin, and I am
interested in your experience with Shawn's sliding mmap() on
real projects, as I suspect Cygwin would be more heavily
impacted with any mmap() related changes.  You already said
performance is "bearable".  Does that mean it was better and
got worse but still bearable, or it was unusably slow but now it
is bearably usable?
