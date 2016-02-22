From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v2 3/6] clean: read user input with strbuf_getline()
Date: Mon, 22 Feb 2016 02:20:36 +0100
Message-ID: <56CA6264.1040400@moritzneeb.de>
References: <56CA5DBB.8040006@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 02:24:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXfEI-00062t-PC
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 02:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbcBVBXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 20:23:55 -0500
Received: from moritzneeb.de ([78.47.1.106]:55748 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601AbcBVBXy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 20:23:54 -0500
Received: from [192.168.1.3] (x55b377aa.dyn.telefonica.de [85.179.119.170])
	by moritzneeb.de (Postfix) with ESMTPSA id 5C5A61C05B;
	Mon, 22 Feb 2016 02:23:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456104233;
	bh=RwP+3uPOJBQ15kkKq6LLWgr8Ywv5qGk+cvqAXabWrnc=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=cl13RXHmzifJJxIZgCsT/xnUIQpdUr71EhBo59IdfMS9xv6QGWzYBZZbatcN0lxnj
	 6QtzsgY0kD1g8HjG7ZnF1LVGoUap1swA6o02WofChAqg87DzKrpASuhv1sODcNKB7l
	 HrYPbz2FxoKkmYE7M3VBQ2bi/hE2qLNemWCLLdFI=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56CA5DBB.8040006@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286860>

The inputs that are read are all answers that are given by the user
when interacting with git on the commandline. As these answers are
not supposed to contain a meaningful CR it is safe to
replace strbuf_getline_lf() can be replaced by strbuf_getline().

Before the user input was trimmed to remove the CR. This would be now
redundant. Another effect of the trimming was that some (accidentally)
typed spaces were filtered. But here we want to be consistent with similar UIs
like interactive adding, which only accepts space-less input.

For the case of filtering by patterns the input is still trimmed in an
untouched codepath after it is split up into multiple patterns.
This is considered as desirable, because of two reasons:
First this fitering is not part of similar UIs and it is way more likely
to accidentally type a space in this way of interacting.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
When playing around with the interactive git clean I noticed that it is
not possible to have a pattern actually containing a space (i.e. escaping it).
Not sure how relevant this is, because I have no feeling how good the support
and demand for smoothly handling space-containing files in git is.

 builtin/clean.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 7b08237..01cc2ff 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -570,9 +570,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 			       clean_get_color(CLEAN_COLOR_RESET));
 		}
 -		if (strbuf_getline_lf(&choice, stdin) != EOF) {
-			strbuf_trim(&choice);
-		} else {
+		if (strbuf_getline(&choice, stdin) == EOF) {
 			eof = 1;
 			break;
 		}
@@ -652,9 +650,7 @@ static int filter_by_patterns_cmd(void)
 		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Input ignore patterns>> "));
 		clean_print_color(CLEAN_COLOR_RESET);
-		if (strbuf_getline_lf(&confirm, stdin) != EOF)
-			strbuf_trim(&confirm);
-		else
+		if (strbuf_getline(&confirm, stdin) == EOF)
 			putchar('\n');
  		/* quit filter_by_pattern mode if press ENTER or Ctrl-D */
@@ -750,9 +746,7 @@ static int ask_each_cmd(void)
 			qname = quote_path_relative(item->string, NULL, &buf);
 			/* TRANSLATORS: Make sure to keep [y/N] as is */
 			printf(_("Remove %s [y/N]? "), qname);
-			if (strbuf_getline_lf(&confirm, stdin) != EOF) {
-				strbuf_trim(&confirm);
-			} else {
+			if (strbuf_getline(&confirm, stdin) == EOF) {
 				putchar('\n');
 				eof = 1;
 			}
-- 
2.7.1.345.gc14003e
