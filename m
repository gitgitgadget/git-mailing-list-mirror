From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 32/48] remote-hg: only update necessary revisions
Date: Fri, 24 May 2013 21:29:48 -0500
Message-ID: <1369449004-17981-33-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4IV-0002Yp-DQ
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab3EYCdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:25 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:43087 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab3EYCdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:22 -0400
Received: by mail-oa0-f49.google.com with SMTP id k14so7071340oag.36
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=n2Lnj1MhybR1gnSwpVatusjufJ8tW/TG9FwqZpTMqjs=;
        b=ENxwzX1LlfjlttSLh4g1ZJCbsBTsxTA4iebsRvwHVCYiwju+zdClKHrp/cytwLpffv
         u0YMrgGMaT96OzpMv+5vINhzSOUnSvK3Fm1nXdeqPqnlS42cOs8zirwOmv6wd56zDre+
         GVcEUhaXhXXsQTtbxmEI6A4e5cDxwVv6eomw6X8lz7RrBLPfNdl1fZJzeWvEZnj7vOAc
         Wu/WWmUFRVo0WBExpCs82c7laOaG26i1fYD7fRi33A/WvwMTdyrurcwVsoezBRHcp22b
         LPUj2dkhdAbfLSR0oi/0OqAco0cFZvO8lwM/5B1UcKExdMOChv6k7MehU+ENvSZzmHp5
         BCEQ==
X-Received: by 10.182.44.165 with SMTP id f5mr13316949obm.26.1369449201411;
        Fri, 24 May 2013 19:33:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm20597023oep.1.2013.05.24.19.33.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225446>

We don't care about the rest, and in fact, we shouldn't try to push
everything, as there might be garbage from previous failed pushes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 4d650b5..7added3 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -858,6 +858,7 @@ def do_export(parser):
     global parsed_refs, bmarks, peer
 
     p_bmarks = []
+    p_revs = set()
 
     parser.next()
 
@@ -882,6 +883,7 @@ def do_export(parser):
             if branch in branches and bnode in branches[branch]:
                 # up to date
                 continue
+            p_revs.add(bnode)
             print "ok %s" % ref
         elif ref.startswith('refs/heads/'):
             bmark = ref[len('refs/heads/'):]
@@ -896,6 +898,7 @@ def do_export(parser):
                     not (bmark == 'master' and bmark not in parser.repo._bookmarks):
                 p_bmarks.append((ref, bmark, old, new))
 
+            p_revs.add(bnode)
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             tag = hgref(tag)
@@ -903,18 +906,20 @@ def do_export(parser):
             if mode == 'git':
                 if not msg:
                     msg = 'Added tag %s for changeset %s' % (tag, node[:12]);
-                write_tag(parser.repo, tag, node, msg, author)
+                tagnode = write_tag(parser.repo, tag, node, msg, author)
+                p_revs.add(tagnode)
             else:
                 fp = parser.repo.opener('localtags', 'a')
                 fp.write('%s %s\n' % (node, tag))
                 fp.close()
+            p_revs.add(bnode)
             print "ok %s" % ref
         else:
             # transport-helper/fast-export bugs
             continue
 
     if peer:
-        parser.repo.push(peer, force=force_push, newbranch=True)
+        parser.repo.push(peer, force=force_push, newbranch=True, revs=list(p_revs))
 
         # update remote bookmarks
         remote_bmarks = peer.listkeys('bookmarks')
-- 
1.8.3.rc3.312.g47657de
