From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Make 'rerere forget' work from a subdirectory.
Date: Thu, 21 Jan 2010 09:23:48 +0100
Message-ID: <4B580F14.5060105@viscovery.net>
References: <7veill3wgc.fsf@alter.siamese.dyndns.org> <4B56F916.7090503@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 09:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXsKY-0000A5-SO
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 09:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab0AUIXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 03:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782Ab0AUIXu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 03:23:50 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36025 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab0AUIXu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 03:23:50 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NXsKS-0005ta-LY; Thu, 21 Jan 2010 09:23:48 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 69B151660F;
	Thu, 21 Jan 2010 09:23:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B56F916.7090503@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137640>

From: Johannes Sixt <j6t@kdbg.org>

It forgot to apply the prefix to the paths given on the command line.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Johannes Sixt schrieb:
 > Junio C Hamano schrieb:
 >> * jc/cache-unmerge (2009-12-25) 9 commits
 >>   (merged to 'next' on 2010-01-13 at 2290c44)
 >>  + rerere forget path: forget recorded resolution
 >
 > Heads up: there is something fishy with the pathspec on Windows (foo\bar
 > is not recognized as foo/bar, but it should be). Will investigate.

 A call get_pathspec is necessary, which applies the prefix and also
 converts Windows's backslashes to forward-slashes.

 -- Hannes

 builtin-rerere.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 25f507a..34f9ace 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -120,8 +120,10 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	if (argc < 2)
 		return rerere(flags);

-	if (!strcmp(argv[1], "forget"))
-		return rerere_forget(argv + 2);
+	if (!strcmp(argv[1], "forget")) {
+		const char **pathspec = get_pathspec(prefix, argv + 2);
+		return rerere_forget(pathspec);
+	}

 	fd = setup_rerere(&merge_rr, flags);
 	if (fd < 0)
-- 
1.6.6.1.1388.g96b4
