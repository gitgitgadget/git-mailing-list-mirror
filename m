Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8505F1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933785AbcHaIzX (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:61630 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756381AbcHaIy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:54:58 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M4o41-1atuHT1AFR-00z1aF; Wed, 31 Aug 2016 10:54:54
 +0200
Date:   Wed, 31 Aug 2016 10:54:53 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/34] sequencer (rebase -i): allow continuing with staged
 changes
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <31b30111bc29fd7362824034857df87b551c725a.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PN8bWCdfb7Rs4/04/zh8QvxLFANH8TCpQAEEX+N0CRokAlX2/oh
 iIQ7K+2bKRxLBXLQ8B2aAkj6xHdhKJPUU7lbDGEr9Kskvy0/rH5VIuFYbNaIG2jef5KOhcT
 +cWUSFfUUC8ar4pXchNTP30HJUntjw0kkeebHkXGg01Ju8fHhsNz5pUc8iNS2Rm3s40S/F4
 ALIMUumtap9Ofir8tGt1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Qm1j6L1W8A=:ibauHXF3NOwnGb1Cn8TzAi
 uy28a3acrhUxIgs98HBb9ImxWX5g9JCj54CMxSXFegZRVosSEMVW2GshTAcyaajVcvZ05Jgju
 3uCNaYQo3MgSCiQ4BoX1cj8ZXaJrbE5WovslYNaJwRgzxnV7h1+n/bLyofZ0otKaXBiIHgy5v
 kx6EqxHA3C2P5mrZWmZHbQfZ6EE0uohcTToQFfgPp2hVyF6992fbOzNS3z4tpEG6la65aR5nH
 1+JaKMV/ROgEZPjzky2hP7hJQ5N2+XFDe5twSILGEHEAYqBa2XWbG2muC2kYPKNwXJ7zVh0g8
 UNCKAo2nsbkjQFqIps6+b4TrSyqZ9oAhjI9x5ZPx3wGUqGzWhI+Ft9Wl9P7K1DNOe54hL4Szm
 IAJYBeZNGGQW1zp0hyF9xXh7so2BnoeQYbIqoxYNJngvfSOp1ldTSoNN0sgXtQSKlKLMv/COE
 M4pMNDu+th40uCKUgH9wciN9UsCLoa+Nd6CuAPktFybTprcr3jUuDSAtNKnbOIQuNNWy1JI2G
 lC2ZGwZKjbpvIqKerGWa1rk8H4r7N9fjOhANcf6DvRIzv54pz+YKcI7L85cSQ7Xt9U7Rn2EMc
 GcdMbZ9KmaW1jcQoos3Bdyo8naqP3k3Bp1KL/jw/GtQbWQXSyJoyMwRXP+4/FoMjT1wWqawQC
 jUUnGkkLCSGxfwAvcG6jdZ96bN7HxcJZu5eLokYQ4MEZCxrGCACY63o3JPe26Gw6DQzEVha34
 DVHkHb7YGyuS6y1ggvhurZyCywh51Bje4k7gF1GiUprwO8sEjpIYR0SWelgcT8Wl6G6jHyt7Z
 SptkzjV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an interactive rebase is interrupted, the user may stage changes
before continuing, and we need to commit those changes in that case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index ef818a2..4ddb12e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1807,6 +1807,41 @@ static int continue_single_pick(void)
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
+static int commit_staged_changes(struct replay_opts *opts)
+{
+	int amend = 0;
+
+	if (has_unstaged_changes(1))
+		return error(_("Cannot rebase: You have unstaged changes."));
+	if (!has_uncommitted_changes(0))
+		return 0;
+
+	if (file_exists(rebase_path_amend())) {
+		struct strbuf rev = STRBUF_INIT;
+		unsigned char head[20], to_amend[20];
+
+		if (get_sha1("HEAD", head))
+			return error("Cannot amend non-existing commit");
+		if (!read_oneliner(&rev, rebase_path_amend(), 0))
+			return error("Invalid file: %s", rebase_path_amend());
+		if (get_sha1_hex(rev.buf, to_amend))
+			return error("Invalid contents: %s",
+				rebase_path_amend());
+		if (hashcmp(head, to_amend))
+			return error("\nYou have uncommitted changes in your "
+				"working tree. Please, commit them\nfirst and "
+				"then run 'git rebase --continue' again.");
+
+		strbuf_release(&rev);
+		amend = 1;
+	}
+
+	if (sequencer_commit(rebase_path_message(), opts, 1, 1, amend, 0))
+		return error("Could not commit staged changes.");
+	unlink(rebase_path_amend());
+	return 0;
+}
+
 int sequencer_continue(struct replay_opts *opts)
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -1815,6 +1850,10 @@ int sequencer_continue(struct replay_opts *opts)
 	if (read_and_refresh_cache(opts))
 		return -1;
 
+	if (is_rebase_i(opts)) {
+		if (commit_staged_changes(opts))
+			return -1;
+	}
 	if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
 	if (read_populate_opts(opts) ||
-- 
2.10.0.rc2.102.g5c102ec


