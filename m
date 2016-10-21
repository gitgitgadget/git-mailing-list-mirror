Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3937B20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932706AbcJUMZm (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:25:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:54663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755140AbcJUMZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:25:37 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MIzGn-1bvcwd3mUT-002ZRj; Fri, 21 Oct 2016 14:25:31
 +0200
Date:   Fri, 21 Oct 2016 14:25:28 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 17/27] sequencer: support cleaning up commit messages
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <8417e4f871cad36e558feaaea79c76f7b9d1ff18.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/c0HAJ6kFQFqX2xa7UrP+xj2BQZxfmVErXAJ7fFUiCR2HQZXg7I
 3uZLrdNj1S/D5W4d+oNFslbTewLN+JbP6R+TvOemxQSTBnG8pxrN6cp0eesADxSj2+ss8Xc
 b2GtOl42TK3dz1HQdueZjzghI0E14KQGVyBaStfDlagkhtXWBie7uq2/5RLiji11s/W2c/t
 hqneQ3n8TsnrEP/jSilqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DfrprkKjHrA=:uix7Cm8wK4LjAPY8GkrDBG
 aSJlSxWZ9Ri07cqoYVpFfJFlJXnLC98LTY7QgFFi08vbUtO2pEjH+1gET69c3aLYUe1sU2fa/
 Upsk5VcfREE9RxhYClH+sHlOBltcr1OjkFmD+jPBjEVJ/Uz3OCzA9sACrbVPF0DSPBNLOWmOx
 GXkOkrV93RuJsyXKgdi7et5FQp4nSkTHge16V78jueFOLYUuV4r8FmwsX84rJqpfsD40LA+UE
 kleLXbTvI07DfmuvE6L8WegjPlDSiqZ/Y6nhxAGWr0WY//p+AnmQZuwW+s6xGLHd4JW1qE2Ch
 Z74Rkzd/E7HNJxLhXwZgbLQBtaGyrsNxPmQCHhvCJiYebgu9rPOqDch5Gee5ZPmU228XJc9Ly
 n2Bop76F+7kEzrd9Bi5jOp+RLwKGjh6cTKLA1lWdb6BN5q7VPXuv1P+C8Uca60VU1QUdykNbA
 R98R/reJ86PAoFu5+wrKckAmaFjzlZB7uGG52A3FxQzxvOQIScYemWMMYv1F4SESlIlPGBU7T
 lbXo3lkRDDyiNH3qXPMtQcTIpOmZHvXwfk2wXvIdaVkB8B06Rtnhvbquu2d4Il321bjwwENxT
 ToXyF67UzaecC/dGy4IjRLf8N2HQbCZrqJhSMKXKO2sh+IhH9AJqi7yc6x3sUAUkDCCg8/xsK
 j6fJtMuI0NVlRo3zWj+1GSzxe/msKXm62NTWYpjzJEShX7F91XfrhfztsOzhRMuaBFpgRVdYh
 2CkrUi7aH536/eu5DipwDDybJ6ci11s2hIr5+xtZ+B6Br6BAVlmt2ZHxxYyvEfG2JHtu6mf3d
 T+jVACP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The run_git_commit() function already knows how to amend commits, and
with this new option, it can also clean up commit messages (i.e. strip
out commented lines). This is needed to implement rebase -i's 'fixup'
and 'squash' commands as sequencer commands.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1ef50a0..8646ca5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -484,7 +484,8 @@ static char **read_author_script(void)
  * author metadata.
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit, int amend)
+			  int allow_empty, int edit, int amend,
+			  int cleanup_commit_message)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -521,9 +522,12 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&array, "-s");
 	if (defmsg)
 		argv_array_pushl(&array, "-F", defmsg, NULL);
+	if (cleanup_commit_message)
+		argv_array_push(&array, "--cleanup=strip");
 	if (edit)
 		argv_array_push(&array, "-e");
-	else if (!opts->signoff && !opts->record_origin &&
+	else if (!cleanup_commit_message &&
+		 !opts->signoff && !opts->record_origin &&
 		 git_config_get_value("commit.cleanup", &value))
 		argv_array_push(&array, "--cleanup=verbatim");
 
@@ -788,7 +792,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
-				     opts, allow, opts->edit, 0);
+				     opts, allow, opts->edit, 0, 0);
 
 leave:
 	free_message(commit, &msg);
-- 
2.10.1.583.g721a9e0


