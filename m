From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] grep: stop looking at random places for .gitattributes
Date: Wed, 10 Oct 2012 18:34:54 +0700
Message-ID: <1349868894-3579-4-git-send-email-pclouds@gmail.com>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org>
 <1349868894-3579-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 13:36:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLua7-0006Kd-RX
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 13:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab2JJLf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 07:35:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54845 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab2JJLf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 07:35:56 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so507038pad.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 04:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iLvr6NrxfHrNHhywYqegNIfq4YpD/tzF0rc7A19fkIE=;
        b=DVHI71J0+vZl8sEDv+Aa2QtYuehGaLVxIBK/yX2+ZoWL4o3UdBbmqeRXnW+NeDVVe5
         UlcJuN3bioQ+uoRF7iUq/6ZErkXRnZXXKlTOigLJCNBKCgdLetwTvLe01mVvtv7igGD9
         nQ990a/+nW0J3SccmAHbNj0SsZQYTZvzJDsZD9+oDGEfZR1QZP2ZCNA6KI6HU35vfBrE
         85OWXgWfvjMpRPxwxjDw7AHcxTQRdiQ+qHm2loQvT3YiS5LCRNLCi8lMbHAk2WktES3P
         ipXsOIiWt9IxWGDiP6mcA27T9WsJUgw5+8QodLlgexehV2GnFmVgQi7c6wKPsCv/zB2+
         Gtww==
Received: by 10.68.248.33 with SMTP id yj1mr7105635pbc.141.1349868956447;
        Wed, 10 Oct 2012 04:35:56 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id vz8sm902715pbc.63.2012.10.10.04.35.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 04:35:55 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 18:35:47 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207403>

grep searches for .gitattributes using "name" field in struct
grep_source but that field is not real on-disk path name. For example,
"grep pattern rev" fills the field with "rev:path", which is
non-existent usually until somebody exploits it to drive git away.

attr does not support looking up .gitattributes from a tree object.
Making "git grep pattern <rev>" support .gitattributes could be a big
work. Just note in document what we support for now. The document
changes in this patch are to be reverted once support is in place.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-grep.txt | 7 +++++--
 grep.c                     | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index cfecf84..a4c66ee 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -86,7 +86,9 @@ OPTIONS
 	files.
=20
 -I::
-	Don't match the pattern in binary files.
+	Don't match the pattern in binary files. Note that binary
+	detection via .gitattributes only works with searching files
+	in working directory.
=20
 --max-depth <depth>::
 	For each <pathspec> given on command line, descend at most <depth>
@@ -189,7 +191,8 @@ OPTIONS
 	the match, unless the matching line is a function name itself.
 	The name is determined in the same way as 'git diff' works out
 	patch hunk headers (see 'Defining a custom hunk-header' in
-	linkgit:gitattributes[5]).
+	linkgit:gitattributes[5]). Note that .gitattributes are only
+	support for searching files in working directory.
=20
 -<num>::
 -C <num>::
diff --git a/grep.c b/grep.c
index 06bc1c6..e36c01b 100644
--- a/grep.c
+++ b/grep.c
@@ -1505,7 +1505,8 @@ void grep_source_load_driver(struct grep_source *=
gs)
 		return;
=20
 	grep_attr_lock();
-	gs->driver =3D userdiff_find_by_path(gs->name);
+	if (gs->path)
+		gs->driver =3D userdiff_find_by_path(gs->path);
 	if (!gs->driver)
 		gs->driver =3D userdiff_find_by_name("default");
 	grep_attr_unlock();
--=20
1.7.12.1.406.g6ab07c4
