From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH] Use line buffering for standard output
Date: Sun,  3 Aug 2008 23:26:08 +0200
Message-ID: <1217798768-18021-1-git-send-email-mail@cup.kalibalik.dk>
Cc: gitster@pobox.com, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 23:27:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPl6g-00041Q-Tt
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 23:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756813AbYHCV0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 17:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756776AbYHCV0O
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 17:26:14 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:44282 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756682AbYHCV0N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 17:26:13 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 838BB14062;
	Sun,  3 Aug 2008 23:26:07 +0200 (CEST)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 67F6D1405A;
	Sun,  3 Aug 2008 23:26:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91276>

Normally, stdout is fully buffered, unless it refers to a terminal
device. This gives problems when fork() is in play: the buffer is
cloned and output appears twice.

By always setting stdout to line buffering, we make the output work
identically for all output devices.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---

On #git, blix mentioned that running git clone through a pipe made it
output the "Initialized empty" line twice. This seems to be due to
bad interactions between fork() and buffered stdio.

Rather than putting in flushing at all the right places, this
sledgehammer fix simply reverts to line buffering for all output devices.


Anders.


 git.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 37b1d76..040b900 100644
--- a/git.c
+++ b/git.c
@@ -421,6 +421,12 @@ int main(int argc, const char **argv)
 	int done_alias = 0;
 
 	/*
+	 * Use line buffering, even if we do not have interactive
+	 * output. Full buffering mixes badly with fork().
+	 */
+	setvbuf(stdout, NULL, _IOLBF, 0);
+
+	/*
 	 * Take the basename of argv[0] as the command
 	 * name, and the dirname as the default exec_path
 	 * if we don't have anything better.
-- 
1.5.6.4
