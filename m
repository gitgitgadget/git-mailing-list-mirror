Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBE420705
	for <e@80x24.org>; Fri,  9 Sep 2016 14:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbcIIOh2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:37:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:63739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbcIIOhV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:37:21 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M1zFf-1atHfz1Cm3-00u5dL; Fri, 09 Sep 2016 16:37:16
 +0200
Date:   Fri, 9 Sep 2016 16:37:15 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 06/17] sequencer: lib'ify walk_revs_populate_todo()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <70b3840e62c8eaf2e2af829b65c746971694bec0.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tohgwka32+pj9uaDbzptP3uDlMozv7HLn5xRig3TSqJX3j0w8mr
 B0I3XfvWBH1CdvgI7M6KHgdGLWLDbk0x39/3PuWkOWr428UXW1KC6WNXjtn2a3LQQNUJHJ+
 sYDPn0ASn+3MVYQeKl8qrJah/7MmoW6zJXHoZdy93SZ1zubrcpTymc73KkmLxM71el4ceLs
 DcV6s3qQdRj9RrjhtAXUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vrVVsBOnS28=:vAncmDgx5aBBklf1EnEkd8
 8XfQBgDk43iX9YyztB8hyn653+xW23HSAckeS46rBjqLILgaTPmHVjCWBSsOvd7NptkuLRuX7
 r2ceVv6YaWQoFEBPo9aGm0ci51f0tl64O3wII7FFBM6CHW8WSFadZk3eudRgTwG5+o2d/LVkk
 MrqhkmaoCHovRXHeOvnDAfFlVSVGAOFXYbGjot/JMDrLFhXXg3dQ1Cimkufg9y9ABlkOWUMHF
 E5MDqtGQAS+A0b1Xy0f+L3QTkKXaT/gR0gWGHnhpLep36T8ZbwESaCGx2ZJSLgLB96hRJNDwk
 SeBeHTiuGWU0V6KNIIRbwG9/OxzH84/LcapjzSWfNsuOpkFnWNrJUCATJQrjw6fak+K+VVKm9
 g0wj/1MHFp/Ta9+NMq8TKtBYrqbX9T3+ybFSUiNrIA7rgRYNMRVh57BlqGqow5K+pT2Nlix0n
 WkyR0+VPbBcarhSMsTN66lmo5+var0Z0vtlKtLO3aGYDsX1xsb9JafZwGQZzEmFDwtfMmflr4
 JI5BtLCtYPz0hd7WwkemBfYGtJov15/3HpJzGEWF2HDSWwPvZR/bzLglpREs9ZFqbFVy3fguA
 /mqVg3fM/qQF237Rk/XSpmrieU4+QYheyhPYgrfKvjISLEZax+ETQAwHh2z+aZaWmpQSt05MM
 UKfpakBXZ2v37WfEPHfzDFfRlfFTmOgx7Yfm2KtkyntMFG7HJ0XDTW/JvsRUbhwkhwhCCaTje
 BesQ8NYE0AVYNxImo6KrCzPkhrugmTGT4bScXm9w0xWhepT3aRuX5/ojq/3lVMPYBSEu/qnXc
 iZbhdsw
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
index 96b9ae1..ab599e0 100644
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
2.10.0.windows.1.10.g803177d


