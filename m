From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/19] pathspec: add match_pathspec_depth()
Date: Mon, 13 Dec 2010 16:46:52 +0700
Message-ID: <1292233616-27692-16-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:49:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS52a-0005FU-2e
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594Ab0LMJts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:49:48 -0500
Received: from mail-px0-f179.google.com ([209.85.212.179]:39098 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab0LMJtr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:49:47 -0500
Received: by pxi20 with SMTP id 20so1600488pxi.10
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ta+ExrXDLiRgj34aDJp/37iZgvjKhILvXpw7uHr9vUk=;
        b=dAgNmAKRCjoS/WgJrQoipLSFim3wF8P3JcF1xYSORzBWtaCq63f6r/viyv12sU4M1g
         EDSkTlAUlgS3Cxa75CsPCFGsBEsDRm0KZ/69lnJFW2K2dN/iKVVt8qR062xGA2cKih02
         p9quYMeorLcil5gE+2JtP5zkL4Kfrbr+gd5oc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dCtv9EM+YnP9kkHDCMp7cN3QInbS23iONbckjZEz7+fxh0LnstWE62Ic/eBH3+zlNj
         qnUyuRy5QPSlrvP0cpi9+pw8k5yNdnTjb4Iw684VNBgxqY+P7MLxzch1o+GRqFUlb4NF
         MCkutBgpZRtMFg/vr59ItQJECiK4VySmquigU=
Received: by 10.143.19.4 with SMTP id w4mr3026392wfi.192.1292233786805;
        Mon, 13 Dec 2010 01:49:46 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id w22sm8676105wfd.19.2010.12.13.01.49.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:49:45 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:48:54 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163542>

match_pathspec_depth() is similar to match_pathspec() except that it
can take depth limit.

In long term, match_pathspec() should be removed in favor of this
function.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 dir.h |    3 +++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index bb5076c..e12dbdd 100644
--- a/dir.c
+++ b/dir.c
@@ -169,6 +169,51 @@ int match_pathspec(const char **pathspec, const ch=
ar *name, int namelen,
 	return retval;
 }
=20
+int match_pathspec_depth(const char **pathspec, int max_depth,
+			 const char *name, int namelen,
+			 int prefix, char *seen)
+{
+	int i, retval =3D 0;
+
+	if (!pathspec) {
+		if (max_depth =3D=3D -1)
+			return MATCHED_RECURSIVELY;
+
+		if (within_depth(name, namelen, 0, max_depth))
+			return MATCHED_EXACTLY;
+		else
+			return 0;
+	}
+
+	name +=3D prefix;
+	namelen -=3D prefix;
+
+	for (i =3D 0; pathspec[i] !=3D NULL; i++) {
+		int how;
+		const char *match =3D pathspec[i] + prefix;
+		if (seen && seen[i] =3D=3D MATCHED_EXACTLY)
+			continue;
+		how =3D match_one(match, name, namelen);
+		if (max_depth !=3D -1 &&
+		    how && how !=3D MATCHED_FNMATCH) {
+			int len =3D strlen(match);
+			if (name[len] =3D=3D '/')
+				len++;
+			if (within_depth(name+len, namelen-len, 0, max_depth))
+				how =3D MATCHED_EXACTLY;
+			else
+				how =3D 0;
+		}
+		if (how) {
+			if (retval < how)
+				retval =3D how;
+			if (seen && seen[i] < how)
+				seen[i] =3D how;
+		}
+	}
+	return retval;
+}
+
 static int no_wildcard(const char *string)
 {
 	return string[strcspn(string, "*?[{\\")] =3D=3D '\0';
diff --git a/dir.h b/dir.h
index c71de08..9dc9592 100644
--- a/dir.h
+++ b/dir.h
@@ -65,6 +65,9 @@ struct dir_struct {
 #define MATCHED_FNMATCH 2
 #define MATCHED_EXACTLY 3
 extern int match_pathspec(const char **pathspec, const char *name, int=
 namelen, int prefix, char *seen);
+extern int match_pathspec_depth(const char **pathspec, int max_depth,
+				const char *name, int namelen,
+				int prefix, char *seen);
 extern int within_depth(const char *name, int namelen, int depth, int =
max_depth);
=20
 extern int fill_directory(struct dir_struct *dir, const char **pathspe=
c);
--=20
1.7.3.3.476.g10a82
