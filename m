Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C211FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 14:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbdCGOkW (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 09:40:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:56114 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932359AbdCGOkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 09:40:20 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwIuc-1cCSnN22CU-0183we; Tue, 07
 Mar 2017 15:33:31 +0100
Date:   Tue, 7 Mar 2017 15:33:30 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v4 10/10] setup_git_directory_gently_1(): avoid die()ing
In-Reply-To: <cover.1488897111.git.johannes.schindelin@gmx.de>
Message-ID: <642c42bb97c3fc4943aaec0fc77173f415d246bc.1488897111.git.johannes.schindelin@gmx.de>
References: <cover.1488562287.git.johannes.schindelin@gmx.de> <cover.1488897111.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+5bEoVbW8JpJSMvKOzxg566SP+oBxFfCtgVEuEyv0+1i+nPhb6p
 p/RLrfgUljVbL0XMdqSQX/2p2k1kT25L+5rc6DvIR7oED/2e7ei21OTkvDBRLwjPSdMs3mz
 xnbLFlJv+1Jyhc31HG7/H9gNhYo1Ve5IpqUtoMiUc+5k2JQVX+PDnTEBWxeV8l8AT/+hUVm
 oD3TPz989Wde5I1VFrXlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n/NpZf1Hg7E=:Dx0WclaXNddeq8AKA/I9Wb
 DGr4mvDQdPfu7LQzbXygtQAVA1rNij4AssQMAvT8rSVWV3msVmRYkgIQJEYlWQS4xSuPL+eJu
 jkX+h/MPSrLsFegtCFCH9t9WNeaiiMn+kLyIK80WROxw5uATcjThmCSfIJA/jaXcScDfH7UDD
 4bAc0oMyMupkfHZOUxhNkDa7o8qUyrjgoGl2E6OrxCYPvgzl7FXZCwiUJ2wbYuMN/usVlHR2g
 PActUqCtdp3ZlqDO8F1OjEzP7TCswptyXFK8SNKl/UBWoRGEXY1gQpReotwihPU6m/ZxbTOXE
 KmTQuhkGVc5uPbCphCDwKdO19X586SVj5nZbuRNatb/RwnluSPfsgWNmuP7zWKodhFUihaUoP
 Y6NplJybtflPunLHgUwUUCU+CZgnv/E3KC4zSsyIHQRRTBJqOPP58HIlowWzLHytQaKiQR+RR
 /+0klGgyNo+XN4Uk4NT8Vk25daFALPnryzB42WGa43/8wUMNtOp3SFwAGU2P+wErRKM9P9sik
 /GhTQkazeQ9R6KpeLyfVr8kV48eCV6hNCyPgYwCPNdy5EaOPryNxicCPZHYbpnqJUp+GWHNzv
 yfmYSZNVu4azPvZcPSbh7MFRoNSIs2ES8nzJPKQUVRkrIcgsnoMg2uZuRlJhyPw3PJenZozDm
 9OohCUaapf7sH9y8IZvs4HbiI0lhnvkmR61EJiZGtLL1MjPsTwg0M2eF2XbZR0FvRWj1WRs3b
 XKx4D4xC/x9lLJ9hV7ZbsxRFt5SGWvLPXhnk8u1PU2SD86XV4g8Vkhib0zW1a5drmQJ4xFxWt
 P3zRQa1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function now has a new caller in addition to setup_git_directory():
the newly introduced discover_git_directory(). That function wants to
discover the current .git/ directory, and in case of a corrupted one
simply pretend that there is none to be found.

Example: if a stale .git file exists in the parent directory, and the
user calls `git -p init`, we want Git to simply *not* read any
repository config for the pager (instead of aborting with a message that
the .git file is corrupt).

Let's actually pretend that there was no GIT_DIR to be found in that case
when being called from discover_git_directory(), but keep the previous
behavior (i.e. to die()) for the setup_git_directory() case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/setup.c b/setup.c
index 486acda2054..9118b48590a 100644
--- a/setup.c
+++ b/setup.c
@@ -825,7 +825,8 @@ enum discovery_result {
 	GIT_DIR_BARE,
 	/* these are errors */
 	GIT_DIR_HIT_CEILING = -1,
-	GIT_DIR_HIT_MOUNT_POINT = -2
+	GIT_DIR_HIT_MOUNT_POINT = -2,
+	GIT_DIR_INVALID_GITFILE = -3
 };
 
 /*
@@ -842,7 +843,8 @@ enum discovery_result {
  * `dir` (i.e. *not* necessarily the cwd).
  */
 static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
-							  struct strbuf *gitdir)
+							  struct strbuf *gitdir,
+							  int die_on_error)
 {
 	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
 	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
@@ -890,14 +892,22 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	if (one_filesystem)
 		current_device = get_device_or_die(dir->buf, NULL, 0);
 	for (;;) {
-		int offset = dir->len;
+		int offset = dir->len, error_code = 0;
 
 		if (offset > min_offset)
 			strbuf_addch(dir, '/');
 		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
-		gitdirenv = read_gitfile(dir->buf);
-		if (!gitdirenv && is_git_directory(dir->buf))
-			gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
+		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
+						NULL : &error_code);
+		if (!gitdirenv) {
+			if (die_on_error ||
+			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
+				if (is_git_directory(dir->buf))
+				    gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
+			} else if (error_code &&
+				   error_code != READ_GITFILE_ERR_STAT_FAILED)
+				return GIT_DIR_INVALID_GITFILE;
+		}
 		strbuf_setlen(dir, offset);
 		if (gitdirenv) {
 			strbuf_addstr(gitdir, gitdirenv);
@@ -934,7 +944,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		return NULL;
 
 	cwd_len = dir.len;
-	if (setup_git_directory_gently_1(&dir, gitdir) <= 0) {
+	if (setup_git_directory_gently_1(&dir, gitdir, 0) <= 0) {
 		strbuf_release(&dir);
 		return NULL;
 	}
@@ -993,7 +1003,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die_errno(_("Unable to read current working directory"));
 	strbuf_addbuf(&dir, &cwd);
 
-	switch (setup_git_directory_gently_1(&dir, &gitdir)) {
+	switch (setup_git_directory_gently_1(&dir, &gitdir, 1)) {
 	case GIT_DIR_NONE:
 		prefix = NULL;
 		break;
-- 
2.12.0.windows.1.7.g94dafc3b124
