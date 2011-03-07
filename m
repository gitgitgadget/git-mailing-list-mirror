From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] blame: honor core.abbrevguard
Date: Mon,  7 Mar 2011 13:35:40 +0900
Message-ID: <1299472540-6066-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 05:35:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwSAg-0002br-6e
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 05:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab1CGEfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 23:35:45 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:34019 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab1CGEfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 23:35:45 -0500
Received: by pxi15 with SMTP id 15so663485pxi.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 20:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=hPw4ru9b80KdlgCJempJlvQF9uf4cwYTsOGOblpJEG4=;
        b=tkKzhKrJ8pQZuEjQCVo4oCGg8bA0aULveWy14q8QBAmn0JQIBTAO3Kqs1wLfgZfd83
         KveEt3NMxQslId6FgwSSuaHrL1GxNiCshUU8uzJxCCtq9CFvSFkeMQ1O5HZRxauO53vP
         PfNQJ/q2XYekJHUpbRFn0lPpzPcRtxvYBAClM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=I7ELbIeRcXtuZw53aV0Wi6NHIaB1GgaOUEG2cyywyhJjNtmf7jiKVqAeLHr3/aYQ3j
         IWxuCDzLVPif4UsNlHgEM0UhMu1aTyJTICymA/SzmIm8XW1YmjkE+ZvHSdqnFaeosJqv
         k9TzWff4Z4Ol6jYAea06fHGu0m0gEi8CpBfII=
Received: by 10.143.170.7 with SMTP id x7mr3018635wfo.34.1299472544571;
        Sun, 06 Mar 2011 20:35:44 -0800 (PST)
Received: from localhost.localdomain ([118.176.73.109])
        by mx.google.com with ESMTPS id w11sm3820682wfh.6.2011.03.06.20.35.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 20:35:44 -0800 (PST)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168568>

Commit 72a5b561 ("core.abbrevguard: Ensure short object names stay
unique a bit longer") introduced this config variable to make object
name unambiguously. Use it.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 builtin/blame.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index aa30ec52692..d1cf22beba1 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1664,14 +1664,22 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	struct commit_info ci;
 	char hex[41];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
+	int length;
 
 	get_commit_info(suspect->commit, &ci, 1);
 	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
 
+	if (opt & OUTPUT_LONG_OBJECT_NAME)
+		length = 40;
+	else {
+		length = 8 + unique_abbrev_extra_length;
+		if (length > 40)
+			length = 40;
+	}
+
 	cp = nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8;
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
-- 
1.7.4
