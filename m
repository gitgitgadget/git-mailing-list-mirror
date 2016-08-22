Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3672018E
	for <e@80x24.org>; Mon, 22 Aug 2016 11:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754705AbcHVLYV (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 07:24:21 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:59217 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752679AbcHVLYM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Aug 2016 07:24:12 -0400
X-AuditID: 1207440d-be3ff700000008af-ff-57bae08c24f7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id B3.46.02223.C80EAB75; Mon, 22 Aug 2016 07:22:52 -0400 (EDT)
Received: from bagpipes.fritz.box (p5790719A.dip0.t-ipconnect.de [87.144.113.154])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7MBMnQO027076
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 Aug 2016 07:22:51 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/7] Better heuristics make prettier diffs
Date:   Mon, 22 Aug 2016 13:22:39 +0200
Message-Id: <cover.1471864378.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsUixO6iqLv2wa5wg5aVghZdV7qZLBp6rzBb
        7F7cz2yx4uocZovbK+YzW/xo6WG22Ly5ncWB3ePv+w9MHjtn3WX3WLCp1ONZ7x5Gj4uXlD0+
        b5ILYIvisklJzcksSy3St0vgynjVsZW9YIdDxcMJT5gaGN9pdzFyckgImEi8PLqDrYuRi0NI
        YCujxMmW/0wQzikmib2TLzGDVLEJ6Eos6mlmArFFBMQl3h6fyQ5SxCzQzyTxo6OLESQhLGAr
        sbltHwuIzSKgKtG/7w1YA6+AucSc+43MEOvkJC5t+8I8gZFrASPDKka5xJzSXN3cxMyc4tRk
        3eLkxLy81CJdI73czBK91JTSTYyQQOHdwfh/ncwhRgEORiUeXo8jO8OFWBPLiitzDzFKcjAp
        ifKatQKF+JLyUyozEosz4otKc1KLDzFKcDArifBa3N8VLsSbklhZlVqUD5OS5mBREudVW6Lu
        JySQnliSmp2aWpBaBJOV4eBQkuB1AGkULEpNT61Iy8wpQUgzcXCCDOcBGn7sHsjw4oLE3OLM
        dIj8KUZFKXHefJCEAEgiozQPrhcWya8YxYFeEeY1AlnBA0wCcN2vgAYzAQ2+/n87yOCSRISU
        VAOjCgtT9bcDj9bZC3/QM1aaFWK211ebLW/fk42eT0MSORWyv92T+O/0n3/Wn/05HRolt5cw
        pc3mLqvMED21v37PzXMHmljK/7Sy7H2beVddSeDh7KZEu38WqQd8amu2a6dzlJczt6lz6dhr
        Rm8r3vjliJvFxuc8vG4CZfYvf185UN0m39g3NUKJpTgj0VCLuag4EQCvw3thvwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of a patch series to improve the heuristics that `git diff`
and related commands use to position ambiguous blocks of added/deleted
lines. Thanks to Stefan, Jacob, Peff, Junio, and Jakub for their
comments about v1 [1]. This patch series is also available from my
GitHub account [2] as branch `diff-indent-heuristic`.

This version started out as a light touch-up of v1, but as I was
working I realized that it needed more changes. Among other things,
the final heuristic is now improved relative to the one proposed in
v1. Summary of changes:

* I changed the `--compaction-heuristic` code such that if a group of
  added/deleted lines can be aligned with a group of deleted/added
  lines in the other file, then that should be done rather than try to
  slide to a blank line. In the existing code, the compaction
  heuristic was attempted, incorrectly, *after* trying to align
  groups, which doesn't make sense.

* I changed `recs_match()` similarly to `is_blank_line()`: now it
  takes two `xrecord_t *` as arguments rather than an array of
  `xrecord_t` and two indexes.

* I refactored the old `xdl_change_compact()` more thoroughly. All of
  the index manipulation was pretty confusing, and I was having
  trouble convincing myself that even the old code was working
  correctly. So I introduced a `struct group`, which is like a cursor
  that keeps track of a (possibly empty) group of changed lines in the
  old or new version of a file. I added functions to initialize a
  group to the first change in a file, to move to the next or previous
  groups, and to slide a group forward or backward if possible (i.e.,
  if the group is a "slider").

* In the course of that refactoring, I found (and fixed) another bug
  in the `--compaction-heuristic` code: it didn't notice if the top
  possible position of a slider had a blank line as its last line. See
  the commit message of patch [5/5] for more details.

