From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] git format-patch: avoid underrun when format.headers is empty or all NLs
Date: Tue, 19 Aug 2008 15:23:25 +0200
Message-ID: <87iqtxyw8i.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 15:26:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVRDq-0000MM-C9
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 15:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbYHSNZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 09:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbYHSNZA
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 09:25:00 -0400
Received: from postfix1-g20.free.fr ([212.27.60.42]:33970 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbYHSNY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 09:24:59 -0400
Received: from smtp7-g19.free.fr (smtp7-g19.free.fr [212.27.42.64])
	by postfix1-g20.free.fr (Postfix) with ESMTP id 9DAC72973A74
	for <git@vger.kernel.org>; Tue, 19 Aug 2008 15:24:57 +0200 (CEST)
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 5DCC2B0106
	for <git@vger.kernel.org>; Tue, 19 Aug 2008 15:23:26 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 07A3DB01D9
	for <git@vger.kernel.org>; Tue, 19 Aug 2008 15:23:26 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id DC6F638632; Tue, 19 Aug 2008 15:23:25 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92855>


* builtin-log.c (add_header): Avoid a buffer underrun when
format.headers is empty or all newlines.  Reproduce with this:
git config format.headers '' && git format-patch -1
---
I spotted this via inspection.

 builtin-log.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index f4975cf..911fd65 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -461,7 +461,7 @@ static int extra_cc_alloc;
 static void add_header(const char *value)
 {
 	int len = strlen(value);
-	while (value[len - 1] == '\n')
+	while (len && value[len - 1] == '\n')
 		len--;
 	if (!strncasecmp(value, "to: ", 4)) {
 		ALLOC_GROW(extra_to, extra_to_nr + 1, extra_to_alloc);
--
1.6.0.4.g750768
