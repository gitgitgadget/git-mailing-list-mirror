From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Cache stat_tracking_info() for faster status and branch -v
Date: Wed, 17 Oct 2012 00:36:07 +0700
Message-ID: <1350408967-13919-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 19:36:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOB4O-0001es-Fh
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528Ab2JPRg3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2012 13:36:29 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45005 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864Ab2JPRg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 13:36:27 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so6128393pad.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=O0AR8dt/YPFQg6Fl5s7JMV3ZyLbo/ACBMgpttuj7CvY=;
        b=k80yTcJynIncaoDidKcgrxxzZ7Q9BvjJF6RN6jr/DOLyOAHYZu2LOH47mqirOjB7Bn
         VlHXhnPez1YgiOfHXC4mXg2RTvCScTBqH3S4WQljqIH4wQiqpx9luCuFTFyqmUlZcpWq
         LuprM0JEFAj+cfD6x/Z9kXSpxTYL4bZdtsNJI6y5WrqjXgCSdXyb18Dro9rHlyvhdomY
         GrcRpnWqXcl2JrmU9/m+QTs0E06UCk6QTbLDKND4reL8iOqoGXsBpO4JK/tCgNOQWz+P
         eOsWhLxUdXgs9w4q/AY1/bwhf3X6N9iqNUPjzpkCMeXpQRrk8QHlhda8P/tkdERVPDwc
         R0dA==
Received: by 10.66.74.6 with SMTP id p6mr43610034pav.40.1350408986603;
        Tue, 16 Oct 2012 10:36:26 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.44.221])
        by mx.google.com with ESMTPS id ty4sm11077649pbc.57.2012.10.16.10.36.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Oct 2012 10:36:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 17 Oct 2012 00:36:08 +0700
X-Mailer: git-send-email 1.8.0.rc2.21.g0695653
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207864>

stat_tracking_info() is used to calculated how many commits ahead or
behind for a branch. Rev walking can be slow especially when the
branch is way behind its remote end. By caching the results, we won't
have to rev walk every time we need these information.
stat_tracking_info() cost can be greatly reduced this way.

This makes sure "git status" instant no matter how far behind HEAD
is, except the first time after HEAD changes. This also makes
"branch -v" usable (for me) as it's now also instant versus 3.5
seconds in non-cache case on my machine.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I wanted guaranteed-fast status for another reason, but it turns out
 "branch -v" benefits even more. Recent commit walking is not
 efficiently optimized even with Shawn's pack bitmaps. This may be
 useful some people, I guess.

 remote.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/remote.c b/remote.c
index 04fd9ea..db825b8 100644
--- a/remote.c
+++ b/remote.c
@@ -1549,6 +1549,7 @@ int stat_tracking_info(struct branch *branch, int=
 *num_ours, int *num_theirs)
 	struct rev_info revs;
 	const char *rev_argv[10], *base;
 	int rev_argc;
+	int fd;
=20
 	/*
 	 * Nothing to report unless we are marked to build on top of
@@ -1579,6 +1580,33 @@ int stat_tracking_info(struct branch *branch, in=
t *num_ours, int *num_theirs)
 	if (theirs =3D=3D ours)
 		return 0;
=20
+	if (!access(git_path("stat_tracking_cache/%s",
+			     branch->refname), R_OK)) {
+		struct strbuf sb =3D STRBUF_INIT;
+		unsigned char sha1_ours[20], sha1_theirs[20];
+		int n1, n2;
+		if ((fd =3D open(git_path("stat_tracking_cache/%s",
+					branch->refname),
+			       O_RDONLY)) !=3D -1 &&
+		    strbuf_read(&sb, fd, 0) !=3D -1 &&
+		    sb.len > (40 + 1) * 2 &&
+		    !get_sha1_hex(sb.buf, sha1_ours) &&
+		    sb.buf[40] =3D=3D '\n' &&
+		    !get_sha1_hex(sb.buf + 41, sha1_theirs) &&
+		    sb.buf[81] =3D=3D '\n' &&
+		    !hashcmp(sha1_ours, ours->object.sha1) &&
+		    !hashcmp(sha1_theirs, theirs->object.sha1) &&
+		    sscanf(sb.buf + 82, "%d\n%d\n", &n1, &n2) =3D=3D 2) {
+			*num_ours =3D n1;
+			*num_theirs =3D n2;
+			close(fd);
+			strbuf_release(&sb);
+			return 1;
+		}
+		close(fd);
+		strbuf_release(&sb);
+	}
+
 	/* Run "rev-list --left-right ours...theirs" internally... */
 	rev_argc =3D 0;
 	rev_argv[rev_argc++] =3D NULL;
@@ -1608,6 +1636,20 @@ int stat_tracking_info(struct branch *branch, in=
t *num_ours, int *num_theirs)
 			(*num_theirs)++;
 	}
=20
+	if (!safe_create_leading_directories(git_path("stat_tracking_cache/%s=
",
+						      branch->refname)) &&
+	    (fd =3D open(git_path("stat_tracking_cache/%s",
+				branch->refname),
+		       O_CREAT | O_TRUNC | O_RDWR, 0644)) !=3D -1) {
+		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_addf(&sb, "%s\n", sha1_to_hex(ours->object.sha1));
+		strbuf_addf(&sb, "%s\n", sha1_to_hex(theirs->object.sha1));
+		strbuf_addf(&sb, "%d\n%d\n", *num_ours, *num_theirs);
+		write(fd, sb.buf, sb.len);
+		strbuf_release(&sb);
+		close(fd);
+	}
+
 	/* clear object flags smudged by the above traversal */
 	clear_commit_marks(ours, ALL_REV_FLAGS);
 	clear_commit_marks(theirs, ALL_REV_FLAGS);
--=20
1.8.0.rc2.21.g0695653
