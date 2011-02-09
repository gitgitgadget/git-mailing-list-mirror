From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/16] ls: strip common directory prefix from output
Date: Wed,  9 Feb 2011 19:24:43 +0700
Message-ID: <1297254284-3729-16-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:28:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn99h-0008GI-K3
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877Ab1BIM2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:28:12 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36632 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1BIM2L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:28:11 -0500
Received: by pzk35 with SMTP id 35so18650pzk.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=anfAT5drxz5aRd1qZ54A5ZL5of1yQkskOaLZXZdy9D8=;
        b=fMY3EnDpnoZyYFL/ZvbYLvKrFpXxfGrxGEieV/P2ro9xYfSl4+6FkRzA/1WAgTeq1c
         13xq4pmlOFSsNJcq5ltr2hqlZ2RUKNgMjPsJIu6gsBuWP3zv8toscCIDgoLyqzlTGVRW
         nnOwq76vWnQuZEcwBJaHAcX3WnlL+SamTWjAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qU41G3FWibc1jYyD+J86iXUczzWDNR8Kd3KLvsZBsdp2BgQg/0yZT+51+XBlCVU0xT
         3n45knZF/3dj6SbameG/wQ1bKbe2RZKZRoBZ6QYTk0GRhgO2N8UzAuInEJ6mqwtCbXAD
         kNqv/Ca4RimdofFCPifgsP0gUfJ0fLgA/ITS8=
Received: by 10.142.142.19 with SMTP id p19mr18668322wfd.247.1297254490842;
        Wed, 09 Feb 2011 04:28:10 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id e14sm331329wfg.20.2011.02.09.04.28.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:28:09 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:26:40 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166420>

In GNU ls, files are printed relative to their parent directory.
We don't have such thing, so stay as close as we can.

The result is quite good. If the given pathspec is a directory prefix,
it will be stripped, strictly following GNU ls behavior. If the pathspe=
c
has wildcards, then the command part is stripped. Usually this is the
prefix part in the pathspec.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 22e0c87..bc438b2 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -710,6 +710,41 @@ static int one_match_pathspec(const char *pathspec=
)
 	return 0;
 }
=20
+static void remove_common_prefix()
+{
+	int i, len =3D -1;
+	const char *s1, *s2;
+
+	if (output.nr <=3D 1)
+		return;
+
+	/*
+	 * Eliminate common prefix. This is caused by a prefix
+	 * pathspec like "ls builtin" or even "ls 't/t*.sh'"
+	 */
+
+	s1 =3D output.items[output.nr-1].string;
+	len =3D strlen(s1);
+	for (i =3D 1; i < output.nr; i++) {
+		int j =3D 0;
+		s1 =3D output.items[i-1].string;
+		s2 =3D output.items[i].string;
+		while (j < len && s1[j] =3D=3D s2[j])
+			j++;
+		len =3D j;
+	}
+	while (len && s1[len] !=3D '/')
+		len--;
+	if (len && s1[len] =3D=3D '/')
+		len++;
+	if (len) {
+		for (i =3D 0; i < output.nr; i++) {
+			char *s =3D output.items[i].string;
+			memcpy(s, s+len, strlen(s) - len + 1);
+		}
+	}
+}
+
 int cmd_ls(int argc, const char **argv, const char *cmd_prefix)
 {
 	int show_pathspec;
@@ -801,6 +836,7 @@ int cmd_ls(int argc, const char **argv, const char =
*cmd_prefix)
 		one_matches[len] =3D NULL;
 		pathspec =3D one_matches;
 		show_files(&dir);
+		remove_common_prefix();
 		display_columns(&output, column_mode, term_columns(), 2, NULL);
 		string_list_clear(&output, 0);
 		if (dst)
@@ -821,6 +857,7 @@ int cmd_ls(int argc, const char **argv, const char =
*cmd_prefix)
 		if (output.nr && show_pathspec)
 			printf("%s:\n", pathspec[0]);
=20
+		remove_common_prefix();
 		display_columns(&output, column_mode, term_columns(), 2, NULL);
 		string_list_clear(&output, 0);
 		if (show_pathspec && pathspecs[0])
--=20
1.7.2.2
