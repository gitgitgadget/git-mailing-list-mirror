From: Dylan Reid <dgreid@gmail.com>
Subject: [PATCH] xdiff: optimise for no whitespace difference when ignoring whitespace.
Date: Mon,  5 Jul 2010 23:11:17 -0400
Message-ID: <1278385877-13902-1-git-send-email-dgreid@gmail.com>
References: <1278310017-24299-1-git-send-email-dgreid@gmail.com>
Cc: dgreid@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 04:58:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVyN5-0005mh-Et
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 04:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab0GFC6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 22:58:50 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59308 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab0GFC6t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 22:58:49 -0400
Received: by vws5 with SMTP id 5so6874387vws.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 19:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=16XOSfONGj/KSIh4mwusPU8BIqJFTk9Yb/jeo83hwpY=;
        b=l+pHaigdHk0Jcj7tcObE3gM2D4xZL2zhyO1nNefALptb/JYSrU+vlKumeS+AvLuV2l
         PD+c4yYRM58XW3yPB4LBXt/tarbotRNvj8mCXdvkTGVMRAZwfTMHN2OhTxyEYQ9v5x7d
         oyBMLlr8HlKNbUDRT52QprxaWUvdMyLzCv+dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=a5F3MFa17+rXYbGqJ5ycT+HbQPVu1sG7aaCo+PINL+c51WLHJ1aE7meKSQxLST+ZPE
         tAjEuaZ3MgEQqhsicl8VeuiYDuqqxGN8EaIhutf2SfzkD/MXuEYgSh9/yFzysDH3o3gg
         Vp7/NBRb0atwwWjVpIA4NmE+xt9kLhehC/bZY=
Received: by 10.229.185.137 with SMTP id co9mr2105675qcb.230.1278385128936;
        Mon, 05 Jul 2010 19:58:48 -0700 (PDT)
Received: from localhost.localdomain (209-6-87-142.c3-0.frm-ubr3.sbo-frm.ma.cable.rcn.com [209.6.87.142])
        by mx.google.com with ESMTPS id q30sm21093670qcq.24.2010.07.05.19.58.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Jul 2010 19:58:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278310017-24299-1-git-send-email-dgreid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150315>

In xdl_recmatch, do the memcmp to check if the two lines are equal before
checking if whitespace flags are set.  If the lines are identical, then
there is no need to check if they differ only in whitespace.
This makes the common case (there is no whitespace difference) faster.
It costs the case where lines are the same length and contain
whitespace differences, but the common case is more than 20% faster.

Signed-off-by: Dylan Reid <dgreid@gmail.com>
---
 xdiff/xutils.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index bc12f29..22f9bd6 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -190,8 +190,10 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 {
 	int i1, i2;
 
+	if (s1 == s2 && !memcmp(l1, l2, s1))
+		return 1;
 	if (!(flags & XDF_WHITESPACE_FLAGS))
-		return s1 == s2 && !memcmp(l1, l2, s1);
+		return 0;
 
 	i1 = 0;
 	i2 = 0;
-- 
1.7.1
