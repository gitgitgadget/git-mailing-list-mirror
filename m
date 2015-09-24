From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/68] war on sprintf
Date: Thu, 24 Sep 2015 17:02:25 -0400
Message-ID: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:02:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDfD-0005DF-5k
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbbIXVC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:02:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:35890 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752523AbbIXVC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:02:28 -0400
Received: (qmail 11624 invoked by uid 102); 24 Sep 2015 21:02:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:02:27 -0500
Received: (qmail 28767 invoked by uid 107); 24 Sep 2015 21:02:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:02:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:02:25 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278559>

This is a revised version of the series I sent earlier[1].

For those just joining us, the goal is to remove sprintf, strcpy, etc,
to make it easier to audit the code base for buffer overflows. I've been
addressing review comments for individual patches as the discussion
progressed, so there's nothing here that hasn't been on the list (and I
think I've addressed all of the comments from the first round of
review).

Here's a list of the commits, with an overview[2] of the changes from v1
(patches without comment are the same as in v1):

  [01/68]: show-branch: avoid segfault with --reflog of unborn branch
  [02/68]: mailsplit: fix FILE* leak in split_maildir
  [03/68]: archive-tar: fix minor indentation violation
  [04/68]: fsck: don't fsck alternates for connectivity-only check
  [05/68]: add xsnprintf helper function
  [06/68]: add git_path_buf helper function
  [07/68]: strbuf: make strbuf_complete_line more generic

    Docstring now makes clear the behavior when the strbuf is empty.

  [08/68]: add reentrant variants of sha1_to_hex and find_unique_abbrev

    These are now called sha1_to_hex_r, etc. The re-entrancy conditions
    are documented.

  [09/68]: fsck: use strbuf to generate alternate directories
  [10/68]: mailsplit: make PATH_MAX buffers dynamic

    Use xstrfmt consistently instead of sometimes using a strbuf.

  [11/68]: trace: use strbuf for quote_crnl output

    Further cleanup of "p2" variable in quote_crnl.

  [12/68]: progress: store throughput display in a strbuf
  [13/68]: test-dump-cache-tree: avoid overflow of cache-tree name
  [14/68]: compat/inet_ntop: fix off-by-one in inet_ntop4
  [15/68]: convert trivial sprintf / strcpy calls to xsnprintf

    Prefer "fixed-size" to "static" for clarity in commit message.

  [16/68]: archive-tar: use xsnprintf for trivial formatting
  [17/68]: use xsnprintf for generating git object headers
  [18/68]: find_short_object_filename: convert sprintf to xsnprintf
  [19/68]: stop_progress_msg: convert sprintf to xsnprintf

    Ditto on "fixed-size" versus "static".

  [20/68]: compat/hstrerror: convert sprintf to snprintf
  [21/68]: grep: use xsnprintf to format failure message
  [22/68]: entry.c: convert strcpy to xsnprintf
  [23/68]: add_packed_git: convert strcpy into xsnprintf

    Drop useless comment. Add comment on magic strlen().

  [24/68]: http-push: replace strcat with xsnprintf
  [25/68]: receive-pack: convert strncpy to xsnprintf
  [26/68]: replace trivial malloc + sprintf / strcpy calls with xstrfmt

    Include NUL in base64 of imap-send cram response. My guess is this
    is a bug in what we send that is overlooked by most servers, but I'd
    prefer to be conservative here and keep the behavior the same.

  [27/68]: config: use xstrfmt in normalize_value
  [28/68]: fetch: replace static buffer with xstrfmt
  [29/68]: use strip_suffix and xstrfmt to replace suffix
  [30/68]: ref-filter: drop sprintf and strcpy calls
  [31/68]: help: drop prepend function in favor of xstrfmt
  [32/68]: mailmap: replace strcpy with xstrdup
  [33/68]: read_branches_file: simplify string handling

    This goes much further than the original in cleaning up the use of a
    static buffer. From what I sent earlier during review, I dropped
    strbuf_read_file in favor of strbuf_getline, to keep the behavior
    identical to the original.

  [34/68]: read_remotes_file: simplify string handling

    New in this iteration; cleanups to match those in 33/68.

  [35/68]: resolve_ref: use strbufs for internal buffers
  [36/68]: upload-archive: convert sprintf to strbuf
  [37/68]: remote-ext: simplify git pkt-line generation

    The v1 of this patch was totally buggy. This is a rewrite to use
    packet_write(), which has several advantages, and includes tests.

  [38/68]: http-push: use strbuf instead of fwrite_buffer
  [39/68]: http-walker: store url in a strbuf
  [40/68]: sha1_get_pack_name: use a strbuf
  [41/68]: init: use strbufs to store paths
  [42/68]: apply: convert root string to strbuf
  [43/68]: transport: use strbufs for status table "quickref" strings
  [44/68]: merge-recursive: convert malloc / strcpy to strbuf
  [45/68]: enter_repo: convert fixed-size buffers to strbufs
  [46/68]: remove_leading_path: use a strbuf for internal storage
  [47/68]: write_loose_object: convert to strbuf

    Clarify comment on subtle mkstemp behavior.

  [48/68]: diagnose_invalid_index_path: use strbuf to avoid strcpy/strcat
  [49/68]: fetch-pack: use argv_array for index-pack / unpack-objects
  [50/68]: http-push: use an argv_array for setup_revisions
  [51/68]: stat_tracking_info: convert to argv_array
  [52/68]: daemon: use cld->env_array when re-spawning
  [53/68]: use sha1_to_hex_r() instead of strcpy

    Use "_r" versions to match change in patch 8.

  [54/68]: drop strcpy in favor of raw sha1_to_hex

    More history in the commit message, courtesy of Eric.

  [55/68]: color: add overflow checks for parsing colors

    Be more careful with OUT() macro.

  [56/68]: use alloc_ref rather than hand-allocating "struct ref"
  [57/68]: avoid sprintf and strcpy with flex arrays

    Trivial typo-fix in comment.

  [58/68]: receive-pack: simplify keep_arg computation

    Another s/static/fixed-size/.

  [59/68]: help: clean up kfmclient munging
  [60/68]: prefer memcpy to strcpy
  [61/68]: color: add color_set helper for copying raw colors
  [62/68]: notes: document length of fanout path with a constant
  [63/68]: convert strncpy to memcpy
  [64/68]: fsck: drop inode-sorting code
  [65/68]: Makefile: drop D_INO_IN_DIRENT build knob
  [66/68]: fsck: use for_each_loose_file_in_objdir
  [67/68]: use strbuf_complete to conditionally append slash

    Drop bogus conversion from imap-send.

  [68/68]: name-rev: use strip_suffix to avoid magic numbers

Hopefully that makes reviewing v2 a little less painful for those who
already slogged through v1. Thanks for your patience. :)

-Peff

[1] Gmane seems down, but once it's back up you should be able to get to
    v1 at: http://mid.gmane.org/20150915152125.GA27504@sigill.intra.peff.net

[2] Keeping track of the tweaks to this many patches would have been
    near impossible without Thomas Rast's git-tbdiff tool:

      https://github.com/trast/tbdiff

    I highly recommend it for people handling multiple versions of a
    long series.
