From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] log-tree: fix patch filename computation in
 "git format-patch"
Date: Fri, 27 Mar 2009 01:13:01 +0100
Message-ID: <20090327011301.a5185805.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 01:18:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmzlm-0002H6-7Y
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 01:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762547AbZC0AOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 20:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758198AbZC0AOI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 20:14:08 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:38762 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756184AbZC0AOG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 20:14:06 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 7443C4C8035;
	Fri, 27 Mar 2009 01:13:53 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with SMTP id 34CED4C8018;
	Fri, 27 Mar 2009 01:13:51 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114833>

When using "git format-patch", "get_patch_filename" in
"log-tree.c" calls "strbuf_splice" that could die with
the following message:

"`pos + len' is too far after the end of the buffer"

if you have:

	buf->len < start_len + FORMAT_PATCH_NAME_MAX

but:

	buf->len + suffix_len > start_len + FORMAT_PATCH_NAME_MAX

This patch tries to get rid of that bug.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 log-tree.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

This bug happens on "pu".

diff --git a/log-tree.c b/log-tree.c
index 56a3488..ade79ab 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -187,16 +187,17 @@ void get_patch_filename(struct commit *commit, int nr, const char *suffix,
 
 	strbuf_addf(buf, commit ? "%04d-" : "%d", nr);
 	if (commit) {
+		int max_len = start_len + FORMAT_PATCH_NAME_MAX;
 		format_commit_message(commit, "%f", buf, DATE_NORMAL);
 		/*
 		 * Replace characters at the end with the suffix if the
 		 * filename is too long
 		 */
-		if (buf->len + suffix_len > FORMAT_PATCH_NAME_MAX + start_len)
-			strbuf_splice(buf,
-				start_len + FORMAT_PATCH_NAME_MAX - suffix_len,
-				suffix_len, suffix, suffix_len);
-		else
+		if (buf->len + suffix_len > max_len) {
+			int base = (max_len > buf->len) ? buf->len : max_len;
+			strbuf_splice(buf, base - suffix_len, suffix_len,
+				      suffix, suffix_len);
+		} else
 			strbuf_addstr(buf, suffix);
 	}
 }
-- 
1.6.2.1.506.g7aa09
