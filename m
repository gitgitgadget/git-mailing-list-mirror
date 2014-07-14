From: Ephrim Khong <dr.khong@gmail.com>
Subject: [PATCH] sha1_file: do not add own object directory as alternate
Date: Mon, 14 Jul 2014 11:02:40 +0200
Message-ID: <53C39CB0.6040909@gmail.com>
References: <53BFB055.206@gmail.com> <xmqqy4vz51gb.fsf@gitster.dls.corp.google.com> <53C26309.5040401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 11:02:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6c9s-0007PL-4S
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 11:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbaGNJCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 05:02:43 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50666 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbaGNJCd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 05:02:33 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so2136500wiv.11
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vsxpINTXsTqVOXLvWPgGPyC7aAq9W42G90BIrEsy+uE=;
        b=KSSNyklkFHfugLBmKQFcnp78JjUj67ftFzT8y2rTWKJ6iBCYJ9ztmlGtsPCwP2UQCM
         K7cIKdJj5UzKRNrx1LVgYTRxjNOdhEgfYLpG0NIAVHjN3Om0aLXaN5jCta1/GR2/HC+v
         F0JLevvgrd76AB7m1zxri1x4zAcN+muwsJTNeuC8/A1Xcrb1XdiXEu4bqIQEOUJoAYgk
         fAPKksC87SXaYAbloCbHpLX3njORzLjkwJtrsJOHp+hX5rikHgM+gcPfd2CInGujyg/n
         bmPm8H5A8/AC8xoMCUL7ni7YmnWWR3F+RHoTCWz7OtXAIavk9IjLmpdbG87R5z/VxXUK
         8/TQ==
X-Received: by 10.180.187.6 with SMTP id fo6mr16441445wic.58.1405328550535;
        Mon, 14 Jul 2014 02:02:30 -0700 (PDT)
Received: from floh-wuff-book.speedport_w723_v_typ_a_1_01_001 (p57B36443.dip0.t-ipconnect.de. [87.179.100.67])
        by mx.google.com with ESMTPSA id eh10sm24054054wic.0.2014.07.14.02.02.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jul 2014 02:02:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C26309.5040401@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253477>

When adding alternate object directories, we try not to add the
directory of the current repository to avoid cycles.  Unfortunately,
that test was broken, since it compared an absolute with a relative
path.

Signed-off-by: Ephrim Khong <dr.khong@gmail.com>
---
My first patch, so be harsh.  I'm not sure about the filename of the 
test, the behavior is tested with repack, but it affects gc and others 
as well.

  sha1_file.c                        |  2 +-
  t/t7702-repack-cyclic-alternate.sh | 24 ++++++++++++++++++++++++
  2 files changed, 25 insertions(+), 1 deletion(-)
  create mode 100755 t/t7702-repack-cyclic-alternate.sh

diff --git a/sha1_file.c b/sha1_file.c
index 34d527f..7e98e9e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -320,7 +320,7 @@ static int link_alt_odb_entry(const char *entry, 
const char *relative_base, int
  			return -1;
  		}
  	}
-	if (!strcmp(ent->base, objdir)) {
+	if (!strcmp(ent->base, absolute_path(objdir))) {
  		free(ent);
  		return -1;
  	}
diff --git a/t/t7702-repack-cyclic-alternate.sh 
b/t/t7702-repack-cyclic-alternate.sh
new file mode 100755
index 0000000..9a22d98
--- /dev/null
+++ b/t/t7702-repack-cyclic-alternate.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Ephrim Khong
+#
+
+test_description='repack involving cyclic alternate'
+. ./test-lib.sh
+
+test_expect_success setup '
+	git init repo &&
+	cd repo &&
+	touch a &&
+	git add a &&
+	git commit -m 1 &&
+	git repack -adl &&
+	echo $PWD/.git/objects > .git/objects/info/alternates
+'
+
+test_expect_success 're-packing repository with itsself as alternate' '
+	git repack -adl &&
+	git fsck
+'
+
+test_done
-- 
1.8.4.3
