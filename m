From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv20 00/12] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 11:13:58 -0800
Message-ID: <1456773250-5510-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 29 20:14:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTGv-0005We-8L
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbcB2TOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:14:17 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34420 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbcB2TOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:14:16 -0500
Received: by mail-pf0-f182.google.com with SMTP id 4so18862047pfd.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=oeFUc/7pfRJUAMhf8/d+WLPuE4VDFkKN1r9bcSqXnvg=;
        b=EUpy56VIDtXXkEOa6p/V2TnkqaQkPAMLtP26OW2yDrvCF314YMiijD85rrthjuv6T5
         qIiV0AwgDTyAvNmU/H+0rauL/clSPNRfJckmFKKWjLvpslYQnUYzLqRNpLPbHSiViUVX
         8XzaFGSRuibsO3oQgT6WRqjuPQeZSDyLukFEvcZhkwxZOxp4N88tuVUI5O7XD6cxsHJ3
         tve4LmJQu2I8VTL2HhQUkfsOVUC0RNq+6lfwo1N340PiCsLOqIJt+KG7XCqKH2CfS+G5
         2p2AemGrwllNgEFYPYERE/YWTVYrK5ir1HYuF0YCKmYjSqBFtP35aoSmu+rqEePB9mR7
         tk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oeFUc/7pfRJUAMhf8/d+WLPuE4VDFkKN1r9bcSqXnvg=;
        b=kJWW69eNT61jBdpUsjj57cmWh3NiGM4zarfCQO2y7/770dAHCIP3WyJEyi1vUv1Uae
         w5AhpM+4aq1wA3f0C68uqAOQoLTrIX7mMRiwARBbzvSBt5wjStpRhqk/f5yVwFCMw2UW
         uiV9KcZ9NA+zMGSSVCrHoL3+Nx/ehGGSfKFYxRMszYD8jRHF2yXWmOvQbnINhQ2F4gR8
         dVNIrt6uMjD9UZl7ppcCeGWYwZ0RcL8burKAh6SJZESiy99wzDep6gbfCFaPH0IIm8To
         hzPx40iLnG8kSlPF9di9UxGVZ5+AE5bjDXHIQfF6DNhgpA48T6uos3aRW2VgFSUKnqWR
         +dKg==
X-Gm-Message-State: AD7BkJIxN16KXw1gh5RbNfEqrCEkJgk5hcKRSI1DqwKVe/+8eiU0D2mYdGS3Wi1VeIHkqnNO
X-Received: by 10.98.86.69 with SMTP id k66mr17309166pfb.28.1456773255383;
        Mon, 29 Feb 2016 11:14:15 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id by3sm39963631pab.39.2016.02.29.11.14.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 11:14:12 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.37.gb7b9e8e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287874>

Thanks Duy for reviewing!
I added your suggestions as amending and as a new patch.

Thanks,
Stefan

Interdiff to v19 (current origin/sb/submodule-parallel-update):
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0272c98..1b0b13a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -299,10 +299,10 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 
 	if (ce_stage(ce)) {
 		if (suc->recursive_prefix) {
-			strbuf_addf(out, "Skipping unmerged submodule %s/%s\n",
+			strbuf_addf(out,_("Skipping unmerged submodule %s/%s\n"),
 				    suc->recursive_prefix, ce->name);
 		} else {
-			strbuf_addf(out, "Skipping unmerged submodule %s\n",
+			strbuf_addf(out, _("Skipping unmerged submodule %s\n"),
 				    ce->name);
 		}
 		goto cleanup;
@@ -319,7 +319,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (suc->update.type == SM_UPDATE_NONE
 	    || (suc->update.type == SM_UPDATE_UNSPECIFIED
 		&& sub->update_strategy.type == SM_UPDATE_NONE)) {
-		strbuf_addf(out, "Skipping submodule '%s'\n",
+		strbuf_addf(out, _("Skipping submodule '%s'\n"),
 			    displaypath);
 		goto cleanup;
 	}
@@ -525,13 +525,13 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	if (argc < 2)
-		die(_("fatal: submodule--helper subcommand must be "
+		die(_("submodule--helper subcommand must be "
 		      "called with a subcommand"));
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++)
 		if (!strcmp(argv[1], commands[i].cmd))
 			return commands[i].fn(argc - 1, argv + 1, prefix);
 
-	die(_("fatal: '%s' is not a valid submodule--helper "
+	die(_("'%s' is not a valid submodule--helper "
 	      "subcommand"), argv[1]);
 }


Stefan Beller (12):
  submodule-config: keep update strategy around
  submodule-config: drop check against NULL
  fetching submodules: respect `submodule.fetchJobs` config option
  submodule update: direct error message to stderr
  run_processes_parallel: treat output of children as byte array
  run-command: expose default_{start_failure, task_finished}
  run_processes_parallel: rename parameters for the callbacks
  run_processes_parallel: correctly terminate callbacks with an LF
  git submodule update: have a dedicated helper for cloning
  submodule helper: remove double 'fatal: ' prefix
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   6 +
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 ++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 259 +++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh                |  56 ++++-----
 run-command.c                   |  36 +++---
 run-command.h                   |  29 ++++-
 strbuf.c                        |   6 +
 strbuf.h                        |   6 +
 submodule-config.c              |  19 ++-
 submodule-config.h              |   2 +
 submodule.c                     |  37 +++++-
 submodule.h                     |  18 +++
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 18 files changed, 480 insertions(+), 73 deletions(-)

-- 
2.7.0.rc0.37.gb7b9e8e
