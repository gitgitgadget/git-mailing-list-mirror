Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CAF520193
	for <e@80x24.org>; Fri,  2 Sep 2016 08:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbcIBIgK (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 04:36:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:64415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbcIBIfn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 04:35:43 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M5cpk-1arK6744KG-00xalL; Fri, 02 Sep 2016 10:34:36
 +0200
Date:   Fri, 2 Sep 2016 10:34:34 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] rebase -i: use the rebase--helper builtin
In-Reply-To: <cover.1472805251.git.johannes.schindelin@gmx.de>
Message-ID: <5a174968fa6410acc2f7987f3cb526d8d1ce6082.1472805251.git.johannes.schindelin@gmx.de>
References: <cover.1472805251.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yVpbqDTrWvs3hMYhOvYGFDDxPXXoj8EUktBfxetY2npMyRBMpU6
 ahgdW9of4VIEwkTfLPHeNsl2oR8/K8X6aa3ejiL4pEbgfSQ+A/bWnWjRtb9NYBOQeLnWMmn
 Oe8TTeQ0nczhVF7jPdGO5XWR+XG5EoCgSiAvmWrn7K1Oad769XAsCKWkotG/IIFJm6fcyZG
 thiXkZKNQv7WolJhwKYNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:txTrNfyL3Lo=:GVbG8Z8lcs8BPr2R/pPTDr
 AKMxYQ9bXvZu6K9Pbhoms3ZkFuw/ckb+mZm1mYjlB1VuevZoJgDzs35DwjzhwMJ7NlUZ93KVY
 /3LmEtFM/PQKqO0O24t7QRrqbpf2ONubGQ/SO5aP9x4sxY+wouFm/SZFolrhGJ05DiV5TRCgx
 uU/9RsJh5lX3o7fz7Ra5Gct2Rb1Dyp+v6acTYl5q4oZh4f6c/ya+NTBOiey/1xVNe2JjomAbu
 y0oUuxbjmSqBnjI//frEGIHAcxMuQsJYFmEt3n0v2mpwuowAHfhjXtZonz6EmRRmmDY6bzlCh
 ZI2CZbsGwTPB4RBmiDaxMijJMVU8HVqbWx9TtVbAl0dFt1K+9qB/7rX2JckY4L5pfMmuzE0+X
 33FnVdQ8w0riJe+MHsrwK3SVQWsGgVD9L5CGNoBnMah2p3SqMGl6QuJmIPqxdeeicsgfZRgWo
 /rDV7Agjtq2EG1HRTxhcL//7fSvm9AMkXEPzLQpaFJ+vGMbQbqtKflKQKA0hpefUfPoW1K48i
 7nqVQGeL7PYpJO7DdTZzp/4zIKN6yo5UwsMsPTN+UC+PCxmF6Gaik27tk1A+ml8qoefRQVWOh
 qjzqZxEHzQIYQkka5AXKtHr2qLpAlPrC3Ht6RepLA7oy5hnw9bbdZmSszUiYDJkwcqLnb3KD7
 LbYDUNN6qfMejMeyNnZcMbqFwBjFDJMy+2Of4VbBj2HQQo3UGcDNqkBirYMMi9VJf8nZ37Lwx
 YY42w53IXIinnLP4SNcaGgeGjDit6auBSX+Z4J6WkVg2bASVcrAC1Jze4GWSX+TLMVr+oDRiY
 lyN197z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the sequencer learned to process a "normal" interactive rebase,
we use it. The original shell script is still used for "non-normal"
interactive rebases, i.e. when --root or --preserve-merges was passed.

Please note that the --root option (via the $squash_onto variable) needs
special handling only for the very first command, hence it is still okay
to use the helper upon continue/skip.

Also please note that the --no-ff setting is volatile, i.e. when the
interactive rebase is interrupted at any stage, there is no record of
it. Therefore, we have to pass it from the shell script to the
rebase--helper.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7e558b0..022766b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1059,6 +1059,10 @@ git_rebase__interactive () {
 
 case "$action" in
 continue)
+	if test ! -d "$rewritten"
+	then
+		exec git rebase--helper ${force_rebase:+--no-ff} --continue
+	fi
 	# do we have anything to commit?
 	if git diff-index --cached --quiet HEAD --
 	then
@@ -1118,6 +1122,10 @@ first and then run 'git rebase --continue' again.")"
 skip)
 	git rerere clear
 
+	if test ! -d "$rewritten"
+	then
+		exec git rebase--helper ${force_rebase:+--no-ff} --continue
+	fi
 	do_rest
 	return 0
 	;;
@@ -1307,6 +1315,11 @@ expand_todo_ids
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
 
 checkout_onto
+if test -z "$rebase_root" && test ! -d "$rewritten"
+then
+	require_clean_work_tree "rebase"
+	exec git rebase--helper ${force_rebase:+--no-ff} --continue
+fi
 do_rest
 
 }
-- 
2.9.3.windows.3
