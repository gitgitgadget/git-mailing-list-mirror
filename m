From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] status: only touch path we may need to check
Date: Thu, 14 Jan 2010 22:02:21 +0700
Message-ID: <1263481341-28401-3-git-send-email-pclouds@gmail.com>
References: <1263481341-28401-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 16:06:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVRGv-0000Wh-Uz
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 16:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888Ab0ANPDX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 10:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476Ab0ANPDW
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 10:03:22 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:64539 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab0ANPDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 10:03:20 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so8323338pzk.33
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 07:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8B2KouUQ3XsbsHsEONXkfUuHDoeA4215O6du/vdnMEI=;
        b=VabuHXyMQsf/ZlFEUuOzXCOxB0f338+ElJXjCc8wsozTDLOfT619bzSpsDkX0baZPp
         6BlzvuokKX2XIen0rw8j4gaiFhFo+wpF+3kus6dMJVPDl/1c1Wy9pN9tZzfaWyJdAP7I
         m4D3we0K7cO03QyLj7iEeL/ddfYH+qKWnavwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PFY8BA1sIaNHoRzuY7518oH2bYtJm06XBpZ4wDb5D+QU4Y4tRh/YOoWfgGOLjWkeP0
         j9mSKsm9jZSx68BIx6uqY9pi4VRSzsgTun0eiqaqa/UWpnOJ1EqK/thNGjssQJbZXrMv
         bvv3ERPsn4HgXxgcnh1+VpEz2kHi4C+fYvZlU=
Received: by 10.115.3.10 with SMTP id f10mr457215wai.44.1263481399903;
        Thu, 14 Jan 2010 07:03:19 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.107])
        by mx.google.com with ESMTPS id 23sm638798pzk.12.2010.01.14.07.03.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Jan 2010 07:03:19 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 14 Jan 2010 22:02:33 +0700
X-Mailer: git-send-email 1.6.6.181.g5ee6
In-Reply-To: <1263481341-28401-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136999>

This patch gets rid of whole-tree cache refresh and untracked file
search. Instead only specified path will be looked at.

Again some numbers on gentoo-x86, ~80k files:

Unmodified Git:

$ time git st eclass/
nothing to commit (working directory clean)

real    0m3.211s
user    0m1.977s
sys     0m1.135s

Modified Git:

$ time ~/w/git/git st eclass/
nothing to commit (working directory clean)

real    0m1.587s
user    0m1.426s
sys     0m0.111s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-commit.c |    2 +-
 wt-status.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 6199db7..dae6cb3 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1024,7 +1024,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		s.pathspec =3D get_pathspec(prefix, argv);
=20
 	read_cache();
-	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
+	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, s.pathspec,=
 NULL, NULL);
 	s.is_initial =3D get_sha1(s.reference, sha1) ? 1 : 0;
 	s.in_merge =3D in_merge;
 	wt_status_collect(&s);
diff --git a/wt-status.c b/wt-status.c
index 5d56988..65feb29 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -343,7 +343,7 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 	setup_standard_excludes(&dir);
=20
-	fill_directory(&dir, NULL);
+	fill_directory(&dir, s->pathspec);
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
 		if (!cache_name_is_other(ent->name, ent->len))
--=20
1.6.6.181.g5ee6
