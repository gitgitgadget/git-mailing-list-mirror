Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4D491FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 13:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbcHZNs5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:48:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:62748 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbcHZNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:48:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MBVwM-1bnlsk1fMs-00AYuf; Fri, 26 Aug 2016 15:47:44
 +0200
Date:   Fri, 26 Aug 2016 15:47:42 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 06/14] sequencer: lib'ify walk_revs_populate_todo()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <752e8fcd89fc08f198f06df145857873dbcdb000.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AJmKh3vdC4BEaxR9d2zJfMMvzY5nir3Tlmm/jILwK/U9dGPmsGJ
 ARGX7ergNL8yEQcqeWuUE/dbdAStNHagC4V9LPDUmpf7D5r6R2+4HIdwwOlAjGuAaPqKVyr
 wh/kli4+eBcbAmKXYK6LkFg/+yjCy21QjaihENof/BiCgLI4RHEozwptkm452rUy6APlExa
 z6+nXGlSC+0FD/j2WgVcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LChrJbTjef0=:IZE3vC+hhsHrxhzoP8dnNR
 hE8t0PGk6Cz//B7/AWwEYkJBOPnpmet+7hayGkWs/AiyCJL0Ld3Tc6jYpgsQmVa4C0deAgHZ6
 CDw3TIhQeoRdgGTFmgl6hbFxGEaglDG7HhcNic7CoJhseVzWrpFLmADJphIi/nBjz3a/elide
 IcYQ+a5fFTVtNAuttI0M0pNvvAemATXXeQnf80IyxkoLRxU0Kb3SOeQcX+PhTGPZI74YN8Mzh
 B0dbn7LU0QKyWCyaSndnBDq0BxgsFveOaOnuP0mPY18f4uGPxwDsFOhjLo3mZ622oSyP0MzmE
 W4iaJT4Kv4vj5udrE2hikkBMlRhc4gMCQIXUeLMXztkwo3QsxajWWBXZYwgxGB9h0oQhkw7PX
 /aUX1EHMjm6qbPhZB7X/VoXDyT9vyywbcqet31WO3rjz6YXMamXpdL69grYUnUhWZ8ptUxhkG
 uq0zM4oxZkplBVS1l40VH4K8h3ZpzmuqCT6tXoeAArGPoRwFLgIZZbSv0iBCHFYfp5cU5XkNj
 a+K8y51vP51/YaJVAm/75gHVmMA0a1iIbmVo3viTifktDZneGcycX06JivKr4rfNX6hGdzx34
 eoiNK7c0sb2L+wbZQm/6RSwK+6iepSBfZwDXX+oefutA1snhpkhpet+JzBH/JnYDlvqeqJKwF
 Z9dvatwyhviasi6Wty7dJtyc0n5zz7HIZApIHrC4+p6x3zWx77kQr3JDCmLtQMFLJ3lwyibYv
 LfPW+2UmX4nVm6eohuchB2OLAHR7KfVTURVGUd6aXukY7RB9DhT6rNnzWTn2wyJi12JIRGdcl
 /zM7kp5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain notice
the error and handle it (by dying, still).

The function sequencer_pick_revisions() is the only caller of
walk_revs_populate_todo(), and it already returns errors
appropriately, so its caller must be already prepared to handle error
returns, and with this step, we make it notice an error return from
this function.

So this is a safe conversion to make walk_revs_populate_todo()
callable from new callers that want it not to die, without changing
the external behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7eef512..ea2681e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -809,17 +809,19 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
 		die(_("Malformed options sheet: %s"), git_path_opts_file());
 }
 
-static void walk_revs_populate_todo(struct commit_list **todo_list,
+static int walk_revs_populate_todo(struct commit_list **todo_list,
 				struct replay_opts *opts)
 {
 	struct commit *commit;
 	struct commit_list **next;
 
-	prepare_revs(opts);
+	if (prepare_revs(opts))
+		return -1;
 
 	next = todo_list;
 	while ((commit = get_revision(opts->revs)))
 		next = commit_list_append(commit, next);
+	return 0;
 }
 
 static int create_seq_dir(void)
@@ -1102,8 +1104,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	 * progress
 	 */
 
-	walk_revs_populate_todo(&todo_list, opts);
-	if (create_seq_dir() < 0)
+	if (walk_revs_populate_todo(&todo_list, opts) ||
+			create_seq_dir() < 0)
 		return -1;
 	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
 		return error(_("Can't revert as initial commit"));
-- 
2.10.0.rc1.99.gcd66998


