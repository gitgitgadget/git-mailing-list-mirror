From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 38/47] remote-hg: only update necessary revisions
Date: Mon, 13 May 2013 23:37:01 -0500
Message-ID: <1368506230-19614-39-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72l-0004oJ-3k
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983Ab3ENEkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:46 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61029 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab3ENEkp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:45 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so102345oag.33
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=vTTEOGAlKiY2FfyhUK+UmMyfxikc8cCM01GcdDycf/0=;
        b=yO89+4LSE6jqfLzYP8T10wDKsu3Cdpg2hCp67JZMjfhRyS2HQM89p/qse9GF51f8y9
         vl0bPWktTWQs8tORBRDAxX6qdnCjCMAerpsrtk0jWln3xkPSXeHxGpq3hBbQ/F9ZR6Ix
         xhdFw5Jjbu5FVuA0Jkhp9xiSBG5V4/wbG+KqKn3KuY6Tyfzkzpu9C1+eU208l108ZeuF
         zPr0A82h4To5pGTMQXveK/AAc65+kh2fs8/KnfS8oyM5HRj+wYcHZ8WgN2/6Tda5COlq
         toVROJZQCwgIUdaQsmUNnQ1oKhy1pJg19iKyArxAXA06E8aDtLnWHmsdjA7IC/YRuXtn
         Qzrw==
X-Received: by 10.60.80.197 with SMTP id t5mr12757979oex.1.1368506444775;
        Mon, 13 May 2013 21:40:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id yx4sm9279377obb.11.2013.05.13.21.40.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224266>

We don't care about the rest, and in fact, we shouldn't try to push
everything, as there might be garbage from previous failed pushes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 0780679..c814188 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -843,6 +843,7 @@ def do_export(parser):
     global parsed_refs, bmarks, peer
 
     p_bmarks = []
+    p_revs = set()
 
     parser.next()
 
@@ -867,6 +868,7 @@ def do_export(parser):
             if branch in branches and bnode in branches[branch]:
                 # up to date
                 continue
+            p_revs.add(bnode)
             print "ok %s" % ref
         elif ref.startswith('refs/heads/'):
             bmark = ref[len('refs/heads/'):]
@@ -883,6 +885,7 @@ def do_export(parser):
             else:
                 p_bmarks.append((ref, bmark, old, new))
 
+            p_revs.add(bnode)
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             tag = hgref(tag)
@@ -890,18 +893,20 @@ def do_export(parser):
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
1.8.3.rc1.579.g184e698
