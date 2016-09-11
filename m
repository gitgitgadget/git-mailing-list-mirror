Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E701207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755864AbcIKKyR (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:54:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:57983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755479AbcIKKyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:54:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MFz0E-1bmpUY3WJq-00Er4L; Sun, 11 Sep 2016 12:54:12
 +0200
Date:   Sun, 11 Sep 2016 12:54:10 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 12/25] sequencer: remember the onelines when parsing the
 todo file
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <5ef9905112fe7b9b785bca8892a26972aca43782.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KzykpdlLpJlBNlo1/qE9aPE5NVLhrQ7YSOkDYEZGeRDNtlYgY+1
 IySanMGSZXGVeALbQEtuBvtunzxd0EIOEv03BP2NEMHNsvMp+KgUN1jaIseRsSWgSSLycnq
 AynYTkSDjaC6Mq75X79r6cXz/66U90VxOibazAZchV1uf41LQJ25WShXyI0NTzwd0cLPJL6
 EQzTJRk6a+G/GOVTwiNlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:74+SYboQkDQ=:KXQG+KKGea8BgycWA5b3Mc
 MnwnIYvc16FhCY2/5b9goywT5LkUGsGSwJGoF0xB8DGUyFV3t0NXKScH2bplTRDy8q1bZqFUI
 PGyPNRsQfOOx7IM3QQn+66ssgLKXvA5mI/Eo9ZD6Ia41yuyNp9TtcKyzRNVc4AyXSxSyvPYrh
 TXqAGbmwlOeNHvsuHr768UzOv1XDS1tJgx1lSlVoNr/4z8JOpqdY04lN+VdkytVqUhhkS0Zsy
 D81huuLa1eDWf/fawojw1RG5s4Je15+nFMwPwY/6IMyhvzjIx/W6w0zUL0vmcvEc5x3O6qbZx
 aeWsqQ+3tC7wmqRcvDoSsInoo5FPTJQbJaLvC2gvas/dIwoUImAIiD3alxY3Sas1J8q4acvWT
 QxR6zS5pThaiprryAko0OeDlrS4T5aWnIAO6OQU5JvpR/X7fqd+ddHCeoHAOMNTFR4VJTJsXo
 QC1xZdR7rBpEBeIRlUc53HC1uOXKjK6NM1AXNiVRcyZMGhCz7oXYCjXjucqa73lMTFlQ25Jhh
 tnRr/9FxV7KxrmV44VBL/ERwiTmWrVtmRwEbZ88bi5M/pM5SAWunN0WGmVRw9tLbOd6kaikuo
 /HNRKwmYXWHT5ipoNmIXalZ7k/XyAeh8eOuN3jnnMXBKg3hAqki3uCIzw5q54F4sVOCgYehaV
 J9JlvHxr6+gtLnYaustmaL7OOSnI/LedS8WWIDStrhcc7Oy+Hp2RLy1FIITKN/XHeDES6wRiJ
 xUzfTWnJSYCaN4kUfFkTqiFdr0B/53opDGJcxsnReyc9KSYhQOSpDO39fPOvvUu2ZLYyXZzjs
 jyW5/oe
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
need to do is remember the begin offsets and lengths.

As we will have to parse and remember the command-line for `exec` commands
later, we do not call the field "oneline" but rather "arg" (and will reuse
that for exec's command-line).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 0c8dec4..ca1961c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -713,6 +713,8 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 struct todo_item {
 	enum todo_command command;
 	struct commit *commit;
+	const char *arg;
+	int arg_len;
 	size_t offset_in_buf;
 };
 
@@ -764,6 +766,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	status = get_sha1(bol, commit_sha1);
 	*end_of_object_name = saved;
 
+	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
+	item->arg_len = (int)(eol - item->arg);
+
 	if (status < 0)
 		return -1;
 
@@ -905,6 +910,8 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 
 		item->command = command;
 		item->commit = commit;
+		item->arg = NULL;
+		item->arg_len = 0;
 		item->offset_in_buf = todo_list->buf.len;
 		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
-- 
2.10.0.windows.1.10.g803177d


