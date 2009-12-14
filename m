From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] help.autocorrect: do not run a command if the command given
 is junk
Date: Mon, 14 Dec 2009 14:03:19 +0100
Message-ID: <4B263797.5070808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 14:03:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKAaR-0001xl-BW
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 14:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbZLNND2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 08:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbZLNND0
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 08:03:26 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:14801 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZLNNDX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 08:03:23 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NKAa7-0002ok-RT; Mon, 14 Dec 2009 14:03:20 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7E3F31660F;
	Mon, 14 Dec 2009 14:03:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135206>

From: Johannes Sixt <j6t@kdbg.org>

If a given command is not found, then help.c tries to guess which one the
user could have meant. If help.autocorrect is 0 or unset, then a list of
suggestions is given as long as the dissimilarity between the given command
and the candidates is not excessively high. But if help.autocorrect was
non-zero (i.e., a delay after which the command is run automatically), the
latter restriction on dissimilarity was not obeyed.

In my case, this happened:

 $ git ..daab02
 WARNING: You called a Git command named '..daab02', which does not exist.
 Continuing under the assumption that you meant 'read-tree'
 in 4.0 seconds automatically...

The similarity limit that this patch introduces is already used a few lines
later where the list of suggested commands is printed.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 help.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/help.c b/help.c
index e8db31f..db888cf 100644
--- a/help.c
+++ b/help.c
@@ -331,7 +331,7 @@ const char *help_unknown_cmd(const char *cmd)
 	n = 1;
 	while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
 		++n;
-	if (autocorrect && n == 1) {
+	if (autocorrect && n == 1 && best_similarity < 6) {
 		const char *assumed = main_cmds.names[0]->name;
 		main_cmds.names[0] = NULL;
 		clean_cmdnames(&main_cmds);
-- 
1.6.6.rc1.46.g1635
