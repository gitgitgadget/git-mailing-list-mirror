From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] diff: bugfix: binary file permission regression
Date: Fri, 11 Jun 2010 02:31:25 +0800
Message-ID: <1276194685-28098-1-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 10 20:30:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMmWV-00013M-ND
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 20:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759148Ab0FJSaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 14:30:21 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:34972 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758889Ab0FJSaS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 14:30:18 -0400
Received: by pxi8 with SMTP id 8so84900pxi.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 11:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9tVkjQtYnK0ece3ynA8HJZzXaIGj7jK520tX1Dzna1M=;
        b=TXEgqh+Din3EkL3Zmd954zD/cSRe7RY73oxv2eLtAdgIrRqL+BbEoKks7KDCP6EEqx
         2mS/ZAcTSVEqBKlRRDE5Mkh1nu7CundYdCxDjwv0rUsHh1Whqms8qRQ5E+6LIPnzhInf
         X/LFMU6MUbaFdhBY4F+dT+vY6ig9uzisF/nwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Tq+ZT/P75xmVB2gGFJryxCCUpoTw0UzPVU1SuNO/XoB7G8pt52cTTDTYmVEHJMednt
         u2fGWhv1izR3KyrSF5VjCtZy+fPJzBxnXMcFORblmzWcRWGXf7A5ovkgt8FddZ4IgBOJ
         /8lIEfW+tFc5g9A7g/DIijPKl3vBPXfgOZ1qM=
Received: by 10.141.23.19 with SMTP id a19mr424033rvj.63.1276194618384;
        Thu, 10 Jun 2010 11:30:18 -0700 (PDT)
Received: from localhost.localdomain ([115.134.71.100])
        by mx.google.com with ESMTPS id g14sm269651rvb.13.2010.06.10.11.30.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jun 2010 11:30:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.245.g7c42e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148906>

Regression at 3e97c7c6af2901cec63bf35fcd43ae3472e24af8
"No diff -b/-w output for all-whitespace changes"

When a binary file's permission is modified, git status
reports the file as modified, but git diff shows nothing.

Add a test file too.
---
 diff.c                            |    4 ++--
 t/t4043-diff-binary-permission.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100755 t/t4043-diff-binary-permission.sh

diff --git a/diff.c b/diff.c
index 494f560..0aa1a2d 100644
--- a/diff.c
+++ b/diff.c
@@ -1745,12 +1745,12 @@ static void builtin_diff(const char *name_a,
 	      (!textconv_two && diff_filespec_is_binary(two)) )) {
 		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 			die("unable to read files to diff");
+		fprintf(o->file, "%s", header.buf);
+		strbuf_reset(&header);
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
 			goto free_ab_and_return;
-		fprintf(o->file, "%s", header.buf);
-		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(o->file, &mf1, &mf2);
 		else
diff --git a/t/t4043-diff-binary-permission.sh b/t/t4043-diff-binary-permission.sh
new file mode 100755
index 0000000..7b77fb3
--- /dev/null
+++ b/t/t4043-diff-binary-permission.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Nazri Ramliy
+#
+
+test_description='Test permission change on binary files
+
+'
+. ./test-lib.sh
+
+/bin/echo -e "\0\0\0\0" > a.bin
+chmod 644 a.bin
+git update-index --add a.bin
+chmod 755 a.bin
+
+cat << EOF > expect
+diff --git a/a.bin b/a.bin
+old mode 100644
+new mode 100755
+EOF
+
+git diff > out
+
+test_expect_success 'diff-binary-permission' 'test_cmp expect out'
+
+test_done
-- 
1.7.1.245.g7c42e.dirty
