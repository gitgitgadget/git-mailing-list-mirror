From: Jeff King <peff@peff.net>
Subject: [PATCH 0/67] war on sprintf, strcpy, etc
Date: Tue, 15 Sep 2015 11:21:26 -0400
Message-ID: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:21:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbs35-0003Zq-5f
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbbIOPVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:21:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:59261 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752060AbbIOPV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:21:29 -0400
Received: (qmail 10971 invoked by uid 102); 15 Sep 2015 15:21:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:21:29 -0500
Received: (qmail 6678 invoked by uid 107); 15 Sep 2015 15:21:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:21:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:21:26 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277901>

The git code contains a lot of calls to sprintf, strcpy, and other
unchecked string functions. In many cases, these aren't actually
overflows, because some earlier part of the code implies that the copied
content is smaller than the destination buffer. But it's often hard to
tell, because the code enforcing that assumption is far away, or there's
a complicated expression to create a buffer. This makes it difficult to
audit git for buffer overflows, because you can spend a lot of time
chasing down false positives.

My goal with this series was to not only audit each of these sites for
overflows, but to convert them to more modern constructs (e.g.,
strbufs), so that it's easier to do more audits going forward.

There are quite a large number of changes. I've tried to group similar
changes together to make reviewing easier. Here's a rough breakdown:

  [01/67]: show-branch: avoid segfault with --reflog of unborn branch
  [02/67]: mailsplit: fix FILE* leak in split_maildir
  [03/67]: archive-tar: fix minor indentation violation
  [04/67]: fsck: don't fsck alternates for connectivity-only check

    These are minor bugfixes that I found while digging into various
    call-sites. There's no semantic dependency, but some of the later
    patches depend on these textually.

  [05/67]: add xsnprintf helper function
  [06/67]: add git_path_buf helper function
  [07/67]: strbuf: make strbuf_complete_line more generic
  [08/67]: add reentrant variants of sha1_to_hex and find_unique_abbrev

    These four patches introduce infrastructure that will help later
    cleanups (alongside existing tools like strbuf, xstrfmt, etc).

  [09/67]: fsck: use strbuf to generate alternate directories
  [10/67]: mailsplit: make PATH_MAX buffers dynamic
  [11/67]: trace: use strbuf for quote_crnl output
  [12/67]: progress: store throughput display in a strbuf
  [13/67]: test-dump-cache-tree: avoid overflow of cache-tree name
  [14/67]: compat/inet_ntop: fix off-by-one in inet_ntop4

    These cases are all things that _can_ overflow, given the right
    input. But none of them is interesting security-wise because,
    because their input is not typically attacker-controlled.

  [15/67]: convert trivial sprintf / strcpy calls to xsnprintf
  [16/67]: archive-tar: use xsnprintf for trivial formatting
  [17/67]: use xsnprintf for generating git object headers
  [18/67]: find_short_object_filename: convert sprintf to xsnprintf
  [19/67]: stop_progress_msg: convert sprintf to xsnprintf
  [20/67]: compat/hstrerror: convert sprintf to snprintf
  [21/67]: grep: use xsnprintf to format failure message
  [22/67]: entry.c: convert strcpy to xsnprintf
  [23/67]: add_packed_git: convert strcpy into xsnprintf
  [24/67]: http-push: replace strcat with xsnprintf
  [25/67]: receive-pack: convert strncpy to xsnprintf

    These cases can all be fixed by using the newly-added xsnprintf. The
    trivial conversions are in patch 15, and the rest are cases that
    needed a little more cleanup or explanation.

  [26/67]: replace trivial malloc + sprintf /strcpy calls to xstrfmt
  [27/67]: config: use xstrfmt in normalize_value
  [28/67]: fetch: replace static buffer with xstrfmt
  [29/67]: use strip_suffix and xstrfmt to replace suffix
  [30/67]: ref-filter: drop sprintf and strcpy calls
  [31/67]: help: drop prepend function in favor of xstrfmt
  [32/67]: mailmap: replace strcpy with xstrdup
  [33/67]: read_branches_file: replace strcpy with xstrdup

    Ditto, but for xstrfmt/xstrdup.

  [34/67]: resolve_ref: use strbufs for internal buffers
  [35/67]: upload-archive: convert sprintf to strbuf
  [36/67]: remote-ext: simplify git pkt-line generation
  [37/67]: http-push: use strbuf instead of fwrite_buffer
  [38/67]: http-walker: store url in a strbuf
  [39/67]: sha1_get_pack_name: use a strbuf
  [40/67]: init: use strbufs to store paths
  [41/67]: apply: convert root string to strbuf
  [42/67]: transport: use strbufs for status table "quickref" strings
  [43/67]: merge-recursive: convert malloc / strcpy to strbuf
  [44/67]: enter_repo: convert fixed-size buffers to strbufs
  [45/67]: remove_leading_path: use a strbuf for internal storage
  [46/67]: write_loose_object: convert to strbuf
  [47/67]: diagnose_invalid_index_path: use strbuf to avoid strcpy/strcat

    Ditto, but for strbufs. I generally used xstrfmt over a strbuf where
    it was feasible, since the former is shorter. These cases typically
    did something a little more complicated than xstrfmt could handle.

  [48/67]: fetch-pack: use argv_array for index-pack / unpack-objects
  [49/67]: http-push: use an argv_array for setup_revisions
  [50/67]: stat_tracking_info: convert to argv_array
  [51/67]: daemon: use cld->env_array when re-spawning

    Ditto, but for argv_array. This helps regular overflows, because
    argv_array_pushf uses a strbuf internally. But it also prevents
    overflowing the array-of-pointers.

  [52/67]: use sha1_to_hex_to() instead of strcpy
  [53/67]: drop strcpy in favor of raw sha1_to_hex

    Ditto, but for the new sha1-formatting helpers.

  [54/67]: color: add overflow checks for parsing colors
  [55/67]: use alloc_ref rather than hand-allocating "struct ref"
  [56/67]: avoid sprintf and strcpy with flex arrays
  [57/67]: receive-pack: simplify keep_arg computation
  [58/67]: help: clean up kfmclient munging
  [59/67]: prefer memcpy to strcpy
  [60/67]: color: add color_set helper for copying raw colors
  [61/67]: notes: document length of fanout path with a constant
  [62/67]: convert strncpy to memcpy

    These are ones that I couldn't fit it any other slot. :)

  [63/67]: fsck: drop inode-sorting code
  [64/67]: Makefile: drop D_INO_IN_DIRENT build knob
  [65/67]: fsck: use for_each_loose_file_in_objdir

    Another complicated case. The memory cleanups are in the third patch
    here, but the other two are preparatory.

  [66/67]: use strbuf_complete to conditionally append slash
  [67/67]: name-rev: use strip_suffix to avoid magic numbers

    And these are just minor code cleanups I ran into along the way.

Obviously this is not intended for v2.6.0. But all of the spots touched
here are relatively quiet right now, so I wanted to get it out onto the
list.  There are a few minor conflicts against "pu", but they're all
just from touching nearby lines.

-Peff
