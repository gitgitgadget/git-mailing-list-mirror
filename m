From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 43/47] remote-hg: simplify branch_tip()
Date: Mon, 13 May 2013 23:37:06 -0500
Message-ID: <1368506230-19614-44-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:41:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc734-000504-74
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058Ab3ENElF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:41:05 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:60217 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab3ENElB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:41:01 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so99017oag.39
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=kTpU3Ch/KTGP/mSErWAcWdtNclE9tM3FazXYqhQDFT8=;
        b=WAeKXMTOdSzpH8jmBM2RKkMEsPQSvBBBHNggUgiJOY7pJ8kCTwNE/9+ZOrWwSH6R2U
         VZ90USp9oa1BguoTr7tLHSiln8vQgFkmm+0fwPOCW9iRjFcoDWXQqgJqT1wUvKbSLiUe
         0YOYNltEw7CkLF2vuEszz5Po6lvYaAL1SOQYUdEo5BNDtGJrSua33ShZq17V7si4/DuA
         JrEWdUz5CqGxp8eR2Iulyj+Kz/m32fmP+igdBW7I8eM/o8tnCskVY62peVZbuq7nSYro
         NKTO3JHniBSWcR50C6c+GdeHEAClfnEC3xsNTAmGQkrFH06dmAy21EifqY/WeM96vRIX
         i7nA==
X-Received: by 10.60.84.102 with SMTP id x6mr15706721oey.73.1368506461074;
        Mon, 13 May 2013 21:41:01 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id qj8sm20528328oeb.2.2013.05.13.21.40.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:41:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224275>

It simply picks the last head that is not closed, but we have a stored
list of open heads.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index df3b9a4..aff1161 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -541,12 +541,8 @@ def do_capabilities(parser):
 
     print
 
-def branch_tip(repo, branch):
-    # older versions of mercurial don't have this
-    if hasattr(repo, 'branchtip'):
-        return repo.branchtip(branch)
-    else:
-        return repo.branchtags()[branch]
+def branch_tip(branch):
+    return branches[branch][-1]
 
 def get_branch_tip(repo, branch):
     global branches
@@ -558,7 +554,7 @@ def get_branch_tip(repo, branch):
     # verify there's only one head
     if (len(heads) > 1):
         warn("Branch '%s' has more than one head, consider merging" % branch)
-        return branch_tip(repo, hgref(branch))
+        return branch_tip(hgref(branch))
 
     return heads[0]
 
@@ -808,7 +804,7 @@ def parse_tag(parser):
 
 def write_tag(repo, tag, node, msg, author):
     branch = repo[node].branch()
-    tip = branch_tip(repo, branch)
+    tip = branch_tip(branch)
     tip = repo[tip]
 
     def getfilectx(repo, memctx, f):
-- 
1.8.3.rc1.579.g184e698
