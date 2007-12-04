From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Use a strbuf for copying the command line for the reflog.
Date: Tue,  4 Dec 2007 02:25:46 -0500
Message-ID: <1196753147-20073-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 04 07:42:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzRUc-0000lz-SB
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 07:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbXLDGmb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 01:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbXLDGma
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 01:42:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46347 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbXLDGma (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 01:42:30 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lB46gQRi000687;
	Tue, 4 Dec 2007 01:42:26 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lB46gQH7019194;
	Tue, 4 Dec 2007 01:42:26 -0500
Received: from localhost.localdomain (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lB46gPeQ007314;
	Tue, 4 Dec 2007 01:42:25 -0500
X-Mailer: git-send-email 1.5.3.7.2108.g5cf27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67010>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-fetch.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index de9947e..f6d16fe 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -14,7 +14,7 @@ static const char fetch_usage[] =3D "git-fetch [-a | =
--append] [--upload-pack <upl
=20
 static int append, force, tags, no_tags, update_head_ok, verbose, quie=
t;
 static const char *depth;
-static char *default_rla =3D NULL;
+static struct strbuf default_rla =3D STRBUF_INIT;
 static struct transport *transport;
=20
 static void unlock_pack(void)
@@ -142,7 +142,7 @@ static int s_update_ref(const char *action,
 	static struct ref_lock *lock;
=20
 	if (!rla)
-		rla =3D default_rla;
+		rla =3D default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 	lock =3D lock_any_ref_for_update(ref->name,
 				       check_old ? ref->old_sha1 : NULL, 0);
@@ -543,16 +543,19 @@ static void set_option(const char *name, const ch=
ar *value)
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	struct remote *remote;
-	int i, j, rla_offset;
+	int i;
 	static const char **refs =3D NULL;
 	int ref_nr =3D 0;
-	int cmd_len =3D 0;
 	const char *upload_pack =3D NULL;
 	int keep =3D 0;
=20
+	/* Record the command line for the reflog */
+	strbuf_addstr(&default_rla, "fetch");
+	for (i =3D 1; i < argc; i++)
+		strbuf_addf(&default_rla, " %s", argv[i]);
+
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
-		cmd_len +=3D strlen(arg);
=20
 		if (arg[0] !=3D '-')
 			break;
@@ -613,17 +616,6 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
 		usage(fetch_usage);
 	}
=20
-	for (j =3D i; j < argc; j++)
-		cmd_len +=3D strlen(argv[j]);
-
-	default_rla =3D xmalloc(cmd_len + 5 + argc + 1);
-	sprintf(default_rla, "fetch");
-	rla_offset =3D strlen(default_rla);
-	for (j =3D 1; j < argc; j++) {
-		sprintf(default_rla + rla_offset, " %s", argv[j]);
-		rla_offset +=3D strlen(argv[j]) + 1;
-	}
-
 	if (i =3D=3D argc)
 		remote =3D remote_get(NULL);
 	else
--=20
1.5.3.4
