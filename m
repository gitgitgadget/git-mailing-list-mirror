Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,SUBJ_ALL_CAPS shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF1A8207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbcIMEqS (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:18 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36445 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbcIMEqR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:17 -0400
Received: by mail-pa0-f47.google.com with SMTP id id6so57729402pad.3
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=k7WBZdWiFxfd33rAs4Ue3xp+whhYw1FjCUZL5MvrZ94=;
        b=dphOxVs74fzmZrQkfyYpnMmHmWKd9iewyNLts+6aR92BrdzGtAUU4x+DAzmfcR98B4
         D4+ChO2j7P/cnN2yrN8QpScrQVYAZdnM+hlr1aUpYrw0pQ3cmC7jGmyyjydGyH2inXjV
         m+zS85t48Kxx65BpFQW7lLbDDCOReXmTgxJ++RBNnMsdOpMKTgczRSPY5sfKulzLplaX
         Kk4AxH6pw0krO6iiGLiA/pyFCIigWqfeLCqUPZKEMCMLQ9DfIgRVMyV5rgMAhlZyL6t6
         St6hp8PMVcafv0LtWNdKF8WB7GsuHdX/KfNMYSL1GlLM3EgA85u6TzmNBGptzpLQhYjz
         4XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k7WBZdWiFxfd33rAs4Ue3xp+whhYw1FjCUZL5MvrZ94=;
        b=d0ZKHd/NRrKoLzdgE+t8K1rjgWlBn2AC7sIj3MkC6zKCKLlMFcWMoWBUvAwzlj2oH9
         7cQ0gLIUlYbCobZkUhcmcyVfKCdClMcRqGp0NudrJ+qAOGkS6WG3MN+CFLTkIngBpw3C
         Ik27KD0I0NdgY2jA2Aa8SrI0LUO1ZlAd/lA+NqvWGvX7lqhHbBP7TK2hfp9haJnzhBob
         x1C+U0iEbiJWIAXwla6/34VEDviXNqACD7emw29WKNNS1eeHxTcEcsoFxUoxo9MYrOTh
         cWB1u4MQuuvvgTfLykPhoCmiduHYvSBXdH7e0+xQihnxeKNE2ZBeICZSbYk86KKQQb+/
         l8sg==
X-Gm-Message-State: AE9vXwN/pjGBGubq6lh776hJqcv8EqNREp60wZ6mgMIqTYnaIHPqcippoEXxVtkCaMsWUakU
X-Received: by 10.66.81.9 with SMTP id v9mr25241550pax.62.1473741976300;
        Mon, 12 Sep 2016 21:46:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id y184sm27784394pfg.94.2016.09.12.21.46.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 00/17] 
Date:   Mon, 12 Sep 2016 21:45:56 -0700
Message-Id: <20160913044613.1037-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.21.g1da280f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

About a week ago, I started experimenting to add a new functionality to the 
diff machinery: We want to color moved lines differently! This will aid developers
to review patches such as the patch "Move libified code from builtin/apply.c to apply.{c,h}"
Or a smaller example:

    git show 11979b9
    

In the original patch series I just used the xdl diff machinery multiple times
to obtain the output for a multi pass algorithm I need for this coloring.
This was one of Junios main concerns (We have to rely on the xdl stuff to 
yield the same output in the two passes).

This brings in another approach:
 * run the xdl stuff only once
 * In case we do not ask for coloring moves, put it out immediately
   (small detour: we do not use fprintf/fputs directly but we channel
   all output through the emit_line_* interface)
 * When asking for coloring moves: buffer all its output for now.
   Feed the line by line into the move detection algorithm.
 * then output it all at once using the information from the move detection
   to recolor moves while outputting.
   
While viewing the output of 11979b9 again, I notice a small bug in the proposal,
but I'd rather be asking for review of the whole design approach.
   
Thanks,
Stefan

Stefan Beller (17):
  diff: move line ending check into emit_hunk_header
  diff: emit_{add, del, context}_line to increase {pre,post}image line
    count
  diff.c: drop tautologous condition in emit_line_0
  diff.c: factor out diff_flush_patch_all_file_pairs
  diff.c: emit_line_0 can handle no color setting
  diff.c: convert fn_out_consume to use emit_line_*
  diff.c: convert builtin_diff to use emit_line_*
  diff.c: convert emit_rewrite_diff to use emit_line_*
  diff.c: convert emit_rewrite_lines to use emit_line_*
  submodule.c: convert show_submodule_summary to use emit_line_fmt
  diff.c: convert emit_binary_diff_body to use emit_line_*
  diff.c: convert show_stats to use emit_line_*
  diff.c: convert word diffing to use emit_line_*
  diff.c: convert diff_flush to use emit_line_*
  diff.c: convert diff_summary to use emit_line_*
  diff: buffer output in emit_line_0
  diff.c: color moved lines differently

 Documentation/config.txt               |  12 +-
 Documentation/diff-options.txt         |   7 +
 contrib/completion/git-completion.bash |   2 +
 diff.c                                 | 666 +++++++++++++++++++++++----------
 diff.h                                 |  35 +-
 submodule.c                            |  42 +--
 submodule.h                            |   3 +-
 t/t4015-diff-whitespace.sh             | 229 ++++++++++++
 8 files changed, 760 insertions(+), 236 deletions(-)

-- 
2.10.0.21.g1da280f.dirty

