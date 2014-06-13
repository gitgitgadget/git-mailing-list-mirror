From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/32] update-index --split-index: do not split if $GIT_DIR is read only
Date: Fri, 13 Jun 2014 19:19:45 +0700
Message-ID: <1402661991-14977-27-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:22:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQVH-0004h7-Se
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbaFMMWg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:22:36 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:39942 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbaFMMWf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:22:35 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so825010pad.35
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Q9y4NyeoJpQG4PqxDAcrOWrrf2tO7fnvmIBpAs/0GXY=;
        b=lcLTSnuHTHUEudsdTa5ttJLRA6lYXSoyVMSkcyX3iSVdbGWvzHTg7qJc9+mHOz3agB
         tGw+JPBD9xTvBfgvkEVIdxf0OnRLlFBipzZKx+9mmBBmNxqfjL+0SiDZxtN4gwnqYjak
         LAekuA8s0RjwFUOFr+vV+sTzHYqJg0krOBSvli9c/weLdLdo2mfV4FmvS2ag0H28WcC9
         QJ1aS15FKwJmLFolR3kvfUyM8f35k5qXxB3+sKh5vnk7Zd4L+jWRWnKtUuN5z2bByDd5
         VO6DyWv9Wf78LL5uILEMEzxoJ2+T7BaOWZEgdpKWiM59Ayx1toaAQ6ha9725WirIVCFD
         l/ig==
X-Received: by 10.66.162.74 with SMTP id xy10mr96422pab.4.1402662154669;
        Fri, 13 Jun 2014 05:22:34 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id xy2sm20777497pab.16.2014.06.13.05.22.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:22:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:22:34 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251584>

If $GIT_DIR is read only, we can't write $GIT_DIR/sharedindex. This
could happen when $GIT_INDEX_FILE is set to somehwere outside
$GIT_DIR.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 8ecb959..aa848e1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2030,14 +2030,21 @@ static void remove_temporary_sharedindex_on_sig=
nal(int signo)
 	raise(signo);
 }
=20
-static int write_shared_index(struct index_state *istate)
+static int write_shared_index(struct index_state *istate,
+			      struct lock_file *lock, unsigned flags)
 {
 	struct split_index *si =3D istate->split_index;
 	static int installed_handler;
 	int fd, ret;
=20
 	temporary_sharedindex =3D git_pathdup("sharedindex_XXXXXX");
-	fd =3D xmkstemp(temporary_sharedindex);
+	fd =3D mkstemp(temporary_sharedindex);
+	if (fd < 0) {
+		free(temporary_sharedindex);
+		temporary_sharedindex =3D NULL;
+		hashclr(si->base_sha1);
+		return do_write_locked_index(istate, lock, flags);
+	}
 	if (!installed_handler) {
 		atexit(remove_temporary_sharedindex);
 		sigchain_push_common(remove_temporary_sharedindex_on_signal);
@@ -2070,7 +2077,7 @@ int write_locked_index(struct index_state *istate=
, struct lock_file *lock,
 	}
=20
 	if (istate->cache_changed & SPLIT_INDEX_ORDERED) {
-		int ret =3D write_shared_index(istate);
+		int ret =3D write_shared_index(istate, lock, flags);
 		if (ret)
 			return ret;
 	}
--=20
1.9.1.346.ga2b5940
