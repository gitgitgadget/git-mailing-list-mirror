From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 3/3] diff: fix the location of hunk headers for "git diff --color-words -U0"
Date: Wed, 28 Oct 2009 13:24:32 +0100
Message-ID: <1256732672-11817-4-git-send-email-markus.heidelberg@web.de>
References: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 13:25:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N37ac-0003No-A2
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 13:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbZJ1MZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 08:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbZJ1MZK
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 08:25:10 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:58515 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbZJ1MZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 08:25:09 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3B45713A1446D;
	Wed, 28 Oct 2009 13:25:13 +0100 (CET)
Received: from [89.59.65.242] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N37aT-0002WH-00; Wed, 28 Oct 2009 13:25:13 +0100
X-Mailer: git-send-email 1.6.5.2.86.g61663
In-Reply-To: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+rm/msjOHHztt5Qzesmwe1oGS8Sm1LsJKT/Wyn
	KhoXba6tU8FJ3ATv3U9qrhKndFOBQPFA5pCfxrnaI/lGdgSSc7
	MKrfpDTHaLHYpxENof+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131458>

Colored word diff without context lines firstly printed all the hunk
headers among each other and then printed the diff.

Because the word diff cannot be calculated before the end of the diff
(added/removed lines) hunk, it was calculated directly before first line
of context after the diff. But this didn't work if there was no context.
In this case the diff wasn't printed in fn_out_consume(), but entirely
in free_diff_words_data(). This also led to calculate the colored diff
from the whole diff in one swoop instead of calculating it in several
independent steps (one step per hunk).

We now calculate and print the word diff directly before the next hunk
header. The word diff of the last hunk is still printed in
free_diff_words_data().

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 diff.c                |   13 +++++++++----
 t/t4034-diff-words.sh |    2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 067e5a0..e95fe9b 100644
--- a/diff.c
+++ b/diff.c
@@ -785,10 +785,15 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			diff_words_append(line, len,
 					  &ecbdata->diff_words->plus);
 			return;
-		} else if (line[0] == ' ') {
-			if (ecbdata->diff_words->minus.text.size ||
-			    ecbdata->diff_words->plus.text.size)
-				diff_words_show(ecbdata->diff_words);
+		}
+		/*
+		 * If line[0] == '@' then this prints the content of the
+		 * previous hunk, necessary for 0-context.
+		 */
+		if (ecbdata->diff_words->minus.text.size ||
+		    ecbdata->diff_words->plus.text.size)
+			diff_words_show(ecbdata->diff_words);
+		if (line[0] == ' ') {
 			line++;
 			len--;
 			emit_line(ecbdata->file, plain, reset, line, len);
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 82240cf..21db6e9 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -77,7 +77,7 @@ cat > expect <<\EOF
 <GREEN>aeff = aeff * ( aaa )<RESET>
 EOF
 
-test_expect_failure 'word diff without context' '
+test_expect_success 'word diff without context' '
 
 	word_diff --color-words --unified=0
 
-- 
1.6.5.2.86.g61663
