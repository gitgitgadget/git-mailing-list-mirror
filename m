From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v4 7/7] wt-status: read rebase todolist with strbuf_getline()
Date: Mon, 29 Feb 2016 09:36:33 +0100
Message-ID: <56D40311.9080603@moritzneeb.de>
References: <56D401C2.8020100@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 09:38:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaJLi-0003pn-9j
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 09:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbcB2Iic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 03:38:32 -0500
Received: from moritzneeb.de ([78.47.1.106]:39578 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbcB2IiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 03:38:25 -0500
Received: from [192.168.1.3] (x4db4d1fb.dyn.telefonica.de [77.180.209.251])
	by moritzneeb.de (Postfix) with ESMTPSA id 3C3A01C0F7;
	Mon, 29 Feb 2016 09:38:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456735104;
	bh=BcCGR8iDtulbKDAvjCNqhv3jf6af3ExBGwdgKsMIxwI=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=Jx1fU4AxUtzCBH/qpOk37LMWtd4DNhP1wu5ujkngq4U2XOqkadJEmcgDiVgSnRVeO
	 aAQAq423+QsL3v/JjzpFTpOx7qnu5j48/8cqo5UU1Jo2CSaOfenqdklsPgkP3+syTP
	 DlWsleAU0ZV05S5zCg5VwqUuh6F1yJCYlYN6889Y=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D401C2.8020100@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287810>

In read_rebase_todolist() the files $GIT_DIR/rebase-merge/done and
$GIT_DIR/rebase-merge/git-rebase-todo are read to collect status
information.

The access to this file should always happen via git rebase, e.g. via
"git rebase -i" or "git rebase --edit-todo". We can assume, that this
interface handles the preprocessing of whitespaces, especially CRLFs
correctly. Thus in this codepath we can remove the call to strbuf_trim().

For documenting the input as expecting "text" input, strbuf_getline_lf()
is still replaced by strbuf_getline().

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 wt-status.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ab4f80d..8047cf2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1076,10 +1076,9 @@ static void read_rebase_todolist(const char *fname, struct string_list *lines)
 	if (!f)
 		die_errno("Could not open file %s for reading",
 			  git_path("%s", fname));
-	while (!strbuf_getline_lf(&line, f)) {
+	while (!strbuf_getline(&line, f)) {
 		if (line.len && line.buf[0] == comment_line_char)
 			continue;
-		strbuf_trim(&line);
 		if (!line.len)
 			continue;
 		abbrev_sha1_in_line(&line);
-- 
2.4.3
