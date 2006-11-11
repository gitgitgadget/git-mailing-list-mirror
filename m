X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: pclouds@gmail.com
Subject: [PATCH] Add file addition/deletion indicator in diffstat
Date: Sat, 11 Nov 2006 19:33:31 +0700
Message-ID: <20061111123331.GA23829@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 12:31:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent:from;
        b=O45ijyyWrVjvmiK00Sx2Jef2NHv0yH04Ytm6L+RAZFkhowSu4zMYa3ATiXcYSSWxhBsSxTPvqQm9LqFwptfTxlcBovXnrXh75lQoju2iBbzmxrOBpz/EavFT1llAJu9JQNi7f2QOaIpkLWL/Ur+VKdbTvx4iCeKuEieHwJKJ4FY=
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31220>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gis0y-0002dV-PY for gcvg-git@gmane.org; Sat, 11 Nov
 2006 13:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946610AbWKKMac convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 07:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946855AbWKKMac
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 07:30:32 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:30537 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1946761AbWKKMab
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 07:30:31 -0500
Received: by py-out-1112.google.com with SMTP id a29so421297pyi for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 04:30:30 -0800 (PST)
Received: by 10.35.65.17 with SMTP id s17mr5748698pyk.1163248229949; Sat, 11
 Nov 2006 04:30:29 -0800 (PST)
Received: from localhost ( [125.234.254.124]) by mx.google.com with ESMTP id
 8sm388273nzn.2006.11.11.04.30.25; Sat, 11 Nov 2006 04:30:29 -0800 (PST)
Received: by localhost (sSMTP sendmail emulation); Sat, 11 Nov 2006 19:33:31
 +0700
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

=46or new files, " (new)" will be appended to filenames.
=46or deleted files, " (deleted)" will be appended to filenames.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 3315378..bd78138 100644
--- a/diff.c
+++ b/diff.c
@@ -599,6 +599,8 @@ struct diffstat_t {
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned is_renamed:1;
+		unsigned is_added:1;
+		unsigned is_deleted:1;
 		unsigned int added, deleted;
 	} **files;
 };
@@ -707,6 +709,10 @@ static void show_stats(struct diffstat_t
 		}
=20
 		len =3D strlen(file->name);
+		if (file->is_added)
+			len +=3D 6; /* " (new)" */
+		if (file->is_deleted)
+			len +=3D 10; /* " (deleted)" */
 		if (max_len < len)
 			max_len =3D len;
=20
@@ -735,12 +741,25 @@ static void show_stats(struct diffstat_t
 		int added =3D data->files[i]->added;
 		int deleted =3D data->files[i]->deleted;
 		int name_len;
+		char *new_name =3D NULL;
=20
 		/*
 		 * "scale" the filename
 		 */
 		len =3D name_width;
 		name_len =3D strlen(name);
+		if (data->files[i]->is_added) {
+			new_name =3D name =3D xmalloc(name_len+7);  /* " (new)" */
+			memcpy(name,data->files[i]->name,name_len);
+			memcpy(name+name_len," (new)",7);
+			name_len +=3D 6;
+		}
+		if (data->files[i]->is_deleted) {
+			new_name =3D name =3D xmalloc(name_len+11);  /* " (deleted)" */
+			memcpy(name,data->files[i]->name,name_len);
+			memcpy(name+name_len," (deleted)",11);
+			name_len +=3D 10; /* " (deleted)" */
+		}
 		if (name_width < name_len) {
 			char *slash;
 			prefix =3D "...";
@@ -787,6 +806,8 @@ static void show_stats(struct diffstat_t
 		show_graph('-', del, del_c, reset);
 		putchar('\n');
 	free_diffstat_file:
+		if (new_name)
+			free(new_name);
 		free(data->files[i]->name);
 		free(data->files[i]);
 	}
@@ -1067,6 +1088,14 @@ static void builtin_diffstat(const char
 		data->is_unmerged =3D 1;
 		return;
 	}
+	if (DIFF_FILE_VALID(one)) {
+		if (!DIFF_FILE_VALID(two))
+			data->is_deleted =3D 1;
+	}
+	else {
+		if (DIFF_FILE_VALID(two))
+			data->is_added =3D 1;
+	}
 	if (complete_rewrite) {
 		diff_populate_filespec(one, 0);
 		diff_populate_filespec(two, 0);
--=20
