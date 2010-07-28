From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] upload-pack: remove unused "create_full_pack" code in do_rev_list
Date: Wed, 28 Jul 2010 16:39:10 +0700
Message-ID: <1280309950-5597-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 12:20:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe3kq-0000DE-P5
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 12:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab0G1KUq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 06:20:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47784 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806Ab0G1KUp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 06:20:45 -0400
Received: by pzk26 with SMTP id 26so1743085pzk.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 03:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=B9ibh61sRTw9U1mYL0PScVGqwVkrbmOBNDyHvnnLll4=;
        b=r4uzvTjW7/tJGiF0zErWEALbDQqhHr2WICCdTj2j8WuKu1BAAtGIY0I7w+NRfIbHtg
         FmMUAAZ1ECSuw86VwAMoa8/DkaBCQjFqnv9PLe5VccBcalyUyTtw3wKZX9+toqtUcJBX
         igjogQxuwAy/Txr+aT7PB+urQWx6kEFdwbd4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=mdvDvGwsMZaHuX0MN0ZLwZlYRF9YiOLQ3G5ejpY3eSAPLKfCNjEL7fDO4v1GHm6d2n
         DQ2C/ufAXO8PyXDyTFRCssCjuxqBE5J3K0XXcAoNX1TZr0cmU71ckphwPf5NYWGJQfuZ
         ZfpO7bK3zF503vaQwYK0k1BANPaF8cdY0S60g=
Received: by 10.114.112.3 with SMTP id k3mr14899990wac.199.1280312444433;
        Wed, 28 Jul 2010 03:20:44 -0700 (PDT)
Received: from dektop ([121.91.36.254])
        by mx.google.com with ESMTPS id c10sm10853829wam.1.2010.07.28.03.20.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 03:20:43 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 28 Jul 2010 16:39:11 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152070>

A bit of history in chronological order, the newest at bottom:

- 80ccaa7 (upload-pack: Move the revision walker into a separate functi=
on.)
   do_rev_list was introduced with create_full_pack argument

- 21edd3f (upload-pack: Run rev-list in an asynchronous function.)
   do_rev_list was now called by start_async, create_full_pack was
   passed by rev_list.data

- f0cea83 (Shift object enumeration out of upload-pack)
   rev_list.data was now zero permanently. Creating full pack was
   done by passing --all to pack-objects

- ae6a560 (run-command: support custom fd-set in async)
   rev_list.data =3D 0 was found out redudant and got rid of.

Get rid of the code as well, for less headache while reading do_rev_lis=
t.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c |   29 ++++++++++++-----------------
 1 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index dc464d7..8f4c718 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -105,7 +105,7 @@ static void show_edge(struct commit *commit)
 	fprintf(pack_pipe, "-%s\n", sha1_to_hex(commit->object.sha1));
 }
=20
-static int do_rev_list(int in, int out, void *create_full_pack)
+static int do_rev_list(int in, int out, void *user_data)
 {
 	int i;
 	struct rev_info revs;
@@ -118,23 +118,18 @@ static int do_rev_list(int in, int out, void *cre=
ate_full_pack)
 	if (use_thin_pack)
 		revs.edge_hint =3D 1;
=20
-	if (create_full_pack) {
-		const char *args[] =3D {"rev-list", "--all", NULL};
-		setup_revisions(2, args, &revs, NULL);
-	} else {
-		for (i =3D 0; i < want_obj.nr; i++) {
-			struct object *o =3D want_obj.objects[i].item;
-			/* why??? */
-			o->flags &=3D ~UNINTERESTING;
-			add_pending_object(&revs, o, NULL);
-		}
-		for (i =3D 0; i < have_obj.nr; i++) {
-			struct object *o =3D have_obj.objects[i].item;
-			o->flags |=3D UNINTERESTING;
-			add_pending_object(&revs, o, NULL);
-		}
-		setup_revisions(0, NULL, &revs, NULL);
+	for (i =3D 0; i < want_obj.nr; i++) {
+		struct object *o =3D want_obj.objects[i].item;
+		/* why??? */
+		o->flags &=3D ~UNINTERESTING;
+		add_pending_object(&revs, o, NULL);
+	}
+	for (i =3D 0; i < have_obj.nr; i++) {
+		struct object *o =3D have_obj.objects[i].item;
+		o->flags |=3D UNINTERESTING;
+		add_pending_object(&revs, o, NULL);
 	}
+	setup_revisions(0, NULL, &revs, NULL);
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
--=20
1.7.1.rc1.69.g24c2f7
