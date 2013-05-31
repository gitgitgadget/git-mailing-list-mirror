From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 5/6] contrib: related: parse committish like format-patch
Date: Fri, 31 May 2013 02:37:43 -0500
Message-ID: <1369985864-31922-6-git-send-email-felipe.contreras@gmail.com>
References: <1369985864-31922-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 09:40:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJwN-0008Qh-LO
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 09:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613Ab3EaHjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 03:39:46 -0400
Received: from mail-ye0-f170.google.com ([209.85.213.170]:38681 "EHLO
	mail-ye0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab3EaHjo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 03:39:44 -0400
Received: by mail-ye0-f170.google.com with SMTP id r5so294001yen.29
        for <git@vger.kernel.org>; Fri, 31 May 2013 00:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gAsf+k34ZZQ/TPGL0ZT5SCytrTDEax534KlWpLnWdbU=;
        b=aXjyKl2a4ZE+w0FiFmx+r0limKOdTf8zb/Ti6rZ5iaJvdmDIMsAyf1/D5tx/UmLoOa
         YGuWgBZBT2+CKHm1Oo7jTxPA6xoBrCl6xMtD/stjwLqcYC4zj0l62utBqRFERbOv5jPX
         21DNE453qpWZA1wNoPzJxPf5n0JUDQIxy+kg2Pnkhu4iNXddoXHStzKKRClL34TxcQcX
         M5S1VovmZHc+dFd4fsu9wyNDIQYNVStXo8j6xW+7fWM7vZ4ZBttZhkjKWykJtF8qYUUK
         uBVDu/u9rSRV1tahBk1Fs8zADFK6a6tnQNNFSXaDnNSQ6WIL7QHQRnHgCxAyYbX6Yy7r
         FNyA==
X-Received: by 10.236.146.8 with SMTP id q8mr6185079yhj.72.1369985982784;
        Fri, 31 May 2013 00:39:42 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id g70sm66058417yhm.7.2013.05.31.00.39.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 May 2013 00:39:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.358.g5a91d05
In-Reply-To: <1369985864-31922-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226061>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 3573237..585572b 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -121,6 +121,21 @@ class Commits
   end
 
   def from_rev_args(args)
+    revs = []
+
+    File.popen(%w[git rev-parse --revs-only --default HEAD --symbolic] + args).each do |rev|
+      revs << rev.chomp
+    end
+
+    case revs.size
+    when 1
+      r = revs[0]
+      r = '^' + r if r[0] != '-'
+      args = [ r, 'HEAD' ]
+    else
+      args = revs
+    end
+
     source = nil
     File.popen(%w[git rev-list --reverse] + args) do |p|
       p.each do |e|
-- 
1.8.3.358.g5a91d05
