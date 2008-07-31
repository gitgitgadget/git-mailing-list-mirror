From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH RFC] Do not override LESS
Date: Fri,  1 Aug 2008 00:00:44 +0200
Message-ID: <1217541644-9297-1-git-send-email-mail@cup.kalibalik.dk>
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 00:02:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOgDU-0006tX-Af
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 00:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842AbYGaWAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 18:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbYGaWAq
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 18:00:46 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:60529 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754626AbYGaWAp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 18:00:45 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id F04FB14062;
	Fri,  1 Aug 2008 00:00:42 +0200 (CEST)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id C46011405A;
	Fri,  1 Aug 2008 00:00:42 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91004>

Passing options to "less" with the LESS environment variable can
interfere with existing environment variables. There are at least two
problems, as the following examples show:

1. Alice is using git with colors. Now she decides to set LESS=i for
some reason. Suddenly, git displays codes in place of colors. Alice
likes codes, but she liked colors better!

2. Bob sets GIT_PAGER="less -RS", but does not set LESS. Git sets
LESS=FRSX before calling $GIT_PAGER. Now Bob wonders why his pager is
not always paging, when he explicitly tried to clear the F option.
Maybe Mallory has been messing with something?

By passing the options on the command line instead, both of these
situations are handled.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---

There are at least two issues with this change:

A. Now /bin/sh will be executed all the time with the default pager. If
this is perceived as a performance problem, I can make a special case.

B. This will make existing setups with PAGER="less" behave differently.
They can, of course, be fixed with GIT_PAGER="less -FRSX".

I think that neither 1, 2, A or B are big problems. Nevertheless, I think
this change makes things "more correct", so I hereby offer it for discussion.


diff --git a/pager.c b/pager.c
index 6b5c9e4..232d6ed 100644
--- a/pager.c
+++ b/pager.c
@@ -60,7 +60,7 @@ void setup_pager(void)
 	if (!pager)
 		pager = getenv("PAGER");
 	if (!pager)
-		pager = "less";
+		pager = "less -FRSX";
 	else if (!*pager || !strcmp(pager, "cat"))
 		return;
 
@@ -90,7 +90,6 @@ void setup_pager(void)
 	close(fd[0]);
 	close(fd[1]);
 
-	setenv("LESS", "FRSX", 0);
 	run_pager(pager);
 	die("unable to execute pager '%s'", pager);
 	exit(255);
-- 
1.5.6.4
