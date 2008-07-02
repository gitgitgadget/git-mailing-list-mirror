From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Suspicious code in builtin-fast-export.c
Date: Wed, 02 Jul 2008 11:04:28 +0200
Message-ID: <486B449C.3050502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Jul 02 11:06:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDyHM-0003so-Bt
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 11:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbYGBJEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 05:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbYGBJEe
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 05:04:34 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41337 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbYGBJEd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 05:04:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KDyGN-0008H6-HN; Wed, 02 Jul 2008 11:04:31 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 49C054FB; Wed,  2 Jul 2008 11:04:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87120>

export_marks() has this code:

	struct object_decoration *deco = idnums.hash;
...
	for (i = 0; i < idnums.size; ++i) {
		deco++;
		if (deco && deco->base && deco->base->type == 1) {
...
		}
	}

I see that deco is off by one here at the end of the idnums.hash array
(and, btw, the check for 'deco &&' is always true). Indeed, this crashes
on Windows, and I can make it crash on Linux with this patch (which
overallocates a bit and writes junk into that space):

diff --git a/wrapper.c b/wrapper.c
index 4e04f76..658925e 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -72,7 +72,7 @@ void *xrealloc(void *ptr, size_t size)

 void *xcalloc(size_t nmemb, size_t size)
 {
-	void *ret = calloc(nmemb, size);
+	void *ret = calloc(nmemb+1, size);
 	if (!ret && (!nmemb || !size))
 		ret = calloc(1, 1);
 	if (!ret) {
@@ -83,6 +83,7 @@ void *xcalloc(size_t nmemb, size_t size)
 		if (!ret)
 			die("Out of memory, calloc failed");
 	}
+	memset(ret+nmemb*size, 0xDE, size);
 	return ret;
 }

-- 
1.5.6.64.gd77fe
