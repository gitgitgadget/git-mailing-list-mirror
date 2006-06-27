From: Junio C Hamano <junkio@cox.net>
Subject: Notes on diffcore API
Date: Tue, 27 Jun 2006 00:28:03 -0700
Message-ID: <7virmn9hx8.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060626233838.GA3121@steel.home>
	<7v4py7h2b9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 09:28:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv7zZ-0000kT-HZ
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 09:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWF0H2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 03:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWF0H2G
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 03:28:06 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40618 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932605AbWF0H2E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 03:28:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060627072804.BMLT554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Jun 2006 03:28:04 -0400
To: Alex Riesen <raa.lkml@gmail.com>,
	Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <7v4py7h2b9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 26 Jun 2006 17:25:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22708>

I really should have done this six months ago, but I guess being
late is much better than never...

Somebody might want to do proper asciidoc and throw it in
Documentation/technical/.

-- >8 --
Notes on diffcore API
=====================

The diff generation mechanism in git is designed to be
self-contained and you should be able to call it as set of
library functions, unlike other parts of the system where "we
run once and let exit() to clean up afterwards" mentality is
dominant.  This is mainly because from early on "diff-tree
--stdin" needed to be able to process hundreds of parent-child
tree pairs without leaking.

NOTE: this note does not describe how combined diff works.  It
is quite a different animal.

The diffcore machinery works in 4 phases:

 1. setting up the machinery, including command line parsing.
 2. feeding input pairs to the machinery.
 3. letting it munge input pairs.
 4. flushing the output.

The first phase sets up the operational parameters (e.g. use of
rename detector, output format).  The second phase feeds pairs
of 'old' and 'new' files to the machinery as the front-end finds
them (e.g. diff-files compares each path found in the index and
in the working tree, and feeds the information from the index as
'old' and the information from the working tree as 'new';
diff-tree compares entries in two trees or entries in the tree
of the first parent commit and the tree of the commit).  In the
third phase, the pairs collected in the previous phase are
split, matched up, and filtered to form a different set of
pairs.  The last phase formats the resulting set of pairs for
the output.

Setting it up
-------------

The diffcore machinery takes one structure, `struct diff_options`,
to record the set of options that affects its behaviour.  These
options affect different parts of its operation, but can roughly
be classified into three groups: the ones that affects how the
input set of pairs are transformed in phase 3, and the ones that
affects how the resulting set of pairs are formatted in phase 4.

First call diff_setup() to initialize the diff_options
structure.  This gives the minimum default set of options:

 - output format defaults to --raw format;
 - output lines are LF terminated;
 - no diffcore transformation (phase 3) is used;

If you are writing a top-level diff command, you can then call
diff_opt_parse() to parse the common diff options and fill the
information in diff_options structure, but if your usage does
not require end-user customizability, you can set up the fields in
diff_options yourself without calling this function.

Then call diff_setup_done() -- this makes sure the set of
options are consistent and derives a reasonable default
(e.g. --find-copies-harder without -C does not make sense, patch
output is always recursive).


Feeding Input
-------------

Your main program feeds 'file pairs' to the diffcore machinery
by using these three functions: diff_addremove(), diff_change()
and diff_unmerge().  The first one records a path appears not in
'old' tree but in 'new' tree (or vice versa), the second one
records a path is different between 'old' and 'new', and the
third one says the comparison is meaningless for the path
because it is unmerged (this is only used by diff-index and
diff-files).

When you want to do something diff-tree does, which is quite
common, you can give two tree object names to diff_tree_sha1()
function and let it walk the trees and call these functions for
you.

To signal the end of input, call `diffcore_std()`.  This
starts the diffcore transformation described next.


Diffcore Transformation
-----------------------

The input file pairs recorded in the previous phase are
collected in diff_queued_diff (a global variable -- which means
that you cannot have two diffs running in parallel with the
current setup).  This is an expandable array of pointers to
`struct diff_filepair` structure.

The `struct diff_filepair` structure has (as the name suggests)
two pointers to `struct diff_filespec` to record the 'old' and
the 'new' file in this pair (the old one is called 'one', and
the new one 'two'), along with some information used by various
diffcore transformation.  `struct diff_filespec` records the
blob object name, pathname, size and mode among other things.
Two things to watch out for are:

 - a non-existent path is denoted by mode=0 (e.g. in a filepair
   for a deleted file, one->mode != 0 and two->mode == 0).

 - 0{40} SHA-1 is used when the filespec talks about the file in
   the working tree.


Documentation/diffcore.txt should be consulted for the details
of what each transformation does.  A short version:

 - diffcore-break breaks a filepair that modifies 'one' to 'two'
   into two filepairs that deletes 'one' and creates 'two' if
   'one' and 'two' are sufficiently dissimilar.

 - diffcore-rename matches up a filepair that deletes 'one' and
   another filepair that creates 'two' and makes them into one
   filepair.

 - diffcore-merge-broken picks up two filepairs that were
   originally one but broken by diffcore-break but did not get
   matched up by diffcore-rename.

 - diffcore-pickaxe filters out filepairs whose 'one' and 'two'
   have the same number of occurrences of the specified string.

 - diffcore-order reorders the resulting filepairs according to
   the given input.

 - after all of the above, --diff-filter is applied to remove
   the uninteresting classes of output (e.g. --diff-filter=A
   shows only additions).


Flushing output
---------------

After diffcore transformation runs, the result is still in the
same diff_queued_diff variable.  Before calling the standard
output routines, you can inspect each file pair in the queue to
see its status (e.g. what renames to what).

Especially interesting is the 'status' field of the filepair
structure.  At this point in the processing chain, each file
pair is marked with `M` (modified), `C` (copied), `R` (renamed),
etc.

Once you are done, calling diff_flush() to perform the output
and free the data structure.  If you ran the diff primarily
because you wanted to read the diff_queued_diff and you do not
want any output from this phase, set the putput_format to
DIFF_FORMAT_NO_OUTPUT before calling diff_flush() -- otherwise
you would leak memory the big way.

The raw, patch-text, diffstat and summary output all happens in
this final phase; recent work to make --patch, --stat, --raw
etc.  independent flags by Timo are primarily about phase 2 and
this phase.
