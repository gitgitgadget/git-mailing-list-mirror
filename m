From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH 4/5] t3200: test -l with core.logAllRefUpdates options
Date: Fri, 21 May 2010 21:28:38 -0300
Message-ID: <1274488119-6989-5-git-send-email-erick.mattos@gmail.com>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 02:30:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFcbN-0002Dk-B9
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 02:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759Ab0EVA3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 20:29:55 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:43521 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932341Ab0EVA3x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 20:29:53 -0400
Received: by gxk27 with SMTP id 27so949454gxk.1
        for <git@vger.kernel.org>; Fri, 21 May 2010 17:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2w3mkKosijJbDcW4DPZWPUeFcTXaJBxfxY4kTyerkBo=;
        b=Wes98sDFW37Dm1eSFphOw9Wxlap/dhMZm22b5CqMABzzTXE1a6Qkwg8luhK9Vqocvm
         FHX9Q9d6+A7r8P7P+irfocwC0wVLilYOb1iFoFIjhbP9EN6SQGJN4hR5xWFf35Xuc0aR
         5k6/pBJRBW+03e7+V47+XoYttD41KWXfcDgRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UzOynKqFeiKc1xIr3SRA2lsDbaYFVBpbqO4vMg+ublrtcsUBQjjnJ5jG0Ol/g47Dht
         SbWuXKGqCm0HoEgMIHzNsyXIGn+G15Nlm84gozY4KVDQmFv1SvpgjpZ0XjuR79WWwO9w
         IAcO/hJ3VPrW2lQIJSl2DapO22xqP98lzNRcQ=
Received: by 10.150.176.7 with SMTP id y7mr3591814ybe.421.1274488193201;
        Fri, 21 May 2010 17:29:53 -0700 (PDT)
Received: from localhost.localdomain ([187.15.117.192])
        by mx.google.com with ESMTPS id z42sm23557998ybc.6.2010.05.21.17.29.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 17:29:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.231.g0687c.dirty
In-Reply-To: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147501>

By default reflogs are always created for new local branches by
"checkout -b".  But by setting core.logAllRefUpdates to false this will
not be true anymore.

In that case you only create the reflogs when you use -l switch with
"checkout -b".

Added missing tests to check expected behaviors.
---
 t/t3200-branch.sh |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e0b7605..9d2c06e 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -224,6 +224,30 @@ test_expect_success \
 	 test -f .git/logs/refs/heads/g/h/i &&
 	 diff expect .git/logs/refs/heads/g/h/i'
 
+test_expect_success 'checkout -b makes reflog by default' '
+	git checkout master &&
+	git config --unset core.logAllRefUpdates &&
+	git checkout -b alpha &&
+	test -f .git/logs/refs/heads/alpha &&
+	PAGER= git reflog show alpha
+'
+
+test_expect_success 'checkout -b does not make reflog when core.logAllRefUpdates = false' '
+	git checkout master &&
+	git config core.logAllRefUpdates false &&
+	git checkout -b beta &&
+	! test -f .git/logs/refs/heads/beta &&
+	test_must_fail PAGER= git reflog show beta
+'
+
+test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates = false' '
+	git checkout master &&
+	git checkout -lb gamma &&
+	git config --unset core.logAllRefUpdates &&
+	test -f .git/logs/refs/heads/gamma &&
+	PAGER= git reflog show gamma
+'
+
 test_expect_success 'avoid ambiguous track' '
 	git config branch.autosetupmerge true &&
 	git config remote.ambi1.url lalala &&
-- 
1.7.1.231.g0687c.dirty
