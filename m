Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BD2A2018B
	for <e@80x24.org>; Tue, 19 Jul 2016 03:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbcGSD6B (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 23:58:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35988 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbcGSD6A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 23:58:00 -0400
Received: by mail-pf0-f196.google.com with SMTP id y134so504525pfg.3
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 20:58:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=M/t6JP5wcJcP5QYJbSABE7vUWOdyrSvwQtvUp1ov9cQ=;
        b=AdhKsSd9wg9AfpxPa+RJ/Jm2P/LJtRHGxdTECHt9mLhY5iqJZqdiCeD5B+Y5jWugfI
         EYYxLuxyz1nRBENcCpiiRsb+GZmNQigZFSc//+0Hkw2umrdZEqjuax+pV6VrcXUb/oQD
         K0y/RlAsWzx+6lSc9LZQJVnxWUzreCuYpufRimDOneEHfLQjIkEIiXEYfTypWadgL4w1
         4JhSTx40HGicijASWeCCHOA756L36LdROwbUVgt+j10VtmqJONSQIEVQJTRbfU/Lmw7P
         qtQ5bBAvb8hsSa1hsy+e35w83027qLJdbmN6G29wNxaIBJbopeCLbV/JWeb+MivTPYM7
         gnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M/t6JP5wcJcP5QYJbSABE7vUWOdyrSvwQtvUp1ov9cQ=;
        b=ctP2oxFPUsGFPhpEZnamjVUDyZs2FZPZJwaMgXh+1ga2gmz5nz+8sadUAtIJ7VKhGd
         STJZGHG13DQ3Xuc8wBZJtAt4KBvK00u2htNYzsQletFBGVXw9QH1HTXNDggmAKMbGeoA
         WdUo5N39YJbsYZiTZG1MgqLkkdekFKmhFlvF849Sr9PRGs5tOZBSoyqf5AiWVlp3h7z6
         rgdJMQinuhp/enwmc7HrHTSFK0rAYhSNS8qzMD+9X+i443dZAiuc7ARutepqP/eZzQYm
         LzE+edecKYJt4HpyPer/4rK56dNpolAIOCxAEEbiPpYl2Zml5LPL62RV2J4qZxQSBIcV
         53EA==
X-Gm-Message-State: ALyK8tLGsKXsFWTp+2JhfOfEpcNTmAl/bB5QWE4LIZu94dHyO5XlXGamQ0s0f6lyTuFMSQ==
X-Received: by 10.98.76.9 with SMTP id z9mr51844277pfa.85.1468900679517;
        Mon, 18 Jul 2016 20:57:59 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id xs12sm172523pac.7.2016.07.18.20.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jul 2016 20:57:58 -0700 (PDT)
From:	David Aguilar <davvid@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	John Keeping <john@keeping.me.uk>,
	Bernhard Kirchen <bernhard.kirchen@rwth-aachen.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] difftool: fix argument handling in subdirs
Date:	Mon, 18 Jul 2016 20:57:54 -0700
Message-Id: <20160719035756.24961-1-davvid@gmail.com>
X-Mailer: git-send-email 2.9.2.280.g385e27a
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: John Keeping <john@keeping.me.uk>

When in a subdirectory of a repository, path arguments should be
interpreted relative to the current directory not the root of the
working tree.

The Git::repository object passed into setup_dir_diff() is configured to
handle this correctly but we create a new Git::repository here without
setting the WorkingSubdir argument.  By simply using the existing
repository, path arguments are handled relative to the current
directory.

Reported-by: Bernhard Kirchen <bernhard.kirchen@rwth-aachen.de>
Signed-off-by: John Keeping <john@keeping.me.uk>
Acked-by: David Aguilar <davvid@gmail.com>
---
This patch is unchanged from John's version but also includes
Reported-by and Acked-by lines.

 git-difftool.perl | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index ebd13ba..c9d3ef8 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -115,16 +115,9 @@ sub setup_dir_diff
 {
 	my ($repo, $workdir, $symlinks) = @_;
 
-	# Run the diff; exit immediately if no diff found
-	# 'Repository' and 'WorkingCopy' must be explicitly set to insure that
-	# if $GIT_DIR and $GIT_WORK_TREE are set in ENV, they are actually used
-	# by Git->repository->command*.
 	my $repo_path = $repo->repo_path();
-	my %repo_args = (Repository => $repo_path, WorkingCopy => $workdir);
-	my $diffrepo = Git->repository(%repo_args);
-
 	my @gitargs = ('diff', '--raw', '--no-abbrev', '-z', @ARGV);
-	my $diffrtn = $diffrepo->command_oneline(@gitargs);
+	my $diffrtn = $repo->command_oneline(@gitargs);
 	exit(0) unless defined($diffrtn);
 
 	# Build index info for left and right sides of the diff
@@ -176,12 +169,12 @@ EOF
 
 		if ($lmode eq $symlink_mode) {
 			$symlink{$src_path}{left} =
-				$diffrepo->command_oneline('show', "$lsha1");
+				$repo->command_oneline('show', "$lsha1");
 		}
 
 		if ($rmode eq $symlink_mode) {
 			$symlink{$dst_path}{right} =
-				$diffrepo->command_oneline('show', "$rsha1");
+				$repo->command_oneline('show', "$rsha1");
 		}
 
 		if ($lmode ne $null_mode and $status !~ /^C/) {
-- 
2.9.2.280.g385e27a

