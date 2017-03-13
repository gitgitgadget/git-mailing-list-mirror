Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD6020373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbdCMULs (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:11:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:61555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752234AbdCMULq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:11:46 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0ML72n-1cnnQY2FBh-000JEL; Mon, 13
 Mar 2017 21:11:23 +0100
Date:   Mon, 13 Mar 2017 21:11:22 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v6 10/12] setup_git_directory_gently_1(): avoid die()ing
In-Reply-To: <cover.1489435755.git.johannes.schindelin@gmx.de>
Message-ID: <134467b8ead65a6eaab10cf3ce35eb577edf2fa1.1489435755.git.johannes.schindelin@gmx.de>
References: <cover.1489098170.git.johannes.schindelin@gmx.de> <cover.1489435755.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4cDTlqnu1O0VotWlyhZeoZMlClrlfRDy9dqH3KpYtpeDWYOhd6w
 7jg5kC6Igvwvhfkn/rzB1nD2+43LuC3wbJQCdbc9eSBFn8ast78lEqnNT4oG1jojOCC++eC
 U73bTtPgNCSgkyBydLTVrfK2Uy8Nvn/o1Fvuwm4EVJTvyGjkSipZ+iVbQB26/Ynr5K6ctWO
 W+Ug/6PfFdi5qsOyCP9fg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9KMRyiBzPpk=:vgXj1+X++BSnEf7TOEtbVE
 nrkkz2jEF4EWrdUt08zgCnhY1vvO9uwR77kCONK2fMd7FJpMKt9FvGniFYrbXZ9kvJNRL0UN5
 9BsDXXIwEPO693bhWp+AbNg+1RLxxS4r9/hO7+iM3oajryAHXpYvBY4pL8LCjKuK4YOydUlii
 DCnTxOZc6SFJ7TcCcSBJNATFAx6W9nHahtjxYB9dQGIdCgBmzHhPRbWntwvnkcYsyfgQdoCeU
 5CeeuZjro9Ewmrmg3vjMYlG+idnZ2QbKzCiFewhTiSzDBzENb3yO2lvs4vDgGlfRMNw7bZmdL
 qZAkckVaIjRBeDFu8+JN8gFhM3f9QhyZj0BktZAm9AOj8G8G/8MZUB8ZT2gSilc2RHuP6AHl0
 11fmqlPFZeUTQMzcNwCfoKRNmzKwaUgLFNe3AtW+pJbYHzO8J4Q9twJvNTaN7yNStBZMbJKLQ
 AyE7x2GWtTmc2zvM1pfjZ9XDbhmkPCjpIWH7Y4Qco1xxTVRvOjkqmZmGA1KLZtjWyDTjWHWe9
 drcX1jmz5aaoLxNZ1hMj5NPF1tCjK9qq6IIaoNcKX9gNQCXc08JDino4Ew9YQdT+OGfqXYV33
 xnSUvmzFDY/KliB7euOVOwdZMHQVtGR6W0HamHAvFsqTejELwDEzquedaEVf7Ub1+1DCoqpvL
 p7TuRBZeT4rode2JWHoDRNJleRe673lr6ZshVOSHHk4xaNoQsjWUaIpFZfSgREO1MFIopXUdp
 V8tH8J+wIL6LixSKql/7vpqYYSxYObDGNvroharSbhVIESi8+3JHQYA7l0YkZswe2lzkMorRe
 3dnfmY8
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
 setup.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/setup.c b/setup.c
index 411e8342972..f31abf8a990 100644
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
  * is relative to `dir` (i.e. *not* necessarily the cwd).
  */
 static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
-							  struct strbuf *gitdir)
+							  struct strbuf *gitdir,
+							  int die_on_error)
 {
 	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
 	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
@@ -890,14 +892,21 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
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
+					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
+			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
+				return GIT_DIR_INVALID_GITFILE;
+		}
 		strbuf_setlen(dir, offset);
 		if (gitdirenv) {
 			strbuf_addstr(gitdir, gitdirenv);
@@ -934,7 +943,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		return NULL;
 
 	cwd_len = dir.len;
-	if (setup_git_directory_gently_1(&dir, gitdir) <= 0) {
+	if (setup_git_directory_gently_1(&dir, gitdir, 0) <= 0) {
 		strbuf_release(&dir);
 		return NULL;
 	}
@@ -994,7 +1003,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die_errno(_("Unable to read current working directory"));
 	strbuf_addbuf(&dir, &cwd);
 
-	switch (setup_git_directory_gently_1(&dir, &gitdir)) {
+	switch (setup_git_directory_gently_1(&dir, &gitdir, 1)) {
 	case GIT_DIR_NONE:
 		prefix = NULL;
 		break;
-- 
2.12.0.windows.1.7.g94dafc3b124


