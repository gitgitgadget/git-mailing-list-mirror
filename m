From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 1/5] t9350: point out that refs are not updated correctly
Date: Sun, 24 Jul 2011 16:21:18 +0200
Message-ID: <1311517282-24831-2-git-send-email-srabbelier@gmail.com>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jul 24 16:22:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkzZn-0006Dd-4Q
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 16:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab1GXOWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 10:22:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56531 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812Ab1GXOWU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 10:22:20 -0400
Received: by mail-wy0-f174.google.com with SMTP id 8so2291817wyg.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 07:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cOvHmU9X7YNCG5kmDrOSDFcCz2liDr0sJs3oRNp5+Sg=;
        b=WEHEvbkjVC8P796/AWmRIGT2WobjmMhkMaWOXtBhZFCk3EqKLjIDisP8Rgn8WXD3Br
         hmIoMTZPQMPZ79fYBapln407VTDUpU8TBukWsjzavE77zmQl8SpWUAmTHNKZo6N7J/X6
         lk8OUTEozAKYPbbI5RH+knXKNQ0aQJL0zU/q4=
Received: by 10.227.173.201 with SMTP id q9mr3071624wbz.92.1311517339310;
        Sun, 24 Jul 2011 07:22:19 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id fc2sm3526819wbb.35.2011.07.24.07.22.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 07:22:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.385.g91185.dirty
In-Reply-To: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177757>

This happens only when the corresponding commits are not exported in
the current fast-export run. This can happen either when the relevant
commit is already marked, or when the commit is explicitly marked
as UNINTERESTING with a negative ref by another argument.

This breaks fast-export basec remote helpers.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Obviously the real occurance of the breakage is not as artificial
  as this test case, but it's a very simple minimal reproducer.

 t/t9350-fast-export.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index f823c05..ed0417a 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -414,4 +414,15 @@ test_expect_success SYMLINKS 'directory becomes symlink'        '
 	(cd result && git show master:foo)
 '
 
+cat > expected << EOF
+reset refs/heads/master
+from $(git rev-parse master)
+
+EOF
+
+test_expect_failure 'refs are updated even if no commits need to be exported' '
+	git fast-export master..master > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.6.385.g91185.dirty
