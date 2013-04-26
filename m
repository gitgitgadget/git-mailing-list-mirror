From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 17/20] remote-bzr: iterate revisions properly
Date: Thu, 25 Apr 2013 20:08:05 -0500
Message-ID: <1366938488-25425-18-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:10:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXB9-0004Ek-Fb
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932913Ab3DZBKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:10:14 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:35779 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853Ab3DZBKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:10:12 -0400
Received: by mail-oa0-f43.google.com with SMTP id k7so3472907oag.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=NdIlMl4GlXq64WPzr9dsYGYRgOAj4F7jnlcYlSgonVg=;
        b=eCiZ0vViqPMg2s/t9EgiVxLmcHWJFCIKbfaJv/vuJfppWtDsnUgTLMOD7bN2PJ374J
         7Ifhq9Yby/84Va7EpjJo1lcqo1ahmyTjns58SPZu9LIUAlSWvccDSUEaZVMiwjGnqIjv
         r2PPFbgc03btR9J14SwigHwB+1RZV1MG0ffDa1HekpTd/GWy+3PRhLZMotrKyajI8C8d
         StXFBDE0rSCG+6tFcy0f0TXv0NiDXvY6Nt2gpVWQV2oySlRJnuUeZ8IZZ9JyKqveZhCF
         h3oBFBBHae9mLPmuI+y+kngKdoGUdbtTVg9r0F+0k7i1uYvGWdMYqMaBle8AB4xhMOTN
         sriw==
X-Received: by 10.182.28.68 with SMTP id z4mr16434003obg.36.1366938612299;
        Thu, 25 Apr 2013 18:10:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id fl7sm5866313obb.0.2013.04.25.18.10.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:10:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222498>

This way we don't need to store the list of all the revisions, which
doesn't seem to be very memory efficient with bazaar's design, for
whatever reason.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 7d3052a..5f1b9c0 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -309,9 +309,10 @@ def export_branch(repo, name):
     last_revno, _ = branch.last_revision_info()
     total = last_revno - tip_revno
 
-    revs = [revid, seq for revid, _, seq, _ in revs if not marks.is_marked(revid)]
+    for revid, _, seq, _ in revs:
 
-    for revid, seq in revs:
+        if marks.is_marked(revid):
+            continue
 
         rev = repo.get_revision(revid)
         revno = seq[0]
-- 
1.8.2.1.884.g3532a8d
