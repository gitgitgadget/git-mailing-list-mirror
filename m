From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] diff: turn skip_stat_unmatch on selectively
Date: Tue, 28 Jan 2014 05:59:28 +0700
Message-ID: <1390863568-22656-1-git-send-email-pclouds@gmail.com>
References: <1390632411-3596-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 27 23:54:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7v46-0005NM-PE
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 23:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbaA0Wx6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jan 2014 17:53:58 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:53987 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbaA0Wx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 17:53:57 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so6316127pdj.29
        for <git@vger.kernel.org>; Mon, 27 Jan 2014 14:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=R32K+tmbwVihDVxpZXBriCpvZ4J0TOL4o4YI2BEc4Zk=;
        b=kRZXpgeBDR+LqlC/JkXP7YGUKzCRkmuEbKdRMNEVpmLFNan16kKUll8HmTUh4caOtr
         WT5SKNIb9PYQCeBbtvfsXg3Tas03DgAqaP7vuPph5KuocZqxigcl1Pds7CguEWkM/uuj
         wh1MHzkCiHeZ9kIcnExVmZ0GTxyMzfOgiXHkCP5zah9d89B+ojQzoroARN/Y8uewNGxD
         PWnA4gNU5QL8gckvH5ljJcKFloamc8smuTtY/nggdK3wFntliUeaVdYNl3g4GAnapFff
         qcHL9z0o7hBH0yjKNsM6QNjW/SqZZ7cerZRDjTm4hH4JO2vuRsJN026nRIixsqd+wi7v
         ds+g==
X-Received: by 10.68.136.162 with SMTP id qb2mr33235602pbb.88.1390863236744;
        Mon, 27 Jan 2014 14:53:56 -0800 (PST)
Received: from lanh ([115.73.231.188])
        by mx.google.com with ESMTPSA id vp4sm94997148pab.8.2014.01.27.14.53.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 Jan 2014 14:53:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 28 Jan 2014 05:59:35 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390632411-3596-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241163>

skip_stat_unmatch flag is added in fb13227 (git-diff: squelch "empty"
diffs - 2007-08-03) to ignore empty diffs caused by stat-only
dirtiness. In some diff case, stat is not involved at all. While
the code is written in a way that no expensive I/O is done, we still
need to move all file pairs from the old queue to the new queue in
diffcore_skip_stat_unmatch().

Only enable it when worktree is involved: "diff" and "diff <rev>".
This should help track down how skip_stat_unmatch is actually used
when bugs occur.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This replaces 'diff: turn off skip_stat_unmatch on "diff --cached"'
 The previous patch obviously leaves skip_stat_unmatch on in "diff
 <rev> <rev>" and maybe other cases.

 builtin/diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 0f247d2..88542d9 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -150,6 +150,7 @@ static int builtin_diff_index(struct rev_info *revs=
,
 			perror("read_cache_preload");
 			return -1;
 		}
+		revs->diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
 	} else if (read_cache() < 0) {
 		perror("read_cache");
 		return -1;
@@ -252,6 +253,7 @@ static int builtin_diff_files(struct rev_info *revs=
, int argc, const char **argv
 		perror("read_cache_preload");
 		return -1;
 	}
+	revs->diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
 	return run_diff_files(revs, options);
 }
=20
@@ -343,7 +345,6 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 		diff_no_index(&rev, argc, argv, prefix);
=20
 	/* Otherwise, we are doing the usual "git" diff */
-	rev.diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
=20
 	/* Scale to real terminal size and respect statGraphWidth config */
 	rev.diffopt.stat_width =3D -1;
--=20
1.8.5.2.240.g8478abd
