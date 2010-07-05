From: Dylan Reid <dgreid@gmail.com>
Subject: [PATCH] xdiff: optimise for no whitespace difference when ignoring whitespace.
Date: Mon,  5 Jul 2010 02:06:57 -0400
Message-ID: <1278310017-24299-1-git-send-email-dgreid@gmail.com>
Cc: dgreid@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 08:02:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVekz-000623-Tx
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 08:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab0GEGCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 02:02:11 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54334 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab0GEGCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 02:02:09 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2010 02:02:09 EDT
Received: by qyk38 with SMTP id 38so1385238qyk.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=E9qfOP3G49hxIev8rnKD5xk4gjHsM+3B8KErf1sDMp4=;
        b=TCcQb/4ogIWXrJMn/3nG73YC2M0NeLpyirle2hHp8hN6aAqQn2BjJq7PZgd0cvzGjY
         bl1r55JEK7FFXis2CiTHJX3vc5E0h0bUkJkcW0DHgwxo+IY59YPtXpgFCm36ulHw3ms+
         d+Iqnr0TBoaXvNQZ1fWgybIckPYnH888qRXxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hbZuCircVMg2yi2NzmyCG9Npc/41Gy4o8Y2iruDvJPtFQhDahzrwCIxmunguHbhP3h
         qf3neuuCDvnhIQmwTVOgKEE/XihiDHT8KNBBi55uXiOxkVgHw4/ty8PvKpytZbXphxoA
         o2iR9eDpZ/4xHBm9FVqH4yI++6JsbEkUja35o=
Received: by 10.224.69.14 with SMTP id x14mr1109477qai.212.1278309273702;
        Sun, 04 Jul 2010 22:54:33 -0700 (PDT)
Received: from localhost.localdomain (209-6-87-142.c3-0.frm-ubr3.sbo-frm.ma.cable.rcn.com [209.6.87.142])
        by mx.google.com with ESMTPS id e32sm16536998qcg.22.2010.07.04.22.54.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Jul 2010 22:54:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150242>

Invert the order of the memcmp and flag check are done in xdl_recmatch,
as it makes the common case (there is no whitespace difference) faster.
It costs the case where lines are the same length and contain
whitespace differences, but the common case is more than 20% faster.

Signed-off-by: Dylan Reid <dgreid@gmail.com>
---
 xdiff/xutils.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index bc12f29..dc97a21 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -190,8 +190,10 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 {
 	int i1, i2;
 
-	if (!(flags & XDF_WHITESPACE_FLAGS))
-		return s1 == s2 && !memcmp(l1, l2, s1);
+	if (s1 == s2 && !memcmp(l1, l2, s1))
+		return 1;
+	else if (!(flags & XDF_WHITESPACE_FLAGS))
+		return 0;
 
 	i1 = 0;
 	i2 = 0;
-- 
1.7.1
