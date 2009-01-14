From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/4] color-words: enable REG_NEWLINE to help user
Date: Wed, 14 Jan 2009 23:26:01 +0100
Message-ID: <48504e8a330beca560208ce050d43bc92ac04c90.1231971446.git.trast@student.ethz.ch>
References: <3ff3ccf6e3c1cd6a002d200aee5df88a197a7bf6.1231971446.git.trast@student.ethz.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 23:28:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNEDF-0000kg-PR
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 23:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbZANW0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbZANW0N
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:26:13 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:14595 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752243AbZANW0K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 17:26:10 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 23:26:07 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 23:26:07 +0100
X-Mailer: git-send-email 1.6.1.142.ge070e
In-Reply-To: <3ff3ccf6e3c1cd6a002d200aee5df88a197a7bf6.1231971446.git.trast@student.ethz.ch>
In-Reply-To: <alpine.DEB.1.00.0901142104400.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901142104400.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 14 Jan 2009 22:26:07.0348 (UTC) FILETIME=[181D4340:01C97697]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105715>

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
index cc42adf..3f07ac1 100644
--- a/diff.c
+++ b/diff.c
@@ -1536,7 +1536,8 @@ static void builtin_diff(const char *name_a,
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
1.6.1.142.ge070e
