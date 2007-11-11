From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/6] builtin-commit --s: add a newline if the last line was
 no S-O-B
Date: Sun, 11 Nov 2007 17:36:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111736170.4362@racer.site>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 11 18:36:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrGjv-00069a-22
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 18:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284AbXKKRgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 12:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756086AbXKKRgj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 12:36:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:50368 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755042AbXKKRgi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 12:36:38 -0500
Received: (qmail invoked by alias); 11 Nov 2007 17:36:36 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp003) with SMTP; 11 Nov 2007 18:36:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rh1kC0yxrq/22BmmpFq0+D8juCyu0M/c1xSmEBk
	WbBm1+HzDsfV9Z
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711111730580.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64482>


The rule is this: if the last line already contains the sign off by the
current committer, do nothing.  If it contains another sign off, just
add the sign off of the current committer.  If the last line does not
contain a sign off, add a new line before adding the sign off.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-commit.c  |    5 ++++-
 t/t7500-commit.sh |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 6b1507d..66d7e5e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -196,8 +196,11 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 
 		for (i = sb.len - 1; i > 0 && sb.buf[i - 1] != '\n'; i--)
 			; /* do nothing */
-		if (prefixcmp(sb.buf + i, sob.buf))
+		if (prefixcmp(sb.buf + i, sob.buf)) {
+			if (prefixcmp(sb.buf + i, sign_off_header))
+				strbuf_addch(&sb, '\n');
 			strbuf_addbuf(&sb, &sob);
+		}
 		strbuf_release(&sob);
 	}
 
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 13d5a0c..e0be2ed 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -95,6 +95,7 @@ test_expect_success 'commit message from file should override template' '
 
 cat > expect << EOF
 zort
+
 Signed-off-by: C O Mitter <committer@example.com>
 EOF
 
-- 
1.5.3.5.1693.g26ed
