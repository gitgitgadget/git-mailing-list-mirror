From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Status of the svn remote helper project (Jan 2011, #1)
Date: Wed, 5 Jan 2011 17:39:15 -0600
Message-ID: <20110105233915.GB22975@burratino>
References: <20101107112129.GA30042@burratino>
 <20101121063149.GA15449@burratino>
 <20101205113717.GH4332@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 00:39:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pacx2-0007jD-E3
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 00:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab1AEXj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 18:39:27 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60007 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab1AEXj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 18:39:26 -0500
Received: by qwa26 with SMTP id 26so16220998qwa.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 15:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+Q/z3nN3WOC8N068ilRfBXbudAdAqCbPOXN2ychnYF8=;
        b=k2TU6nCD3LTfZvtqboOpnsNWfJnGHDnj/TQ5yDBmUuBoKld2sRUK4uQzmfietMOPJP
         RVuAbOqxWA5u/8S7obhFTUZZU4pNAee/diy5fTUU4wJaDdWlL9qzXGdwX25hysahnbX0
         rRRvpqSuh3IWzsYwgaD8D8xvneM9BQuVS/2EE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RT6sqvl40WQlklmQFNUvkaa1tzlpYnvGnzzeaDRRDIL7gRgUkcdVOGSGI6+9+NvzK0
         bf8ZdKTOqqjtq7NsjLIZNEhs5rk2zBaEwcjZGVeVTMcJqzKUlbdn0Pif9QvgRFr43GdR
         W/wayNFGekMaqtNfvhlZQRLlN8j8NIwt7v9do=
Received: by 10.224.73.137 with SMTP id q9mr22785866qaj.53.1294270764947;
        Wed, 05 Jan 2011 15:39:24 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id g32sm13929652qck.22.2011.01.05.15.39.21
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Jan 2011 15:39:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101205113717.GH4332@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164611>

Here are the topics that are cooking in vcs-svn-pu.

Hopefully v1.7.4-rc0 is treating you well and free git time has been
going into finding and fixing regressions.  So if you are bored and
looking for something to do, please skip to [1] and ignore the rest of
this message.

December was a busy month.  Excluding changes from the 'jch' branch:

 39 files changed, 1472 insertions(+), 2020 deletions(-)

That breaks down as

   1.7% Documentation/
   1.8% contrib/svn-fe/
  17.5% t/
  65.4% vcs-svn/

The other 13%:

 .gitignore                        |    3 -
 Makefile                          |   17 +--
 fast-import.c                     |  134 ++++++++-----
 quote.h                           |    3 +-

Users will probably notice that svn-fe requires ls and cat-blob
support from fast-import (alas); hopefully the lower memory footprint,
code simplification and incremental import support can justify that
cost.

The fast-import changes are a mixture of enhancements to the "ls"
command and general optimizations.  The optimizations are not in their
final form and likely have bugs but are being sent out now for some
early exposure.

As always, a merge of the branches listed below is available as

	git://repo.or.cz/git/jrn.git vcs-svn-pu

and individual topic branches are available in that repository under
the refs/topics namespace.

Let's get svn-fe3 polished so when the next merge window comes around
it is ready to be merged quickly.  

--------------------------------------------------
[Graduated to "master"]
* db/fast-import-object-reuse (2010-11-24) 1 commit
 - fast-import: insert new object entries at start of hash bucket

* jn/fast-import-ondemand-checkpoint (2010-11-24) 1 commit
 - fast-import: treat SIGUSR1 as a request to access objects early

* jn/svn-fe-makefile (2010-12-04) 1 commit
 - Makefile: dependencies for vcs-svn tests

* rr/svnfe-tests-no-perl (2010-11-23) 1 commit
 - t9010 (svn-fe): Eliminate dependency on svn perl bindings

* jn/maint-svn-fe (2010-12-05) 2 commits
 - vcs-svn: fix intermittent repo_tree corruption
 - treap: make treap_insert return inserted node

* db/fast-import-blob-access (2010-12-04) 4 commits
 - fast-import: Allow cat-blob requests at arbitrary points in stream
 - fast-import: let importers retrieve blobs
 - fast-import: clarify documentation of "feature" command
 - fast-import: stricter parsing of integer options

The old tip commit that adds an 'ls' command was reworked (see below).

* jn/fast-import-ondemand-checkpoint (2010-11-24) 1 commit
 - fast-import: treat SIGUSR1 as a request to access objects early

--------------------------------------------------
[New Topics]
* jn/line-buffer-error (2010-12-28) 4 commits
 - vcs-svn: improve reporting of input errors
 - vcs-svn: make buffer_copy_bytes return length read
 - vcs-svn: make buffer_skip_bytes return length read
 - vcs-svn: allow input errors to be detected promptly

>From jn/svndiff0 but expanded, waiting for feedback from the list.
These let the calling function take care of reporting the error with
more context; is that worth it or would it make more sense to die()
directly?

* jn/line-buffer-large-file (2010-12-24) 1 commit
 - vcs-svn: improve support for reading large files

>From jn/svndiff0.  Will merge soon if there are no objections.

* jn/line-buffer (2011-01-02) 14 commits
 - Merge branch 'jn/line-buffer-large-file' into jn/line-buffer
 - Merge branch 'jn/line-buffer-error' into jn/line-buffer
 - vcs-svn: teach line_buffer about temporary files
 - vcs-svn: allow input from file descriptor
 - vcs-svn: allow character-oriented input
 - vcs-svn: add binary-safe read function
 - t0081 (line-buffer): add buffering tests
 - vcs-svn: tweak test-line-buffer to not assume line-oriented input
 - tests: give vcs-svn/line_buffer its own test script
 - vcs-svn: make test-line-buffer input format more flexible
 - vcs-svn: teach line_buffer to handle multiple input files
 - vcs-svn: collect line_buffer data in a struct
 - vcs-svn: replace buffer_read_string memory pool with a strbuf
 - vcs-svn: eliminate global byte_buffer
 (this branch uses jn/line-buffer-error and jn/line-buffer-large-file.)

>From jn/svndiff0 and db/text-delta.  Putting temporary files with
meaningless names in /tmp is unfortunate (maybe buffer_tmpfile_init
could use a filename prefix argument?).

* jn/unsigned-overflow (2010-12-25) 1 commit
 - compat: helper for detecting unsigned overflow

>From jn/svndiff0.  Should submit for separate inclusion.

* jn/sliding-window (2011-01-02) 1 commit
 - vcs-svn: learn to maintain a sliding view of a file
 (this branch uses jn/line-buffer, jn/line-buffer-error, and
  jn/line-buffer-large-file.)

>From jn/svndiff0 but clarified somewhat.

* db/vcs-svn-incremental (2011-01-05) 20 commits
 - svn-fe: WIP testme.sh performance enhancements
 - svn-fe: testme.sh update
 - vcs-svn: use mark from previous import for parent commit
 - vcs-svn: handle filenames with dq correctly
 - vcs-svn: quote paths correctly for ls command
 - vcs-svn: eliminate repo_tree structure
 - vcs-svn: add a comment before each commit
 - vcs-svn: simplify repo_modify_path and repo_copy
 - vcs-svn: prepare to eliminate repo_tree structure
 - vcs-svn: do not rely on marks for old blobs
 - vcs-svn: split off function to export result from delta application
 - vcs-svn: make apply_delta caller retrieve preimage
 - vcs-svn: explicitly close streams used for delta application at exit
 - vcs-svn: introduce cat_mark function to retrieve a marked blob
 - vcs-svn: save marks for imported commits
 - vcs-svn: use higher mark numbers for blobs
 - vcs-svn: check for errors reading from cat-blob-fd
 - quote.h: simplify the inclusion
 - Makefile: update dependencies for test-svn-fe.c
 - Merge branch 'db/fast-import-blob-access' into db/vcs-svn-incremental
 (this branch uses db/text-delta, db/prop-delta, jn/svndiff0,
  jn/sliding-window, jn/line-buffer, jn/line-buffer-error,
  jn/line-buffer-large-file, and db/fast-import-blob-access.)

Support for importing different revs in different svn-fe runs.

* db/optimize-vcs-svn (2011-01-05) 9 commits
 - vcs-svn: use strchr to find RFC822 delimiter
 - vcs-svn: drop obj_pool.h
 - vcs-svn: drop trp.h
 - vcs-svn: drop string_pool
 - vcs-svn: factor out usage of string_pool
 - vcs-svn: implement perfect hash for top-level keys
 - vcs-svn: implement perfect hash for node-prop keys
 - vcs-svn: avoid using ls command twice
 - vcs-svn: pass paths through to fast-import
 (this branch uses db/vcs-svn-incremental, db/text-delta, db/prop-delta,
  jn/svndiff0, jn/sliding-window, jn/line-buffer, jn/line-buffer-error,
  jn/line-buffer-large-file, and db/fast-import-blob-access.)

The diffstat says it all. ;-)

