Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA3E2018E
	for <e@80x24.org>; Fri, 26 Aug 2016 13:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752987AbcHZNsn (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:48:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:63744 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752513AbcHZNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:48:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M5uLh-1atRAL2QZ7-00xohj; Fri, 26 Aug 2016 15:47:56
 +0200
Date:   Fri, 26 Aug 2016 15:47:56 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 10/14] sequencer: lib'ify read_populate_opts()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <0fde7522953f71bd07e6aa7a15081dbf069aa6b6.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:R3PAODljEs726cGjLh+sa6DH0fCD05DvgQDJQBiRdk4PJZhcpBJ
 p10UrUzTGC7o/IUct0dP4mjNynpHGnmUZPREOZhgilxcTRmaTVRFbiwUr6CzfsDoKGP5ZqU
 Z+WPxYMMsPLCsHwCcGoXt/GjvInLB0nN4h2gNLCQeoaUmjy3Pn169x59OpsDgO2vgJIgVyY
 cRJADvK7OBTGWry/3jlAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7pC2zruf8Jo=:5mGJWgXuqwFQHPQt0k4nj+
 jYoROaUarwGkbFr9DKNApYVYtRiUbKAWg65GGiyh8UFwO9tPmwmMRFT+DaVe0qjinRsxGieYK
 aTkjBNoN/2AzWxLN2KB72/WMysG2T9y7/D0ePeJwLFOypvhwCdY3pXjvzY8osbRJdVbJkzSvH
 QrWQIgi6qmlNO8SYuUxuGPj05ggisi9Xacz9w7QEsALOTEXbQgdjFGoXQhFMUDqctrCMNTE8b
 ybFJnsDGOapjFulIJmLczeP9dYGvz3pCQsyvlE7gKESzKaBbhfr1wqBagEx42Uscot/No1umD
 dEVdzrPtqcVMoHc0/3PTKndc/VR5eDGExbJNlE3dahLqnnnhNPnpltLEWMA6ZUpYhL2E0dwo5
 vXYUNB5v96F43htmqRwOxHLe56Pr53MzEpLW/PFg+jUcLn8g81yljpGU89nSAL595ShBTY1ob
 pjKflNfy2mTWE3VOLjfyFPSGcFERxUzO6kK9g+rtVrfhsbBot4toYuXeVii5acp6CsTpy/A2v
 6NDUv7mev9OjT6HB0LY1sR8/4yvE8nT3q+vGlsElc5Y73IkpIlFDi4xzDQTGLkCOYzBzIs0Tb
 GqxgaUJFQA2APTA4Es9HkPyjmMhd1WIUglaVfzZv0EEpep91DtMJnvQPWH5XU2DyP1Pa0jMvO
 v+SiDxeSxYrty+kROoB2bCrKlkJpf3QIYeQtcXw5giGwSktWdWLu4CxWYNnUrKkt9jFrxAGrx
 W1PrkoicGmF4Ok5M7oLegdxEgemamZmlEPhXx37e+z+FWkz3E945xcH7f2IBFfkcIID/jHWiL
 O1Ibju/
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e11b24f..be6020a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -808,12 +808,14 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
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
+	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
+		return error(_("Malformed options sheet: %s"),
+			git_path_opts_file());
+	return 0;
 }
 
 static int walk_revs_populate_todo(struct commit_list **todo_list,
@@ -1021,8 +1023,8 @@ static int sequencer_continue(struct replay_opts *opts)
 
 	if (!file_exists(git_path_todo_file()))
 		return continue_single_pick();
-	read_populate_opts(&opts);
-	if (read_populate_todo(&todo_list, opts))
+	if (read_populate_opts(&opts) ||
+			read_populate_todo(&todo_list, opts))
 		return -1;
 
 	/* Verify that the conflict has been resolved */
-- 
2.10.0.rc1.99.gcd66998


