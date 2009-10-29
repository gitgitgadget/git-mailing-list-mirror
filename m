From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] diff --color-words -U0: fix the location of hunk headers
Date: Thu, 29 Oct 2009 11:45:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910291144170.3687@felix-maschine>
References: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de> <1256732672-11817-4-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 29 11:45:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3SVM-00068H-Eh
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 11:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbZJ2KpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 06:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753978AbZJ2KpH
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 06:45:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:33677 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753977AbZJ2KpG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 06:45:06 -0400
Received: (qmail invoked by alias); 29 Oct 2009 10:45:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO [10.1.35.45]) [141.5.11.5]
  by mail.gmx.net (mp002) with SMTP; 29 Oct 2009 11:45:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19U3ZRmoxZU0eC8nD4hFdIgZr2Z6E4LfDz3XP5eKf
	qKsc5ey13NGcmv
X-X-Sender: johannes@felix-maschine
In-Reply-To: <1256732672-11817-4-git-send-email-markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131580>


Colored word diff without context lines firstly printed all the hunk
headers among each other and then printed the diff.

This was due to the code relying on getting at least one context line at
the end of each hunk, where the colored words would be flushed (it is
done that way to be able to ignore rewrapped lines).

Noticed by Markus Heidelberg.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I would strongly prefer this fix instead of your 2/3 and 3/3.

 diff.c                |    6 ++++++
 t/t4034-diff-words.sh |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 51b5dbb..4eafaf5 100644
--- a/diff.c
+++ b/diff.c
@@ -656,6 +656,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	for (i = 0; i < len && line[i] == '@'; i++)
 		;
 	if (2 <= i && i < len && line[i] == ' ') {
+		/* flush --color-words even for --unified=0 */
+		if (ecbdata->diff_words &&
+		    (ecbdata->diff_words->minus.text.size ||
+		     ecbdata->diff_words->plus.text.size))
+			diff_words_show(ecbdata->diff_words);
+
 		ecbdata->nparents = i - 1;
 		len = sane_truncate_line(ecbdata, line, len);
 		emit_line(ecbdata->file,
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
1.6.4.GIT