* db/optimize-fast-import (2011-01-05) 3 commits
 - WIP
 - WIP
 - WIP Hash/bitmap combo
 (this branch uses db/fast-import-blob-access.)

Very rough.  Testers beware.

I suspect "struct hash_table" may provide a simpler approach to
avoiding filling fast-import's tables.

--------------------------------------------------
[Cooking]
* jn/svndiff0 (2011-01-05) 11 commits
 - vcs-svn: microcleanup in svndiff0 window-reading code
 - vcs-svn: let deltas use data from preimage
 - vcs-svn: let deltas use data from postimage
 - vcs-svn: verify that deltas consume all inline data
 - vcs-svn: implement copyfrom_data delta instruction
 - vcs-svn: read instructions from deltas
 - vcs-svn: read inline data from deltas
 - vcs-svn: read the preimage when applying deltas
 - vcs-svn: parse svndiff0 window header
 - vcs-svn: skeleton of an svn delta parser
 - Merge branch 'jn/unsigned-overflow' into jn/svndiff0
 (this branch uses jn/sliding-window, jn/line-buffer,
  jn/line-buffer-error, and jn/line-buffer-large-file.)

Well tested and should be ready for wide use.

Is there some tool (a hex editor?) that can be used to read and write
deltas?  The "printf and test against 'svnadmin load'" method is a bit
time confusing.

