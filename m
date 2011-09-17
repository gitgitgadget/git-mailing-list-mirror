From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Prevent users from adding the file that has all-zero SHA-1
Date: Sat, 17 Sep 2011 21:39:34 +1000
Message-ID: <1316259574-1291-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 13:39:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4tFS-0006lX-6T
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 13:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab1IQLjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Sep 2011 07:39:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59815 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab1IQLjo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 07:39:44 -0400
Received: by iaqq3 with SMTP id q3so3202834iaq.19
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 04:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=UpJvFO2U7piqoWgs+oM1XLaeDGA7Rta6lfRvkjs3dfo=;
        b=X3cAmbtGi24Ugj5EN1hgJpQz0Bg7rkjl0qouDQWGDlbnxAVIowFDuE5d9PcUe7B5Q9
         Rc+bWu5vobBBL6sND380n5AHtHk7zkZfHpJZuCDTBajJ+xeXoPGEEd5eZ3ZwNwkxtoWq
         ScW75cysbc4NVAyhL3qn5g2DptBZwqednPWMo=
Received: by 10.42.115.198 with SMTP id l6mr798710icq.132.1316259584146;
        Sat, 17 Sep 2011 04:39:44 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id o5sm14186749ibu.12.2011.09.17.04.39.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Sep 2011 04:39:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 17 Sep 2011 21:39:36 +1000
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181575>

This particular SHA-1 has special meaning to git, very much like NULL
in C. If a user adds a file that has this SHA-1, unexpected things can
happen.

Granted, the chance is probably near zero because the content must
also start with valid blob header. But extra safety does not harm.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Another way than die() is to detect this situation and update header a
 little to give different SHA-1 (for example a leading 0 in object
 size in header). Older git versions may not be happy with such an
 approach.

 The same check can be added to commit, tree, tag creation and fsck.
 Maybe I'm too paranoid.

 By the way, are any other SHA-1s sensitive to git like this one?

 sha1_file.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 064a330..76be0dd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2748,6 +2748,11 @@ int index_fd(unsigned char *sha1, int fd, struct=
 stat *st,
 	else
 		ret =3D index_stream(sha1, fd, size, type, path, flags);
 	close(fd);
+	if (!ret && is_null_sha1(sha1))
+		die(_("You are very unluckly.\n"
+		      "You cannot add '%s' because this particular SHA-1 is used int=
ernally by git.\n"
+		      "Any chance you can modify this file just a little to give dif=
ferent SHA-1?"),
+		    path);
 	return ret;
 }
=20
--=20
1.7.3.1.256.g2539c.dirty
