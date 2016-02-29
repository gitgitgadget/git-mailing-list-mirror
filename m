From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v4 3/7] clean: read user input with strbuf_getline()
Date: Mon, 29 Feb 2016 09:36:23 +0100
Message-ID: <56D40307.4080903@moritzneeb.de>
References: <56D401C2.8020100@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 09:38:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaJLc-0003pn-0l
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 09:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbcB2Ii1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 03:38:27 -0500
Received: from moritzneeb.de ([78.47.1.106]:39564 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247AbcB2IiX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 03:38:23 -0500
Received: from [192.168.1.3] (x4db4d1fb.dyn.telefonica.de [77.180.209.251])
	by moritzneeb.de (Postfix) with ESMTPSA id 72A3F1C114;
	Mon, 29 Feb 2016 09:38:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456735101;
	bh=6flP162UhShquA17SROMNX1wKFdcOWuxkjqBg7B3oCE=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=Ny73LpqBOeHtPXanOt8PhA9Q5m9cbDTnCGF5OEyL4mJEX+XBI+DJic63Au1/eXx/U
	 HA3f+Ol2m7OU9lKmby3FNy974lyKbIozu22yGmMZJovSM+Kg97U8tBir/AGHeIMcjT
	 TvXQKyHlE1MSGiun3Mw/lVJEXI8sQ/cEBPKP2hTA=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D401C2.8020100@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287806>

The inputs that are read are all answers that are given by the user
when interacting with git on the commandline. As these answers are
not supposed to contain a meaningful CR it is safe to
replace strbuf_getline_lf() by strbuf_getline().

After being read, the input is trimmed. This leads to accepting user
input with spaces, e.g. "  y ", as a valid answer in the interactive
cleaning process.

Although trimming would not be required anymore to remove a potential CR,
we don't want to change the existing behavior with this patch.
Thus, the trimming is kept in place.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 builtin/clean.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 0371010..5b17a31 100644
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
