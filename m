From: goooguo <erwangg@fortemedia.com.cn>
Subject: Re: question: how to ignore extral CR when diff dos format files
 with 'color=auto'
Date: Wed, 27 Aug 2008 18:39:15 -0700 (PDT)
Message-ID: <1219887555724-788498.post@n2.nabble.com>
References: <1219728743111-783231.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:40:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYWUm-0003qu-VT
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 03:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbYH1BjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 21:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbYH1BjR
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 21:39:17 -0400
Received: from kuber.nabble.com ([216.139.236.158]:51612 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbYH1BjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 21:39:16 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1KYWTj-0003ru-Q9
	for git@vger.kernel.org; Wed, 27 Aug 2008 18:39:15 -0700
In-Reply-To: <1219728743111-783231.post@n2.nabble.com>
X-Nabble-From: erwangg@fortemedia.com.cn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94013>



git v1.6.0 still didn't work, neither v1.5.6.4. (however,v1.5.5 works on
mingwin)

I checked the source code of v1.6.0, and I found emit_line didn't check
whether there is a cr at eol.

I have fixed it.

>From dae20e25960c73bd7ccc0939fe096bb68a009fb5 Mon Sep 17 00:00:00 2001
From: erwangg <erwangg@fortemedia.com.cn>
Date: Wed, 27 Aug 2008 12:22:43 +0800
Subject: [PATCH] ingore cr at eol when diff with color=auto

---
 diff.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 18fa7a7..846a9af 100644
--- a/diff.c
+++ b/diff.c
@@ -517,9 +517,16 @@ static void emit_line(FILE *file, const char *set,
const char *reset, const char
 	if (has_trailing_newline)
 		len--;
 
+	int has_trailing_return = (len > 0 && line[len-1] == '\r');
+	if (has_trailing_return)
+        len--;
+
 	fputs(set, file);
 	fwrite(line, len, 1, file);
 	fputs(reset, file);
+
+    if (has_trailing_return)
+        fputc('\r', file);
 	if (has_trailing_newline)
 		fputc('\n', file);
 }
@@ -535,7 +542,7 @@ static void emit_add_line(const char *reset, struct
emit_callback *ecbdata, cons
 		/* Emit just the prefix, then the rest. */
 		emit_line(ecbdata->file, set, reset, line, ecbdata->nparents);
 		ws_check_emit(line + ecbdata->nparents,
-			      len - ecbdata->nparents, ecbdata->ws_rule,
+			      len - ecbdata->nparents, ecbdata->ws_rule|WS_CR_AT_EOL,
 			      ecbdata->file, set, reset, ws);
 	}
 }
-- 
1.6.0.GIT




-- 
View this message in context: http://n2.nabble.com/question%3A-how-to-ignore-extral-CR-when-diff-dos-format-files-with-%27color%3Dauto%27-tp783231p788498.html
Sent from the git mailing list archive at Nabble.com.
