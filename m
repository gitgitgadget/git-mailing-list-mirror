From: Dylan Reid <dgreid@gmail.com>
Subject: [PATCH] xdiff: optimise for no whitespace difference when ignoring whitespace.
Date: Mon,  5 Jul 2010 09:00:42 -0400
Message-ID: <1278334842-9701-1-git-send-email-dgreid@gmail.com>
References: <1278310017-24299-1-git-send-email-dgreid@gmail.com>
Cc: git@vger.kernel.org, dgreid@gmail.com
To: git@drmicha.warpmail.net
X-From: git-owner@vger.kernel.org Mon Jul 05 14:50:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVl8A-00017t-OO
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 14:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab0GEMsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 08:48:51 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62848 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab0GEMsu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 08:48:50 -0400
Received: by qyk38 with SMTP id 38so1506505qyk.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tFRnKTKMcZmOxNdVFySz9zuIw//vZjF0RiU95XvV72c=;
        b=G0pcrxHhA6bnRMq22xaMD/v/rPd1cebWyy+t0mDD9LByXboUbKc3cWN2OXq43rbLwm
         Hfv7px9uHSdERKIAxBnyBtkSvjuieE77SXcw3k2mTGJTViLr3CLho1Vx18MDyxFNnEw8
         +PIlYAUTZ7mux05QfyD2YEeTQhD80JB0Ytkjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H4wrEY8CRaVszWkwr4P8TOnh9RqJj0Lhf0Km97G0hiUbcmBmICgV4vhWIsNIcup6tG
         2Hys3SsfqslL90eEhze2t+fhoXDTUAHgfU6JOVOgDCZYpITSSNyWYuaFQHJTjo3sSPeg
         t4U+0htEkhtRBdqrrfV9jrvMntWG4rvchYTEY=
Received: by 10.224.115.146 with SMTP id i18mr1361275qaq.275.1278334129533;
        Mon, 05 Jul 2010 05:48:49 -0700 (PDT)
Received: from localhost.localdomain (209-6-87-142.c3-0.frm-ubr3.sbo-frm.ma.cable.rcn.com [209.6.87.142])
        by mx.google.com with ESMTPS id g33sm18007246qcq.16.2010.07.05.05.48.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Jul 2010 05:48:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278310017-24299-1-git-send-email-dgreid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150267>

In xdl_recmatch, do the memcmp to check if the two lines are equal before
checking if whitespace flags are set.  If the lines are identicle, then
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
