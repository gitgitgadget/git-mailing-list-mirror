From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 1/2] fast-import: add a test for tree delta base corruption
Date: Mon, 15 Aug 2011 00:32:23 +0600
Message-ID: <1313346744-30340-2-git-send-email-divanorama@gmail.com>
References: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 20:31:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsfTW-00054q-Su
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 20:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633Ab1HNSbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 14:31:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523Ab1HNSbq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 14:31:46 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2601545bke.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 11:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=q2oPwFSZa2efyAjXPDhFCmZZJqaj6AzelTVEHolPwpE=;
        b=Cb9NyDoevtJquR2les7pgvd7n+GJz0cft/Zk9KjU9Ek3yNpoYJp3X3QHF0D2z/QkRn
         PiCAiMqWBhswnXt78zzhGlgW8tsehPSkfiDWq69AKcRMV5NXeZDkyXcn17wtYOAGX990
         5PFMT0q/521bCKXpVKN5b/jbitZMAJNweGwHY=
Received: by 10.205.65.201 with SMTP id xn9mr9117bkb.406.1313346705458;
        Sun, 14 Aug 2011 11:31:45 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id n11sm1334281bkd.47.2011.08.14.11.31.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 11:31:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179340>

fast-import is able to write imported tree objects in delta format.
It holds a tree structure in memory where each tree entry may have
a delta base sha1 assigned. When delta base data is needed it is
reconstructed from this in-memory structure. Though sometimes the
delta base data doesn't match the delta base sha1 so wrong or even
corrupt pack is produced.

Add a small test that produces a corrupt pack. It uses just tree
copy and file modification commands aside from the very basic commit
and blob commands.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 t/t9300-fast-import.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index f256475..e2b94b5 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -734,6 +734,47 @@ test_expect_success \
 	 git diff-tree --abbrev --raw L^ L >output &&
 	 test_cmp expect output'
 
+cat >input <<INPUT_END
+blob
+mark :1
+data <<EOF
+the data
+EOF
+
+commit refs/heads/L2
+committer C O Mitter <committer@example.com> 1112912473 -0700
+data <<COMMIT
+init L2
+COMMIT
+M 644 :1 a/b/c
+M 644 :1 a/b/d
+M 644 :1 a/e/f
+
+commit refs/heads/L2
+committer C O Mitter <committer@example.com> 1112912473 -0700
+data <<COMMIT
+update L2
+COMMIT
+C a g
+C a/e g/b
+M 644 :1 g/b/h
+INPUT_END
+
+cat <<EOF >expect
+g/b/f
+g/b/h
+EOF
+
+test_expect_failure \
+    'L: nested tree copy does not corrupt deltas' \
+	'git fast-import <input &&
+	git ls-tree L2 g/b/ >tmp &&
+	cat tmp | cut -f 2 >actual &&
+	test_cmp expect actual &&
+	git fsck `git rev-parse L2`'
+
+git update-ref -d refs/heads/L2
+
 ###
 ### series M
 ###
-- 
1.7.3.4
