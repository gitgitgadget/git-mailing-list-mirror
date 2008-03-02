From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 02/10] Make sure setup_git_directory is called before
	accessing repository
Date: Sun, 2 Mar 2008 17:33:33 +0700
Message-ID: <20080302103333.GA8915@laptop>
References: <cover.1204453703.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 11:34:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlWX-0003AH-6I
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbYCBKdl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 05:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbYCBKdk
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:33:40 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:40776 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbYCBKdj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:33:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6063513wah.23
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 02:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=/cpXBoVyJre1OQgNS5dnabekTu+hMT+8xwclqMUsBjo=;
        b=lLtSBIa8zN6oZgKlY4d4+oMnLou/vUi12RJYEIgYBo5zfarybqGEh3gIdUd32zloZKQvz2nHTWTfoLyFVBn5eF+FEne0n9g1awvFcN0pfkLKl6JYZpgBwkBwspRO12otpgKvgruCT8tZCACd9elHBsarExld8rqaVvTckCe4bCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=hwqQwu205N4mxMHjZXFFf4tiBLfwZLdSSVBJRVjwJSgbzb1NJ69Ilv9PmCtrwTeQl72YQKZl+i3Kuu2AtBFhCunGYMyKvw8QzEjzzyB438TMZxzM74LnjWCvT5HcQJTmofoCXBujf3/xg+NJJMJhOo6BkIzGEwKBNE1l/MIETB8=
Received: by 10.114.126.1 with SMTP id y1mr3189508wac.25.1204454019301;
        Sun, 02 Mar 2008 02:33:39 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.2.84])
        by mx.google.com with ESMTPS id m28sm18445717waf.20.2008.03.02.02.33.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 02:33:38 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:33:33 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204453703.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75762>

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
index 9c0c278..1dbe88d 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -785,7 +785,9 @@ int main(int argc, char **argv)
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
