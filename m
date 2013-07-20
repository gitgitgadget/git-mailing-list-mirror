From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/16] send-pack: forbid pushing from a shallow repository
Date: Sat, 20 Jul 2013 16:57:55 +0700
Message-ID: <1374314290-5976-2-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:58:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Tvw-0001JR-5A
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab3GTJ6R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:58:17 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46352 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab3GTJ6C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:58:02 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so11431952iec.33
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fgg6gH+KTQ6bmwdVtaULC1XsQyjov8XDtiz0CdMeUd4=;
        b=owmfg03auUUg8apjntVC/pm9+DNuKory7rMkMyc74GQ64xqciYmWksUX5i1Lyro8Ey
         yopir9HevZfDzhH+j/i3UON7HJW/Njd40jowfkgE6FnZafbPhLxB09xJbYnyQ+F3eQn8
         oKqOoWKFTMg8C4trsTDrzev6MgN7IvFPN6MJQiEOjbW4b+quGankIoavuDX9MATyQm/f
         LZMBUTBkpof1NOs4k2cceTcfXysvYqj4aUs71lbQP0Wa3zz4OEIDbwdb6HSXaSNJ4yqT
         /5xJqmnGKoHh3eZW667zvxLZhcWGuDMFgIUrBdTGE+E9Ha0GggvlBVi1Y+1AFXOrdvjI
         MjdQ==
X-Received: by 10.50.47.107 with SMTP id c11mr14335813ign.52.1374314281803;
        Sat, 20 Jul 2013 02:58:01 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id k14sm44188932igf.8.2013.07.20.02.57.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:58:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:58:20 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230882>

send-pack can send a pack with loose ends to the server.  receive-pack
before 6d4bb38 (fetch: verify we have everything we need before
updating our ref - 2011-09-01) does not detect this and keeps the pack
anyway, which corrupts the repository, at least from fsck point of
view.

send-pack will learn to safely push from a shallow repository later.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/send-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 152c4ea..d4cbf64 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -184,6 +184,9 @@ int cmd_send_pack(int argc, const char **argv, cons=
t char *prefix)
 	    (send_all && args.send_mirror))
 		usage(send_pack_usage);
=20
+	if (is_repository_shallow())
+		die("attempt to push from a shallow repository");
+
 	if (remote_name) {
 		remote =3D remote_get(remote_name);
 		if (!remote_has_url(remote, dest)) {
--=20
1.8.2.83.gc99314b
