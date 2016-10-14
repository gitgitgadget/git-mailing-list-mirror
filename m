Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351AF1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932820AbcJNNUQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:20:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:57593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755685AbcJNNSK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:10 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M92ZJ-1c7RUZ3Tqv-00CTO6; Fri, 14 Oct 2016 15:17:42
 +0200
Date:   Fri, 14 Oct 2016 15:17:27 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 06/25] sequencer: future-proof read_populate_todo()
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <be30c373782e0022075c41541c15bf4ade026c3f.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mr5PggJBsZfhu/2WonHjJ2pet1YtNQlhn0oDA8/PmWUumyIVGdO
 gLHLnEteLrQz7G4akx5iRbegmn+uxhznelA2v0wYOsO0hbUvfk0RKc5StDh2k6pwLKlXg8f
 Jf+cB047HPoTXcYibif2w4s7FOR0bo8mFbS/PM6ys4c/4/GD7ueg52JsXIoi44srtiTqMpy
 zuIzH5gJO83E5JqM/hk6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UNKyn907jbM=:3JV2h4VIaBC5mjCdhS8Zvf
 qnDd++iel5Aq9d3lpEj5DZ7WHVXpfe9qtUDEwV3izTEQw/NUeNKMJ54xLF4pk2AY2CVb+k2re
 O4jdn2ZLbsEWWfyTLbej+SW0FoHFLOr+iym59UyxBQ6dHEoMuphoVSnYPhOUUcPTbT5oDcv/c
 111SRVsoNYTstXu0kz1jB4lXdySTeclXo7qx4aYQ6aKAgRloqQ5kowpI56/q0prVEPV3Wzwhf
 aFrTTriV9125+ffidFfsgtPKeo68wrVGSLO9yYoyCKtixIj6Qv8sGxhyky64bup0Mpj2Ud6X4
 eYPFXzvSiUbweu25y2s4TfwyavoEKSBNgyZm1SwlXPiuv+ZeJgnPPD47H219ZY7To1zBQLy+H
 aXWEMGetXKCR+QU6STWdV4f/D1NrUo5+CVVgM4h7CZt50EZrNd8ma9UpT9mOzotkE8hp5GYZO
 v3tpp/kjEoPvjgzUDEx4x35pGYgYlB5ZH8NP4VYTVRpAvlb7lJr33BSMRHlNTnzb/Ln1ba867
 BCSohgbAPsjOjnB14DtutILZiELiqs/erxkyxANRL3BilaXIgKlB6VORDvItvT70GFLfHBQnJ
 KX/SnEJIn1pKkKVClnlhNhuIuZoCiPLukiIe7K2NeG7A5bSzs3SkrfIXz583iuWW/MNGxmR3Q
 jAtn1BuMgpXz2QZXm5b/2L+/bVBa6/uCXVlRwmthbWl/3kCl2kQmpP+omTSdvOvbrlR+AvI+e
 sek2nkqMROlt6sYTppITKVhN3+vgb1weL4vNzVV5i2ydSw+tcviPtcDRHD1Iy4em8PdpW6Kl7
 h2GIxlO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over the next commits, we will work on improving the sequencer to the
point where it can process the todo script of an interactive rebase. To
that end, we will need to teach the sequencer to read interactive
rebase's todo file. In preparation, we consolidate all places where
that todo file is needed to call a function that we will later extend.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 04c55f2..fb0b94b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -32,6 +32,11 @@ static const char *get_dir(const struct replay_opts *opts)
 	return git_path_seq_dir();
 }
 
+static const char *get_todo_path(const struct replay_opts *opts)
+{
+	return git_path_todo_file();
+}
+
 static int is_rfc2822_line(const char *buf, int len)
 {
 	int i;
@@ -769,25 +774,24 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 static int read_populate_todo(struct commit_list **todo_list,
 			struct replay_opts *opts)
 {
+	const char *todo_file = get_todo_path(opts);
 	struct strbuf buf = STRBUF_INIT;
 	int fd, res;
 
-	fd = open(git_path_todo_file(), O_RDONLY);
+	fd = open(todo_file, O_RDONLY);
 	if (fd < 0)
-		return error_errno(_("Could not open %s"),
-				   git_path_todo_file());
+		return error_errno(_("Could not open %s"), todo_file);
 	if (strbuf_read(&buf, fd, 0) < 0) {
 		close(fd);
 		strbuf_release(&buf);
-		return error(_("Could not read %s."), git_path_todo_file());
+		return error(_("Could not read %s."), todo_file);
 	}
 	close(fd);
 
 	res = parse_insn_buffer(buf.buf, todo_list, opts);
 	strbuf_release(&buf);
 	if (res)
-		return error(_("Unusable instruction sheet: %s"),
-			git_path_todo_file());
+		return error(_("Unusable instruction sheet: %s"), todo_file);
 	return 0;
 }
 
@@ -1075,7 +1079,7 @@ static int sequencer_continue(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
 
-	if (!file_exists(git_path_todo_file()))
+	if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
 	if (read_populate_opts(opts) ||
 			read_populate_todo(&todo_list, opts))
-- 
2.10.1.513.g00ef6dd


