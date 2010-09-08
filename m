From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/8] setup_tree_pathspec(): interpret '^' as negative pathspec
Date: Thu,  9 Sep 2010 01:50:22 +1000
Message-ID: <1283961023-4491-8-git-send-email-pclouds@gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 05:23:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtXjU-0000RF-FB
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 05:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab0IIDXY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 23:23:24 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35424 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332Ab0IIDXS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 23:23:18 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so311287pzk.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 20:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=kNv1mjSwyGW7PNgKPRtKQqzAv4gaF50wqF1sN3/hj80=;
        b=tm3+KUMT01J+NMTygoAp/41F29Rg+AA9Z/dN3UGrgkKADETJgBrXIK8Ga5Bp8604J9
         HqLzbKFSNBAHOuUo+HAZSsR0h/xg/ppHc3v9wt9C2fnCl9lc7/lw1MG2EVTxVBr9AE46
         y64685nAnUAn03Ztt7hozdUX51ZmikQGLu7pE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oT61QI0pgqJqpkwrL/gKwbYSCkrN4uX+t1J7M65zmTkj6iQwSQ9X2DYFXlss9T+8E+
         Vt6CaHskNfSH7X5vVv7LK+Dqc9dBaTVxkXJLvIHFp30CN7FVyxfR+86+G6sBRJ1UMa3D
         6FlU4IEf72Kt6uQ0f/sSskAa0OvbNpx5l+NQ0=
Received: by 10.142.14.6 with SMTP id 6mr488958wfn.66.1284002597874;
        Wed, 08 Sep 2010 20:23:17 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id l41sm829300wfa.1.2010.09.08.20.23.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 20:23:17 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  9 Sep 2010 01:51:22 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g13aff
In-Reply-To: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155836>

This patch does preparation work for tree exclusion in
tree_entry_interesting(). '^' has similar meaning to '!' in
gitexcludes. '!' is not used because bash does not like arguments with
a leading '!'.

Eventually, "git diff -- foo ^foo/bar" should show differences in foo,
except foo/bar. If "git diff -- ^foo" is given, then it implies
everything except foo, which could surprise users that
"bar" in "git diff -- bar ^foo" has no effect at all.

NOTE: pathspec in diff machinery is also used by ce_path_match() and
read_index_preload(), which currently do not understand '^' at all.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-walk.c |   28 ++++++++++++++++++++++++++++
 tree-walk.h |    3 +++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index e7041d7..a2f4a00 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -479,7 +479,35 @@ int setup_tree_pathspec(const char **paths, struct=
 tree_pathspec_list *ps)
 	for (i=3D0; i < ps->nr; i++) {
 		struct tree_pathspec *exc =3D ps->info+i;
 		exc->path =3D ps->paths[i];
+		if (*exc->path =3D=3D '^') {
+			exc->path++;
+			exc->to_exclude =3D 1;
+		}
 		exc->pathlen =3D strlen(exc->path);
+		if (exc->to_exclude) {
+			int j, found =3D 0;
+
+			for (j =3D i-1; j >=3D 0; j--) {
+				int len =3D strlen(ps->info[j].path);
+				if (len < exc->pathlen &&
+				    !strncmp(ps->info[j].path, exc->path, len) &&
+				    exc->path[len] =3D=3D '/') {
+					ps->info[j].has_sub_pathspec =3D 1;
+					found =3D 1;
+				}
+			}
+
+			/*
+			 * If a negative pathspec has nothing to
+			 * negate from, include everything so it can
+			 * negate from that.  This way is not
+			 * perfect. You may be surprised to find out
+			 * "^Documentation t" does not take "t" into
+			 * account at all
+			 */
+			if (!found)
+				ps->include_by_default =3D 1;
+		}
 	}
 	return 0;
 }
diff --git a/tree-walk.h b/tree-walk.h
index bb55656..6be1e6c 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -16,9 +16,12 @@ struct tree_desc {
 struct tree_pathspec_list {
 	const char **paths;
 	int nr;
+	int include_by_default:1;
 	struct tree_pathspec {
 		const char *path;
 		int pathlen;
+		int to_exclude:1;
+		int has_sub_pathspec:1;
 	} *info;
 };
=20
--=20
1.7.1.rc1.70.g13aff
