From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 1/2] fast-import: add 'commit from 0{40}' failing test
Date: Mon, 19 Sep 2011 03:20:45 +0600
Message-ID: <1316380846-15845-2-git-send-email-divanorama@gmail.com>
References: <1316380846-15845-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 23:14:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5OhO-0007FT-S6
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555Ab1IRVOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 17:14:38 -0400
Received: from mail-wy0-f170.google.com ([74.125.82.170]:38777 "EHLO
	mail-wy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932366Ab1IRVOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 17:14:35 -0400
Received: by mail-wy0-f170.google.com with SMTP id 8so8299412wyg.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wr371KvSSk+Dy1TH7PgoiICx+YGb5uPDLmdTSGxMgLA=;
        b=HsLq9upd0c8f9Hyu+oRDcBGPURQ0VpmsJJG4EWXHy+Wooz3xaK47W2j1elWhJaWksR
         y/SU4x7LC3OA7kI5ct10DInyfP4vJLwHWkocTdoCbaRfS9iMdxQrydKEebFWbTOIso41
         kw11TJVYTPVBpmmiuPabYBBcOGA+itkpdf3ag=
Received: by 10.216.220.129 with SMTP id o1mr1885901wep.103.1316380474871;
        Sun, 18 Sep 2011 14:14:34 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id gd6sm22990486wbb.1.2011.09.18.14.14.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 14:14:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316380846-15845-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181640>

Following shouldn't be allowed, while it is:

commit refs/heads/some
committer ...
data ...
from `null_sha1`

It is treated as if 'from' was omitted. But it is allowed to just
omit 'from' actually. And `null_sha1` being special in fast-import
is an internal implementation detail.

Add a test as described.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 t/t9300-fast-import.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 1a6c066..8cc3f16 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -375,6 +375,18 @@ test_expect_success 'B: fail on invalid branch name "bad[branch]name"' '
 rm -f .git/objects/pack_* .git/objects/index_*
 
 cat >input <<INPUT_END
+commit refs/heads/zeromaster
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data 0
+
+from 0000000000000000000000000000000000000000
+INPUT_END
+test_expect_failure 'B: fail on "from 0{40}"' '
+    test_must_fail git fast-import <input
+'
+rm -f .git/objects/pack_* .git/objects/index_*
+
+cat >input <<INPUT_END
 commit TEMP_TAG
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
-- 
1.7.3.4
