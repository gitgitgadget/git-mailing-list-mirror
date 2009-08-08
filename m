From: "Nick Edelen" <sirnot@gmail.com>
Subject: [PATCH 1/6 (v2)] revision caching documentation: man page and
 technical discussion
Date: Sat, 08 Aug 2009 09:31:32 +0200
Message-ID: <op.uyb1uuu4tdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmic
X-From: git-owner@vger.kernel.org Sat Aug 08 09:32:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZgPQ-0007cU-Un
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 09:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbZHHHbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 03:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbZHHHbl
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 03:31:41 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:49896 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbZHHHbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 03:31:38 -0400
Received: by ey-out-2122.google.com with SMTP id 9so629316eyd.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 00:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=ZEVz9zKRgHDGqTrnCmPHKmNkAQ8q2zrbwZcM7GPmc0M=;
        b=mPaqFIp6RSvU7fOa35ZvhI2pMEpkZqwhkG3PSryM/od0mlDiiAXbbOi3urRnoMBka0
         M8Ia00YzmkpSeqQyWV30niGLmN6vqMbJi2nLBIKaD2pMwcktDxTSType5QDQy9HmpQ6K
         FkjgOchtWdGlt7ksCUL2ajPWe1n2VSuawmXnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=TbtnZHzTqE0uM4m6D1ZptATRaId5XyC7yNjjQMDgAAhRE/tdnH6aWfB7D0FjEeozjP
         88M+cJA/ezfwBr8NYnMczd0pBP7KPAq5a0SemCsUSAJdvJv2gyhgCrS1owzMBw3fjo47
         ofngy//GbpTusEfFy+YhS6egJHme/9M50slZA=
Received: by 10.210.136.15 with SMTP id j15mr368371ebd.21.1249716698817;
        Sat, 08 Aug 2009 00:31:38 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 5sm5054029eyf.58.2009.08.08.00.31.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 00:31:38 -0700 (PDT)
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125255>

Before any code is introduced the full documentation is put forth.  This 
provides a man page for the porcelain, and a technical doc in technical/.  The 
latter describes the API, and discusses rev-cache's design, file format and 
mechanics.

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
Same as 1/5 in previous set.  The man page has been flushed out, and formatted 
more congruently with git's other man pages.  The technical discussion has been 
updated and tweaked for better formatting as well.  This has been in response 
to Sam's commentary.

 Documentation/git-rev-cache.txt       |   96 +++++++++
 Documentation/technical/rev-cache.txt |  379 +++++++++++++++++++++++++++++++++
 2 files changed, 475 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-cache.txt b/Documentation/git-rev-cache.txt
