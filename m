From: Junio C Hamano <junkio@cox.net>
Subject: 50% speed-up of "git-apply && git-write-tree" sequence.
Date: Sun, 23 Apr 2006 22:41:43 -0700
Message-ID: <7vvesz8r8o.fsf@assigned-by-dhcp.cox.net>
References: <7v3bg3etnv.fsf@assigned-by-dhcp.cox.net>
	<7vodyrdas9.fsf@assigned-by-dhcp.cox.net>
	<7v8xpvd69s.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 07:42:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXtpk-00005W-OO
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 07:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWDXFls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 01:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWDXFlr
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 01:41:47 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:16085 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750797AbWDXFlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 01:41:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060424054146.SWUD24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Apr 2006 01:41:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19090>

I've fixed-up the series and they are now sitting near the tip
of "pu" branch tonight.  With some more testing I am hoping to
merge it in "next" soon.

I should recap the overall idea for general public here.

When applying a series of patches to your working tree and
making commits out of the results, what happens is roughly this:

 1. Your index file exactly matches your HEAD commit; you may
    have local modifications to some paths in your working tree
    as long as they do not interfere with the patch application.

 2. "git-apply --index" reads the index file, reads the patch,
    applies them to both index and the working tree, and writes
    the updated index file out.

 3. "git-write-tree" reads the index file, writes the index
    entries out as a set of hierarchical tree objects, the top
    of which is wrapped in a new commit object that has the
    current HEAD as the parent, and the commit becomes the new
    HEAD.

You repeat 1-3 as many times as you apply patches.

When dealing with a huge tree, with a typical patch touching
only a handful paths, this is not very efficient.  A recent
kernel source tree has about 1200 directories, each of which
needs to be made into the "tree" object format in-core from the
data in the index file, and we hash it to see if we already have
that tree, and if not we write it out after compression (if we
do have it, we do not do anything after checking).

The updated code does this:

 (1) When git-write-tree writes out trees from the index, we
     store <directory, tree SHA1> pair for all the trees we
     compute, in .git/index.aux file.

 (2) When git-write-tree starts up, it reads the index file, and
     also reads the .git/index.aux file.  The latter file
     contains a fingerprint of the former, so if the index was
     updated without updating the index.aux, what is read is
     discarded.  However, if .git/index.aux is up-to-date, what
     it records can be reused when we scan the index.

 (3) There are a few commands that updates the index file.
     git-update-index is the most well-known one, but read-tree
     and apply also update it.

     No command other than apply updates index.aux when writing
     out index (yet).  However, git-apply has been told about
     it.  It reads index and index.aux file, and when it updates
     an index entry, it _invalidates_ the directory information
     it read from index.aux file, and writes the updated
     index.aux file out when it is done.

     Note.  Earlier I sent out a fix ([PATCH 5/4]) that
     contained a two-line removal from apply.c; the code was
     doing more than just invalidating entries, but actually
     recomputing the tree.  The fixed code does not hash tree
     information when git-apply writes index out.

 (4) When git-write-tree starts up after git-apply finishes its
     job, it notices index.aux file matches the fingerprint of
     the index (so it is up-to-date) and some entries have been
     _invalidated_.  When it writes out the index, the parts of
     the directory hierarchy that have not been invalidated do
     not have to be formatted in-core into "tree" -- we already
     know what tree object they are.  Only the parts that were
     invalidated need to be computed.

For this, a new data structure "cache_tree" is introduced.  The
way to use the API is very simple.  You initialize it like this:

	struct cache_tree *active_cache_tree;
	unsigned char sha1[20];
	read_cache_1(sha1);
        active_cache_tree = read_cache_tree(sha1);
     
The new function read_cache_1() is similar to the traditional
read_cache(), but it gives back the index file fingerprint.
This is given to read_cache_tree() to make sure index.aux is not
stale.  Then, when you touch a path in the cache, you invalidate
the paths in the cache_tree with:

	cache_tree_invalidate_path(active_cache_tree, path);

For example, if you are updating an index entry
"fs/ext3/inode.c", it invalidates the cached tree SHA1
information for top-level tree, "fs" tree and "fs/ext3" tree.
All other information you read from index.aux are still valid
(IOW, three out of 1200 are invalidated).

When you are done, you write out the index file and the updated
index.aux file like this:

        if (write_cache_1(newfd, active_cache, active_nr, active_cache_sha1) ||
            commit_index_file(&cache_file))
                die("Unable to write new cachefile");
        write_cache_tree(active_cache_sha1, active_cache_tree);

Again, write_cache_1() has one extra parameter to receive the
updated index file fingerprint, and you call write_cache_tree()
with it.  It updates index.aux file (with invalidated entries).

One thing write-tree does different is this (note that it does
not update the index file, it just reads from it):

	if (cache_tree_update(active_cache_tree, active_cache, active_nr,
			      missing_ok))
		die("git-write-tree: error building trees");
	write_cache_tree(active_cache_sha1, active_cache_tree);

The call to cache_tree_update() takes the (possibly partially
invalidated) cache_tree, fills in the invalidated parts from the
index file (this involves creation of new "tree" objects as
needed).  So the above call to write_cache_tree() writes a
complete index.aux file out without any invalidated entries.

Obviously, the change similar to what I did to apply.c in this
series can be done to other index-updating commands.  That's
"low hanging fruit" for the week ;-).