* I realized that the behavior of the indent heuristic from v1,
  because it multiplied weighting factors times indent widths, would
  behave differently if a project changed its convention for how many
  spaces to use per level of indentation. That doesn't make sense, so
  I changed the handling of indentation:

  Now, the sum of the indentation width at the top and bottom of the
  slider are added, *but those sums are only compared* between slider
  positions, and the weight is multipled by -1, 0, or +1 depending on
  whether the first indent sum is less than, equal, or greater than
  the other. This should make the behavior relatively independent of
  the project's indentation convention, and thus make the heuristic
  work more consistently across projects.

  The resulting heuristic works significantly better than the one
  proposed in v1:

  | repository            | count |      Git 2.9.0 |             v1 |             v2 |
  | --------------------- | ----- | -------------- | -------------- | -------------- |
  | afnetworking          |   109 |    89  (81.7%) |     3   (2.8%) |     2   (1.8%) |
  | alamofire             |    30 |    18  (60.0%) |     2   (6.7%) |     0   (0.0%) |
  | angular               |   184 |   127  (69.0%) |    15   (8.2%) |     5   (2.7%) |
  | animate               |   313 |     2   (0.6%) |     2   (0.6%) |     2   (0.6%) |
  | ant                   |   380 |   356  (93.7%) |    22   (5.8%) |    15   (3.9%) |
  | bugzilla              |   306 |   263  (85.9%) |    24   (7.8%) |    15   (4.9%) |
  | corefx                |   126 |    91  (72.2%) |    15  (11.9%) |     6   (4.8%) |
  | couchdb               |    78 |    44  (56.4%) |    17  (21.8%) |     6   (7.7%) |
  | cpython               |   937 |   158  (16.9%) |    26   (2.8%) |     5   (0.5%) |
  | discourse             |   160 |    95  (59.4%) |    24  (15.0%) |    13   (8.1%) |
  | docker                |   307 |   194  (63.2%) |    16   (5.2%) |     8   (2.6%) |
  | electron              |   163 |   132  (81.0%) |    15   (9.2%) |     6   (3.7%) |
  | git                   |   536 |   470  (87.7%) |    18   (3.4%) |    16   (3.0%) |
  | gitflow               |   127 |     0   (0.0%) |     0   (0.0%) |     0   (0.0%) |
  | ionic                 |   133 |    89  (66.9%) |     6   (4.5%) |     1   (0.8%) |
  | ipython               |   482 |   362  (75.1%) |    45   (9.3%) |    11   (2.3%) |
  | junit                 |   161 |   147  (91.3%) |     4   (2.5%) |     1   (0.6%) |
  | lighttable            |    15 |     5  (33.3%) |     2  (13.3%) |     0   (0.0%) |
  | magit                 |    88 |    75  (85.2%) |     5   (5.7%) |     0   (0.0%) |
  | neural-style          |    28 |     0   (0.0%) |     0   (0.0%) |     0   (0.0%) |
  | nodejs                |   781 |   649  (83.1%) |    98  (12.5%) |     5   (0.6%) |
  | phpmyadmin            |   491 |   481  (98.0%) |     7   (1.4%) |     2   (0.4%) |
  | react-native          |   168 |   130  (77.4%) |     5   (3.0%) |     0   (0.0%) |
  | rust                  |   171 |   128  (74.9%) |    17   (9.9%) |    14   (8.2%) |
  | spark                 |   186 |   149  (80.1%) |    17   (9.1%) |     2   (1.1%) |
  | tensorflow            |   115 |    66  (57.4%) |     7   (6.1%) |     5   (4.3%) |
  | test-more             |    19 |    15  (78.9%) |     1   (5.3%) |     1   (5.3%) |
  | test-unit             |    51 |    34  (66.7%) |     8  (15.7%) |     2   (3.9%) |
  | xmonad                |    23 |    22  (95.7%) |     1   (4.3%) |     1   (4.3%) |
  | --------------------- | ----- | -------------- | -------------- | -------------- |
  | totals                |  6668 |  4391  (65.9%) |   422   (6.3%) |   144   (2.2%) |

* I noticed that most of the "bonus" weights were actually negative,
  so calling them "bonuses" was misleading. Therefore, I negated the
  coefficients and now call them "penalties"

* I noticed that `git blame` was parsing diff options like
  `--indent-heuristic` from the command line, but wasn't using the
  values. That is fixed in a new patch [07/07].

* I redid all of the analysis and training with a bigger corpus. To
  check whether I was overtraining the heuristic, I also did the
  following experiment: I optimized the weights against a training set
  consisting of only some of the repositories, then tested it against
  the rest of the corpus. See the full results in the commit message
  for patch [06/06].

* I added a couple of smoke tests.

The companion project [3] now provides an easy way to replicate and
extend these results, if anybody is interested.

The new heuristic still has to be enabled via the `--indent-heuristic`
command-line parameter or the `diff.indentHeuristic` configuration
setting. Before we release this, we should decide what the final UI
should look like and make it so. If we decide to replace the existing
compaction heuristic with this one and/or turn this heuristic on for
all users by default, those steps might look like branch
`indent-heuristic-default` in my GitHub repository [2].

Michael

[1] http://public-inbox.org/git/cover.1470259583.git.mhagger@alum.mit.edu/t/#u
[2] https://github.com/mhagger/git
[3] https://github.com/mhagger/diff-slider-tools

Michael Haggerty (7):
  xdl_change_compact(): fix compaction heuristic to adjust ixo
  xdl_change_compact(): only use heuristic if group can't be matched
  is_blank_line(): take a single xrecord_t as argument
  recs_match(): take two xrecord_t pointers as arguments
  xdl_change_compact(): introduce the concept of a change group
  diff: improve positioning of add/delete blocks in diffs
  blame: actually use the diff opts parsed from the command line

 Documentation/diff-config.txt  |   7 +-
 Documentation/diff-options.txt |   9 +-
 builtin/blame.c                |  11 +-
 diff.c                         |  23 +-
 git-add--interactive.perl      |   5 +-
 t/t4059-diff-indent.sh         | 160 +++++++++++
 xdiff/xdiff.h                  |   1 +
 xdiff/xdiffi.c                 | 635 ++++++++++++++++++++++++++++++++++-------
 8 files changed, 736 insertions(+), 115 deletions(-)
 create mode 100755 t/t4059-diff-indent.sh

-- 
2.9.3

