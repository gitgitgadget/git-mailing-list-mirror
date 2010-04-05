From: Nick Edelen <sirnot@gmail.com>
Subject: [PATCH 1/7 (v5)] man page and technical docs
Date: Mon, 05 Apr 2010 20:57:55 +0100
Message-ID: <4BBA40C3.9080404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail
X-From: git-owner@vger.kernel.org Mon Apr 05 21:58:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NysQx-0008Ax-Rq
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345Ab0DET56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 15:57:58 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:41494 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756313Ab0DET54 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 15:57:56 -0400
Received: by ey-out-2122.google.com with SMTP id d26so255182eyd.19
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 12:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=XWRZxIBeRDu663/iF8Od4cdJefr3PGqf9IJjcNFqkRc=;
        b=TjqRHntJTZjv6zvWJ+R2hQMRn8qgh8MZchPbpkQWWQ3Oa7L69ScXBPfxrFcxo35NZT
         CxQiXYQYYsX1RwQiaeoMDv5+NSagROCLRxv2UMmTwHjsDeDqmlYt58S32LwO4yKUg+NX
         7jdMyhkiXmQBNpnJCjHTZUMBJczlT9fNUWOMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=XrLJdulWz9KdDLbLbRSCfr3pC14fEf4O7j6tYScogluRcJXr5XyTr5+qoo/2cXhki4
         VC6jWi4mA21sFKfwzQFinX6iC+B/cdQXVLVintxSbfvYIcSRDNkMZFcTV4kn6IpV+aho
         tI6fvCyAgj4mwo+BKXGY2aFyDTpT2FHr2z0ts=
Received: by 10.213.43.83 with SMTP id v19mr3158234ebe.1.1270497474423;
        Mon, 05 Apr 2010 12:57:54 -0700 (PDT)
