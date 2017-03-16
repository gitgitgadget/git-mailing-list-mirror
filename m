Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62643202C1
	for <e@80x24.org>; Thu, 16 Mar 2017 00:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbdCPAdi (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 20:33:38 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36667 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdCPAdh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 20:33:37 -0400
Received: by mail-pg0-f46.google.com with SMTP id g2so16433790pge.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 17:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=beFgfr/mbZMICdhLrXhpHPfugoejhcgV9gwmdCzpUCA=;
        b=M5r7Tu2DQh0lruF+blJ0zFkJJinHqgQBRanfTxA/OCjjsofKKGQnz0hRDszyk426Xe
         CK/UWBkdgAY7RVJwEJrdPZYw2ZOaxuS96v9fbccHjYd1HDOeYV1fe149tOBzhXBIBCKf
         UnjvOa23o8b/nTU6CXRrhQNPjW+lAyt8Rke0sFTvXlqpCZbcLJIB1PDc5bog58QQ5Hc7
         XuHmZuKMoCaf7nh+TAbsoIV5vCLyhlmaEcjBoCJ/Y8DOex599gli0KjcbHL2f/74K8Qs
         hGCAV8bfaVVeD/NGX/cT8kEm4QNXlSvhcC/IHuwtGt0zUFOZCC87n+w7CYaE6GUhKoUi
         8Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=beFgfr/mbZMICdhLrXhpHPfugoejhcgV9gwmdCzpUCA=;
        b=jT608llx/ulJAll8JeHCp5+954zsw6bCWdK4JzebmyBABBfiS1x9buhb8BFgDczk5x
         uF1zL7DwvBAZTu5vsOOAA77CJhIDlyvcPigKrsy86mlVVyJsGDKemLPFrBl55JmNt7KL
         sTJOROFfOo1bosDVGANOKRbi17NcYtSfNGl4NrSyOhIfM+OTbIiI7hs9at2vPrNgXzu9
         r3psbNF5W5CjiaZWtEcXi1S88wvt8XQWe922tidDjv5dbdg3CQ8I6C/KqEYquurWRCcS
         3K9uCeD8uwo0qqLicYYq6WmomsNAvSNP+kJdQ1KoDloaCkTWXwEw1xA7FuIY54fz+3vX
         sO8Q==
X-Gm-Message-State: AFeK/H2GdynIUtyx+5ND5E4oAH6+IbAz3sRNkQfkgMNCtXGGWjDwVdud87n8rqyqXrkoDFyg
X-Received: by 10.98.139.195 with SMTP id e64mr7100222pfl.86.1489624416249;
        Wed, 15 Mar 2017 17:33:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fc0f:1036:2cd5:c72b])
        by smtp.gmail.com with ESMTPSA id b195sm6355392pfb.106.2017.03.15.17.33.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 17:33:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH] short status: improve reporting for submodule changes
Date:   Wed, 15 Mar 2017 17:33:32 -0700
Message-Id: <20170316003332.30918-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.269.g1a05a5734c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While we already have a porcelain2 layer for git-status, that is accurate
for submodules, users still like the way they are are used to of
'status -s'.

As a submodule has more state than a file potentially, we'll look at all
cases:

   ------ new submodule commits
 /  ----- modified files
 | /   -- untracked files
 | |  /
 | | |   current / proposed reporting
 0 0 0     "  "     "  "
 0 0 1     " M"     " ?"
 0 1 0     " M"     " m"
 0 1 1     " M"     " m"
 1 0 0     " M"     " M"
 1 0 1     " M"     " M"
 1 1 0     " M"     " M"
 1 1 1     " M"     " M"

So when there is no new commits in the submodule, we'd want to tell
what actually happend to the submodule. The lower case 'm' indicates
to the user that there is need to give a --recurse-submodules option
for e.g. adding or committing these changes. The " ?" also differentiates
an untracked file in the submodule from a regular untracked file.

While making these changes, we need to make sure to not break porcelain
level 1, which uses the same code as the short printing function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-status.txt |  8 ++++++++
 wt-status.c                  | 15 +++++++++++++--
 wt-status.h                  |  1 +
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index ba873657cf..26c8d832cd 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -181,6 +181,12 @@ in which case `XY` are `!!`.
     !           !    ignored
     -------------------------------------------------
 
+Submodules have more state to it, such that it reports instead:
+		M    the submodule has new commits
+		m    the submodule has modified content
+		?    the submodule has untracked files
+
+
 If -b is used the short-format status is preceded by a line
 
     ## branchname tracking info
@@ -210,6 +216,8 @@ field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
 backslash-escaping is performed.
 
+Any submodule changes are reported as modified `M` instead of `m` or single `?`.
+
 Porcelain Format Version 2
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/wt-status.c b/wt-status.c
index a52d342695..080d97f272 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1664,9 +1664,19 @@ static void wt_shortstatus_status(struct string_list_item *it,
 		color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%c", d->index_status);
 	else
 		putchar(' ');
-	if (d->worktree_status)
+	if (d->worktree_status) {
+		if (!s->submodule_porcelain1 &&
+		    (d->dirty_submodule || d->new_submodule_commits)) {
+			/* It is a submodule, and we're not in plumbing mode. */
+			if (d->new_submodule_commits)
+				d->worktree_status = 'M';
+			else if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
+				d->worktree_status = 'm';
+			else if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+				d->worktree_status = '?';
+		}
 		color_fprintf(s->fp, color(WT_STATUS_CHANGED, s), "%c", d->worktree_status);
-	else
+	} else
 		putchar(' ');
 	putchar(' ');
 	if (s->null_termination) {
@@ -1811,6 +1821,7 @@ static void wt_porcelain_print(struct wt_status *s)
 	s->relative_paths = 0;
 	s->prefix = NULL;
 	s->no_gettext = 1;
+	s->submodule_porcelain1 = 1;
 	wt_shortstatus_print(s);
 }
 
diff --git a/wt-status.h b/wt-status.h
index 54fec77032..620e4d2ae4 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -70,6 +70,7 @@ struct wt_status {
 	int display_comment_prefix;
 	int relative_paths;
 	int submodule_summary;
+	int submodule_porcelain1;
 	int show_ignored_files;
 	enum untracked_status_type show_untracked_files;
 	const char *ignore_submodule_arg;
-- 
2.12.0.269.g1a05a5734c.dirty

