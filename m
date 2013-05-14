From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 44/47] remote-hg: improve branch listing
Date: Mon, 13 May 2013 23:37:07 -0500
Message-ID: <1368506230-19614-45-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:41:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc73G-0005A8-De
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074Ab3ENElM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:41:12 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:42535 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab3ENElE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:41:04 -0400
Received: by mail-oa0-f51.google.com with SMTP id f4so100477oah.38
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=FSKIc32Bol+mj0eR8XUA4yf7dvqFKZE+74ac8w4FsfI=;
        b=XZ3xX9dlDIUrnobkceU8gUfSw88O9VdSVe71z3R0SUDg+oaGAaVqxC/Xg0VAEbyoVp
         TqDHLTVkMPH+jlH6iV04gUrZ9baIn8EHFPiqlL5FVltIUXf+GBeu8vd5JzpwZw+XecOW
         vDGAK2ekLEdPcZKF/1c8vlm95bxXW4qfazQPHZ7PetweODQb75j6QODR3A44qNcW2v1Q
         v+QqRPx9MLh0KhbNdOhY5PsjKH28uoaiZrd4Yb96kL6LxBB/qnCOxLqhqgMJuvOk32/Y
         5hLdCUkOgVebhlRV7A7hfE1DYSDk8VTzE4rHbBdUPOpcYir4IhWEItNJnVmbM+iYfaQM
         +Vtg==
X-Received: by 10.60.147.197 with SMTP id tm5mr15732821oeb.72.1368506464289;
        Mon, 13 May 2013 21:41:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm20489929oes.6.2013.05.13.21.41.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:41:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224279>

We want to show the remote heads, not the internal ones, which might
have garbage.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index aff1161..cacf2da 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -585,9 +585,12 @@ def do_list(parser):
     list_head(repo, cur)
 
     if track_branches:
-        for branch in repo.branchmap():
-            heads = repo.branchheads(branch)
-            if len(heads):
+        orig = peer if peer else repo
+
+        for branch, heads in orig.branchmap().iteritems():
+            # only open heads
+            heads = [h for h in heads if not repo[h].closesbranch()]
+            if heads:
                 branches[branch] = heads
 
         for branch in branches:
-- 
1.8.3.rc1.579.g184e698
