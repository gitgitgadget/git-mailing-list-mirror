From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 2/9] Make sure setup_git_directory is called before
	accessing repository
Date: Wed, 27 Feb 2008 23:38:29 +0700
Message-ID: <20080227163829.GA28031@laptop>
References: <cover.1204130175.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 17:39:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUPJn-0001Yw-Fl
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 17:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858AbYB0Qih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 11:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755849AbYB0Qig
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 11:38:36 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:56726 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786AbYB0Qif (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 11:38:35 -0500
Received: by an-out-0708.google.com with SMTP id d31so645074and.103
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 08:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=V5eLS4N4At4UDeTsBeytn6D/JZQB2770+G3EV0s6suE=;
        b=gpxOqwCSqvag91iXH8+zbHpWJbiC8Yg6NbwwvRwRT+oSZnlwDwSKUKadhbWfYcpzXQsckWcnqjBMKwM5G1Z/UKtF2l96L5SUbEZqmUoctZi5RF+tXqhiRnXfD49EGn9c5htzLqe3OmsKqdN1qMnpm6dvtiAzteWaa2IFCYFcUbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=d5uK9BzhtLxTBD0QtCaw7sx7+189lfzeK8xJPXI0joh8+XAaAFqoB0gjY+26glqBmJmJ84oqFG6y0HB+144xGQBX/EOyHAijB2QVzO1ulxIJSrx+DffQ9W+Y1Brf2Yi3QjHWvPia5IfN8P6isOrX+CirBy/WwyQjWzOm9RX99qQ=
Received: by 10.100.172.17 with SMTP id u17mr4069763ane.2.1204130315255;
        Wed, 27 Feb 2008 08:38:35 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.231])
        by mx.google.com with ESMTPS id c2sm11156702ana.4.2008.02.27.08.38.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 08:38:34 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Feb 2008 23:38:29 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204130175.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75235>

Right now setup_git_env is called automatically when needed and
will not die out if $GIT_DIR is invalid. The next patch no longer
guarantee that, so make sure all commands have environment properly
setup before using.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fast-import.c |    1 +
 hash-object.c |   10 +++++-----
 index-pack.c  |    2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 0d3449f..7f197d5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2377,6 +2377,7 @@ int main(int argc, const char **argv)
 {
 	unsigned int i, show_stats =3D 1;
=20
+	setup_git_directory();
 	git_config(git_pack_config);
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level =3D core_compression_level;
diff --git a/hash-object.c b/hash-object.c
index 61e7160..46d57ad 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -42,7 +42,10 @@ int main(int argc, char **argv)
 	int prefix_length =3D -1;
 	int no_more_flags =3D 0;
 	int hashstdin =3D 0;
+	int nongit =3D 0;
=20
+	prefix =3D setup_git_directory_gently(&nongit);
+	prefix_length =3D prefix ? strlen(prefix) : 0;
 	git_config(git_default_config);
=20
 	for (i =3D 1 ; i < argc; i++) {
@@ -53,11 +56,8 @@ int main(int argc, char **argv)
 				type =3D argv[i];
 			}
 			else if (!strcmp(argv[i], "-w")) {
-				if (prefix_length < 0) {
-					prefix =3D setup_git_directory();
-					prefix_length =3D
-						prefix ? strlen(prefix) : 0;
-				}
+				if (nongit)
+					die("Not a git repository");
 				write_object =3D 1;
 			}
 			else if (!strcmp(argv[i], "--")) {
diff --git a/index-pack.c b/index-pack.c
index 9fd6982..b4c2310 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -703,7 +703,9 @@ int main(int argc, char **argv)
 	char *index_name_buf =3D NULL, *keep_name_buf =3D NULL;
 	struct pack_idx_entry **idx_objects;
 	unsigned char sha1[20];
+	int nongit =3D 0;
=20
+	setup_git_directory_gently(&nongit);
 	git_config(git_index_pack_config);
=20
 	for (i =3D 1; i < argc; i++) {
--=20
1.5.4.2.281.g28d0e