new file mode 100755
index 0000000..600cf64
--- /dev/null
+++ b/Documentation/git-rev-cache.txt
@@ -0,0 +1,96 @@
+git-rev-cache(1)
+================
+
+NAME
+----
+git-rev-cache - Add, walk and maintain revision cache slices.
+
+SYNOPSIS
+--------
+'git-rev-cache' COMMAND [options] [<commit>...]
+
+DESCRIPTION
+-----------
+A front end for the rev-cache API.  It is mainly intended for cache slice
+generation and maintenance, but can also walk commits within a slice.  It
+currently provides basic administrative functionality.
+
+COMMANDS
+--------
+
+add
+~~~
+Add revisions to the cache by creating a new cache slice.  Reads a revision
+list from the command line, formatted as: `START START ... \--not END END ...`
+
+Options:
+
+\--all::
+	Include all branch heads in the new cache slice.
+
+\--fresh::
+	Exclude everything already in the revision cache.  
+
+\--stdin::
+	Read newline-seperated revisions from the standard input.  Use \--not
+	to exclude commits, as on the command line.
+
+\--legs::
+	Ensure newly-generated cache slice is self-contained.  This means that
+	no commit has partially cached parents, in that all its parents are
+	cached or none of them are.
+
+\--noobjects::
+	Non-commit objects are normally included along with the commit with
+	which they were introduced.  This is obviously very benificial, but can
+	take longer in cache slice generation.  Use this option to disable
+	non-commit object caching.
+
+walk
+~~~~
+Walk a cache slice based on revision list, formatted like 'add'.
+
+Options:
+
+\--objects::
+	Like 'git-rev-list', 'walk' will normally only list commits.  Use this
+	option to list non-commit objects as well.
+
+fuse
+~~~~
+Merge several cache slices into a single large slice.  On each invocation of
+'add' a new file ("slice") is added to the revision cache directory, and after
+several additions the directory may become populated with many, relatively
+small slices.  Numerous smaller slices will yield poorer performance than a one
+or two large ones, because of the overhead of loading new slices into memory.
+
+Running 'fuse' every once in a while will solve this problem by coalescing all
+the cache slices into one larger slice.  For very large projects, using
+\--ignore-size is advisable to prevent overly large cache slices.
+
+Options:
+
+\--all::
+	Normally fuse will only include everything that's already in the
+	revision cache.  \--add tells it to start walking from the branch
+	heads, effectively an `add --all --fresh; fuse` (pseudo-command).
+
+\--noobjects::
+	As in 'add', this option disables inclusion of non-commit objects.  If
+	some cache slices do contain such objects, the information will be lost.
+
+\--ignore-size[=N]::
+	Do not merge cache slices of size >=N.  If N is not provided 'fuse'
+	will default to a size of ~25MB (be aware that slices must be mapped to
+	memory).
+
+index
+~~~~~
+Regenerate the cache index.  If the index file associating objects with cache
+slices gets corrupted, lost, or otherwise becomes unusable, 'index' will
+quickly regenerate the file.  'fuse' will also regenerate the index.
+
+DISCUSSION
+----------
+For an explanation of the API and its inner workings, see
+link:technical/rev-cache.txt[technical info on rev-cache].
diff --git a/Documentation/technical/rev-cache.txt b/Documentation/technical/rev-cache.txt
new file mode 100755
index 0000000..78d7218
--- /dev/null
+++ b/Documentation/technical/rev-cache.txt
@@ -0,0 +1,379 @@
+rev-cache
+=========
+
+The revision cache API ('rev-cache') provides a method for efficiently storing
+and accessing commit branch sections.  Such branch slices are defined by a
+series of top (interesting) and bottom (uninteresting) commits.  Each slice
+contains, per commit:
+
+* All intra-slice topological relations, encoded into path "channels" (see
+  'Mechanics' for full explanation).
+* Object meta-data: type, SHA-1, size, date (for commits).
+* Objects introduced in that commit, relative to slice (ie. only for non-start
+  commits).
+
+Storage data structures are not exported, in part to keep git's global scope
+clean, but largely because they're pretty much useless outside of rev-cache.
+
+The API
+-------
+
+The API for 'rev-cache' is quite simple.  You can find the function prototypes
+in `revision.h`.
+
+Data Structures
+~~~~~~~~~~~~~~~
+
+The `rev_cache_info` struct holds all the options and flags for the API.
+
+----
+struct rev_cache_info {
+        /* generation flags */
+        unsigned objects : 1,
+                legs : 1,
+                make_index : 1;
+        
+        /* traversal flags */
+        unsigned save_unique : 1,
+                add_to_pending : 1,
+                add_names : 1;
+        
+        /* fuse options */
+        unsigned int ignore_size;
+};
+----
+
+The fields:
+
+`objects`::
+	Add non-commit objects to slice.
+
+`legs`::
+	Ensure end commits have no children.
+
+`make_index`::
+	Integrate newly-made slice into index.
+
+`save_unique`::
+	Load non-commit objects into `unique` field of their associated
+	`commit` object.
+
+`add_to_pending`::
+	Append unique non-commit objects to the `pending` object list in the
+	passed `rev_info` instance.
+
+`add_names`::
+	Include non-commit object names in the pending object entries (if
+	`add_to_pending` is set), and set the `name` field of `blob` and `tree`
+	objects (if `save_unique`).
+
+`ignore_size`::
+	If non-zero, ignore slices with size greater or equal to this during
+fusion.
+
+Functions
+~~~~~~~~~
+
+`init_rci`::
+        Initiate a `rev_cache_info` struct to default options.
+
+`make_cache_slice`::
+        Create a cache based on an a `rev_info` instance or `commit_list` s of
+        "starts" and "ends" (defaulting to latter if `rev_info` pointer is
+        NULL), copying the cache SHA-1 into a passed pointer if non-zero.  A
+        `rev_cache_info` struct pointer can be passed to set options, while
+        passing NULL will set default options.  A last parameter can
+        optionally recieve the final cache hash.
+
+`make_cache_index`::
+        Add a slice to the cache index.  Requires a file descriptor, the cache
+        hash and the file size.  Note that this is normally called by
+        `make_cache_slice` under the `make_index` option.
+
+`get_cache_slice`::
+        Given a commit SHA-1 `get_cache_slice` will search the slice index and
+        return, if found, the cache-identifying SHA-1.
+
+`traverse_cache_slice`::
+        Traverse a specified cache slice based on:
+
+        * `rev_info` instance; options set in the `rev_cache_info` field.
+        * cache SHA-1 identifier
+        * a starting commit and commit work list
+        * date of oldest encountered interesting commit (passing 0 will tell
+          rev-cache to use defaults)
+        * current `slop` (this is a counter, a la `revision.c`, to determine
+          when to stop traversing; typically you can just pass 0 and rev-cache
+          will use default settings)
+        
++
+The output is sent to a FILO `commit_list` "queue", while any end commits 
+are passed back into the work list.  If the walk is not contained within the 
+slice, commit boundaries are also inserted into "work".
+
+`start_from_slices`::
+        Will mark all start-commits in the specified cache slices with a given
+        flag, and add them to the rev pending list.  Will include all if no
+        slices are specified.
+
+`coagulate_cache_slices`::
+        Generate a slice based on the passed `rev_info` instance, replacing all
+        encountered slices with one (larger) slice.  The `ignore_size` field in
+        `rci`, if non-zero, will dictate which cache slice sizes to ignore in
+        both traversal and replacement.
+
+`regenerate_index`::
+        Remake cache index.
+
+Example Usage
+-------------
+
+A few examples to demonstrate usage:
+
+.Creating a slice
+----
+/* pretend you're a porcelain for rev-cache reading from the command line */
+struct rev_info revs;
+struct rev_cache_info rci;
+
+init_revisions(&revs, 0);
+init_rci(&rci);
+
+flags = 0;
+for (i = 1; i < argc; i++) {
+        if (!strcmp(argv[i], "--not"))
+                flags ^= UNINTERESTING;
+        else if(!strcmp(argv[i], "--fresh"))
+                starts_from_slices(&revs, UNINTERESTING, 0, 0);
+        else
+                handle_revision_arg(argv[i], &revs, flags, 1);
+}
+
+/* we want to explicitly set certain options */
+rci.objects = 0;
+
+if (!make_cache_slice(&rci, &revs, 0, 0, cache_sha1))
+        printf("made slice!  it's called %s\n", sha1_to_hex(cache_sha1));
+----
+
+.Traversing a slice
+----
+/* let's say you're walking the tree with a 'work' list of current heads and a 
+ * FILO output list 'out' */
+out = 0;
+outp = &out;
+
+while (work) {
+        struct commit *commit = pop_commit(&work);
+        struct object *object = &commit->object;
+        unsigned char *cache_sha1;
+        
+        if (cache_sha1 = get_cache_slice(object->sha1)) {
+                /* note that this will instatiate any topo-relations 
+                 * as it goes */
+                if (traverse_cache_slice(&revs, cache_sha1,
+                        commit, 0, 0, /* use defaults */
+                        &outp, &work) < 0)
+                        die("I'm overreacting to a non-fatal cache error");
+        } else {
+                struct commit_list *parents = commit->parents;
+                
+                while (parents) {
+                        struct commit *p = parents->item;
+                        struct object *po = &p->object;
+                        
+                        parents = parents->next;
+                        if (po->flags & UNINTERESTING)
+                                continue;
+                        
+                        if (object->flags & UNINTERESTING)
+                                po->flags |= UNINTERESTING;
+                        else if (po->flags & SEEN)
+                                continue;
+                        
+                        if (!po->parsed)
+                                parse_commit(p);
+                        insert_by_date(p, &work);
+                }
+                
+                if (object->flags & (SEEN | UNINTERESTING) == 0)
+                        outp = &commit_list_insert(commit, outp);
+                object->flags |= SEEN;
+        }
+}
+----
+
+Some Internals
+--------------
+
+Although you really don't need to know anything about how rev-cache actually
+does its magic shizz, a bit of background may go a long way if you're wading
+through the source.
+
+File Formats
+~~~~~~~~~~~~
+
+A slice has a basic fixed-size header, followed by a certain number of object
+entries, then a NULL-seperated list of object names.  Commits are sorted in
+topo-order, and each commit entry is followed by the objects added in that
+commit.
+
+----
+         -- +--------------------------------+
+header      | object number, etc...          |
+         -- +--------------------------------+
+commit      | commit info                    |
+entry       | path data                      |
+            +--------------------------------+
+            | tree/blob info                 |
+            +--------------------------------+
+            | tree/blob info                 |
+            +--------------------------------+
+            | ...                            |
+         -- +--------------------------------+
+commit      | commit info                    |
+entry       | path data                      |
+            +--------------------------------+
+            | tree/blob info                 |
+            +--------------------------------+
+            | ...                            |
+         -- +--------------------------------+
+...         ...                               
+         -- +--------------------------------+
+name list   | \0some_file_name\0             |
+(note       +--------------------------------+
+preceeding  | another_file\0                 |
+null)       ...                              |
+            +--------------------------------+
+----
+
+The index is a single file that associates SHA-1s with cache slices and file
+positions.  It is somewhat similar to pack-file indexes, containing a fanout
+table and a list of index entries sorted by hash.
+
+----
+         -- +--------------------------------+
+header      | object #, cache #, etc.        |
+         -- +--------------------------------+
+sha1s of    | SHA-1                          |
+slices      | ...                            |
+         -- +--------------------------------+
+fanout      | fanout[0x00]                   |
+table       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+            | fanout[0xff]                   |
+         -- +--------------------------------+
+index       | SHA-1 of object                |
+entries     | index of cache slice SHA-1     |
+            | position in cache slice        |
+            +--------------------------------+
+            |                                |
+            ...                               
+            +--------------------------------+
+----
+
+All the relavant structures are readily accessible in `rev-cache.c`
+
+Mechanics
+~~~~~~~~~
+
+The most important part of rev-cache is its method of encoding topological
+relations.  To ensure fluid traversal and reconstruction, commits are related
+through high-level "streams"/"channels" rather than individual
+interconnections.  Intuitively, rev-cache stores history the way gitk shows it:
+commits strung up on lines, which interconnect at merges and branches.
+
+Each commit is associated to a given channel/path via a 'path id', and
+variable-length fields govern which paths (if any) are closed or opened at that
+object.  This means that topo-data can be preserved in only a few bytes extra
+per object entry.  Other information stored per entry is the sha-1 hash, type,
+date, size, name, and status in cache slice.  Here is format of an object
+entry, both on-disk and in-memory:
+
+----
+struct object_entry {
+        unsigned type : 3;
+        unsigned is_end : 1;
+        unsigned is_start : 1;
+        unsigned uninteresting : 1;
+        unsigned include : 1;
+        unsigned flags : 1;
+        unsigned char sha1[20];
+        
+        unsigned merge_nr : 6;
+        unsigned split_nr : 7;
+        unsigned size_size : 3;
+        unsigned name_size : 3;
+        unsigned what_to_do : 5;
+        
+        uint32_t date;
+        uint16_t path;
+        
+        /* merge paths */
+        /* split paths */
+        /* size */
+        /* name index */
+};
+----
+
+An explanation of each field:
+
+`type`::
+	Object type
+`is_end`::
+	The commit has some parents outside the cache slice (all if slice has
+	legs)
+`is_start`::
+	The commit has no children in cache slice
+`uninteresting`::
+	Run-time flag, used in traversal
+`include`::
+	Run-time flag, used in traversal (initialization)
+`flags`::
+	Currently unused, extra bit
+`sha`::
+	Object SHA-1 hash
+
+`merge_nr`::
+	The number of paths the current channel diverges into; the current path
+	ends upon any merge.
+`split_nr`::
+	The number of paths this commit ends; used on both merging and
+	branching.
+`size_size`::
+	Number of bytes the object size takes up.
+`name_size`::
+	Number of bytes the name index takes up.
+`what_to_do`::
+	Currently space-filler, to properly align the struct fields.  Can
+	potentially be used for anything.
+
+merge paths::
+	The path IDs (16-bit) that are to be created.
+split paths::
+	The path IDs (16-bit) that are to be ended.
+size::
+	The size split into the minimum number of bytes.
+name index::
+	An offset for the null-seperated, object name list at the end of the
+	cache slice.  Also split into the minimum number of bytes.
+
+Each path ID refers to an index in a 'path array', which stores the current
+status (eg. active, interestingness) of each channel.
+
+Due to topo-relations and boundary tracking, all of a commit's parents must be
+encountered before the path is reallocated.  This is achieved by using a
+counter system per merge: starting at the parent number, the counter is
+decremented as each parent is encountered (dictated by 'split paths'); at 0 the
+path is cleared.
+
+Boundary tracking is necessary because non-commits are stored relative to the
+commit in which they were introduced.  If a series of commits is not included
+in the output, the last interesting commit must be parsed manually to ensure
+all objects are accounted for.
+
+To prevent list-objects from recursing into trees that we've already taken care
+of, the flag `FACE_VALUE` is introduced.  An object with this flag is not
+explored (= "taken at face value"), significantly reducing I/O and processing
+time.
+
+(NSE)
-- 
tg: (6f604e7..) t/revcache/docs (depends on: t/revcache/integration)
