Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2793B1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932651AbcJNNS7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:18:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:62471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932428AbcJNNSh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:37 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MZTw5-1cG8ZB00U9-00LCuD; Fri, 14 Oct 2016 15:18:32
 +0200
Date:   Fri, 14 Oct 2016 15:18:31 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 18/25] sequencer: do not try to commit when there were
 merge conflicts
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <38d5f853444f80c90713f7a6e4ef1f2382549b29.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ubOLcwj3AVAfmI5zpKOhwJJqxO7+uqG5TlJa4tfvHVMQd1ao4E5
 cdjg+L/v3+U37/mb6ID2c4+8xOyR6vsu4Fwjn3W0ZdhKbvcYPlkK1s46VyrKYwAcn3d316P
 HFPsTx3oi6TjcKuFKJXMV+jPje8K4s9DtXZBtKj2KEVhS/VwTVWm4WeFVhL8jcsGP9qTAVQ
 SBMnWB6hyi29VWb4E+ndg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oFniTYjlNew=:draF1YRj2l0j1Plhuu0Hq/
 Gz4n8PcvYR5LzbzpyaYKcwqZLokpn2uqOQoX5S1I6HmekGr0Qx1nXalZJCX/k6wTD0QGFdf02
 3Zw9+IsNdt64sAdGO9qQDN5Ochfz7N2cgQAonere85GewqD5Gry8y4Q95sXYpCVw7Kv52w02Z
 ICo3DK++uebxD8/oJOpLv3s6iLeIvtcHToITThmlwDSPX/qJ8lksbLClr0sPuaPfZTaCoBmzt
 iK7tn7wuPysTictbf7RBAPKaapsTKNz0jSsZMKL0Cfoxw1r41QcKZy1Vzfif7FK3nwxJ1VMyk
 7rtiE+LZLq+7hT5tjFyqTWlJM7FYrvtI8sUJQ2+gpkgZEhTrdVhRqmaMRIKoLXOR6ravO+bk1
 qnzZG6IwxpRwZR4WMm6Mh2ZC63Avkuu/7iCk4EhlWxniSEkVdte48kQAPcO/sAQSJIqP9fAoD
 ey74rL6mphwE8cRGewvL9w5OPtRtxC1N6O6ehsH1pMMvFpPG8cxye4rilueAgtm2sXgX0KrTi
 FKOKDntcyUzEPC4R4IHmWqy5y7l6cztLRLcEbg6fC6DgxEL2k8jeIExiWhQf8hHJiWYFRYN66
 fCA+0CJrqKSjTfmmjYvpWdGG/l3PVq++RVuS/Ps7Qu/aYvkNW5MkWuroQAa3pb1aLGMEHuliu
 5FsRvTKKQUZoHqRAcAaNGi0PCNTDiZ2amAdzSRCTwqj75X0UiFH9Yai/Do0ibFjVkOjRr/M72
 XJM2EuyQ95006K6SaDM82pclaqDFzmJl7/1o1gk57/fNsbIePq4y4eBvtC7phSynpTdEOJU9i
 /NnpOxd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The return value of do_recursive_merge() may be positive (indicating merge
conflicts), or 0 (indicating success). It also may be negative, indicating
a fatal error that requires us to abort.

Now, if the return value indicates that there are merge conflicts, we
should not try to commit those changes, of course.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index cbc3742..9ffc090 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -787,7 +787,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		res = allow;
 		goto leave;
 	}
-	if (!opts->no_commit)
+	if (!res && !opts->no_commit)
 		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
 				     opts, allow, opts->edit, 0, 0);
 
-- 
2.10.1.513.g00ef6dd


