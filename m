Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BEC51F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756748AbcH2IGf (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:06:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:50061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756656AbcH2IGd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:06:33 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LsTjw-1ayElK1oXg-0121nS; Mon, 29 Aug 2016 10:06:30
 +0200
Date:   Mon, 29 Aug 2016 10:06:29 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 19/22] sequencer: support cleaning up commit messages
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <eeb3d11d235a0220a9a125a21d1b09a73d2c61dc.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:y7CwivFPXp5hV8HnxfQ5TW+JUSc56DFrPOhz0dt/0HmH1KfCSrI
 tM7Iz1NRwx0jhpdw5+OWl9nypxLsjD/xSerCVjMhhX71TJPcLGWi+Qwcjguy4dfO6bTZNSo
 ksQpClz/mdygydo++YMK+Wt6rJkNqBTekr54f24GCUFb7E3fcIYhIaJCIHxIMEL1s9k9U7S
 oEdNGRAnpcTKDAbM9DRDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zTEh+7kplS0=:UpTBeuqNN8Y91JSQmlja5N
 oPVxcWru2azVtvFg6p88eLlXrGmR2HuoQaQc5r2CYbShXMIDjH3NgdLnephzwzcRUZ/gPbp5h
 pl9OwY3TCOXe3i8J4/NVVKNhirVQDqE00maYdY4eYb7lKIWP80KAOvRWSPaNPc9nrJRDHMwsj
 iUZKhFPhR6kZkza/RgleMf/GS1KKAqmxNoRDtunCYpsdSJBHfMR5fdoNGLdb/+cxISEKENkQa
 jIVWVGolCuT1Oa3QPgB8LcyYm8Cm+NNr0hbmSB/oIHMoeCfg9w/XaFLm8LhMF8fX2UV8nr0mG
 ZJJh3D/rFcMpL3JBtE6p5G4x+FbznRIqHbZw70RuXBPTQhbC1AGIZTbZuW13lFs0hKOPJZR/1
 FrpWsH/e7GvF2+/IYEghNEDl2mrmssw5epRK7qqoilv4JuJzXbPTVot/og1HJARuXruJ1R0od
 80c6ecvtdaSNvEs1SCt/m7JAcaEQhYqyzfcgvUQB5oIod5SddUeAr5pmYLR3zPyIB3kQHOYNA
 DIGrzybC92APkjH3wiOe6W7VCBK160U2X5XAgw0wDqvOrEuUcr74CW9DNrvmIVlBZ5CaaaW3/
 a6znApOQPwVmKcOCysphG6625PPlFkeD5up5KBbLyGGeuQl/MNoKR/pg8tIp6n/vEGkxwyCLl
 gg39B0H3eT4kJxmnNilW5Qtk+fWtlcSzt5LfKuse+OFyV7SqE9IF52IqdaQETFcYRme+S3Hne
 5CozK+df6A/UZ7FWFBY0CC3olUbj6L6AMX72VAuOFMT9AabyDa/bABpqfUSOHHZXtAHwlXDZc
 XUcwJ9S
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer_commit() function already knows how to amend commits, and
with this new option, it can also clean up commit messages (i.e. strip
out commented lines). This is needed to implement rebase -i's 'fixup'
and 'squash' commands as sequencer commands.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 10 +++++++---
 sequencer.h |  3 ++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 20f7590..5ec956f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -478,7 +478,8 @@ static char **read_author_script(void)
  * (except, of course, while running an interactive rebase).
  */
 int sequencer_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit, int amend)
+			  int allow_empty, int edit, int amend,
+			  int cleanup_commit_message)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -515,9 +516,12 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
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
 
@@ -781,7 +785,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
-			opts, allow, opts->edit, 0);
+			opts, allow, opts->edit, 0, 0);
 
 leave:
 	free_message(commit, &msg);
diff --git a/sequencer.h b/sequencer.h
index 2106c0d..e272549 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -50,7 +50,8 @@ int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
 int sequencer_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit, int amend);
+			  int allow_empty, int edit, int amend,
+			  int cleanup_commit_message);
 
 extern const char sign_off_header[];
 
-- 
2.10.0.rc1.114.g2bd6b38


