Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 602EE1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 23:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeAVXbj (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 18:31:39 -0500
Received: from lucaswerkmeister.de ([94.130.58.99]:57024 "EHLO
        lucaswerkmeister.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeAVXbi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 18:31:38 -0500
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jan 2018 18:31:38 EST
Received: from localhost (unknown [IPv6:2a02:8109:9a3f:f575:be5f:f4ff:fecb:74cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mail@lucaswerkmeister.de)
        by lucaswerkmeister.de (Postfix) with ESMTPSA id D79C41925B2;
        Tue, 23 Jan 2018 00:23:54 +0100 (CET)
Authentication-Results: lucaswerkmeister.de; dmarc=fail (p=none dis=none) header.from=lucaswerkmeister.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucaswerkmeister.de;
        s=mail; t=1516663434;
        bh=vfrDU44w9PGYh00dEHqVdBgrGFKyTAMBgJSK1KWG3Ck=;
        h=From:To:Cc:Subject:Date:Message-Id:From:Reply-To:Subject:Date:To:
         Cc:In-Reply-To:References:Message-Id:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version;
        b=YiE8Q9X98Nk/EnedczCCi0EDPRZPaPp0i88j7eS2dK9FIGrXDsWwe9aX0XAuME6YI
         ZusMCxZ8KeK40dFjFzEreVlWeBA7VQHVIkYvs7L6JJbZ7yMB6c/Mm+QGXM9ryWQixd
         DVGNYjmrVNaiLCXtX15gjCdqO2Ya1pjKutq+RQuk=
From:   Lucas Werkmeister <mail@lucaswerkmeister.de>
To:     git@vger.kernel.org
Cc:     Lucas Werkmeister <mail@lucaswerkmeister.de>
Subject: [PATCH] daemon: add --no-syslog to undo implicit --syslog
Date:   Tue, 23 Jan 2018 00:23:04 +0100
Message-Id: <20180122232304.4863-1-mail@lucaswerkmeister.de>
X-Mailer: git-send-email 2.16.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several options imply --syslog, without there being a way to disable it
again. This commit adds that option.

This is useful, for instance, when running `git daemon` as a systemd
service with --inetd. systemd connects stderr to the journal by default,
so logging to stderr is useful. On the other hand, log messages sent via
syslog also reach the journal eventually, but run the risk of being
processed at a time when the `git daemon` process has already exited
(especially if the process was very short-lived, e.g. due to client
error), so that the journal can no longer read its cgroup and attach the
message to the correct systemd unit. See systemd/systemd#2913 [1].

[1]: https://github.com/systemd/systemd/issues/2913

Signed-off-by: Lucas Werkmeister <mail@lucaswerkmeister.de>
---

Notes:
    I decided not to add the option to git-daemon's --help output, since
    the similar --no-informative-errors option is also not listed there.
    Let me know if it should be added.
    
    Feel free to remove the part about systemd from the commit message
    if you feel it doesn't need to be included.

 Documentation/git-daemon.txt | 6 ++++--
 daemon.c                     | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 3c91db7be..dfd6ce03c 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -8,7 +8,7 @@ git-daemon - A really simple server for Git repositories
 SYNOPSIS
 --------
 [verse]
-'git daemon' [--verbose] [--syslog] [--export-all]
+'git daemon' [--verbose] [--[no-]syslog] [--export-all]
 	     [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]
 	     [--strict-paths] [--base-path=<path>] [--base-path-relaxed]
 	     [--user-path | --user-path=<path>]
@@ -109,9 +109,11 @@ OPTIONS
 	Maximum number of concurrent clients, defaults to 32.  Set it to
 	zero for no limit.
 
---syslog::
+--[no-]syslog::
 	Log to syslog instead of stderr. Note that this option does not imply
 	--verbose, thus by default only error conditions will be logged.
+	`--no-syslog` is the default, but may be given explicitly to override
+	the implicit `--syslog` of an earlier `--inetd` or `--detach` option.
 
 --user-path::
 --user-path=<path>::
diff --git a/daemon.c b/daemon.c
index e37e343d0..d59fef6d6 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1300,6 +1300,10 @@ int cmd_main(int argc, const char **argv)
 			log_syslog = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--no-syslog")) {
+			log_syslog = 0;
+			continue;
+		}
 		if (!strcmp(arg, "--export-all")) {
 			export_all_trees = 1;
 			continue;
-- 
2.16.0

