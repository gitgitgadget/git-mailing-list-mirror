From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/19] tree_entry_interesting(): optimize fnmatch when base is matched
Date: Mon, 13 Dec 2010 16:46:50 +0700
Message-ID: <1292233616-27692-14-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:55:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS58B-0007G3-2i
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab0LMJzi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:55:38 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33497 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab0LMJzh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:55:37 -0500
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2010 04:55:37 EST
Received: by iyi12 with SMTP id 12so773185iyi.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HZ6clmMIvLl9vi4LmxK0mT/cD8hdR4cX/ULBDAw4eGE=;
        b=WajlkVW/1IL21xZ0Y6tD1GXhImIadRw1iGTxuJ1t3UZReGDoCsmwfYcu5Sdq9qtm8y
         leaUjyOIRRRxjn0nzSOtk64trX48QKVm7ZQ5ShmmWXvfQOI2BfSCcRwdCWWc4eGwr0ba
         VpnE674lsQ9CGGqvQLOTiF9frKkQbjKAvHaQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sX74an9d7sRMG7ORB5WVwbsvTCB32ZEwtWUhzYUkLezmuI9oG/3mCEaNdzyP+gtHM2
         fQ3kzOsUrdOM2iADG5tEjXT4N8H84UT7/dMm5rAx87uVEyJg4rBzJO7BuGEETLs36KZm
         AIjf1KF1S+YCCw/xJmIeHi1x3OJN17cFROU/4=
Received: by 10.231.30.68 with SMTP id t4mr1045722ibc.15.1292233772379;
        Mon, 13 Dec 2010 01:49:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id i16sm6048580ibl.12.2010.12.13.01.49.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:49:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:48:39 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163548>

If base is already matched, skip that part when calling
fnmatch(). This happens quite often when users start a command from
worktree's subdirectory and prefix is usually prepended to all
pathspecs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4010-diff-pathspec.sh |   14 ++++++++++++++
 tree-walk.c              |   15 +++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

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
index b5ad42b..e1a18fc 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -597,6 +597,21 @@ int tree_entry_interesting(const struct name_entry=
 *entry,
 					match + baselen, matchlen - baselen,
 					&never_interesting))
 				return 1;
+
+			if (item->has_wildcard) {
+				never_interesting =3D 0;
+				if (!fnmatch(match + baselen, entry->path, 0))
+					return 1;
+
+				/*
+				 * Match all directories. We'll try to
+				 * match files later on.
+				 */
+				if (ps->recursive && S_ISDIR(entry->mode))
+					return 1;
+			}
+
+			continue;
 		}
=20
 match_wildcards:
--=20
1.7.3.3.476.g10a82
