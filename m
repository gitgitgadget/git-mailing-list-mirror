From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/21] tree_entry_interesting(): optimize wildcard matching when base is matched
Date: Wed, 15 Dec 2010 22:02:47 +0700
Message-ID: <1292425376-14550-13-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:05:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsvL-00013J-Fr
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab0LOPF1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:05:27 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:49020 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450Ab0LOPF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:05:26 -0500
Received: by gwb20 with SMTP id 20so1538861gwb.1
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=T5eFxAs/HL5QP9eU/ldr3X/V7z/hXy+W/FBVCXVRDBY=;
        b=H4yxb+CiEY5D/2xogGc+0cm34jvJ7f3t1uuW+kN1W+pOGkJzZIRvtEzDt4pxi0QA7J
         tzke/BgaNXmjnkjWtwQXME15lI8OvBxNecM1wb/bhGcrMjm135uYPgA9JJOdn+6kJOd6
         980uLs+v6iF8PadX8uxNEYbopLB+nw1Lyvu4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=N5P62DwJG0vvr8SqmhIoojYrSQtLacLxLJNjXTSScsK36xkLbPqueAkXoVbei9KRn3
         2wiWqZ8HI04lQyOzEvmYJJmSO6NxrTxDgH46ap6tsogNzLCeTDKS78UH2HV6JSm6Ukur
         o2DcY9VjdiulUSZLJvfKWohJnjJUzUPnd8ekU=
Received: by 10.42.170.135 with SMTP id f7mr5983344icz.74.1292425525873;
        Wed, 15 Dec 2010 07:05:25 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id y8sm853060ica.2.2010.12.15.07.05.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:05:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:04:33 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163764>

If base is already matched, skip that part when calling
fnmatch(). This happens quite often if users start a command from
worktree's subdirectory and prefix is usually prepended to all
pathspecs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4010-diff-pathspec.sh |   18 ++++++++++++++++++
 tree-walk.c              |   14 ++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 4b120f8..fbc8cd8 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -84,4 +84,22 @@ test_expect_success 'diff-tree -r with wildcard' '
 	test_cmp expected result
 '
=20
+test_expect_success 'diff-tree with wildcard shows dir also matches' '
+	git diff-tree --name-only $tree $tree2 -- "path1/f*" >result &&
+	echo path1 >expected &&
+	test_cmp expected result
+'
+
+test_expect_success 'diff-tree -r with wildcard from beginning' '
+	git diff-tree -r --name-only $tree $tree2 -- "path1/*file1" >result &=
&
+	echo path1/file1 >expected &&
+	test_cmp expected result
+'
+
+test_expect_success 'diff-tree -r with wildcard' '
+	git diff-tree -r --name-only $tree $tree2 -- "path1/f*" >result &&
+	echo path1/file1 >expected &&
+	test_cmp expected result
+'
+
 test_done
diff --git a/tree-walk.c b/tree-walk.c
index cc5a4e1..99413b3 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -593,6 +593,20 @@ int tree_entry_interesting(const struct name_entry=
 *entry,
 					match + baselen, matchlen - baselen,
 					&never_interesting))
 				return 1;
+
+			if (ps->items[i].has_wildcard) {
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
