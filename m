From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/20] fetch-pack: use a separate flag for fetch in deepening mode
Date: Tue, 29 Dec 2015 19:10:34 +0700
Message-ID: <1451391043-28093-12-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:12:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt8I-0006mT-Hi
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbbL2MMC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:12:02 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33977 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbbL2MMA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:12:00 -0500
Received: by mail-pf0-f172.google.com with SMTP id e65so74285002pfe.1
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KzZCaGKOzrE1jjQxX9OLVOYJWgI4nysei2/6TPyEpfk=;
        b=kqa9uBBQ0SI0eKwZXmuEP6n7QION5Im8rzDVdlWascgbzgigP/BvD2d3/gPGKQ19I5
         fZON0hOHf9NBWWswwHGsrW0wpvUmWiM7ugglIJUhRcMoUbtIQn/Qgz9Bd39Ynr6c0XNJ
         +xppm4EZ9EsCBReQnClx+mM2duJkur1plxjkBcgIk8VI2p9HbU5Igs0LxDF3AlaCMIVz
         l0jy94FKj4TSy7BiR3sGJrxizcxNFuvuOILsJBLIVHuXoD80HrBTFpeJrsOzaX1LKQi7
         vr40cEMzXDFsd9edil2dhIC32OPhTvN84RNGO1Tw5nbmU2tZ4XOV5lwu71IfvKc2gE5B
         jwDA==
X-Received: by 10.98.73.75 with SMTP id w72mr85780860pfa.161.1451391120219;
        Tue, 29 Dec 2015 04:12:00 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id v10sm30254154pfi.32.2015.12.29.04.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:11:58 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:11:55 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283121>

The shallow repo could be deepened or shortened when then user gives
--depth. But in future that won't be the only way to deepen/shorten a
repo. Stop relying on args->depth in this mode. Future deepening
methods can simply set this flag on instead of updating all these if
expressions.

The new name "deepen" was chosen after the command to define shallow
boundary in pack protocol. New commands also follow this tradition.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fetch-pack.c | 14 ++++++++------
 fetch-pack.h |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 16917f9..e947514 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -197,7 +197,7 @@ enum ack_type {
=20
 static void consume_shallow_list(struct fetch_pack_args *args, int fd)
 {
-	if (args->stateless_rpc && args->depth > 0) {
+	if (args->stateless_rpc && args->deepen) {
 		/* If we sent a depth we will get back "duplicate"
 		 * shallow and unshallow commands every time there
 		 * is a block of have lines exchanged.
@@ -348,7 +348,7 @@ static int find_common(struct fetch_pack_args *args=
,
 	packet_buf_flush(&req_buf);
 	state_len =3D req_buf.len;
=20
-	if (args->depth > 0) {
+	if (args->deepen) {
 		char *line;
 		const char *arg;
 		unsigned char sha1[20];
@@ -557,7 +557,7 @@ static void filter_refs(struct fetch_pack_args *arg=
s,
 		}
=20
 		if (!keep && args->fetch_all &&
-		    (!args->depth || !starts_with(ref->name, "refs/tags/")))
+		    (!args->deepen || !starts_with(ref->name, "refs/tags/")))
 			keep =3D 1;
=20
 		if (keep) {
@@ -627,7 +627,7 @@ static int everything_local(struct fetch_pack_args =
*args,
 		}
 	}
=20
-	if (!args->depth) {
+	if (!args->deepen) {
 		for_each_ref(mark_complete_oid, NULL);
 		for_each_alternate_ref(mark_alternate_complete, NULL);
 		commit_list_sort_by_date(&complete);
@@ -813,6 +813,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports(=
"shallow"))
 		die("Server does not support shallow clients");
+	if (args->depth > 0)
+		args->deepen =3D 1;
 	if (server_supports("multi_ack_detailed")) {
 		print_verbose(args, "Server supports multi_ack_detailed");
 		multi_ack =3D 2;
@@ -873,7 +875,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
-	if (args->depth > 0)
+	if (args->deepen)
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
 	else if (si->nr_ours || si->nr_theirs)
@@ -940,7 +942,7 @@ static void update_shallow(struct fetch_pack_args *=
args,
 	int *status;
 	int i;
=20
-	if (args->depth > 0 && alternate_shallow_file) {
+	if (args->deepen && alternate_shallow_file) {
 		if (*alternate_shallow_file =3D=3D '\0') { /* --unshallow */
 			unlink_or_warn(git_path_shallow());
 			rollback_lock_file(&shallow_lock);
diff --git a/fetch-pack.h b/fetch-pack.h
index bb7fd76..4d0adb0 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -25,6 +25,7 @@ struct fetch_pack_args {
 	unsigned self_contained_and_connected:1;
 	unsigned cloning:1;
 	unsigned update_shallow:1;
+	unsigned deepen:1;
 };
=20
 /*
--=20
2.3.0.rc1.137.g477eb31
