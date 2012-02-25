From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] index-pack --verify: skip sha-1 collision test
Date: Sat, 25 Feb 2012 17:56:13 +0700
Message-ID: <1330167376-24859-2-git-send-email-pclouds@gmail.com>
References: <1330167376-24859-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 11:54:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1FGX-0000Sj-E0
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 11:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164Ab2BYKyH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 05:54:07 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49280 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756062Ab2BYKyF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 05:54:05 -0500
Received: by pbcup15 with SMTP id up15so390805pbc.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 02:54:05 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.213.234 as permitted sender) client-ip=10.68.213.234;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.213.234 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.213.234])
        by 10.68.213.234 with SMTP id nv10mr17915757pbc.71.1330167245162 (num_hops = 1);
        Sat, 25 Feb 2012 02:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8TjTLdWX6qZx02eF4Fj8zawsl+4i26OuA3o83IsZljM=;
        b=YbZcuIST6Xzu5lkdVFlohqNN0ujYhF2hPKRMLi/63wT9aH5RnSECqdLlEE8e4usV0j
         9qp9ulBBG5SuI8xxGz2yuPtvgNB8lZwSd3QO6Hh/URQdGm8bffNWWzj3gRnMbpEL0P6z
         TfO16luO3ZgBX1g07I36YgDH8GZotlrtdq8qc=
Received: by 10.68.213.234 with SMTP id nv10mr14875762pbc.71.1330167245086;
        Sat, 25 Feb 2012 02:54:05 -0800 (PST)
Received: from tre ([115.74.53.120])
        by mx.google.com with ESMTPS id kx17sm6928959pbb.19.2012.02.25.02.54.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 02:54:04 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 25 Feb 2012 17:56:23 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330167376-24859-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191518>

index-pack --verify (or verify-pack) is about verifying the pack
itself. SHA-1 collision test is about outside (probably malicious)
objects with the same SHA-1 entering current repo.

SHA-1 collision test is currently done unconditionally. Which means if
you verify an in-repo pack, all objects from the pack will be checked
against objects in repo, which are themselves.

Skip this test for --verify, unless --strict is also specified.

linux-2.6 $ ls -sh .git/objects/pack/pack-e7732c98a8d54840add294c3c5628=
40f78764196.pack
401M .git/objects/pack/pack-e7732c98a8d54840add294c3c562840f78764196.pa=
ck

Without the patch (and with another patch to cut out second pass in
index-pack):

linux-2.6 $ time ~/w/git/old index-pack -v --verify .git/objects/pack/p=
ack-e7732c98a8d54840add294c3c562840f78764196.pack
Indexing objects: 100% (1944656/1944656), done.
fatal: pack has 1617280 unresolved deltas

real    1m1.223s
user    0m55.028s
sys     0m0.828s

With the patch:

linux-2.6 $ time ~/w/git/git index-pack -v --verify .git/objects/pack/p=
ack-e7732c98a8d54840add294c3c562840f78764196.pack
Indexing objects: 100% (1944656/1944656), done.
fatal: pack has 1617280 unresolved deltas

real    0m41.714s
user    0m40.994s
sys     0m0.550s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dd1c5c9..cee83b9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -62,6 +62,7 @@ static int nr_resolved_deltas;
=20
 static int from_stdin;
 static int strict;
+static int verify;
 static int verbose;
=20
 static struct progress *progress;
@@ -461,7 +462,7 @@ static void sha1_object(const void *data, unsigned =
long size,
 			enum object_type type, unsigned char *sha1)
 {
 	hash_sha1_file(data, size, typename(type), sha1);
-	if (has_sha1_file(sha1)) {
+	if ((strict || !verify) && has_sha1_file(sha1)) {
 		void *has_data;
 		enum object_type has_type;
 		unsigned long has_size;
@@ -1078,7 +1079,7 @@ static void show_pack_info(int stat_only)
=20
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, fix_thin_pack =3D 0, verify =3D 0, stat_only =3D 0, stat =3D 0=
;
+	int i, fix_thin_pack =3D 0, stat_only =3D 0, stat =3D 0;
 	const char *curr_pack, *curr_index;
 	const char *index_name =3D NULL, *pack_name =3D NULL;
 	const char *keep_name =3D NULL, *keep_msg =3D NULL;
--=20
1.7.8.36.g69ee2
