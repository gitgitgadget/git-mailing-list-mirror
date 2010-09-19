From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] tree_entry_interesting: turn to match_pathspec if wildcard is present
Date: Mon, 20 Sep 2010 09:29:58 +1000
Message-ID: <1284939000-16907-4-git-send-email-pclouds@gmail.com>
References: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 01:30:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTLC-0001WE-O9
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab0ISXa3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:30:29 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42215 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab0ISXa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:30:28 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1011131pvg.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=YrpS0ji3K1tjCM61sivsOZk+YQV8w0HFz+8d0dCwL1E=;
        b=kAuuKvYdRfcLH21cqqyAKNLI7OwBL9xCob3H9t8lAQwL+u0xzwxLvpEflG41UxTls+
         nYQH4f4cKlpVujJL3fKLaHjYtmQ9F3WHE+QoM+q7cTzy1jJSXCra5Wr49CqevCpoCd9e
         RbzSnR0woP5y2rJ453wQRexDgKXa7Xtoqbxhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FZhxiYQG4npvtBvW3OiTW4Tw6kHheUXn1G5G1OYEineo2OwHKbNtv38DkI94LQ9Zht
         Epo182fhLo6TwIno9ebUVu1EVfoOqudP3ndEWBju94Ea6FRMXTqPEMfcJ4Z2raHY0B+u
         OvhNFpLjdbYdt07JlI3PbO78MpP9bfaXgS0V0=
Received: by 10.114.15.5 with SMTP id 5mr9011913wao.200.1284939028102;
        Sun, 19 Sep 2010 16:30:28 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id s5sm12276365wak.12.2010.09.19.16.30.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:30:27 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:30:22 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156533>

A pathspec with wildcard usually requires full path to do
matching. When full path is found, match_pathspec() can do the job
pretty well (actually it can utilize pathspec_item.has_wildcard, but
that's another matter).

So if tree_entry_interesting() finds that there is wildcard in any
pathspec, it just skips all of its optimizations, tries to make full
path and pass to match_pathspec().

The implementation is pretty naive. Maybe with some pattern analysis,
we can do some early tree cutting.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4010-diff-pathspec.sh |   14 ++++++++++++++
 tree-walk.c              |   18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 94df7ae..4b120f8 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -70,4 +70,18 @@ test_expect_success 'diff-tree pathspec' '
 	test_cmp expected current
 '
=20
+EMPTY_TREE=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904
+
+test_expect_success 'diff-tree with wildcard shows dir also matches' '
+	git diff-tree --name-only $EMPTY_TREE $tree -- "f*" >result &&
+	echo file0 >expected &&
+	test_cmp expected result
+'
+
+test_expect_success 'diff-tree -r with wildcard' '
+	git diff-tree -r --name-only $EMPTY_TREE $tree -- "*file1" >result &&
+	echo path1/file1 >expected &&
+	test_cmp expected result
+'
+
 test_done
diff --git a/tree-walk.c b/tree-walk.c
index 01168ea..bc8c9bd 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -2,6 +2,7 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "tree.h"
+#include "dir.h"
=20
 static const char *get_mode(const char *str, unsigned int *modep)
 {
@@ -478,6 +479,23 @@ int tree_entry_interesting(const struct name_entry=
 *entry,
=20
 	pathlen =3D tree_entry_len(entry->path, entry->sha1);
=20
+	if (ps->has_wildcard) {
+		static char full_path[PATH_MAX];
+
+		/*
+		 * If it's recursive diff, directories are
+		 * intermediate step before ending up to a file.
+		 * Let it pass and we can match the files within
+		 * later.
+		 */
+		if (ps->tree_recursive_diff && S_ISDIR(entry->mode))
+			return 1;
+
+		memcpy(full_path, base, baselen);
+		memcpy(full_path+baselen, entry->path, pathlen+1);
+		return match_pathspec(ps->raw, full_path, baselen+pathlen, 0, NULL) =
> 0;
+	}
+
 	for (i =3D 0; i < ps->nr; i++) {
 		const char *match =3D ps->raw[i];
 		int matchlen =3D ps->items[i].len;
--=20
1.7.1.rc1.70.g788ca
