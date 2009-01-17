From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 5/7] color-words: enable REG_NEWLINE to help user
Date: Sat, 17 Jan 2009 17:29:46 +0100
Message-ID: <1232209788-10408-6-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
 <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-2-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-3-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-4-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-5-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:32:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOE5L-00087b-0x
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763518AbZAQQ3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 11:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763305AbZAQQ3u
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:29:50 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:8904 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763398AbZAQQ3p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:29:45 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:40 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:40 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232209788-10408-5-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 16:29:40.0628 (UTC) FILETIME=[CBE00540:01C978C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106085>

We silently truncate a match at the newline, which may lead to
unexpected behaviour, e.g., when matching "<[^>]*>" against

  <foo
  bar>

since then "<foo" becomes a word (and "bar>" doesn't!) even though the
regex said only angle-bracket-delimited things can be words.

To alleviate the problem slightly, use REG_NEWLINE so that negated
classes can't match a newline.  Of course newlines can still be
matched explicitly.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 diff.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 9fb3d0d..00c661f 100644
--- a/diff.c
+++ b/diff.c
@@ -1544,7 +1544,8 @@ static void builtin_diff(const char *name_a,
 				ecbdata.diff_words->word_regex = (regex_t *)
 					xmalloc(sizeof(regex_t));
 				if (regcomp(ecbdata.diff_words->word_regex,
-						o->word_regex, REG_EXTENDED))
+						o->word_regex,
+						REG_EXTENDED | REG_NEWLINE))
 					die ("Invalid regular expression: %s",
 							o->word_regex);
 			}
-- 
1.6.1.315.g92577
