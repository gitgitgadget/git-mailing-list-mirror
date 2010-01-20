From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Fix memory corruption when .gitignore does not end by \n
Date: Wed, 20 Jan 2010 21:09:16 +0700
Message-ID: <1263996556-9712-1-git-send-email-pclouds@gmail.com>
References: <fcaeb9bf1001200458v436a8adeq5cfc6753900e6c0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 15:10:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXbGL-00028g-8M
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 15:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab0ATOKT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2010 09:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948Ab0ATOKQ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 09:10:16 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:42725 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab0ATOKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 09:10:13 -0500
Received: by pxi12 with SMTP id 12so5618526pxi.33
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 06:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FhkIQx7Y8NHP9EyLvHfFclfmF0qkPMnfLIUNEPd9s54=;
        b=KzO/SN24WdnSy0Ui8J+MAtjfEkpJHTCBOrPMV/woRG78G/+KlfIftP5TPAFZZTAUww
         4x20krIGgkhmcoSlrhjNQsCIkeE8e+/icle0YqZ0K0hfB6jnRj3ZQJPfc6GaH3SLbufQ
         Ddi7/Xfh4o/iNMqXqlkFh3G8riJgE1+ZtL2q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=v67kGtF0/WD98nxJqg8wKZM8YkBFsNc45O8KxnWeXTqp8rBjJ843GLtz56JCD+tv+8
         6BNQSWNrLWeMSCRH+aK5hxK4SWoZaN7QjqgZqRtBwoqklaaZKjEZf8GI9iUaTppuayaE
         HCJhwwssD5CnJ2+3wqSLHwMe1XMfikyq1fEjY=
Received: by 10.141.89.20 with SMTP id r20mr2477rvl.250.1263996612684;
        Wed, 20 Jan 2010 06:10:12 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.253.98])
        by mx.google.com with ESMTPS id 22sm6259253pzk.10.2010.01.20.06.10.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Jan 2010 06:10:11 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 20 Jan 2010 21:09:25 +0700
X-Mailer: git-send-email 1.6.6.181.g5ee6
In-Reply-To: <fcaeb9bf1001200458v436a8adeq5cfc6753900e6c0c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137551>

Commit b5041c5 (Avoid writing to buffer in add_excludes_from_file_1())
tried not to append '\n' at the end because the next commit
may return a buffer that does not have extra space for that.

Unfortunately it left this assignment in the loop:

  buf[i - (i && buf[i-1] =3D=3D '\r')] =3D 0;

that can corrupt memory if "buf" is not '\n' terminated. But even if
it does not corrupt memory, the last line would not be
NULL-terminated, leading to errors later inside add_exclude().

This patch fixes it by reverting the faulty commit and make
sure "buf" is always \n terminated.

While at it, free unused memory properly.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This patch causes a crash for me. Not sure if it does for anybody else=
=2E

  diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-ot=
hers-exclude.sh
  index 6d2f2b6..e7efdb5 100755
  --- a/t/t3001-ls-files-others-exclude.sh
  +++ b/t/t3001-ls-files-others-exclude.sh
  @@ -57,7 +57,7 @@ expect
   echo '*.1
   /*.3
   !*.6' >.gitignore
  -echo '*.2
  +echo -n '*.2
   two/*.4
   !*.7
   *.8' >one/.gitignore

 dir.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 1538ad5..67c3af6 100644
--- a/dir.c
+++ b/dir.c
@@ -242,6 +242,14 @@ int add_excludes_from_file_to_list(const char *fna=
me,
 		if (!check_index ||
 		    (buf =3D read_skip_worktree_file_from_index(fname, &size)) =3D=3D=
 NULL)
 			return -1;
+		if (size =3D=3D 0) {
+			free(buf);
+			return 0;
+		}
+		if (buf[size-1] !=3D '\n') {
+			buf =3D xrealloc(buf, size+1);
+			buf[size++] =3D '\n';
+		}
 	}
 	else {
 		size =3D xsize_t(st.st_size);
@@ -249,19 +257,21 @@ int add_excludes_from_file_to_list(const char *fn=
ame,
 			close(fd);
 			return 0;
 		}
-		buf =3D xmalloc(size);
+		buf =3D xmalloc(size+1);
 		if (read_in_full(fd, buf, size) !=3D size) {
+			free(buf);
 			close(fd);
 			return -1;
 		}
+		buf[size++] =3D '\n';
 		close(fd);
 	}
=20
 	if (buf_p)
 		*buf_p =3D buf;
 	entry =3D buf;
-	for (i =3D 0; i <=3D size; i++) {
-		if (i =3D=3D size || buf[i] =3D=3D '\n') {
+	for (i =3D 0; i < size; i++) {
+		if (buf[i] =3D=3D '\n') {
 			if (entry !=3D buf + i && entry[0] !=3D '#') {
 				buf[i - (i && buf[i-1] =3D=3D '\r')] =3D 0;
 				add_exclude(entry, base, baselen, which);
--=20
1.6.6.181.g5ee6
