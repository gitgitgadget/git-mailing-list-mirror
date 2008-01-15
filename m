From: Mark Drago <markdrago@gmail.com>
Subject: [PATCH] hg-to-git: improve popen calls
Date: Mon, 14 Jan 2008 20:11:19 -0500
Message-ID: <478C0837.7090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, brian.ewins@gmail.com, stelian@popies.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 15 02:11:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEaL4-0003aR-PU
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 02:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbYAOBLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 20:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbYAOBLA
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 20:11:00 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:23080 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbYAOBK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 20:10:59 -0500
Received: by py-out-1112.google.com with SMTP id u52so3371571pyb.10
        for <git@vger.kernel.org>; Mon, 14 Jan 2008 17:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=2o5n865cLDLIJ4l+2f4LckHf5l7NSgZkCNGaSRyZyOQ=;
        b=LPb0NxqeBzgNNtlCiFsKl8JuOeWKA6Sw8q7an8X7RiByHSt0qddARxvoIOlQo2WlzoETEWSJP0jktovtyWc7hhOclIUd98QhGfuLyL0DNoDMmr6taSWla+CfIzO9Lk8/1P8VQGH/KUAhpVjxq1fjmTADBasKANx/r2q9OOSI8FY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=rGmwDhZE8boDS+gG1nObx+D9iz7vMHrfPkwy05R9LOhFqCqeu2WByT6C3OcvROx8NRJgcve8b/EOMlvWjVMDTx9SZHZjkaJCzJlglB++Mxdi+gB5yiiAWmpv/MZadkgFfpHlOpFz8lJ3CQvAzrBTtQFLZ9faSq24gBCVSbUxBfI=
Received: by 10.65.252.13 with SMTP id e13mr15906531qbs.84.1200359457657;
        Mon, 14 Jan 2008 17:10:57 -0800 (PST)
Received: from ?192.168.1.5? ( [24.189.168.60])
        by mx.google.com with ESMTPS id f15sm5504584qba.23.2008.01.14.17.10.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jan 2008 17:10:57 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70495>

This patch improves all of the popen calls in hg-to-git.py by specifying the
template 'hg log' should use instead of calling 'hg log' and grepping for the
desired data.

Signed-off-by: Mark Drago <markdrago@gmail.com>

---

Hello,

I wrote this patch back when the popen calls within hg-to-git came up on the
list and I'm just now getting around to sending it in.  Junio commented on one
of the popen calls by saying the following:

"Isn't this one of the ugliest lines in the whole git.git project, I have
to wonder?" -- Junio, http://marc.info/?l=git&m=119673122106601&w=2

So, this patch removes that line and improves the rest of the popen calls
as well.  It also reduces the overall number of popen calls by combining a
bunch of them.

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 9befb92..c35b158 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -1,6 +1,6 @@
 #! /usr/bin/python
 
-""" hg-to-svn.py - A Mercurial to GIT converter
+""" hg-to-git.py - A Mercurial to GIT converter
 
     Copyright (C)2007 Stelian Pop <stelian@popies.net>
 
@@ -27,6 +27,8 @@ import re
 hgvers = {}
 # List of children for each hg revision
 hgchildren = {}
+# List of parents for each hg revision
+hgparents = {}
 # Current branch for each hg revision
 hgbranch = {}
 # Number of new changesets converted from hg
@@ -99,17 +101,19 @@ if state:
     else:
         print 'State does not exist, first run'
 
-tip = os.popen('hg tip | head -1 | cut -f 2 -d :').read().strip()
+tip = os.popen('hg tip --template "{rev}"').read()
 print 'tip is', tip
 
 # Calculate the branches
 print 'analysing the branches...'
 hgchildren["0"] = ()
+hgparents["0"] = (None, None)
 hgbranch["0"] = "master"
 for cset in range(1, int(tip) + 1):
     hgchildren[str(cset)] = ()
-    prnts = os.popen('hg log -r %d | grep ^parent: | cut -f 2 -d :' % cset).readlines()
-    if len(prnts) > 0:
+    prnts = os.popen('hg log -r %d --template "{parents}"' % cset).read().split(' ')
+    prnts = map(lambda x: x[:x.find(':')], prnts)
+    if prnts[0] != '':
         parent = prnts[0].strip()
     else:
         parent = str(cset - 1)
@@ -120,6 +124,8 @@ for cset in range(1, int(tip) + 1):
     else:
         mparent = None
 
+    hgparents[str(cset)] = (parent, mparent)
+
     if mparent:
         # For merge changesets, take either one, preferably the 'master' branch
         if hgbranch[mparent] == 'master':
@@ -147,34 +153,27 @@ for cset in range(int(tip) + 1):
     hgnewcsets += 1
 
     # get info
-    prnts = os.popen('hg log -r %d | grep ^parent: | cut -f 2 -d :' % cset).readlines()
-    if len(prnts) > 0:
-        parent = prnts[0].strip()
-    else:
-        parent = str(cset - 1)
-    if len(prnts) > 1:
-        mparent = prnts[1].strip()
-    else:
-        mparent = None
-
+    log_data = os.popen('hg log -r %d --template "{tags}\n{date|date}\n{author}\n"' % cset).readlines()
+    tag = log_data[0].strip()
+    date = log_data[1].strip()
+    user = log_data[2].strip()
+    parent = hgparents[str(cset)][0]
+    mparent = hgparents[str(cset)][1]
+
+    #get comment
     (fdcomment, filecomment) = tempfile.mkstemp()
-    csetcomment = os.popen('hg log -r %d -v | grep -v ^changeset: | grep -v ^parent: | grep -v ^user: | grep -v ^date | grep -v ^files: | grep -v ^description: | grep -v ^tag:' % cset).read().strip()
+    csetcomment = os.popen('hg log -r %d --template "{desc}"' % cset).read().strip()
     os.write(fdcomment, csetcomment)
     os.close(fdcomment)
 
-    date = os.popen('hg log -r %d | grep ^date: | cut -f 2- -d :' % cset).read().strip()
-
-    tag = os.popen('hg log -r %d | grep ^tag: | cut -f 2- -d :' % cset).read().strip()
-
-    user = os.popen('hg log -r %d | grep ^user: | cut -f 2- -d :' % cset).read().strip()
-
     print '-----------------------------------------'
     print 'cset:', cset
     print 'branch:', hgbranch[str(cset)]
     print 'user:', user
     print 'date:', date
     print 'comment:', csetcomment
-    print 'parent:', parent
+    if parent:
+	print 'parent:', parent
     if mparent:
         print 'mparent:', mparent
     if tag:
@@ -224,8 +223,7 @@ for cset in range(int(tip) + 1):
         os.system('git-branch -d %s' % otherbranch)
 
     # retrieve and record the version
-    vvv = os.popen('git-show | head -1').read()
-    vvv = vvv[vvv.index(' ') + 1 : ].strip()
+    vvv = os.popen('git-show --quiet --pretty=format:%H').read()
     print 'record', cset, '->', vvv
     hgvers[str(cset)] = vvv
 
