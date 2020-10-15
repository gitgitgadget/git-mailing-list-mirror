Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063A5C43457
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 07:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC77A2224A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 07:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgJOHYQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 15 Oct 2020 03:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgJOHYP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 03:24:15 -0400
Received: from mx.pao1.isc.org (mx.pao1.isc.org [IPv6:2001:4f8:0:2::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6A7C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 00:24:15 -0700 (PDT)
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id DC4AB3AB0D9
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 07:24:14 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id CF60716005D
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 07:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id B4EBF16006B
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 07:24:14 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kBFD-T6FJ8QD for <git@vger.kernel.org>;
        Thu, 15 Oct 2020 07:24:14 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id 2443E16005D
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 07:24:13 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <michal@isc.org>
To:     git@vger.kernel.org
Subject: [PATCH v3 0/2] diff: add -I<regex> that ignores matching changes
Date:   Thu, 15 Oct 2020 09:24:04 +0200
Message-Id: <20201015072406.4506-1-michal@isc.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012091751.19594-1-michal@isc.org>
References: <20201012091751.19594-1-michal@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series adds a new diff option that enables ignoring changes
whose all lines (changed, removed, and added) match a given regular
expression.  This is similar to the -I/--ignore-matching-lines option in
standalone diff utilities and can be used e.g. to ignore changes which
only affect code comments or to look for unrelated changes in commits
containing a large number of automatically applied modifications (e.g. a
tree-wide string replacement).  The difference between -G/-S and the new
-I option is that the latter filters output on a per-change basis.

Changes from v2:

  - Add a long option for -I (--ignore-matching-lines) as it is
    commonplace in standalone diff utilities.  Update documentation and
    commit log messages accordingly.

  - Use xmalloc() instead of xcalloc() for allocating regex_t
    structures in diff_opt_ignore_regex().

  - Ensure the memory allocated in diff_opt_ignore_regex() gets
    released.

  - Use "return error(...)" instead of die() in the -I option callback.
    Make the relevant error message localizable.

  - Drastically reduce the number of -I<regex> tests due to excessive
    run time of t/t4069-diff-ignore-regex.sh from v1/v2 on some
    platforms (notably Windows).  Use a tweaked version of a test
    suggested by Johannes Schindelin (thanks!).  Given its reduction in
    size, squash patch 3 (which contained the tests) into patch 2.

  - Replace "see Documentation/diff-options.txt" with "-I<regex>" in the
    comments for the added structure fields, in order to make these
    comments more useful.

Changes from v1:

  - Add a new preliminary cleanup patch which ensures xpparam_t
    structures are always zero-initialized.  (This was a prerequisite
    for the next change below.)

  - Do not add a new 'xdl_opts' flag to check whether -I was used;
    instead, just check whether the array of regular expressions to
    match against is non-NULL.

  - Enable the -I option to be used multiple times.  As a consequence of
    this, regular expressions are now "pre-compiled" in the option's
    callback (and passed around as an array of regex_t structures)
    rather than deep down in xdiff code.  Add test cases exercising use
    of multiple -I options in the same git invocation.  Update
    documentation accordingly.

  - Rename xdl_mark_ignorable() to xdl_mark_ignorable_lines(), to
    indicate that it is logically a "sibling" of
    xdl_mark_ignorable_regex() rather than its "parent".

  - Optimize xdl_mark_ignorable_regex() by making it immediately skip
    changes already marked as ignored by xdl_mark_ignorable_lines().

  - Fix coding style issue in the prototype part of the definition of
    xdl_mark_ignorable_regex().

  - Add "/* see Documentation/diff-options.txt */" comments for the
    fields added to struct diff_options and xpparam_t, mimicking the
    comments used for 'anchors', 'anchors_nr', and 'anchors_alloc'.

  - Revise commit log messages to reflect all of the above.

Michał Kępień (2):
  merge-base, xdiff: zero out xpparam_t structures
  diff: add -I<regex> that ignores matching changes

 Documentation/diff-options.txt |  5 ++++
 builtin/merge-tree.c           |  1 +
 diff.c                         | 28 ++++++++++++++++++++
 diff.h                         |  4 +++
 t/t4013-diff-various.sh        | 33 ++++++++++++++++++++++++
 xdiff/xdiff.h                  |  4 +++
 xdiff/xdiffi.c                 | 47 ++++++++++++++++++++++++++++++++--
 xdiff/xhistogram.c             |  2 ++
 xdiff/xpatience.c              |  2 ++
 9 files changed, 124 insertions(+), 2 deletions(-)

-- 
2.28.0

