From: David Greaves <david@dgreaves.com>
Subject: [PATCH] More docs
Date: Fri, 22 Apr 2005 20:50:20 +0100
Message-ID: <4269557C.1050606@dgreaves.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020605060200000407060401"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 21:48:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP47B-00036W-RG
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 21:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVDVTvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 15:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVDVTvg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 15:51:36 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:1686 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262119AbVDVTu0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 15:50:26 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id C01A4E6D65; Fri, 22 Apr 2005 20:48:27 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 16764-11; Fri, 22 Apr 2005 20:48:27 +0100 (BST)
Received: from oak.dgreaves.com (modem-263.lemur.dialup.pol.co.uk [217.135.129.7])
	by mail.ukfsn.org (Postfix) with ESMTP
	id A217AE6A86; Fri, 22 Apr 2005 20:48:23 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DP4AO-0004SN-Mn; Fri, 22 Apr 2005 20:50:20 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------020605060200000407060401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Removed Cogito stuff

Updated:
  checkout-cache
  commit-tree
  diff-cache
  diff-tree
  fsck-cache
  git-export
  init-db
  read-tree
  show-files
  update-cache
  write-tree

Thanks also to Junio C Hamano <junio@siamese.dyndns.org>
More eyes please :)

There are ???s where I'd _especially_ appreciate comments

Also note that much of this is simply edited emails from the list or 
comments cross checked with the source.


Signed-off-by: David Greaves <david@dgreaves.com>
---





--------------020605060200000407060401
Content-Type: text/plain;
 name="README.reference.patch3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.reference.patch3"

Index: README.reference
===================================================================
--- 5f61aecb06c2f2579bbb5951b1b53e0dedc434eb/README.reference  (mode:100644 sha1:8186a561108d3c62625614272bd5e2f7d5826b4b)
+++ bc80a76ad52f0cdf28c4e10a2490da3558f5def6/README.reference  (mode:100644 sha1:810f4990448fbee57490a945d03a5e8a3eaadec0)
@@ -53,7 +53,7 @@
 
 ################################################################
 checkout-cache
-	checkout-cache [-q] [-a] [-f] [--] <file>...
+	checkout-cache [-q] [-a] [-f] [--prefix=<string>] [--] <file>...
 
 Will copy all files listed from the cache to the working directory
 (not overwriting existing files). Note that the file contents are
@@ -69,6 +69,13 @@
 	checks out all files in the cache before processing listed
 	files.
 
+--prefix=<string>
+	When creating files, prepend this <string> (usually a
+	directory including a trailing /)
+
+--
+	Do not interpret any more arguments as options.
+
 Note that the order of the flags matters:
 
 	checkout-cache -a -f file.c
@@ -96,6 +103,22 @@
 problems (not possible in the above example, but get used to it in
 scripting!).
 
+The prefix ability basically makes it trivial to use checkout-cache as
+a "export as tree" function. Just read the desired tree into the
+index, and do a
+  
+        checkout-cache --prefix=export-dir/ -a
+  
+and checkout-cache will "export" the cache into the specified
+directory.
+  
+NOTE! The final "/" is important. The exported name is literally just
+prefixed with the specified string, so you can also do something like
+  
+        checkout-cache --prefix=.merged- Makefile
+  
+to check out the currently cached copy of "Makefile" into the file
+".merged-Makefile".
 
 ################################################################
 commit-id
@@ -109,12 +132,340 @@
 
 ################################################################
 commit-tree
