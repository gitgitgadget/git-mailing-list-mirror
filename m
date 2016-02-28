From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v3 3/7] clean: read user input with strbuf_getline()
Date: Sun, 28 Feb 2016 06:13:39 +0100
Message-ID: <56D28203.7040502@moritzneeb.de>
References: <56D28092.9090209@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 06:15:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZthx-0003CP-KS
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 06:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbcB1FPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 00:15:39 -0500
Received: from moritzneeb.de ([78.47.1.106]:37005 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbcB1FPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 00:15:32 -0500
Received: from [192.168.1.3] (x4db4d017.dyn.telefonica.de [77.180.208.23])
	by moritzneeb.de (Postfix) with ESMTPSA id 4BCF61C114;
	Sun, 28 Feb 2016 06:15:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456636531;
	bh=btB+zIZ5LdHt1TnDH6XJZO/i7Pr0gsfH+eHsDu1hBbQ=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=mNPRSbgxkus/pGw1t6RpGcKacNn+Ka+Nh+OzR/1hdNbMgPYBD3wnwhFUUqGLfimU3
	 g2vUL3QwV4DQKQkMAofjRW7v8YXols5FJ4iCR5JYwsgng/N/mefKVwatzAjNe1YaXp
	 8sxCzMzGVXUPAU31AF3YnS1krx1YX3fEA2vibbAA=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D28092.9090209@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287750>

The inputs that are read are all answers that are given by the user
when interacting with git on the commandline. As these answers are
not supposed to contain a meaningful CR it is safe to
replace strbuf_getline_lf() can be replaced by strbuf_getline().

In the subsequent codepath, the input is trimmed. This leads to
accepting user input with spaces, e.g. "  y ", as a valid answer in
the interactive cleaning process.

Although trimming would not be required anymore to remove a potential CR,
we don't want to change the existing behavior with this patch.
Thus, the trimming is kept in place.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 builtin/clean.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 7b08237..956283d 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -570,7 +570,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 			       clean_get_color(CLEAN_COLOR_RESET));
 		}
 
-		if (strbuf_getline_lf(&choice, stdin) != EOF) {
+		if (strbuf_getline(&choice, stdin) != EOF) {
 			strbuf_trim(&choice);
 		} else {
 			eof = 1;
@@ -652,7 +652,7 @@ static int filter_by_patterns_cmd(void)
 		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Input ignore patterns>> "));
 		clean_print_color(CLEAN_COLOR_RESET);
-		if (strbuf_getline_lf(&confirm, stdin) != EOF)
+		if (strbuf_getline(&confirm, stdin) != EOF)
 			strbuf_trim(&confirm);
 		else
 			putchar('\n');
@@ -750,7 +750,7 @@ static int ask_each_cmd(void)
 			qname = quote_path_relative(item->string, NULL, &buf);
 			/* TRANSLATORS: Make sure to keep [y/N] as is */
 			printf(_("Remove %s [y/N]? "), qname);
-			if (strbuf_getline_lf(&confirm, stdin) != EOF) {
+			if (strbuf_getline(&confirm, stdin) != EOF) {
 				strbuf_trim(&confirm);
 			} else {
 				putchar('\n');
-- 
2.4.3