Received: from [192.168.55.86] (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 16sm6510004ewy.3.2010.04.05.12.57.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 12:57:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144059>

Before any code is introduced the full documentation is put forth.  This
provides a man page for the porcelain, and a technical doc in technical/.  The
latter describes the API, and discusses rev-cache's design, file format and
mechanics.

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
 Documentation/git-rev-cache.txt       |  194 ++++++++++
 Documentation/technical/rev-cache.txt |  634 +++++++++++++++++++++++++++++++++
 command-list.txt                      |    1 +
 3 files changed, 829 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-cache.txt b/Documentation/git-rev-cache.txt
new file mode 100644
index 0000000..20d98c6
--- /dev/null
+++ b/Documentation/git-rev-cache.txt
@@ -0,0 +1,194 @@
+git-rev-cache(1)
+================
+
+NAME
+----
+git-rev-cache - Add, walk and maintain revision cache slices
+
+SYNOPSIS
+--------
+'git-rev-cache' COMMAND [options] [<commit>...]
+
+DESCRIPTION
+-----------
+The revision cache ('rev-cache') provides a mechanism for significantly
+speeding up revision traversals.  It does this by creating an efficient
+database (cache) of commits, their related objects and topological relations.
+Independant of packs and the object store, this database is composed of
+rev-cache "slices" -- each a different file storing a given segment of commit
+history.  To map commits to their respective slices, a single index file is
+kept for the rev-cache.
+
+'git-rev-cache' provides a front-end for the rev-cache mechanism, intended for
+updating and maintaining rev-cache slices in the current repository.  New cache
+slice files can be 'add'ed, to keep the cache up-to-date; individual slices can
+be traversed; smaller slices can be 'fuse'd into a larger slice; and the
+rev-cache index can be regenerated.
+
+COMMANDS
+--------
+
+add
+~~~
+Add revisions to the cache by creating a new cache slice.  Reads a revision
+list from the command line, formatted as: `START START ... \--not END END ...`
+
+Options
+^^^^^^^
+
+\--all::
+	Include all refs in the new cache slice, like the \--all option in
+	'rev-list'.
+
+\--fresh/\--incremental::
+	Exclude everything already in the revision cache, analogous to
+	\--incremental in 'pack-objects'.
+
+\--stdin::
+	Read newline-seperated revisions from the standard input.  Use \--not
+	to exclude commits, as on the command line.
+
+\--legs/\--close::
+	Ensure newly-generated cache slice has no partial ends, simplifying the
+definition of 'end' to be the true analog of 'start': having *none* of its
+parents in the same slice.  99.9% of users can ignore this command.
++
+\--legs will cause 'rev-cache' to expand potential slice end-points (creating
+"legs") until this condition is met, simplifying the cache slice structure.
+'rev-cache' itself does not care if a slice has legs or not, but the condition
+may reduce the required complexity of other applications that might use the
+revision cache.
+
+\--no-objects::
+	Non-commit objects are normally included along with the commit with
+	which they were introduced.  This is obviously very benificial, but can
+	take longer in cache slice generation.  Using this option will disable
+	non-commit object caching.
++
+\--no-objects is mainly intended for debugging or development purposes, but may
+find use in special situations (e.g. common traversal of only commits).  Note
+that traversal output correctness will not be affected by this option -- it will
+simply traverse the object trees itself.
+
+Output
+^^^^^^
+
+On `stderr` 'add' outputs general information about the generated slice,
+including the number of objects and paths, and the start/end commits (prefix S
+indicates start, E an end).  Through `stdout` it emits only the SHA-1 of the
+slice.
+
+walk
+~~~~
+Analogous to a slice-oriented 'rev-list', 'walk' will walk commits contained in
+a region of one cache slice.  Interesting and uninteresting (delimited, as with
+'rev-list', with \--not) are specified on the command line, and output is the
+same as vanilla 'rev-list'.  Note that information outputted is limited by the
+information contained in the slice.
+
+Options
+^^^^^^^
+
+\--objects::
+	Like 'rev-list', 'walk' will normally only list commits.  Use this
+	option to list non-commit objects as well, if they are present in the
+	cache slice.
+
+Output
+^^^^^^
+
+'walk' will simply dump the contents of the output commit list, work list, and
+pending object array.  The headers are outputted on `stderr`, the object hashes
+and names on `stdout`.
+
+fuse
+~~~~
+Merge several cache slices into a single large slice, like 'repack' for
+'rev-cache'.  On each invocation of 'add' a new file ("slice") is added to the
+revision cache directory, and after several additions the directory may become
+populated with many, relatively small slices.  Numerous smaller slices will
+yield poorer performance than a one or two large ones, because of the overhead
+of loading new slices into memory.
+
+Running 'fuse' every once in a while will solve this problem by coalescing all
+the cache slices into one larger slice.  For very large projects, using
+\--ignore-size is advisable to prevent overly large cache slices.  This can be
+set to run on garbage collection; see 'Automation' for more info.
+
+Note that 'fuse' uses the internal revision walker, so the options used in
+fusion override those of the cache slices upon which it operates.  For example,
+if some slices were generated with \--no-objects, yet 'fuse' was performed with
+non-commit objects, the resulting slice would still contain objects but would
+take longer to generate.
+
+Options
+^^^^^^^
+
+\--all::
+	Normally fuse will only include everything that's already in the
+	revision cache.  \--all tells it to start walking from the branch
+	heads, effectively a `add --all --fresh; fuse`
+	(pseudo-revcache-command).
+
+\--no-objects::
+	As in 'add', this option disables inclusion of non-commit objects.  If
+	some cache slices do contain such objects, the information will be lost.
+
+\--ignore-size[=N]/\--keep-size[=N]::
+	Do not merge cache slices of size >=N (be aware that slices must be
+	mapped to memory).  N can have a suffix of "k" or "m", denoting N as
+	kilobytes and megabytes, respectively.  If N is not provided 'fuse'
+	will default to a size specified in `revcache.ignoresize`, or ~25MB if
+	the config var is not set.
+
+Output
+^^^^^^
+
+This command prints the SHA-1 of the new slice on `stdout`, and information
+about its work on `stderr` -- specifically which files it's removing.
+
+Automation
+^^^^^^^^^^
+
+Set the git configuration variable `gc.revcache` to run 'fuse' on garbage
+collection.  The arguments passed are `fuse \--all \--ignore-size`; i.e. 'gc'
+will keep everything cached into size-regulated slices.
+
+index
+~~~~~
+Regenerate the revision cache index.  If the rev-cache index file associating
+objects with cache slices gets corrupted, lost, or otherwise becomes unusable,
+'index' will quickly regenerate the file.  It's most likely that this won't be
+needed in every day use, as it is targeted towards debugging and development,
+but is a useful fallback.
+
+alt
+~~~
+Create a cache slice pointer to another slice, identified by its full path:
+`alt path/to/other/slice`
+
+This command is useful if you have several repositories sharing a common
+history.  Although space requirements for rev-cache are slim anyway, you can in
+this situation reduce it further by using slice pointers, pointing to relavant
+slices in other repositories.  Note that only one level of redirection is
+allowed, and the slice pointer will break if the original slice is removed.
+'fuse' will not touch slice pointers.
+
+NOTES
+-----
+In certain circumstances there may be some inconsistencies with object names
+between cached and non-cached walks.  Specifically, if two objects in a commit
+tree have the same content (= same SHA-1); or if objects of the same SHA-1 are
+introduced independantly in parallel branches.
+
+In the first case rev-cache will use the name of the youngest file, while
+vanilla rev-list will return the name of the entry first encountered in walking
+the tree.  The latter case is a result of rev-cache's internal topological
+ordering: the difference is the same between sorted and unsorted revision walks.
+
+See 'Discussion' for the underlying reasons for the discrepencies.
+
+DISCUSSION
+----------
+For an explanation of the API and its inner workings, see
+link:technical/rev-cache.txt[technical info on rev-cache].
diff --git a/Documentation/technical/rev-cache.txt b/Documentation/technical/rev-cache.txt
new file mode 100644
index 0000000..91fce8b
--- /dev/null
+++ b/Documentation/technical/rev-cache.txt
@@ -0,0 +1,634 @@
+rev-cache
+=========
+
+The revision cache API ('rev-cache') provides a method for efficiently storing
+and accessing commit branch sections.  Such branch slices are defined by a
+series of start/top (interesting) and end/bottom (uninteresting) commits.  Each
+slice contains information on commits in topological order.  Recorded with each
+commit is:
+
+* All intra-slice topological relations, encoded into path "channels" (see
+  'Mechanics' for full explanation).
+* Object meta-data: type, SHA-1, size, date (for commits).
+* Objects introduced by that commit, not present in the its cached parents.
+
+In addition to the API, basic structures are exported for the possibility of
+direct access.
+
+The API
+-------
+You can find the function prototypes in `revision.h`.
+
+Data Structures
+~~~~~~~~~~~~~~~
+The `rev_cache_info` struct holds all the options and flags for the API.
+
+----
+struct rev_cache_info {
+	/* generation flags */
+	unsigned objects : 1,
+		legs : 1,
+		make_index : 1,
+		fuse_me : 1;
+
+	/* index inclusion */
+	unsigned overwrite_all : 1;
+
+	/* traversal flags */
+	unsigned add_to_pending : 1;
+
+	/* fuse options */
+	unsigned int ignore_size;
+
+	/* reserved */
+	struct rev_cache_slice_map *maps,
+		*last_map;
+};
+----
+
+The fields:
+
+`objects`::
+	Add non-commit objects to slice.
+
+`legs`::
+	Ensure end/bottom commits have no children.
+
+`make_index`::
+	Integrate newly-made slice into index.
+
+`fuse_me`::
+	This is specified if a fuse is occuring, and slices are to be reused.
+	This option requires `maps` and `last_maps` to be initialized.
+
+`overwrite_all`::
+	When a cache slice is added to the index, sometimes overlap occures
+	between it and other slices.  Normally, original index entries are kept
+	unless the new entry represents a start commit (older entries are more
+	likely to lead to greater in-slice traversals).  This options overrides
+	that, and updates all entries of the new slice.
+
+`add_to_pending`::
+	Append unique non-commit objects to the `pending` object list in the
+	passed `rev_info` instance.
+
+`add_names`::
+	Include non-commit object names in the pending object entries if
+	`add_to_pending` is set.
+
+`ignore_size`::
+	If non-zero, ignore slices with size greater or equal to this during
+fusion.
+
+`maps`/`last_map`::
+	An array of slice mappings, indexed by their id in the slice index
+	header, to be re-used with `fuse_me`.  `last_map` points to the last
+	mapping used, and should be initialized to 0.
+
+Functions
+~~~~~~~~~
+
+init_rev_cache
+^^^^^^^^^^^^^^
+----
+void init_rev_cache_info(
+	struct rev_cache_info *rci OUT
+)
+----
+
+Initialize `rci` to default options.
+
+make_cache_slice
+^^^^^^^^^^^^^^^^
+----
+int make_cache_slice(
+	struct rev_cache_info *rci IN,
+	struct rev_info *revs IN,
+	struct commit_list **starts IN/OUT,
+	struct commit_list **ends IN/OUT,
+	unsigned char *cache_sha1 OUT
+)
+----
+
+Create a cache slice based on either `revs` (if non-NULL) *or* the `starts` and
+`ends` lists.  The actual list of start and end commits of the slice may be
+different from the parameters, based on what defines the branch segment, and
+this actual list is passed back through `starts` and `ends`.
+
+The cache slice is identified via a SHA-1 generated from the actual start/end
+commit lists.  `cache_sha1`, if non-NULL, can recieve the cache slice name.
+`rci` is used to specify generation options, but can be NULL if you want
+`make_cache_slice` to fall back on defaults.  Returns 0 on success, non-zero on
+failure.
+
+make_cache_index
+^^^^^^^^^^^^^^^^
+----
+int make_cache_index(
+	struct rev_cache_info *rci IN,
+	unsigned char *cache_sha1 IN,
+	int fd IN,
+	unsigned int size IN
+)
+----
+
+Add a slice to the rev-cache index.  `cache_sha1` is the identity hash of the
+cache slice; `fd` is a file descriptor of the cache slice opened with
+read/write privileges (the slice is not actually modified); `size` is the size
+of the cache slice.  Although there are currently no options for index
+updating, `rci` is a placeholder in case of future options.  Note that this
+function is normally called by `make_cache_slice`.  Returns 0 on success,
+non-zero on failure.
+
+open_cache_slice
+^^^^^^^^^^^^^^^^
+----
+int open_cache_slice(
+	unsigned char *sha1 IN,
+	int flags IN
+)
+----
+
+Returns a file descriptor to a cache slice described by `sha1` hash, using
+`flags` as the access mode.  This will follow cache slice pointers to one level
+of indirection.
+
+get_cache_slice
+^^^^^^^^^^^^^^^
+----
+unsigned char *get_cache_slice(
+	struct commit *commit IN
+)
+----
+
+Given a commit object `get_cache_slice` will search the revision cache index
+and return, if found, the cache slice SHA-1.
+
+traverse_cache_slice
+^^^^^^^^^^^^^^^^^^^^
+----
+int traverse_cache_slice(
+	struct rev_info *revs IN/OUT,
+	unsigned char *cache_sha1 IN,
+	struct commit *commit IN,
+	unsigned long *date_so_far IN/OUT,
+	int *slop_so_far IN/OUT,
+	struct commit_list ***queue OUT,
+	struct commit_list **work IN/OUT
+)
+----
+
+Traverse a specified cache slice.  An explanation of the each field:
+
+`revs`::
+	The revision walk instance.  `traverse_cache_slice` uses this for
+	general options (e.g. which objects are included) and slice traversal
+	options (in the `rev_cache_info` field).  If the `add_to_pending`
+	option is specified, non-commit objects are appended to the `pending`
+	object list field.
+
+`cache_sha1`::
+	SHA-1 identifying the cache slice to use.  This can be taken directly
+	from `get_cache_slice`.
+
+`commit`::
+	The current commit object in the revision walk, i.e. the commit which
+	inspired this slice traversal.  Although theoretically redundant in
+	view of the `work` list, this simplifies interaction with normal
+	revision walks, which pop commits from `work` before analyzing them.
+
+`date_so_far`::
+	The date of the oldest encountered interesting commit.  Passing NULL
+	will let `traverse_cache_slice` use defaults.
+
+`slop_so_far`::
+	The `slop` value, a la revision.c.  This is a counter used to determine
+	when to stop traversing, based on how many extra uninteresting commits
+	should be encountered.  NULL will enable defaults, as above.
+
+`queue`::
+	Refers to a pointer to the head of a FIFO commit list, recieving the
+	commits we've seen and added.
+
+`work`::
+	A date-ordered list of commits that have yet to be processed (i.e. seen
+	but not added).  Commits from here present in the slice are removed
+	(and, obviously, used as starting places for traversal), and any end
+	commits encountered are inserted.
+
+starts_from_slices
+^^^^^^^^^^^^^^^^^^
+----
+void starts_from_slices(
+	struct rev_info *revs OUT,
+	unsigned int flags IN,
+	unsigned char *which IN,
+	int n IN
+)
+----
+
+Will mark start-commits in certain rev-cache slices with `flag`, and added them
+to the pending list of `revs`.  If `n` is zero, `starts_from_slices` will use
+all slices.  Otherwise `which` will specify an *unseperated* list of cache
+SHA-1s to use (20 bytes each), and `n` will contain the number of slices (i.e.
+20 * `n` = size of `which`).
+
+fuse_cache_slices
+^^^^^^^^^^^^^^^^^
+----
+int fuse_cache_slices(
+	struct rev_cache_info *rci IN,
+	struct rev_info *revs IN
+)
+----
+
+Generate a slice based on `revs`, replacing all encountered slices with one
+(larger) slice.  The `ignore_size` field in `rci`, if non-zero, will dictate
+which cache slice sizes to ignore in both traversal and replacement.
+
+regenerate_cache_index
+^^^^^^^^^^^^^^^^^^^^^^
+----
+int regenerate_cache_index(
+	struct rev_cache_info *rci IN
+)
+----
+
+Remake the revision cache index, including all the slices.  Currently no
+options in `rci` exist for index (re)generation, but some may develop in the
+future.
+
+to/from_disked_rc_object/index_entry
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+----
+struct rc_object/index_entry *from_disked_rc_object/index_entry(
+	struct rc_object/index_entry_ondisk *src IN,
+	struct rc_object/index_entry *dst OUT
+)
+
+struct rc_object/index_entry_ondisk *to_disked_rc_object/index_entry(
+	struct rc_object/index_entry *src IN,
+	struct rc_object/index_entry_ondisk *dst OUT
+)
+----
+
+Functions to convert between the internal and storage (`_ondisk`) versions of
+object and index entry structures.  These are necessary for direct access to
+the cache slices.  If NULL is provided for `dst` a statically allocated
+structure is used, and a pointer to the struct is returned.  Otherwise the
+functions return `dst`.
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
+                        outp = &commit_list_insert(commit, outp)->next;
+                object->flags |= SEEN;
+        }
+}
+----
+
+Some Internals
+--------------
+For more advanced usage, the slice and index file(s) may be accessed directly.
+Relavant structures are availabe in `rev-cache.h`.
+
+File Formats
+~~~~~~~~~~~~
+
+Cache Slices
+^^^^^^^^^^^^
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
+Here is the header:
+
+----
+struct rc_cache_slice_header {
+	char signature[8]; /* REVCACHE */
+	unsigned char version;
+	uint32_t ofs_objects;
+
+	uint32_t object_nr;
+	uint16_t path_nr;
+	uint32_t size;
+
+	unsigned char sha1[20];
+
+	uint32_t names_size;
+};
+----
+
+Explanations:
+
+`signature`::
+	The identifying signature of cache slice file.  Always "REVCACHE".
+`version`::
+	The version number, currently 1.
+`ofs_objects`::
+	The byte offset at which the commit/object listing starts.  Always
+	present at the 10th byte, regardless of file version.
+`object_nr`::
+	The total number of objects (commit + non-commit objects) present in
+	the slice.
+`path_nr`::
+	The total number of paths/channels used in encoding the topological
+	data.  Note that paths are reused (see 'Mechanics'), so there will
+	never be more than a few hundred paths (if that) used.
+`size`::
+	The size of the slice *excluding* the name list.  In other words, the
+	size of the portion mapped to memory.
+`sha1`::
+	The cache slice SHA-1.
+`names_size`::
+	The size of the name list.  `size` + `names_size` = size of slice
+
+Revision Cache Index
+^^^^^^^^^^^^^^^^^^^^
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
+The header:
+
+----
+struct rc_index_header {
+	char signature[8]; /* REVINDEX */
+	unsigned char version;
+	uint32_t ofs_objects;
+
+	uint32_t object_nr;
+	unsigned char cache_nr;
+
+	uint32_t max_date;
+};
+----
+
+Explanations:
+
+`signature`::
+	Always "REVINDEX".
+`version`::
+	Version number, currently 1.
+`ofs_objects`::
+	Offset at which the entry objects begin.  This is more obviously useful
+	in the index because the list of slice SHA-1s is variably-sized.
+`object_nr`::
+	Number of index entry objects present.
+`cache_nr`::
+	Number of cache slices to which the index maps, and hence the number of
+slice SHA-1s listed.
+`max_date`::
+	The oldest commit represented in the index.  This is used to help speed
+up lookup times by knowing what range of commits we definitely don't have
+cached.  Normal usage of 'rev-cache' would leave no "holes" in its coverage of
+commit history -- once a commit is cached, everything reachable from it should
+be cached as well.  Most of the time refs are added to rev-cache simultaneous
+as well.  This means that in most situations almost everything <= `max_date`
+will be cached.
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
+        unsigned char merge_nr;
+        unsigned char split_nr;
+        unsigned size_size : 3;
+        unsigned name_size : 3;
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
+`sha1`::
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
+
+`date`::
+	The date of the commit.
+`path`::
+	The path ID of the channel with which this commit is associated.
+
+merge paths::
+	The path IDs (16-bit) that are to be created.  Overflow is not a
+	problem as path IDs are reused, leaving even complicated projects to
+	consume no more than a few hundred IDs.
+split paths::
+	The path IDs (16-bit) that are to be ended.
+size::
+	The size split into the minimum number of bytes.  That is, 1-8 bytes
+	representing the size, least-significant byte first.
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
+Notes
+~~~~~
+
+Due to rev-cache's internal storage format, walking may lead to some
+discrepencies between cached and uncached repositories.  Although noticeable to
+users directly calling rev-list, these are unused or corner cases and
+internally a non-issue.
+
+First note that rev-cache records commits in topological order.  Large portions
+of commit history will already be sorted topologically in the revision walk,
+yielding a different output for unsorted calls to rev-list.  A more obscure
+consquence occurs when two objects of the same SHA-1, but different name, are
+introduced seperately in parallel branches: different names might be shown for
+that object depending on which object entry was encountered first.
+
+A similar disparity arises when two objects of same SHA-1/different name are
+present in the same tree structure.  rev-cache, walking objects as they were
+introduced, lists the youngest file's name; rev-list, walking the full trees
+each commit, shows the first file encountered.
diff --git a/command-list.txt b/command-list.txt
index 95bf18c..21fae3f 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -100,6 +100,7 @@ git-request-pull                        foreignscminterface
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain common
 git-revert                              mainporcelain
+git-rev-cache                           plumbingmanipulators
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
 git-rm                                  mainporcelain common
-- 
tg: (11766ca..) t/rc/docs (depends on: master)
