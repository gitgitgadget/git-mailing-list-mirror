Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B87251FF7F
	for <e@80x24.org>; Fri,  9 Dec 2016 08:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932792AbcLII64 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 03:58:56 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35090 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932499AbcLII6z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 03:58:55 -0500
Received: by mail-pf0-f195.google.com with SMTP id i88so884895pfk.2
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 00:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KRana4saJbAziIvL6RR4gn66Ajc0oruAckcjy4Eh3hs=;
        b=gNGNcUP7V2sP+WjB86owkr56v2Yv+GpRmgn0aQnBGWo+WlU4x5u9yHz5HREJStAS1R
         viCT81+npgy0fFe+jPcJXqijTw0gCfzX88B48IHI3yC4Co32WpDPJwMKpDfKUMIeyIEE
         IBd0WAPBYOKOOA0Hf33/Cy45WZbsEWRcawT53WCiWAnrqyDvmkNak5oRjbrkifdmqpd7
         54GiFr5i/r1555Cq3J0uU/RV6r9aNS6A3G8Do5wE7+5DCee8QSEg9npUj/hptqn2nRIk
         VgLUOSVp16GStO9EqUJwn54I/RAVMXyQCuSFKPmFm2iG7mw+iyS98zTF7JE8AEP/z0cm
         7WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KRana4saJbAziIvL6RR4gn66Ajc0oruAckcjy4Eh3hs=;
        b=KfVOsuOZ3Xnp4j4rYAgYhR6kEUGx6AVY4cujxHpQHLSf8HlOzS8vsD4QPC4aJQKEg7
         FGiUE7dXqCGKyBkd2N1vTnGUiOFKUEn8dA6effPGw6VYT99yuylQUjyw/fMNjh4v9s1S
         0ESMWYvAYXUbC6hWTCpYwho5W53pOwCRKKM1p6EgeHqKqobwii3+lEm2b5n4k1NyNBsL
         7lq/Bm63zaTu0BRR3wpVZOHjKn84TvADmMlYTdlVIdfBkXdomZCpnNl2+XPHR+6paSWF
         86pNU+hjXJ/iXo/Y/s0qSEVf08V4WM8+7j3+hLKCGJTMXf/HYP6kLsvGAc+9OP2Os9cQ
         Iavg==
X-Gm-Message-State: AKaTC01Z4HsYlcoHFhHb98zyQy1y133V9ye+rzXLlB5FU4O/TyrWaa/TUbpxZNHopHqsrg==
X-Received: by 10.98.201.196 with SMTP id l65mr80929210pfk.116.1481273935148;
        Fri, 09 Dec 2016 00:58:55 -0800 (PST)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id o26sm55587687pfk.91.2016.12.09.00.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2016 00:58:54 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: [PATCH 2/3] difftool: chdir as early as possible
Date:   Fri,  9 Dec 2016 00:58:47 -0800
Message-Id: <20161209085848.10929-2-davvid@gmail.com>
X-Mailer: git-send-email 2.11.0.26.gb65c994
In-Reply-To: <20161209085848.10929-1-davvid@gmail.com>
References: <20161209085848.10929-1-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make difftool chdir to the top-level of the repository as soon as it can
so that we can simplify how paths are handled.  Replace construction of
absolute paths via string concatenation with relative paths wherever
possible.  The bulk of the code no longer needs to use absolute paths.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 17c336321f..99b03949bf 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -59,14 +59,14 @@ sub exit_cleanup
 
 sub use_wt_file
 {
-	my ($workdir, $file, $sha1) = @_;
+	my ($file, $sha1) = @_;
 	my $null_sha1 = '0' x 40;
 
-	if (-l "$workdir/$file" || ! -e _) {
+	if (-l $file || ! -e _) {
 		return (0, $null_sha1);
 	}
 
-	my $wt_sha1 = Git::command_oneline('hash-object', "$workdir/$file");
+	my $wt_sha1 = Git::command_oneline('hash-object', $file);
 	my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
 	return ($use, $wt_sha1);
 }
@@ -105,6 +105,12 @@ sub setup_dir_diff
 	my $diffrtn = Git::command_oneline(@gitargs);
 	exit(0) unless defined($diffrtn);
 
+	# Go to the root of the worktree now that we've captured the list of
+	# changed files.  The paths returned by diff --raw are relative to the
+	# top-level of the repository, but we defer changing directories so
+	# that @ARGV can perform pathspec limiting in the current directory.
+	chdir($workdir);
+
 	# Build index info for left and right sides of the diff
 	my $submodule_mode = '160000';
 	my $symlink_mode = '120000';
@@ -172,7 +178,7 @@ EOF
 				next;
 			}
 			my ($use, $wt_sha1) =
-				use_wt_file($workdir, $dst_path, $rsha1);
+				use_wt_file($dst_path, $rsha1);
 			if ($use) {
 				push @working_tree, $dst_path;
 				$wtindex .= "$rmode $wt_sha1\t$dst_path\0";
@@ -182,10 +188,6 @@ EOF
 		}
 	}
 
-	# Go to the root of the worktree so that the left index files
-	# are properly setup -- the index is toplevel-relative.
-	chdir($workdir);
-
 	# Setup temp directories
 	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 0, TMPDIR => 1);
 	my $ldir = "$tmpdir/left";
@@ -235,10 +237,10 @@ EOF
 			symlink("$workdir/$file", "$rdir/$file") or
 			exit_cleanup($tmpdir, 1);
 		} else {
-			copy("$workdir/$file", "$rdir/$file") or
+			copy($file, "$rdir/$file") or
 			exit_cleanup($tmpdir, 1);
 
-			my $mode = stat("$workdir/$file")->mode;
+			my $mode = stat($file)->mode;
 			chmod($mode, "$rdir/$file") or
 			exit_cleanup($tmpdir, 1);
 		}
@@ -430,10 +432,10 @@ sub dir_diff
 			$error = 1;
 		} elsif (exists $tmp_modified{$file}) {
 			my $mode = stat("$b/$file")->mode;
-			copy("$b/$file", "$workdir/$file") or
+			copy("$b/$file", $file) or
 			exit_cleanup($tmpdir, 1);
 
-			chmod($mode, "$workdir/$file") or
+			chmod($mode, $file) or
 			exit_cleanup($tmpdir, 1);
 		}
 	}
-- 
2.11.0.26.gb65c994

