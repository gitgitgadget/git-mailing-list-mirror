Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD04920705
	for <e@80x24.org>; Fri,  9 Sep 2016 14:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753204AbcIIOhv (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:37:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:54676 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbcIIOhs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:37:48 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LxPgU-1axSfc0ZpK-016w3X; Fri, 09 Sep 2016 16:37:42
 +0200
Date:   Fri, 9 Sep 2016 16:37:27 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 10/17] sequencer: lib'ify read_populate_opts()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <77e4701a438aa266ea09e10df0820a8a8bb2feea.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GyXDnQm5NScyIpbh89PQdMmd5DqSY56OIz2BC3JuMF/ZBz0zdlk
 cdc7rjgwbL+FzMitBwQJcEZfXi4mTJI2KZ3MLnMMASxgglMU1S+Hvo+HHtzhLII+PXAmnOE
 k0Fdg9Nn8u8iWFHLQBg+t1tYBFlMkMtoWN0BF6kETI9Xt9+IMhWTAYqzlfWqenCRdcRP4sE
 X0MDwoh/R9GqKdVdsmrLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LdudmQIGYrM=:XPLgGj+znm7isPd1+1e0Bl
 emx51D2UAyh1pvPeQEoEqTZdM0j2n72tZWQvjVAApJGRo+UubmZ5dm0AiTf/UVlARDy/vcYJ3
 kwITE5h12T7RUbBlw5RjxFuaEkdqyeWt15tHEl0sw2O7HOHjP2zTn5WM7Qbctw+mGRoffvYO3
 WSOJ00x7csbTsU+z2KNAhW+wVZU12m9mKw0W9eeLLNoxvm9W6Gk1Pgwlz/oA6wPJTFnVkRb8V
 AAG5/r0+gbo36WGVakkS/cOWJOrTzN2XF1Gh9oHygePpuH6A8XZT3XwToig9zQdiBrBWG6LO/
 xATWXzXlX79NiJUFIwm3Fc2RPx4uQ3Tl4RiBfjuHqqWAJjol9IKRb9PX5OaXdHw8WKk+J81bD
 +mjThldUdL7mnoe8xSol5Gxb0vcCQh5xWOjQcWnQ6RYGI/dMYhS3ZQowRviQyfGJIUx5asaZO
 vszPAJL/+n3oWUt6jS+O+PBNaMTV1DUkg2VsLq2qi/n0M/rvhV6O00igF8mkX6xbrtFlkINRb
 ktW6G82Ky5SMXvGL20D6EdAAAQwFPLUqp/iNgPXCUppgAuHtDtlOKMe4foNQ21X0FgD/TESw6
 vUFctczqfCap+Fsc+NOYW0GPEhchI3G9XPsQ4CWQERqQPrG6pQ4YRz86HafyuECw92P18tfqy
 hjBx4LUzAIQYiqEYlkRp877N7/dYMi1hzfQEiimIkiZYos9GJVcPVUCpt3Jhqet749r/KaDsh
 1kf4j3LWrLp4pKN4iMpGfBf0BpVUTaJEXGmSRZ3KYPH7P9D0R04v1XYyZliwB6bmEY5AFtuer
 QzdXXG1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain notice
the error and handle it (by dying, still).

The only caller of read_populate_opts(), sequencer_continue() can
already return errors, so its caller must be already prepared to
handle error returns, and with this step, we make it notice an error
return from this function.

So this is a safe conversion to make read_populate_opts() callable
from new callers that want it not to die, without changing the
external behaviour of anything existing.

Note that the function git_config_from_file(), called from
read_populate_opts(), can currently still die() (in git_parse_source(),
because the do_config_from_file() function sets die_on_error = 1). We do
not try to fix that here, as it would have larger ramifications on the
config code, and we also assume that we write the opts file
programmatically, hence any parse errors would be bugs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c73cdfd..1614efb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -808,12 +808,20 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	return 0;
 }
 
-static void read_populate_opts(struct replay_opts **opts_ptr)
+static int read_populate_opts(struct replay_opts **opts)
 {
 	if (!file_exists(git_path_opts_file()))
-		return;
-	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts_ptr) < 0)
-		die(_("Malformed options sheet: %s"), git_path_opts_file());
+		return 0;
+	/*
+	 * The function git_parse_source(), called from git_config_from_file(),
+	 * may die() in case of a syntactically incorrect file. We do not care
+	 * about this case, though, because we wrote that file ourselves, so we
+	 * are pretty certain that it is syntactically correct.
+	 */
+	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
+		return error(_("Malformed options sheet: %s"),
+			git_path_opts_file());
+	return 0;
 }
 
 static int walk_revs_populate_todo(struct commit_list **todo_list,
@@ -1021,8 +1029,8 @@ static int sequencer_continue(struct replay_opts *opts)
 
 	if (!file_exists(git_path_todo_file()))
 		return continue_single_pick();
-	read_populate_opts(&opts);
-	if (read_populate_todo(&todo_list, opts))
+	if (read_populate_opts(&opts) ||
+			read_populate_todo(&todo_list, opts))
 		return -1;
 
 	/* Verify that the conflict has been resolved */
-- 
2.10.0.windows.1.10.g803177d


