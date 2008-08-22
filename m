From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH RESEND] Do not override LESS
Date: Fri, 22 Aug 2008 14:25:12 +0200
Message-ID: <1219407912-32085-1-git-send-email-mail@cup.kalibalik.dk>
Cc: gitster@pobox.com, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 14:26:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWVim-0001Wv-Oj
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 14:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757432AbYHVMZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 08:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756631AbYHVMZQ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 08:25:16 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:45839 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757432AbYHVMZP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 08:25:15 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id BE88F14062;
	Fri, 22 Aug 2008 14:25:14 +0200 (CEST)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 99F181405A;
	Fri, 22 Aug 2008 14:25:14 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93287>

Passing options to "less" with the LESS environment variable can
interfere with existing environment variables. There are at least two
problems, as the following examples show:

1. Alice is using git with colors. Now she decides to set LESS=i for
some reason. Suddenly, she sees codes in place of colors because LESS
is no longer set automatically.

2. Bob sets GIT_PAGER="less -RS", but does not set LESS. Git sets
LESS=FRSX before calling $GIT_PAGER. Now Bob wonders why his pager is
not always paging, when he explicitly tried to clear the F option.

By passing the options on the command line instead, both of these
situations are handled.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---


Here is a resend, as I got no comments on the first try. The patch
is rebased to the recent pager-swap setup.

For completeness, I note that this change will make existing setups
with PAGER="less" behave differently, as they will no longer have
-FRSX options set automatically. I tend to think that this is correct,
since you then get what you ask for.


 pager.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/pager.c b/pager.c
index aa0966c..9753fe9 100644
--- a/pager.c
+++ b/pager.c
@@ -20,8 +20,6 @@ static void pager_preexec(void)
 	FD_ZERO(&in);
 	FD_SET(0, &in);
 	select(1, &in, NULL, &in, NULL);
-
-	setenv("LESS", "FRSX", 0);
 }
 #endif
 
@@ -52,7 +50,7 @@ void setup_pager(void)
 	if (!pager)
 		pager = getenv("PAGER");
 	if (!pager)
-		pager = "less";
+		pager = "less -FRSX";
 	else if (!*pager || !strcmp(pager, "cat"))
 		return;
 
-- 
1.5.6.4