-	commit-tree <sha1> [-p <sha1>]* < changelog
+	commit-tree <sha1> [-p <parent sha1>]* < changelog
+
+Creates a new commit object based on the provided tree object and
+emits the new commit object id on stdout. If no parent is given then
+it is considered to be an initial tree.
+
+A commit object usually has 1 parent (a commit after a change) or up
+to 16 parents.  More than one parent represents merge of branches that
+led to them.
+
+While a tree represents a particular directory state of a working
+directory, a commit represents that state in "time", and explains how
+to get there.
+
+Normally a commit would identify a new "HEAD" state, and while git
+doesn't care where you save the note about that state, in practice we
+tend to just write the result to the file ".git/HEAD", so that we can
+always see what the last committed state was.
+
+Options
+
+<sha1>
+	An existing tree object
+
+-p <parent sha1>
+	Each -p indicates a the id of a parent commit object.
+	
+
+Commit Information
+
+A commit encapsulates:
+	all parent object ids
+	author name, email and date
+	committer name and email and the commit time.
+
+If not provided, commit-tree uses your name, hostname and domain to
+provide author and committer info. This can be overridden using the
+following environment variables.
+	AUTHOR_NAME
+	AUTHOR_EMAIL
+	AUTHOR_DATE
+	COMMIT_AUTHOR_NAME
+	COMMIT_AUTHOR_EMAIL
+(nb <,> and '\n's are stripped)
+
+A commit comment is read from stdin (max 999 chars)
+
+see also: write-tree
 
 
 ################################################################
