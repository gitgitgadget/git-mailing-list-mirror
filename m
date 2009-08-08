From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6 (v2)] revision caching documentation: man page and
 technical discussion
Date: Sat, 08 Aug 2009 11:31:35 -0700
Message-ID: <7vbpmqi2d4.fsf@alter.siamese.dyndns.org>
References: <op.uyb1uuu4tdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmicha.warpmail.net>,
	"Jeff King" <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Andreas Ericsson" <exon@op5.se>,
	"Christian Couder" <christian@couder.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Nick Edelen" <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 20:32:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZqiC-0001gb-Dy
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 20:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbZHHSby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 14:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752797AbZHHSby
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 14:31:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbZHHSbw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 14:31:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ABC1B22BF4;
	Sat,  8 Aug 2009 14:31:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EADBF22BF1; Sat,  8 Aug 2009
 14:31:36 -0400 (EDT)
In-Reply-To: <op.uyb1uuu4tdk399@sirnot.private> (Nick Edelen's message of
 "Sat\, 08 Aug 2009 09\:31\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BDA28684-8449-11DE-9865-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125295>

"Nick Edelen" <sirnot@gmail.com> writes:

> Before any code is introduced the full documentation is put forth.  This 
> provides a man page for the porcelain, and a technical doc in technical/.  The 
> latter describes the API, and discusses rev-cache's design, file format and 
> mechanics.
>
> Signed-off-by: Nick Edelen <sirnot@gmail.com>

Quite respectable work, in that not many people try to start from
specification. 

I'll ask quite a many questions in the following.  I do not want you to
explain them to _me_ in your response.  I am asking them so that the v3
and subsequent revision will remove the need for these questions to be
asked by somebody (other than me) who reads the document.

>  Documentation/git-rev-cache.txt       |   96 +++++++++
>  Documentation/technical/rev-cache.txt |  379 +++++++++++++++++++++++++++++++++
>  2 files changed, 475 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-rev-cache.txt b/Documentation/git-rev-cache.txt
> new file mode 100755

An executable documentation?

> index 0000000..600cf64
> --- /dev/null
> +++ b/Documentation/git-rev-cache.txt
> @@ -0,0 +1,96 @@
> +git-rev-cache(1)
> +================
> +
> +NAME
> +----
> +git-rev-cache - Add, walk and maintain revision cache slices.

Drop the last '.'; also you may need to add this command to the command
classification list so that "man git" would know where to include this in
its command list.

> +SYNOPSIS
> +--------
> +'git-rev-cache' COMMAND [options] [<commit>...]
> +
> +DESCRIPTION
> +-----------
> +A front end for the rev-cache API.  It is mainly intended for cache slice
> +generation and maintenance, but can also walk commits within a slice.  It
> +currently provides basic administrative functionality.
> +

Briefly discuss

 - what rev-cache is for (e.g. "an optional mechanism to speed up
   revision traversal");
   
 - what a cache slice is (e.g. "records such and such for a set of commit
   objects");

 - how these two relate to each other (e.g. "one or more slices are tied
   together with a single rev-cache-index to form a rev-cache); and

 - how a rev-cache relates to a repository or an object store (e.g. "a
   given repository can have up to N rev-cache that describes its
   objects")

here.

> +COMMANDS
> +--------
> +
> +add
> +~~~
> +Add revisions to the cache by creating a new cache slice.  Reads a revision
> +list from the command line, formatted as: `START START ... \--not END END ...`
> +
> +Options:
> +
> +\--all::
> +	Include all branch heads in the new cache slice.

Is this "all branch heads"?  Shouldn't it be "all refs?"  If not, why not?

> +\--fresh::
> +	Exclude everything already in the revision cache.  

This concept seems to correspond to --incremental in pack-objects parlance.

> +\--stdin::
> +	Read newline-seperated revisions from the standard input.  Use \--not
> +	to exclude commits, as on the command line.
> +
> +\--legs::
> +	Ensure newly-generated cache slice is self-contained.  This means that
> +	no commit has partially cached parents, in that all its parents are
> +	cached or none of them are.

If I am reading the description correctly what you mean is that for a
history:

	---A---C---D
              /
          ---B

a slice is allowed to consist of (empty), (D), (C D), (A B C D), but not
(A C D), if it wants to be "--legs compliant".

But without your definition in the second and third line, people would not
call (C D) "self-contained", as you cannot tell what C's parents are.
Because you do not use "self-containedness" in the rest of documentation
to explain other things, you do not need to introduce such an unintuitive
definition of a word.  I'd suggest dropping the first line.

Also for the lack of better word I said "--legs compliant" above.  We do
need a better word to express this concept, and use that as the option
name.  Unfortunately, I can tell "legs" is not it, but I cannot offhand
think of what word should it be.

> +\--noobjects::
> +	Non-commit objects are normally included along with the commit with
> +	which they were introduced.  This is obviously very benificial, but can
> +	take longer in cache slice generation.  Use this option to disable
> +	non-commit object caching.

"--no-objects" (I think you meant reverse of --objects to rev-list).

What is the ramification of using this option?  "rev-list" and "gitk" will
still be fast but "pack-objects" won't get as much speed-up?  Will use of
the option affect correctness?  Can a slice generated with this option
later fused with another generated without this option?  What are the
performance (or correctness) characteristics of a resulting slice of such
a fuse?

If the target audience of this manual page is Porcelain writers and API
users, these things need to be explained somewhere in this documentation.

> +walk
> +~~~~
> +Walk a cache slice based on revision list, formatted like 'add'.

What is formatted like 'add'?  The output from the command?  The command
line arguments this subcommand takes?

Define "walk".  Is it "dump the contents of a slice"?  In a rev-cache with
more than one slice, which slice is chosen to be walked, and how?  How
does the command line argument and options interract with cached data?

For example...

> +Options:
> +
> +\--objects::
> +	Like 'git-rev-list', 'walk' will normally only list commits.  Use this
> +	option to list non-commit objects as well.

... how does walking with --objects option behave if you created all of
your slices with --no-objects?  Does it notice the lack of cached object
information and falls back on reading from the objects?  If so how is this
different from rev-list itself?  If not, when is the walk command useful?
"while debugging the rev-cache machinery" is a perfectly acceptable answer
to the last question, but if that is the case please say so in the
documentation.

> +fuse
> +~~~~
> +Merge several cache slices into a single large slice.  On each invocation of
> +'add' a new file ("slice") is added to the revision cache directory, and after
> +several additions the directory may become populated with many, relatively
> +small slices.  Numerous smaller slices will yield poorer performance than a one
> +or two large ones, because of the overhead of loading new slices into memory.

Something like this is a perfect overview description that should have
been given upfront (remember, I earlier said "Briefly discuss..."?).

This operation feels like "repack".

> +Running 'fuse' every once in a while will solve this problem by coalescing all
> +the cache slices into one larger slice.  For very large projects, using
> +\--ignore-size is advisable to prevent overly large cache slices.
> +
> +Options:
> +
> +\--all::
> +	Normally fuse will only include everything that's already in the
> +	revision cache.  \--add tells it to start walking from the branch
> +	heads, effectively an `add --all --fresh; fuse` (pseudo-command).
> +
> +\--noobjects::
> +	As in 'add', this option disables inclusion of non-commit objects.  If
> +	some cache slices do contain such objects, the information will be lost.
> +
> +\--ignore-size[=N]::
> +	Do not merge cache slices of size >=N.  If N is not provided 'fuse'
> +	will default to a size of ~25MB (be aware that slices must be mapped to
> +	memory).

Should this autotune, perhaps relative to pack.windowMemory?  --ignore
sounds misnomer; it is similar to "keep" flag that packfiles have.

> +index
> +~~~~~
> +Regenerate the cache index.  If the index file associating objects with cache
> +slices gets corrupted, lost, or otherwise becomes unusable, 'index' will
> +quickly regenerate the file.  'fuse' will also regenerate the index.

We already have .git/index (the index), and .git/objects/pack/pack-*.idx
(pack idx files).  At least please call this "the rev-cache index" so that
technical documentations can differentiate when they want to talk about
this new index without having to worry about disambiguities.

At the beginning of your DESCRIPTION, you mentioned "rev-cache", then
"cache slice", without explaining what they are, or how they relate to
each other, leaving frustration to the readers.  The reader who reads on,
suppressing this frustration, is finally rewarded at the beginning of
"fuse" description, where you mention that a rev-cache contains one or
more cache slices.  At that point, how these two concepts relate to each
other is finally revealed.

But here, you introduce a new frustration.  There is no meantion in how
the rev-cache index relates to the other two concepts introduced earlier
(the rev-cache itself, and cache slices).

When is this "reindex" operation necessary under normal circumstances?  Is
it primarily to recover bugs in rev-cache?  For example, "repack -a -f" is
not about recovering from bugs in "repack" but is a way to squeeze out
more redundancy from your pack because repeated "repack -a" may degrade
the pack efficiency over time.  Is "reindex" useful for a similar reason,
even when the rev-cache mechanism is bug-free?

> diff --git a/Documentation/technical/rev-cache.txt b/Documentation/technical/rev-cache.txt
> new file mode 100755

Executable documentation.

> index 0000000..78d7218
> --- /dev/null
> +++ b/Documentation/technical/rev-cache.txt
> @@ -0,0 +1,379 @@
> +rev-cache
> +=========
> +
> +The revision cache API ('rev-cache') provides a method for efficiently storing
> +and accessing commit branch sections.  Such branch slices are defined by a
> +series of top (interesting) and bottom (uninteresting) commits.  Each slice
> +contains, per commit:
> +
> +* All intra-slice topological relations, encoded into path "channels" (see
> +  'Mechanics' for full explanation).
> +* Object meta-data: type, SHA-1, size, date (for commits).
> +* Objects introduced in that commit, relative to slice (ie. only for non-start
> +  commits).

"introduced"?  That is a bit puzzling description to me, probably because
of an untold assumption.

Do you mean, in a two-commit history "B builds on top of root A", your
slice lists objects by traversing topology from the top, so commit A is
listed, and the tree and its subtrees and blobs are "introduced to the
slice", and then commit B is listed, along with its tree and associated
objects that have not been listed in the slice before commit B (namely,
objects commit B changed since commit A) are "introduced to the slice (by
commit B)"?

You can alley the above puzzlement by saying something like:

	Each slice stores information on commits and its associated
	objects, in the topological order traversing from the top
	commits.  For each commit, the following is recorded:

> +Storage data structures are not exported, in part to keep git's global scope
> +clean, but largely because they're pretty much useless outside of rev-cache.
> +
> +The API
> +-------
> +
> +The API for 'rev-cache' is quite simple.  You can find the function prototypes
> +in `revision.h`.

Drop the first sentence and leave the judging of simplicity to the reader.

> +Data Structures
> +~~~~~~~~~~~~~~~
> +
> +The `rev_cache_info` struct holds all the options and flags for the API.
> +
> +----
> +struct rev_cache_info {
> +        /* generation flags */
> +        unsigned objects : 1,
> +                legs : 1,
> +                make_index : 1;
> +        
> +        /* traversal flags */
> +        unsigned save_unique : 1,
> +                add_to_pending : 1,
> +                add_names : 1;
> +        
> +        /* fuse options */
> +        unsigned int ignore_size;
> +};
> +----
> +
> +The fields:
> +
> +`objects`::
> +	Add non-commit objects to slice.
> +
> +`legs`::
> +	Ensure end commits have no children.

What are "end commits"?

> +`make_index`::
> +	Integrate newly-made slice into index.
> +
> +`save_unique`::
> +	Load non-commit objects into `unique` field of their associated
> +	`commit` object.

What is "unique" field?  What is it used for?  Is it a list that can hold
many objects?

> +`add_to_pending`::
> +	Append unique non-commit objects to the `pending` object list in the
> +	passed `rev_info` instance.
> +
> +`add_names`::
> +	Include non-commit object names in the pending object entries (if
> +	`add_to_pending` is set), and set the `name` field of `blob` and `tree`
> +	objects (if `save_unique`).
> +
> +`ignore_size`::
> +	If non-zero, ignore slices with size greater or equal to this during
> +fusion.
> +
> +Functions
> +~~~~~~~~~
> +
> +`init_rci`::
> +        Initiate a `rev_cache_info` struct to default options.

"Initialize"?

Spell it out like "init_rev_cache_info()".  It's not like you will be
calling this over and over again, and "i" is ambiguous between rev cache
info and rev cache index.

> +`make_cache_slice`::
> +        Create a cache based on an a `rev_info` instance or `commit_list` s of
> +        "starts" and "ends" (defaulting to latter if `rev_info` pointer is
> +        NULL), copying the cache SHA-1 into a passed pointer if non-zero.  A

What's "cache SHA-1"?  I imagine that rev-cache consists of one or more
cache slices, and each slice is named after the hash value of its data,
but the documentation should not make _me_ guess.

Also a pointer is either NULL or non-NULL; it is never "zero".

> +        `rev_cache_info` struct pointer can be passed to set options, while
> +        passing NULL will set default options.  A last parameter can
> +        optionally recieve the final cache hash.

Is it just me who wish to see list of parameters on the head line, e.g.

	make_cache_slice(struct rev_info *, ...)::

to understand what the description is talking about better?

> +`make_cache_index`::
> +        Add a slice to the cache index.  Requires a file descriptor, the cache
> +        hash and the file size.  Note that this is normally called by
> +        `make_cache_slice` under the `make_index` option.

A file descriptor points at what file?  The index is written to that
descriptor?  The slice is read from the descriptor?  What is "cache hash"?
File size of what file is taken as parameter?

> +`get_cache_slice`::
> +        Given a commit SHA-1 `get_cache_slice` will search the slice index and
> +        return, if found, the cache-identifying SHA-1.

Is there a "slice index"?  How does it relate to "the cache index" the
earlier documentation mentioned in its description of the "index"
subcommand?

> +`traverse_cache_slice`::
> +        Traverse a specified cache slice based on:
> +
> +        * `rev_info` instance; options set in the `rev_cache_info` field.
> +        * cache SHA-1 identifier
> +        * a starting commit and commit work list
> +        * date of oldest encountered interesting commit (passing 0 will tell
> +          rev-cache to use defaults)
> +        * current `slop` (this is a counter, a la `revision.c`, to determine
> +          when to stop traversing; typically you can just pass 0 and rev-cache
> +          will use default settings)
> +        
> ++
> +The output is sent to a FILO `commit_list` "queue", while any end commits 
> +are passed back into the work list.  If the walk is not contained within the 
> +slice, commit boundaries are also inserted into "work".
> +
> +`start_from_slices`::
> +        Will mark all start-commits in the specified cache slices with a given
> +        flag, and add them to the rev pending list.  Will include all if no
> +        slices are specified.
> +
> +`coagulate_cache_slices`::
> +        Generate a slice based on the passed `rev_info` instance, replacing all
> +        encountered slices with one (larger) slice.  The `ignore_size` field in
> +        `rci`, if non-zero, will dictate which cache slice sizes to ignore in
> +        both traversal and replacement.

"coagulate"?  If you want to say "fuse", use that word consistently.

> +Some Internals
> +--------------
> +
> +Although you really don't need to know anything about how rev-cache actually
> +does its magic shizz, a bit of background may go a long way if you're wading
> +through the source.

Drop these three lines.  People know that already when they are reading
this section.

> +File Formats
> +~~~~~~~~~~~~
> +
> +A slice has a basic fixed-size header, followed by a certain number of object
> +entries, then a NULL-seperated list of object names.  Commits are sorted in
> +topo-order, and each commit entry is followed by the objects added in that
> +commit.

What's in the header?  Is there a version number?

> +struct object_entry {

Rename this to something more rev-cache specific, perhaps rev_cache_entry,
as the name is already used for different purposes in pack-objects and
fast-import.

> +        unsigned type : 3;
> +        unsigned is_end : 1;
> +        unsigned is_start : 1;
> +        unsigned uninteresting : 1;
> +        unsigned include : 1;
> +        unsigned flags : 1;
> +        unsigned char sha1[20];
> +        
> +        unsigned merge_nr : 6;
> +        unsigned split_nr : 7;
> +        unsigned size_size : 3;
> +        unsigned name_size : 3;
> +        unsigned what_to_do : 5;
> +        
> +        uint32_t date;
> +        uint16_t path;
> +        
> +        /* merge paths */
> +        /* split paths */
> +        /* size */
> +        /* name index */
> +};
> +----
> +
> +An explanation of each field:
> +
> +`type`::
> +	Object type
> +`is_end`::
> +	The commit has some parents outside the cache slice (all if slice has
> +	legs)
> +`is_start`::
> +	The commit has no children in cache slice

You said "top" and "bottom" in the documentation.  Perhaps use them
here as well for consistency?

> +`uninteresting`::
> +	Run-time flag, used in traversal
> +`include`::
> +	Run-time flag, used in traversal (initialization)
> +`flags`::
> +	Currently unused, extra bit
> +`sha`::
> +	Object SHA-1 hash

That's `sha1` if I am reading the above display correctly.

> +`merge_nr`::
> +	The number of paths the current channel diverges into; the current path
> +	ends upon any merge.
> +`split_nr`::
> +	The number of paths this commit ends; used on both merging and
> +	branching.

How will an overflowing situation handled?

> +`size_size`::
> +	Number of bytes the object size takes up.
> +`name_size`::
> +	Number of bytes the name index takes up.
> +`what_to_do`::
> +	Currently space-filler, to properly align the struct fields.  Can
> +	potentially be used for anything.

You seem to be assuming that 24-bit fields starting at merge_nr (begins at
offset 21) will be packed and it is Ok that after this filler field date
is aligned to multiple of 4.  I am not sure if that is a safe assumption.

We use 'unsigned long' for timestamps.  Is uint32_t sufficient?

What is `path` (not "merge paths" nor "split paths" you explain next)?
Is uint32_t sufficient?

> +merge paths::
> +	The path IDs (16-bit) that are to be created.
> +split paths::
> +	The path IDs (16-bit) that are to be ended.

Are 65536 paths sufficient?  How will an overflowing situation handled?

> +size::
> +	The size split into the minimum number of bytes.
> +name index::
> +	An offset for the null-seperated, object name list at the end of the
> +	cache slice.  Also split into the minimum number of bytes.

What does this mean?  1-to-8 bytes integer in network byte order?

Did you consider using the variable-length size representation used by the
pack object layer (cf. encode_header() in builtin-pack-objects.c and
unpack_object_header_buffer() in sha1_file.c)?

> +
> +Each path ID refers to an index in a 'path array', which stores the current
> +status (eg. active, interestingness) of each channel.
> +
> +Due to topo-relations and boundary tracking, all of a commit's parents must be
> +encountered before the path is reallocated.  This is achieved by using a
> +counter system per merge: starting at the parent number, the counter is
> +decremented as each parent is encountered (dictated by 'split paths'); at 0 the
> +path is cleared.
> +
> +Boundary tracking is necessary because non-commits are stored relative to the
> +commit in which they were introduced.  If a series of commits is not included
> +in the output, the last interesting commit must be parsed manually to ensure
> +all objects are accounted for.
> +
> +To prevent list-objects from recursing into trees that we've already taken care
> +of, the flag `FACE_VALUE` is introduced.  An object with this flag is not
> +explored (= "taken at face value"), significantly reducing I/O and processing
> +time.

> +(NSE)

You do not need this last line.  As 530e741 (Start preparing the API
documents., 2007-11-24) mention, these were pointers to people who may
know enough information to fill in _undocumented_ territory.  You
documented this API fairly completely.

Besides, nobody would know who NSE is ;-).  Back then, there were only
handful of people, all of whom can be ientified by short names, who were
responsible for large body of internal API code that needed further
documentation.
