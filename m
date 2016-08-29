Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 687A92018E
	for <e@80x24.org>; Mon, 29 Aug 2016 08:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932676AbcH2IGF (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:06:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:50117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932511AbcH2IGC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:06:02 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MSIf1-1bWkVa3lJj-00TRym; Mon, 29 Aug 2016 10:05:57
 +0200
Date:   Mon, 29 Aug 2016 10:05:57 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 13/22] sequencer: remember the onelines when parsing the todo
 file
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ueg6pCcSaSMVpoPPs1AjCy9/u6IrmbHO+yIOBUbnCl+U5ksv9cX
 poiKUhOdIm+nctSTX2rGuUnvy0ATRlBiT4dCDQeqm9vb+AW/2/92l9LIXrcGrX9k00fpdKU
 kob+BXmt70yc16iWmL67T1sYE+DeNEAgsCVjOjbYdDEVmPpKTeXrPkHIVc6VdCQ1+zwY18/
 JtyXVhAZVf6xNacWF2o2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M4IFr6S8Iqo=:VCaqUJ5cs+1NBlzeBgsdjZ
 L9nwNWrh6ScW9HALoiIReHtWY5BfNRxCe4bLC+PjdvXYAFFBiACcVsk/qXSn3kuqhwqUhxocB
 Ad4kw2UTZQVXph3VgwB6xScKokYFfALjbfbJVofQSmRX6WMs22HbnQy5Yqe6Oh4yyJWQgGCwr
 EPbW8OTVTMc2K0ZZSB/+sKXrOijMNCfRj9tmqTtWfaSZeIJhCttKFuuXYiaS50/gCyNPixkaj
 OAb6GIj+4fl0Zic8RNWhe5KkUunyyr/NUgztFtmX9RSRGkvzTHhXlY0qIOOBG5lXdFJX9MnYO
 6hbGTQPmN3w5E07f3E6z0EmmQuBGgjJoq4hEO+FEoyLp9sfF2Hv4Mto75WJMYc1nk4bUvoOev
 CJEmTS6PyI0iJq+FXplr2XQxhLM6+CfTdpaHtWyliFgNa9hkf5NW6li4YcD1/3uLKo4Wo7Z1c
 HnHHbiSQep5JgSXijmAnsJhssJklC79DRta/5Vm0f4DxDHGlSnkjIQZ+3BPbCWxo4pb3FcyaA
 PymQ5hlCDueFaxPwne8uNLl/v2ic8Y1oI4/DIcO/l8OJ4crrpSVB3V7w9SKSkQkhlxnSlzpir
 vr9lDsUpja09hHyxh+MSsBRQAJRfPGJ0qRdmp9cZLujiWq6EChcopyvCqhT26O8EZMFxTzNVP
 Ab/qKP8jBExXrvsTnaa2ogk+8bykjL303zMGEQMPUK8rvotJm/wEqmyefYUTV1wPFsJ/0bXVa
 UtRi4YMOGHbccbgahy43H1mRTsEjKFMb46ny/5HZSsLnMJ5oShXmsBTmlxykVeeRZ9o4VgFcV
 J7f9JNK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git-rebase-todo` file contains a list of commands. Most of those
commands have the form

	<verb> <sha1> <oneline>

The <oneline> is displayed primarily for the user's convenience, as
rebase -i really interprets only the <verb> <sha1> part. However, there
are *some* places in interactive rebase where the <oneline> is used to
display messages, e.g. for reporting at which commit we stopped.

So let's just remember it when parsing the todo file; we keep a copy of
the entire todo file anyway (to write out the new `done` and
`git-rebase-todo` file just before processing each command), so all we
need to do is remember the begin and end offsets.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 06759d4..3398774 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -709,6 +709,8 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 struct todo_item {
 	enum todo_command command;
 	struct commit *commit;
+	const char *arg;
+	int arg_len;
 	size_t offset_in_buf;
 };
 
@@ -760,6 +762,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	status = get_sha1(bol, commit_sha1);
 	*end_of_object_name = saved;
 
+	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
+	item->arg_len = (int)(eol - item->arg);
+
 	if (status < 0)
 		return -1;
 
@@ -880,6 +885,8 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 
 		item->command = command;
 		item->commit = commit;
+		item->arg = NULL;
+		item->arg_len = 0;
 		item->offset_in_buf = todo_list->buf.len;
 		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(&todo_list->buf, "%s %s %.*s\n",
-- 
2.10.0.rc1.114.g2bd6b38