* db/prop-delta (2010-12-09) 18 commits
 - vcs-svn: Simplify handling of deleted properties
 - vcs-svn: Allow change nodes for root of tree (/)
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
 - Allow simple v3 dumps (no deltas yet)

All but the tip commit are in 'jch'.

* db/fast-import-blob-access (2011-01-03) 3 commits
 - fast-import: add 'ls' command
 - fast-import: treat filemodify with empty tree as delete
 - fast-import: clarify handling of cat-blob feature

A proof of concept for 'cat-blob' and 'ls' support targetting another
repository format (hg?) would be a great comfort.

Synchronization overhead seems to be a problem.  If someone can use
"top -b" output to produce a nice timechart then I would be happy to
take a look.

* db/text-delta (2011-01-04) 5 commits
 - svn-fe: Test script for handling of dumps with --deltas
 - vcs-svn: implement text-delta handling
 - vcs-svn: introduce repo_read_path to check the content at a path
 - Merge branch 'db/prop-delta' into db/text-delta
 - Merge branch 'jn/svndiff0' into db/text-delta
 (this branch uses db/prop-delta, jn/svndiff0, jn/sliding-window,
  jn/line-buffer, jn/line-buffer-error, and jn/line-buffer-large-file.)

Still seems to work. ;-)

* db/svn-extract-branches (2010-11-20) 1 commit
 - svn-fe: Script to remap svn history

Very rough but let's merge it so it doesn't get forgotten.

--------------------------------------------------
[Ejected]
* db/recognize-v3 (2010-11-20) 1 commit
 - vcs-svn: Allow simple v3 dumps (no deltas yet)

Not worth maintaining as a separate branch from db/prop-delta.

* xx/thinner-wrapper-svndiff0 (2010-11-07) 1 commit
 - svn-fe: stop linking to libz and libxdiff
 (this branch used jn/svndiff0.)

Fixed when jn/svndiff0 was rebased on top of jn/thinner-wrapper.

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

I here there has been some work to make this work with the usual
fast-import.

* rr/remote-helper: http://github.com/artagnon/git
 . [WIP] Temporary commit
 . remote-svn: Write in fetch functionality
 . run-command: Protect the FD 3 from being grabbed
 . remote-svn: Build a pipeline for the import using svnrdump
 . run-command: Extend child_process to include a backchannel FD
 . Allow the transport fetch command to add additional refs
 . Remote helper: accept ':<value> <name>' as a response to 'list'
 . test-svn-fe: Allow for a dumpfile on stdin
 . Add Tom's remote helper for reference
 . Add a stubby remote-svn remote helper
 . Add a correct svndiff applier

Work in progress, waiting on lower levels to stabilize.

* sb/svn-fe-example: $gmane/159054

[1] Debian: 8 reports[2]
    Fedora: 6 reports[3]
    Gentoo: 1 report[4]
[2] http://bugs.debian.org/cgi-bin/pkgreport.cgi?src=git;include=tags:upstream;exclude=tags:fixed-upstream;exclude=severity:wishlist
[3] https://bugzilla.redhat.com/buglist.cgi?component=git&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED
[4] http://bugs.gentoo.org/buglist.cgi?short_desc_type=allwordssubstr&short_desc=dev-vcs/git&product=Gentoo+Linux&bug_status=UNCONFIRMED&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED
