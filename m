From: William Giokas <1007380@gmail.com>
Subject: [PATCH v2] remote-hg: getbundle changed in mercurial 3.0
Date: Tue, 13 May 2014 15:21:46 -0500
Message-ID: <1400012506-20705-1-git-send-email-1007380@gmail.com>
References: <1400008359-18267-1-git-send-email-1007380@gmail.com>
Cc: William Giokas <1007380@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 22:22:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJDA-0007uD-6U
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbaEMUV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:21:58 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:50514 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbaEMUVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:21:53 -0400
Received: by mail-ig0-f179.google.com with SMTP id hn18so900522igb.6
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FF+2mB4NyQfsfzjwdRyHIVvBq3Fc96nPMnUEOPRdilk=;
        b=H03SG6f+MfSHH3QwF1crHsWTESmZE+G3xilvTDyBuscXy5VAQKGYC5HHtslWD2Gvja
         I0Zt4poEI0XyCOuxkq0ICY0DZiYz/0ISZXcSHPSbveNXFyWlH1NCvDiHWRru0F43DFUv
         O9qxlsHpu4cC+Ziirk9y+Ls2AKEQa+GJgXXiFYQQ+EfVA3Y0Sz1v5eRc2FRhE21Z/alp
         qjSEwRxpRnT6u4bZpxvn7MckxVJbfr7YAamqraFvvhgEQarY/06rhkUrvn4pFhATyTxo
         PwC88PiDTI+IxWvpc1G6DC12GAOKnce9DF65enP25lppy8putJQdkbNEgEi2EzMWsgTV
         YlYQ==
X-Received: by 10.42.129.9 with SMTP id o9mr1542057ics.38.1400012513436;
        Tue, 13 May 2014 13:21:53 -0700 (PDT)
Received: from localhost (of2-nat1.sat6.rackspace.com. [50.56.228.64])
        by mx.google.com with ESMTPSA id u13sm4316440igd.0.2014.05.13.13.21.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 13:21:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3
In-Reply-To: <1400008359-18267-1-git-send-email-1007380@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248813>

In mercurial 3.0, getbundle was moved to the changegroup module, and
gained a new argument. Due to this we cannot simply start using
getbundle(...) imported from either one unconditionally, as that would
cause errors in mercurial 3.0 without changing the syntax, and errors in
mercurial <3.0 if we do change it.

The try:except block at the beginning of git-remote-hg.py tries first to
import mercurial.changegroup.getbundle, and if that fails we set the
function 'getbundle' to work correctly with mercurial.repo.getbundle by
removing the first argument.

Signed-off-by: William Giokas <1007380@gmail.com>
---

So, what I had in there before would not work at all on repo.getbundle
because **kwargs only unpacks keyword args, not normal args. Sometimes my
brain works.

 git-remote-hg.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-remote-hg.py b/git-remote-hg.py
index 34cda02..32eeffb 100755
--- a/git-remote-hg.py
+++ b/git-remote-hg.py
@@ -14,6 +14,13 @@
 
 from mercurial import hg, ui, bookmarks, context, encoding, node, error, extensions, discovery, util
 
+try:
+    from mercurial.changegroup import getbundle
+
+except ImportError:
+    def getbundle(repo, **kwargs):
+        return repo.getbundle(**kwargs)
+
 import re
 import sys
 import os
@@ -985,7 +992,8 @@ def push_unsafe(repo, remote, parsed_refs, p_revs):
     if not checkheads(repo, remote, p_revs):
         return None
 
-    cg = repo.getbundle('push', heads=list(p_revs), common=common)
+    cg = getbundle(repo=repo, source='push', heads=list(p_revs),
+                   common=common)
 
     unbundle = remote.capable('unbundle')
     if unbundle:
-- 
2.0.0.rc3