+diff-cache
+	diff-cache [-r] [-z] [--cached] <tree/commit sha1>
+
+Compares the content and mode of the blobs found via a tree object
+with the content of the current cache and, optionally ignoring the
+stat state of the file on disk.
+
+(This is basically a special case of diff-tree that works with the
+current cache as the first tree.)
+
+<tree sha1>
+	The id of a tree or commit object to diff against.
+
+-r
+	recurse
+
+-z
+	/0 line termination on output
+
+--cached
+	do not consider the on-disk file at all
+
+Output format:
+
+For files in the tree but not in the cache
+-<mode>\t <type>\t	<sha1>\t	<path><filename>
+
+For files in the cache but not in the tree
++<mode>\t <type>\t	<sha1>\t	<path><filename>
+
+For files that differ:
+*<tree-mode>-><cache-mode>\t <type>\t	<tree sha1>-><cache sha1>\t	<path><filename>
+
+In the special case of the file being changed on disk and out of sync
+with the cache, the sha1 is all 0's.  Example:
+
+	*100644->100660 blob    5be4a414b32cf4204f889469942986d3d783da84->0000000000000000000000000000000000000000      file.c
+	
+
+Operating Modes
+You can choose whether you want to trust the index file entirely
+(using the "--cached" flag) or ask the diff logic to show any files
+that don't match the stat state as being "tentatively changed".  Both
+of these operations are very useful indeed.
+
+Cached Mode
+If --cached is specified, it allows you to ask:
+	show me the differences between HEAD and the current index
+	contents (the ones I'd write with a "write-tree")
+
+For example, let's say that you have worked on your index file, and are
+ready to commit. You want to see eactly _what_ you are going to commit is
+without having to write a new tree object and compare it that way, and to
+do that, you just do
+
+	diff-cache --cached $(cat .git/HEAD)
+
+Example: let's say I had renamed "commit.c" to "git-commit.c", and I had 
+done an "upate-cache" to make that effective in the index file. 
+"show-diff" wouldn't show anything at all, since the index file matches 
+my working directory. But doing a diff-cache does:
+	torvalds@ppc970:~/git> diff-cache --cached $(cat .git/HEAD)
+	-100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        commit.c
+	+100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        git-commit.c
+
+And as you can see, the output matches "diff-tree -r" output (we
+always do "-r", since the index is always fully populated
+??CHECK??).
+You can trivially see that the above is a rename.
+
+In fact, "diff-tree --cached" _should_ always be entirely equivalent to
+actually doing a "write-tree" and comparing that. Except this one is much
+nicer for the case where you just want to check where you are.
+
+So doing a "diff-cache --cached" is basically very useful when you are 
+asking yourself "what have I already marked for being committed, and 
+what's the difference to a previous tree".
+
+Non-cached Mode
+
+The "non-cached" mode takes a different approach, and is potentially
+the even more useful of the two in that what it does can't be emulated
+with a "write-tree + diff-tree". Thus that's the default mode.  The
+non-cached version asks the question
+
+   "show me the differences between HEAD and the currently checked out 
+    tree - index contents _and_ files that aren't up-to-date"
+
+which is obviously a very useful question too, since that tells you what
+you _could_ commit. Again, the output matches the "diff-tree -r" output to
+a tee, but with a twist.
+
+The twist is that if some file doesn't match the cache, we don't have a
+backing store thing for it, and we use the magic "all-zero" sha1 to show
+that. So let's say that you have edited "kernel/sched.c", but have not
+actually done an update-cache on it yet - there is no "object" associated
+with the new state, and you get:
+
+	torvalds@ppc970:~/v2.6/linux> diff-cache $(cat .git/HEAD )
+	*100644->100664 blob    7476bbcfe5ef5a1dd87d745f298b831143e4d77e->0000000000000000000000000000000000000000      kernel/sched.c
+
+ie it shows that the tree has changed, and that "kernel/sched.c" has is
+not up-to-date and may contain new stuff. The all-zero sha1 means that to
+get the real diff, you need to look at the object in the working directory
+directly rather than do an object-to-object diff.
+
+NOTE! As with other commands of this type, "diff-cache" does not actually 
+look at the contents of the file at all. So maybe "kernel/sched.c" hasn't 
+actually changed, and it's just that you touched it. In either case, it's 
+a note that you need to upate-cache it to make the cache be in sync.
+
+NOTE 2! You can have a mixture of files show up as "has been updated" and
+"is still dirty in the working directory" together. You can always tell
+which file is in which state, since the "has been updated" ones show a
+valid sha1, and the "not in sync with the index" ones will always have the
+special all-zero sha1.
+
+################################################################
 diff-tree
-	diff-tree [-r] [-z] <tree sha1> <tree sha1>
+	diff-tree [-r] [-z] <tree/commit sha1> <tree/commit sha1>
+
+Compares the content and mode of the blobs found via two tree objects.
+
+Note that diff-tree can use the tree encapsulated in a commit object.
+
+<tree sha1>
+	The id of a tree or commit object.
+
+-r
+	recurse
+
+-z
+	/0 line termination on output
+
+--cached
+	Cached only (private?)
+
+Output format:
+
+For files in tree1 but not in tree2
+-<mode>\t <type>\t	<sha1>\t	<path><filename>
+
+For files not in tree1 but in tree2
++<mode>\t <type>\t	<sha1>\t	<path><filename>
+
+For files that differ:
+*<tree1-mode>-><tree2-mode>\t <type>\t	<tree1 sha1>-><tree2 sha1>\t	<path><filename>
+
+
+An example of normal usage is:
+
+	torvalds@ppc970:~/git> diff-tree 5319e4d609cdd282069cc4dce33c1db559539b03 b4e628ea30d5ab3606119d2ea5caeab141d38df7
+	*100664->100664 blob    ac348b7d5278e9d04e3a1cd417389379c32b014f->a01513ed4d4d565911a60981bfb4173311ba3688      fsck-cache.c
+
+which tells you that the last commit changed just one file (it's from
+this one:
+
+	commit 3c6f7ca19ad4043e9e72fa94106f352897e651a8
+	tree 5319e4d609cdd282069cc4dce33c1db559539b03
+	parent b4e628ea30d5ab3606119d2ea5caeab141d38df7
+	author Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
+	committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
+
+	Make "fsck-cache" print out all the root commits it finds.
+
+	Once I do the reference tracking, I'll also make it print out all the
+	HEAD commits it finds, which is even more interesting.
+
+in case you care).
+
+
+################################################################
+fsck-cache
+	fsck-cache [[--unreachable] <head-sha1>*]
+
+Verifies the connectivity and validity of the objects in the database.
+
+<head-sha1>
+	A commit object to begin an unreachability trace
+
+--unreachable
+	print out objects that exist but that aren't readable from any
+	of the specified root nodes
+
+It tests SHA1 and general object sanity, but it does full tracking of
+the resulting reachability and everything else. It prints out any
+corruption it finds (missing or bad objects), and if you use the
+"--unreachable" flag it will also print out objects that exist but
+that aren't readable from any of the specified root nodes.
+
+So for example
+
+	fsck-cache --unreachable $(cat .git/HEAD)
+
+or, for Cogito users:
+
+	fsck-cache --unreachable $(cat .git/heads/*)
+
+will do quite a _lot_ of verification on the tree. There are a few
+extra validity tests to be added (make sure that tree objects are
+sorted properly etc), but on the whole if "fsck-cache" is happy, you
+do have a valid tree.
+
+Any corrupt objects you will have to find in backups or other archives
+(ie you can just remove them and do an "rsync" with some other site in
+the hopes that somebody else has the object you have corrupted).
+
+Of course, "valid tree" doesn't mean that it wasn't generated by some
+evil person, and the end result might be crap. Git is a revision
+tracking system, not a quality assurance system ;)
+
+Extracted Diagnostics
+expect dangling commits - potential heads - due to lack of head information
+	You haven't specified any nodes as heads so it won't be
+	possible to differentiate between un-parented commits and
+	root nodes.
+
+missing sha1 directory '<dir>'
+	The directory holding the sha1 objects is missing.
+
+unreachable <type> <sha1>
+	The <type> object <sha1>, isn't actually referred to directly
+	or indirectly in any of the trees or commits seen. This can
+	mean that there's another root na SHA1_ode that you're not specifying
+	or that the tree is corrupt. If you haven't missed a root node
+	then you might as well delete unreachable nodes since they
+	can't be used.
+
+missing <type> <sha1>
+	The <type> object <sha1>, is referred to but isn't present in
+	the database.
+
+dangling <type> <sha1>
+	The <type> object <sha1>, is present in the database but never
+	_directly_ used. A dangling commit could be a root node.
+
+warning: fsck-cache: tree <tree> has full pathnames in it
+	And it shouldn't...
+
+sha1 mismatch <sha1>
+	The database has an object who's sha1 doesn't match the
+	database value.
+	This indicates a ??serious?? data integrity problem.
+	(note: this error occured during early git development when
+	the database format changed.)
+
+Environment Variables
+
+SHA1_FILE_DIRECTORY
+	used to specify the object database root (usually .git/objects)
+
+################################################################
+git-export
+	git-export top [base]
+
+probably deprecated:
+On Wed, 20 Apr 2005, Petr Baudis wrote:
+>> I will probably not buy git-export, though. (That is, it is merged, but
+>> I won't make git frontend for it.) My "git export" already does
+>> something different, but more importantly, "git patch" of mine already
+>> does effectively the same thing as you do, just for a single patch; so I
+>> will probably just extend it to do it for an (a,b] range of patches.
+
+
+That's fine. It was a quick hack, just to show that if somebody wants to, 
+the data is trivially exportable.
+
+		Linus
+
+
+################################################################
+init-db
+	init-db
+
+This simply creates an empty git object database - basically a .git
+directory.
+
+If the object storage directory is specified via the
+SHA1_FILE_DIRECTORY environment variable then the sha1 directories are
+created underneath - otherwise the default .git/objects directory is
+used.
+
+init-db won't hurt an existing repository.
 
 
 ################################################################
@@ -134,7 +485,108 @@
 
 ################################################################
 read-tree
-	read-tree [-m] <sha1>
+	read-tree (<sha> | -m <sha1> [<sha2> <sha3>])"
+
+Reads the tree information given by <sha> into the directory cache,
+but does not actually _update_ any of the files it "caches". (see:
+checkout-cache)
+
+Optionally, it can merge a tree into the cache or perform a 3-way
+merge.
+
+Trivial merges are done by read-tree itself.  Only conflicting paths
+will be in unmerged state when read-tree returns.
+
+
+-m
+	Perform a merge, not just a read
+
+<sha#>
+	The id of the tree object(s) to be read/merged.
+
+
+Merging
+Each "index" entry has two bits worth of "stage" state. stage 0 is the
+normal one, and is the only one you'd see in any kind of normal use.
+
+However, when you do "read-tree" with multiple trees, the "stage"
+starts out at 0, but increments for each tree you read. And in
+particular, the old "-m" flag (which used to be "merge with old
+state") has a new meaning: it now means "start at stage 1" instead.
+
+This means that you can do
+
+	read-tree -m <tree1> <tree2> <tree3>
+
+and you will end up with an index with all of the <tree1> entries in
+"stage1", all of the <tree2> entries in "stage2" and all of the
+<tree3> entries in "stage3".
+
+Furthermore, "read-tree" has this special-case logic that says: if you
+see a file that matches in all respects in all three states, it
+"collapses" back to "stage0".
+
+Write-tree refuses to write a nonsensical tree, so write-tree will
+complain about unmerged entries if it sees a single entry that is not
+stage 0".
+
+Ok, this all sounds like a collection of totally nonsensical rules,
+but it's actually exactly what you want in order to do a fast
+merge. The different stages represent the "result tree" (stage 0, aka
+"merged"), the original tree (stage 1, aka "orig"), and the two trees
+you are trying to merge (stage 2 and 3 respectively).
+
+In fact, the way "read-tree" works, it's entirely agnostic about how
+you assign the stages, and you could really assign them any which way,
+and the above is just a suggested way to do it (except since
+"write-tree" refuses to write anything but stage0 entries, it makes
+sense to always consider stage 0 to be the "full merge" state).
+
+So what happens? Try it out. Select the original tree, and two trees
+to merge, and look how it works:
+
+ - if a file exists in identical format in all three trees, it will 
+   automatically collapse to "merged" state by the new read-tree.
+
+ - a file that has _any_ difference what-so-ever in the three trees
+   will stay as separate entries in the index. It's up to "script
+   policy" to determine how to remove the non-0 stages, and insert a
+   merged version.  But since the index is always sorted, they're easy
+   to find: they'll be clustered together.
+
+ - the index file saves and restores with all this information, so you
+   can merge things incrementally, but as long as it has entries in
+   stages 1/2/3 (ie "unmerged entries") you can't write the result.
+
+So now the merge algorithm ends up being really simple:
+
+ - you walk the index in order, and ignore all entries of stage 0,
+   since they've already been done.
+
+ - if you find a "stage1", but no matching "stage2" or "stage3", you
+   know it's been removed from both trees (it only existed in the
+   original tree), and you remove that entry.  - if you find a
+   matching "stage2" and "stage3" tree, you remove one of them, and
+   turn the other into a "stage0" entry. Remove any matching "stage1"
+   entry if it exists too.  .. all the normal trivial rules ..
+
+NOTE NOTE NOTE! although read-tree coule do some of these nontrivial
+merges, only the "matches in all three states" thing collapses by
+default. This is because even though there are other trivial cases
+("matches in both merge trees but not in the original one"), those
+cases might actually be interesting for the merge logic to know about,
+so that information is left around. It should be fairly rare anyway,
+so a few extra index entries are written out to disk so that the merge
+can be annotated.
+
+Incidentally - it also means that you don't even have to have a separate 
+subdirectory for this. All the information literally is in the index file, 
+which is a temporary thing anyway. There is no need to worry about what is in 
+the working directory, since it is never shown and never used.
+
+see also:
+write-tree
+show-files
 
 
 ################################################################
@@ -151,8 +603,145 @@
 show-files
 	show-files [-z] [-t] (--[cached|deleted|others|ignored|stage])*
 
+This merges the file listing in the directory cache index with the
+actual working directory list, and shows different combinations of the
+two.  
+
+--cached
+	Show cached files in the output (default)
+
+--deleted
+	Show deleted files in the output
+
+--others
+	Show other files in the output
+
+--ignored
+	Show ignored files in the output
+
+--stage
+	Show stage files in the output
+
+-t
+	Show the following tags (followed by a space) at the start of
+	each line:
+	H	cached
+	M	unmerged
+	R	removed/deleted
+	?	other
+
+-z
+	/0 line termination on output
+
+Output
+show files just outputs the filename unless --stage is specified in
+which case it outputs:
+
+[<tag> ]<mode> <sha1> <stage> <filename>
+
+show-files --unmerged" and "show-files --stage " can be used to examine
+detailed information on unmerged paths.
+
+For an unmerged path, instead of recording a single mode/SHA1 pair,
+the dircache records up to three such pairs; one from tree O in stage
+1, A in stage 2, and B in stage 3.  This information can be used by
+the user (or Cogito) to see what should eventually be recorded at the
+path. (see read-cache for more information on state)
+
+see also:
+read-cache
+
 
 ################################################################
 unpack-file
 	unpack-file.c <sha1>
 
+################################################################
+update-cache
+	update-cache [--add] [--remove] [--refresh] [--cacheinfo <mode> <sha1> <path>]* [--] [<file>]*
+
+Modifies the index or directory cache. Each file mentioned is updated
+into the cache and any 'unmerged' or 'needs updating' state is
+cleared.
+
+The way update-cache handles files it is told about can be modified
+using the various options:
+
+--add
+	If a specified file isn't in the cache already then it's
+	added.
+	Default behaviour is to ignore new files.
+
+--remove
+	If a specified file is in the cache but is missing then it's
+	removed.
+	Default behaviour is to ignore removed file.
+
+--refresh
+	Looks at the current cache and checks to see if merges or
+	updates are needed by checking stat() information.
+
+--cacheinfo <mode> <sha1> <path>
+	Directly insert the specified info into the cache.
+	
+--
+	Do not interpret any more arguments as options.
+
+<file>
+	Files to act on.
+	Note that files begining with '.' are discarded. This includes
+	"./file" and "dir/./file". If you don't want this, then use	
+	cleaner names.
+	The same applies to directories ending '/' and paths with '//'
+
+
+Using --refresh
+
+--refresh" does not calculate a new sha1 file or bring the cache
+up-to-date for mode/content changes. But what it _does_ do is to
+"re-match" the stat information of a file with the cache, so that you
+can refresh the cache for a file that hasn't been changed but where
+the stat entry is out of date.
+
+For example, you'd want to do this after doing a "read-tree", to link
+up the stat cache details with the proper files.
+
+Using --cacheinfo
+--cacheinfo is used to register a file that is not in the current
+working directory.  This is useful for minimum-checkout merging.
+
+To pretend you have a file with mode and sha1 at path, say:
+
+ $ update-cache --cacheinfo mode sha1 path
+
+
+################################################################
+write-tree
+	write-tree
+
+Creates a tree object using the current cache.
+
+The cache must be merged.
+
+Conceptually, write-tree sync()s the current directory cache contents
+into a set of tree files.
+In order to have that match what is actually in your directory right
+now, you need to have done a "update-cache" phase before you did the
+"write-tree".
+
+
+################################################################
+
+
+
+git Environment Variables
+AUTHOR_NAME
+AUTHOR_EMAIL
+AUTHOR_DATE
+COMMIT_AUTHOR_NAME
+COMMIT_AUTHOR_EMAIL
+GIT_DIFF_CMD
+GIT_DIFF_OPTS
+GIT_INDEX_FILE
+SHA1_FILE_DIRECTORY
+
Index: contrib/gitfeedmaillist.sh
===================================================================

--------------020605060200000407060401--
