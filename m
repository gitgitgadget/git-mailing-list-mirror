From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Status of the svn remote helper project (Dec 2010, #1)
Date: Sun, 5 Dec 2010 05:37:17 -0600
Message-ID: <20101205113717.GH4332@burratino>
References: <20101107112129.GA30042@burratino>
 <20101121063149.GA15449@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 05 12:37:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPCuZ-0002SH-GE
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 12:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272Ab0LELhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 06:37:41 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64188 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab0LELhj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 06:37:39 -0500
Received: by iwn6 with SMTP id 6so2041103iwn.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2F/k4p7gxB68fZGUpEIFwpz/Z17+5KdjuKFNimuVvw4=;
        b=SjsMJfk4SocwFirNfa5YKhe2ldHYClVNRFabMvSnJ2v8zGwB0Dmp8b+oDSn4AgA0y3
         C1xgY9vAskoLodIkonP2F8UDFNetiQQj537yxtZRZfqQ3NAJCueuHFw3NXYDFNagWNc+
         SKOxMhj15bNVlxpZccUgWEQcKrQjPzvZSpglo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hocP57SnLX1q6JrJqq5wlXJixuqKNKNNm2874+gGZWDhx3+y0ntDh5Nuwe8BWs4tlo
         Pkisg32tUblsZleJ8zAswoQSIjWklFeb7iZVBUo4f/tRK+fTzkr4XG+/MbKmZV6Sq8+Z
         oXKgRmmPRuVDJ8Y8GQuL/S221EqQcX0xtW+gY=
Received: by 10.231.17.141 with SMTP id s13mr4444096iba.11.1291549056925;
        Sun, 05 Dec 2010 03:37:36 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id gy41sm3833285ibb.23.2010.12.05.03.37.33
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 03:37:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101121063149.GA15449@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162943>

It's been a couple of months since I mentioned that it would be
possible for a simple svn remote helper on top of svn-fe to be usable
in a couple of weeks.  I still believe a read-only importer is _just_
within grasp; but there are plenty of tempting and interesting topics
to work on in the stack below that, too.

That said, the collection of topics cooking is already satisfying.
Time for cleaning up additional branches for the tree seems short;
patch series and branches that are ready for wider testing as-is would
be fantastic (and should be based on a merge of 'master' and as few of
the topics listed below as possible).

Excluding changes taken from the 'jch' branch, relative to last time
we have

 Makefile                          |    4 +-
 contrib/svn-fe/svn-filter-root.py |  107 ++++++++++++++++++++++++
 contrib/svn-fe/testme.sh          |    4 +-
 fast-import.c                     |  164 ++++++++++++++++++++++++++++++++++---
 t/t9011-svn-da.sh                 |   10 +-
 t/t9300-fast-import.sh            |    6 +-
 test-treap.c                      |   11 ++-
 vcs-svn/repo_tree.c               |    4 +-
 vcs-svn/sliding_window.c          |   11 ++-
 vcs-svn/trp.h                     |    3 +-
 vcs-svn/trp.txt                   |   10 ++-
 11 files changed, 298 insertions(+), 36 deletions(-)

The added fast-import code implements the 'ls' command.

Most of the changes are one-liners and small cleanups.  The most
visible change in practice should be the fix for the mysterious
historical-files-appearing-as-directories bug in repo_tree.

As always, a merge of the branches listed below is available as

	git://repo.or.cz/git/jrn.git vcs-svn-pu

and individual topic branches are also available in that repository
under the refs/topics namespace.

--------------------------------------------------
[Cooking]
* jn/svndiff0 (2010-11-06) 24 commits
- vcs-svn: Allow deltas to copy from preimage
- vcs-svn: Reject deltas that read past end of preimage
- vcs-svn: Let deltas use data from postimage
- vcs-svn: Reject deltas that do not consume all inline data
- vcs-svn: Check declared number of output bytes
- vcs-svn: Implement copyfrom_data delta instruction
- vcs-svn: Read instructions from deltas
- vcs-svn: Read inline data from deltas
- vcs-svn: Read the preimage while applying deltas
- vcs-svn: Skeleton of an svn delta parser
- compat: helper for detecting unsigned overflow
- vcs-svn: Learn to check for SVN\0 magic
- vcs-svn: Learn to parse variable-length integers
- vcs-svn: Add code to maintain a sliding view of a file
- vcs-svn: Allow character-oriented input
- vcs-svn: Allow input errors to be detected early
- vcs-svn: Let callers peek ahead to find stream end
- vcs-svn: Add binary-safe read() function
- vcs-svn: Improve support for reading large files
- vcs-svn: Make buffer_skip_bytes() report partial reads
- vcs-svn: Teach line_buffer to handle multiple input files
- vcs-svn: Collect line_buffer data in a struct
- vcs-svn: Replace buffer_read_string() memory pool with a strbuf
- vcs-svn: Eliminate global byte_buffer[] array

Well tested and should be ready for wide use.

Is there some tool (a hex editor?) that can be used to easily read
and write deltas?  The "printf and test against 'svnadmin load'"
method is a bit time confusing.

* db/recognize-v3 (2010-11-20) 2 commits
- vcs-svn: Allow simple v3 dumps (no deltas yet)
- vcs-svn: Error out for v3 dumps

A bugfix and the framework for a feature.  Probably the bugfix
should be pushed toward 'maint'.

* db/prop-delta (2010-11-20) 16 commits
- vcs-svn: Simplify handling of deleted properties
- vcs-svn: Implement Prop-delta handling
- vcs-svn: Sharpen parsing of property lines
- vcs-svn: Split off function for handling of individual properties
- vcs-svn: Make source easier to read on small screens
- vcs-svn: More dump format sanity checks
- vcs-svn: Reject path nodes without Node-action
- vcs-svn: Delay read of per-path properties
- vcs-svn: Combine repo_replace and repo_modify functions
- vcs-svn: Replace = Delete + Add
- vcs-svn: handle_node: Handle deletion case early
- vcs-svn: Use mark to indicate nodes with included text
- vcs-svn: Unclutter handle_node by introducing have_props var
- vcs-svn: Eliminate node_ctx.mark global
- vcs-svn: Eliminate node_ctx.srcRev global
- vcs-svn: Check for errors from open()
(this branch uses db/recognize-v3.)

All but the tip commit are from 'pu'.

* db/fast-import-blob-access (2010-12-04) 5 commits
- fast-import: add 'ls' command
- fast-import: Allow cat-blob requests at arbitrary points in stream
- fast-import: let importers retrieve blobs
- fast-import: clarify documentation of "feature" command
- fast-import: stricter parsing of integer options

A proof of concept for the protocol targetting another repository
format (hg?) would be a great comfort.

Synchronization overhead seems to be a big problem.  If someone can
use "top -b" output to produce a nice timechart explaining this then
I would be happy to take a look.

* db/fast-import-object-reuse (2010-11-24) 1 commit
- fast-import: insert new object entries at start of hash bucket

A speedup.  Acked by Shawn, taken from 'pu'.

* jn/fast-import-ondemand-checkpoint (2010-11-24) 1 commit
- fast-import: treat SIGUSR1 as a request to access objects early

Taken from 'pu'.

* jn/svn-fe-makefile (2010-12-04) 1 commit
- Makefile: dependencies for vcs-svn tests

Seems to have been forgotten?  Simplified commit message, otherwise
unchanged.

* xx/thinner-wrapper-svndiff0 (2010-11-07) 1 commit
- svn-fe: stop linking to libz and libxdiff
(this branch uses jn/svndiff0 and jn/thinner-wrapper.)

Simplification.  jn/thinner-wrapper is part of 'jch'.

* rr/svnfe-tests-no-perl (2010-11-23) 1 commit
- t9010 (svn-fe): Eliminate dependency on svn perl bindings

>From 'pu'.

* db/text-delta (2010-11-20) 10 commits
- fixup! vcs-svn: tweak sliding window code to tolerate excessive
  readahead
- fixup! svn-fe: Test script for handling of dumps with --deltas
- svn-fe: Test script for handling of dumps with --deltas
- vcs-svn: Implement text-delta handling
- vcs-svn: Teach line_buffer about temporary files
- vcs-svn: tweak sliding window code to tolerate excessive readahead
- vcs-svn: Let caller set up sliding window for delta preimage
- vcs-svn: Read delta preimage from file descriptor
- vcs-svn: Introduce fd_buffer routines
- vcs-svn: Introduce repo_read_path to check the content at a path
- vcs-svn: Internal fast_export_save_blob helper
- Merge branch 'db/fast-import-blob-access' (early part) into
  db/text-delta
- Merge branch 'jn/svndiff0' into db/text-delta
(this branch uses db/recognize-v3, db/prop-delta, db/fast-import-blob-access,
and jn/svndiff0.)

It works!

* db/svn-extract-branches (2010-11-20) 1 commit
- svn-fe: Script to remap svn history

Very rough but let's merge it so it doesn't get forgotten.

* jn/maint-svn-fe (2010-12-05) 2 commits
- vcs-svn: fix intermittent repo_tree corruption
- treap: make treap_insert return inserted node

Fixes an old bug.  Hoping for feedback or an ack from someone familiar
svn-fe internals; afterwards, would fast-track to maint.

---------------------------------------------------
[Graduated]
* jn/thinner-wrapper (2010-11-06) 7 commits
 - Remove pack file handling dependency from wrapper.o
 - pack-objects: mark file-local variable static
 - wrapper: give zlib wrappers their own translation unit
 - strbuf: move strbuf_branchname to sha1_name.c
 - path helpers: move git_mkstemp* to wrapper.c
 - wrapper: move odb_* to environment.c
 - wrapper: move xmmap() to sha1_file.c

Part of 'jch' now.

--------------------------------------------------
[Out of tree, stalled]

* tc/remote-helper-usability: $gmane/157860
 . Register new packs after the remote helper is done fetching
 . Properly record history of the notes ref
 . Fix ls-remote output when displaying impure refs
 . Add git-remote-svn
 . Introduce the git fast-import-helper
 . Rename get_mode() to decode_tree_mode() and export it
 . Allow the transport fetch command to add additional refs
 . Allow more than one keepfile in the transport
 . Remote helper: accept ':<value> <name>' as a response to 'list'

The fourth-from-top seems a bit hard to review.  If it really is
necessary to introduce a separate program with a separate interface,
maybe a compile-time flag to choose between them would help?

* rr/remote-helper: http://github.com/artagnon/git
 . remote-svn: Write in fetch functionality
 . run-command: Protect the FD 3 from being grabbed
 . remote-svn: Build a pipeline for the import using svnrdump
 . run-command: Extend child_process to include a backchannel FD
 . Allow the transport fetch command to add additional refs
 . Remote helper: accept ':<value> <name>' as a response to 'list'
 . test-svn-fe: Allow for a dumpfile on stdin
 . contrib/svn-fe: Fast script to remap svn history
 . Add Tom's remote helper for reference
 . Add a stubby remote-svn remote helper
 . Add a correct svndiff applier

Work in progress, waiting on lower levels to be more functional
(in particular, svn-fe does not support incremental imports yet).

* sb/svn-fe-example: $gmane/159054
