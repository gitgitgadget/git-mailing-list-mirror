From: William Giokas <1007380@gmail.com>
Subject: [PATCH] remote-hg: getbundle changed in mercurial 3.0
Date: Tue, 13 May 2014 14:12:39 -0500
Message-ID: <1400008359-18267-1-git-send-email-1007380@gmail.com>
Cc: William Giokas <1007380@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 21:13:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkI8h-00044B-Iq
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 21:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbaEMTNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 15:13:09 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:53979 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbaEMTNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 15:13:07 -0400
Received: by mail-ig0-f171.google.com with SMTP id c1so5596715igq.4
        for <git@vger.kernel.org>; Tue, 13 May 2014 12:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BG1fy+NdOvZBm9+U3yXsYDvWgyxDBpqScg8qHIip5YA=;
        b=tlfmYNGlZuAfYQpjkyRRSM9sCwqbsX9mnLv2jFZiRPkFVYkIJh2Br8lm45/vJ1tRj5
         0X8WMcc+b0WzcF3naN+eI6BpgiEyerxa98YmmM8EjG4Lg49c6SOCUNrGxaqF1wAGKtf5
         WrwlxmzaFnAq0zdReJ48Kqz/OxQ2rK+0qSqyurKr4HSPrLlGFZlBy7smzuB7yv25rC4W
         PGlDJuTHfL+RBHsIxDVh277WE3W8xYnErLUAX36nS5ZoGNcsXgrH72OTXPseBkZ20GGM
         Hm60nCCJAVHmfW5sl9IZQwNeW9dYp3SEKJ4sI4Mrj5dQW2uHxWFD9Zub2JYg8RYRyAkW
         FkPw==
X-Received: by 10.50.22.37 with SMTP id a5mr60208056igf.30.1400008386265;
        Tue, 13 May 2014 12:13:06 -0700 (PDT)
Received: from localhost (of2-nat1.sat6.rackspace.com. [50.56.228.64])
        by mx.google.com with ESMTPSA id kr5sm32053507igb.9.2014.05.13.12.13.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 12:13:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248806>

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

I have tested this briefly with mercurial 3.0, but have not yet really run
through its paces. The tests that are included in next do pass with
mercurial 3.0.

 git-remote-hg.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-remote-hg.py b/git-remote-hg.py
index 34cda02..3dc9e11 100755
--- a/git-remote-hg.py
+++ b/git-remote-hg.py
@@ -14,6 +14,13 @@
 
 from mercurial import hg, ui, bookmarks, context, encoding, node, error, extensions, discovery, util
 
+try:
+    from mercurial.changegroup import getbundle
+
+except ImportError:
+    def getbundle(__empty__, **kwargs):
+        return repo.getbundle(**kwargs)
+
 import re
 import sys
 import os
@@ -985,7 +992,7 @@ def push_unsafe(repo, remote, parsed_refs, p_revs):
     if not checkheads(repo, remote, p_revs):
         return None
 
-    cg = repo.getbundle('push', heads=list(p_revs), common=common)
+    cg = getbundle(repo, 'push', heads=list(p_revs), common=common)
 
     unbundle = remote.capable('unbundle')
     if unbundle:
-- 
2.0.0.rc3
