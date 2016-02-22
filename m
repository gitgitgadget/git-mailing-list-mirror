From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v2 6/6] wt-status: read rebase todolist with strbuf_getline()
Date: Mon, 22 Feb 2016 02:17:38 +0100
Message-ID: <56CA61B2.2020904@moritzneeb.de>
References: <56CA5DBB.8040006@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 02:24:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXfEK-00062t-DR
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 02:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbcBVBX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 20:23:59 -0500
Received: from moritzneeb.de ([78.47.1.106]:55745 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbcBVBXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 20:23:53 -0500
Received: from [192.168.1.3] (x55b377aa.dyn.telefonica.de [85.179.119.170])
	by moritzneeb.de (Postfix) with ESMTPSA id 5985F1C0F5;
	Mon, 22 Feb 2016 02:23:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456104232;
	bh=RxRFvVhr8iVtrEctofm9fsxtegqdCASWeLgU8ayNw6U=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=AryeplP8lB9FOTIbrKb+FbhudZqR5Q8+b/zECWm3/+KfhQo8VE/Yn0kbJalO2Q9Ix
	 5sf6Qh18vNtRixY6RgiWONSd5ya3dWTVcmE6U3HzEjUKFacoLPw8GvSUWwumYQLCNb
	 rlEn8CHXhl1nDfaO/kEWzIq6u/AUNN/tnjkJeiNA=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56CA5DBB.8040006@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286866>

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
2.7.1.345.gc14003e
