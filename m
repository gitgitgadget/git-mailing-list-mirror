Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3271F404
	for <e@80x24.org>; Thu, 22 Feb 2018 19:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbeBVT3i (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 14:29:38 -0500
Received: from mout.web.de ([217.72.192.78]:50661 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbeBVT3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 14:29:37 -0500
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LetQh-1eOyCh28Vj-00qn5f; Thu, 22
 Feb 2018 20:29:32 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] sequencer: factor out strbuf_read_file_or_whine()
Message-ID: <6b58885c-b0f6-1687-3f2d-4594aacff9ac@web.de>
Date:   Thu, 22 Feb 2018 20:29:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:xocH286Gei73xruRvcHf+c52iKRuKKloOtJHhcxmDTQKEpGvx5d
 ixffJ3i7KJY3Yp1nBp8XFM/oy5Oh9URsa+sm7ClUHASSsk4lEKt40A7dhCHAYO5G9uchcks
 J1w40cVKHA2X80RyYLSeCUp30DkrGy6Qph3Rz/eqgE5SA0/YaSENGTHXIur5FCqdt74coMz
 lOZtd59TpAeCqbi6LPE2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ykPr8I8OBYM=:7eILPuy3qpz9FqAPx24PO/
 x4EcsjoZ1LML9Ke1Tl9+imaWBq8kb6an97Y9Sbc8+MTc8gGl75sJvZtqXYR91adFUFEuLvPS0
 Z3VsIhyZtskU3iscCY1sjWg/A6VeoEeh5P0pWJLSeNxjjaKSMgU2caxI7xeyH8MPTvVPYr57l
 cmZ8AjPhtKSEqVA2WI4DU6nmPRqONfBFacZViC0Neiev4wIbbOCQ4CjwSfmuJjXDBfvtQ3FnR
 zJbVBIF2IGaw85jH/W3TyDw2rEyqnt6ld0qopm0cRapr70M8pgDGFF6XQZR+AKJmbFA+sLegr
 Erg1mgx5dpHJFLtXaI7h36ePhYYQEcmkgnsma4g3dfqAPDdSrvLggYEqjXP6dAErTV0EUAyEc
 BZBBIlfMkA7fDIFDW7rTfhcvapJ10Oh6mxXt6QuleBz2VteNJH88G7PpVMB+P1fOcJ8wvxyAs
 UKuWDo1eV8s40wCdmqZehApIQjOXNJmSIs17RPBFCYVgf+IFyGeVwHk+8SvhaY7bM29gIat8z
 yz6MkSjmYjXRBerLZw6JjJsIJB9kNpRvCj/IFUnTd83lpIHGUxG6VaLY0mK15x6K+iorp7gdY
 g5nbQHC86oZ/E8l6YUN0J8855/IHjzgWiFfD1RZSrXj767V7mM3L+R6chQ1zcnem3ID1n6gJg
 rA1DGhYvVHCGaJI2BrEsH3vagZxJV8+FUChp0ZbrAUuB80+vnp1HN+uR5eFq7jl2rJef1gISc
 3YNWv3F1NoHfrZgGmV0ZQiDQekiYsYi9pqXG65zSVZN14j97YDe04GsxkKdRygzTfzJyitJfg
 uYc8f1NcqrjnllUQj9dhuogv2y3bunDAipcTyYtZDlk/8w27PA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce code duplication by factoring out a function that reads an entire
file into a strbuf, or reports errors on stderr if something goes wrong.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
The difference to using strbuf_read_file() is more detailed error
messages for open(2) failures.  But I don't know if we need them -- or
under which circumstances reading todo files could fail anyway.  When
doing multiple rebases in parallel perhaps?

 sequencer.c | 74 +++++++++++++++++++++++--------------------------------------
 1 file changed, 28 insertions(+), 46 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e9baaf59bd..e34334f0ef 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1869,22 +1869,31 @@ static int count_commands(struct todo_list *todo_list)
 	return count;
 }
 
+static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
+{
+	int fd;
+	ssize_t len;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return error_errno(_("could not open '%s'"), path);
+	len = strbuf_read(sb, fd, 0);
+	close(fd);
+	if (len < 0)
+		return error(_("could not read '%s'."), path);
+	return len;
+}
+
 static int read_populate_todo(struct todo_list *todo_list,
 			struct replay_opts *opts)
 {
 	struct stat st;
 	const char *todo_file = get_todo_path(opts);
-	int fd, res;
+	int res;
 
 	strbuf_reset(&todo_list->buf);
-	fd = open(todo_file, O_RDONLY);
-	if (fd < 0)
-		return error_errno(_("could not open '%s'"), todo_file);
-	if (strbuf_read(&todo_list->buf, fd, 0) < 0) {
-		close(fd);
-		return error(_("could not read '%s'."), todo_file);
-	}
-	close(fd);
+	if (strbuf_read_file_or_whine(&todo_list->buf, todo_file) < 0)
+		return -1;
 
 	res = stat(todo_file, &st);
 	if (res)
@@ -3151,20 +3160,13 @@ int check_todo_list(void)
 	struct strbuf todo_file = STRBUF_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct strbuf missing = STRBUF_INIT;
-	int advise_to_edit_todo = 0, res = 0, fd, i;
+	int advise_to_edit_todo = 0, res = 0, i;
 
 	strbuf_addstr(&todo_file, rebase_path_todo());
-	fd = open(todo_file.buf, O_RDONLY);
-	if (fd < 0) {
-		res = error_errno(_("could not open '%s'"), todo_file.buf);
-		goto leave_check;
-	}
-	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
-		close(fd);
-		res = error(_("could not read '%s'."), todo_file.buf);
+	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file.buf) < 0) {
+		res = -1;
 		goto leave_check;
 	}
-	close(fd);
 	advise_to_edit_todo = res =
 		parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
@@ -3180,17 +3182,10 @@ int check_todo_list(void)
 
 	todo_list_release(&todo_list);
 	strbuf_addstr(&todo_file, ".backup");
-	fd = open(todo_file.buf, O_RDONLY);
-	if (fd < 0) {
-		res = error_errno(_("could not open '%s'"), todo_file.buf);
-		goto leave_check;
-	}
-	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
-		close(fd);
-		res = error(_("could not read '%s'."), todo_file.buf);
+	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file.buf) < 0) {
+		res = -1;
 		goto leave_check;
 	}
-	close(fd);
 	strbuf_release(&todo_file);
 	res = !!parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
@@ -3271,15 +3266,8 @@ int skip_unnecessary_picks(void)
 	}
 	strbuf_release(&buf);
 
-	fd = open(todo_file, O_RDONLY);
-	if (fd < 0) {
-		return error_errno(_("could not open '%s'"), todo_file);
-	}
-	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
-		close(fd);
-		return error(_("could not read '%s'."), todo_file);
-	}
-	close(fd);
+	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
+		return -1;
 	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
@@ -3370,17 +3358,11 @@ int rearrange_squash(void)
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct hashmap subject2item;
-	int res = 0, rearranged = 0, *next, *tail, fd, i;
+	int res = 0, rearranged = 0, *next, *tail, i;
 	char **subjects;
 
-	fd = open(todo_file, O_RDONLY);
-	if (fd < 0)
-		return error_errno(_("could not open '%s'"), todo_file);
-	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
-		close(fd);
-		return error(_("could not read '%s'."), todo_file);
-	}
-	close(fd);
+	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
+		return -1;
 	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
-- 
2.16.2
