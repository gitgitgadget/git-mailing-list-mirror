From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] diff: support --root --cached combination
Date: Fri, 29 Oct 2010 16:54:47 +0700
Message-ID: <1288346087-20263-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 11:55:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBlfz-0007sx-6w
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 11:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756538Ab0J2Jyv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 05:54:51 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52867 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756694Ab0J2Jyt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 05:54:49 -0400
Received: by pwj3 with SMTP id 3so769463pwj.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=hcoJVcXOaAtu+z2AdpgyxhRtVrJfEuJhY3SW6OwFXlI=;
        b=VqMLcCBnIJcGtK8WcpLy2kOcAzxBmVAu8vIjHFUHbWzpOpHsvgg3wVy4d1TjR2xl6J
         m6EIAbbV0i9rkZzNuWzU5QV1vB+BMHrab6auJi7jR9XSEy3zzhHL6AQyvhPZCJLo6U2D
         N75i4olnsCM+6YG9addjoHeNh3lwhk7g0LNGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=WUxlZ7w0a3l72XdzeBJT/Smp3qdVxRYEDhXBW8Iah95CEvQ917dwLWvMJhXtw3XOX6
         77C8NuJhLGMMhrXT33JhlIXE6ShRpBdHKb5SNPHaRsAVfkofphXEdXt8Pl8NylY5/HzS
         vVOODI5UN9MLIYy2pZKM8qZQPsMk7YBX5cVIo=
Received: by 10.142.209.15 with SMTP id h15mr1169689wfg.271.1288346089107;
        Fri, 29 Oct 2010 02:54:49 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x18sm1432783wfa.23.2010.10.29.02.54.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 02:54:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 16:54:48 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160324>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I have a ritual of doing "git dic" (short for diff --cached) before
 committing and does not want to break it, even on new repos.

 Looks like a good thing and no harm to the rest of the world.

 builtin/diff.c              |    9 +++++++--
 t/t4046-diff-cached-root.sh |   31 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100755 t/t4046-diff-cached-root.sh

diff --git a/builtin/diff.c b/builtin/diff.c
index a43d326..45be6f3 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -330,8 +330,13 @@ int cmd_diff(int argc, const char **argv, const ch=
ar *prefix)
 			else if (!strcmp(arg, "--cached") ||
 				 !strcmp(arg, "--staged")) {
 				add_head_to_pending(&rev);
-				if (!rev.pending.nr)
-					die("No HEAD commit to compare with (yet)");
+				if (!rev.pending.nr) {
+					struct object *obj;
+					if (!rev.show_root_diff)
+						die("No HEAD commit to compare with (yet)");
+					obj =3D (struct object*)lookup_tree((unsigned char*)EMPTY_TREE_SH=
A1_BIN);
+					add_pending_object(&rev, obj, "HEAD");
+				}
 				break;
 			}
 		}
diff --git a/t/t4046-diff-cached-root.sh b/t/t4046-diff-cached-root.sh
new file mode 100755
index 0000000..82e3ad8
--- /dev/null
+++ b/t/t4046-diff-cached-root.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description=3D'git diff --cached --root test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo cached >file &&
+	git add file &&
+	echo not-cached >>file
+'
+
+test_expect_success 'diff --cached' '
+	test_must_fail git diff --cached
+'
+
+test_expect_success 'diff --cached --root' '
+	git diff --cached --root >result &&
+	cat >expected <<\EOF &&
+diff --git a/file b/file
+new file mode 100644
+index 0000000..ec9a961
+--- /dev/null
++++ b/file
+@@ -0,0 +1 @@
++cached
+EOF
+	test_cmp expected result
+'
+
+test_done
--=20
1.7.0.2.445.gcbdb3
