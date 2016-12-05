Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7128E1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 22:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbcLEW0q (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 17:26:46 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33944 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbcLEW0o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 17:26:44 -0500
Received: by mail-pg0-f68.google.com with SMTP id e9so17642700pgc.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 14:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+zJy6Gn3kGeY5mR2Pnb1f6JGPWJC4B6ZGGGT1lvCrvg=;
        b=qE+KICY7FLsMBRJCWPhmifVCYk6+8WdaTtiZIJB8zkR6RVI3CfYfQz3tQaAqNFsaZN
         a7EorCgkCVhqjsEeU1XJEeYI0UxFSoo0nn7X0KGxKOH87/xW0tXTdBJ7xn0pGrwTxfD5
         TCGkkKgQdSnC8lGpiAaUjLSUoYayV5Xwaxdd70MzlwakXRvsNTH0q6eyQzBCNmPv9x4g
         52vDgUaIOcacixQJu904hKGuRexpdae6rE1CsQUrEMT6kjbyG9vWCa6UthOlkv37FMS5
         uZaZORhj0fYXoFow+AISPFPJTa8NtA6JBD8rbPYBAh+8Hu/QWvbTOh8qSSZRUnpJi4k6
         C2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+zJy6Gn3kGeY5mR2Pnb1f6JGPWJC4B6ZGGGT1lvCrvg=;
        b=TbS7+f3iQELBXvobu4ta7h9VDIgPFys3Yw0nnV2W7Swe3ahWxMsPeu9ZsZjFOMlWD1
         wJncQFXOpGqRqhmYUI8gPMt1TspDtrlyayYwZAsGThu4bie7VrRB6wTamYS8fhJsOecx
         3W1goSo1lRxCSQpJyk+nz3HGVvGaDVKCyr4kdfqktiJlsXoyKHa139IE+YlzJXQHfs9I
         PuZXiajmglnNiYem2oT8HeTzK87K3LWvfj6CWDqehRNXqByw0bGEoEYhwjBABPoUj+ia
         jTwqJxH3b5P+yyrXirwgMTWRY7s5tTiGbdEzj/ukal/IU7u73zGfsRPJqI3mqcOiJFo+
         igTw==
X-Gm-Message-State: AKaTC01pG4LDmYEsY0FSgIaviLQwRpPaYhwrFyqa9uE7YCDEOU6LWveWMarK9fAVbCLn3A==
X-Received: by 10.84.148.203 with SMTP id y11mr130057244plg.29.1480976764507;
        Mon, 05 Dec 2016 14:26:04 -0800 (PST)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id y6sm29830326pge.16.2016.12.05.14.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2016 14:26:03 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>, Frank Becker <fb@mooflu.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>
Subject: [PATCH] difftool: fix dir-diff index creation when in a subdirectory
Date:   Mon,  5 Dec 2016 14:26:00 -0800
Message-Id: <20161205222600.29914-1-davvid@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

9ec26e797781239b36ebccb87c590e5778358007 corrected how path arguments
are handled in a subdirectory, but it introduced a regression in how
entries outside of the subdirectory are handled by dir-diff.

When preparing the right-side of the diff we only include the
changed paths in the temporary area.

The left side of the diff is constructed from a temporary
index that is built from the same set of changed files, but it
was being constructed from within the subdirectory.  This is a
problem because the indexed paths are toplevel-relative, and
thus they were not getting added to the index.

Teach difftool to chdir to the toplevel of the repository before
preparing its temporary indexes.  This ensures that all of the
toplevel-relative paths are valid.

Adjust the test cases to more thoroughly exercise this scenario.

Reported-by: Frank Becker <fb@mooflu.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
I figured I'd send this as a proper patch.
The patch contents have not changed since the original in-thread
patch, but the commit message was modified slightly.

 git-difftool.perl   | 4 ++++
 t/t7800-difftool.sh | 7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index a5790d03a..959822d5f 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -182,6 +182,10 @@ EOF
 		}
 	}
 
+	# Go to the root of the worktree so that the left index files
+	# are properly setup -- the index is toplevel-relative.
+	chdir($workdir);
+
 	# Setup temp directories
 	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 0, TMPDIR => 1);
 	my $ldir = "$tmpdir/left";
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 70a2de461..caab4b5ca 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -413,8 +413,11 @@ run_dir_diff_test 'difftool --dir-diff from subdirectory' '
 	(
 		cd sub &&
 		git difftool --dir-diff $symlinks --extcmd ls branch >output &&
-		grep sub output &&
-		grep file output
+		# "sub" must only exist in "right"
+		# "file" and "file2" must be listed in both "left" and "right"
+		test "1" = $(grep sub output | wc -l) &&
+		test "2" = $(grep file"$" output | wc -l) &&
+		test "2" = $(grep file2 output | wc -l)
 	)
 '
 
-- 
2.11.0

