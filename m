From: Stelian Pop <stelian@popies.net>
Subject: [PATCH] hg-to-git: fix parent analysis
Date: Fri, 15 Feb 2008 22:20:44 +0100
Message-ID: <1203110444.5579.23.camel@galileo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 22:21:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ7zo-0003C6-CL
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 22:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761361AbYBOVUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 16:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760935AbYBOVUs
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 16:20:48 -0500
Received: from sd-11162.dedibox.fr ([88.191.70.230]:38304 "EHLO
	sd-11162.dedibox.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758963AbYBOVUr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 16:20:47 -0500
Received: from sd-11162.dedibox.fr (localhost.localdomain [127.0.0.1])
	by sd-11162.dedibox.fr (Postfix) with ESMTP id D424892E97
	for <git@vger.kernel.org>; Fri, 15 Feb 2008 22:20:46 +0100 (CET)
Received: from [192.168.6.8] (voyager.popies.net [62.147.231.2])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sd-11162.dedibox.fr (Postfix) with ESMTP id 9662592CF2
	for <git@vger.kernel.org>; Fri, 15 Feb 2008 22:20:46 +0100 (CET)
X-Mailer: Evolution 2.12.1 
X-AV-Checked: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73983>

Fix a bug in the hg-to-git convertor introduced by commit
1bc7c13af9f936aa80893100120b542338a10bf4: when searching the changeset
parents, 'hg log' returns an extra space at the end of the line, which
confuses the .split(' ') based tokenizer:

    Traceback (most recent call last):
      File "hg-to-git.py", line 123, in <module>
          hgchildren[mparent] += ( str(cset), )
      KeyError: ''

Signed-off-by: Stelian Pop <stelian@popies.net>

---

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index c35b158..d72ffbb 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -111,7 +111,7 @@ hgparents["0"] = (None, None)
 hgbranch["0"] = "master"
 for cset in range(1, int(tip) + 1):
     hgchildren[str(cset)] = ()
-    prnts = os.popen('hg log -r %d --template "{parents}"' % cset).read().split(' ')
+    prnts = os.popen('hg log -r %d --template "{parents}"' % cset).read().strip().split(' ')
     prnts = map(lambda x: x[:x.find(':')], prnts)
     if prnts[0] != '':
         parent = prnts[0].strip()

-- 
Stelian Pop <stelian@popies.net>
