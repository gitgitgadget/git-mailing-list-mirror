From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] mailinfo: fix passing wrong address to git_mailinfo_config
Date: Sun,  1 Nov 2015 15:30:30 +0100
Message-ID: <1446388230-27966-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 15:31:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZstfG-0008OS-CD
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 15:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbbKAObR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 09:31:17 -0500
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36366 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbbKAObR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 09:31:17 -0500
Received: by wicfx6 with SMTP id fx6so35644889wic.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 06:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=QkiwLw5mm2xYHTyKps6QniU+bZkwMagWs0GiQQE5Au8=;
        b=UMfFgPESCMuf01Fqz8yzCFyzcPVk0xYrLCadrcDjyFUyhLmUrF6/aeSqnRp+W2kGHw
         LVj7r7Q7t4YckoUvYHtnvS08kjsOY7xyOpg/ad1rC/bnGhoFlyzFArxBFb5CcsZBUH1X
         xBeUmqhqV2bh8efiUjzSaB7b6aEDH5ktFVDd4ulx3jGFeSDAxLN2c/Zc3FRkOd233w2Z
         LR+z19FnypNz0DMH0JyNZZ+zdQ5nCf+arI0FTjMsc45+lLDET6BOGZGJLwbxXYZ5m8cZ
         S4lWGW9YMILrn5daEfn5I1kdmKLcQ96C11RGfXa9rvvd7cAJ3PeZaXbL8dkCOiZrAFKm
         wk6w==
X-Received: by 10.194.82.166 with SMTP id j6mr20281941wjy.63.1446388275893;
        Sun, 01 Nov 2015 06:31:15 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id m143sm13087170wmb.1.2015.11.01.06.31.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 06:31:14 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280634>

git_mailinfo_config() expects "struct mailinfo *". But in
setup_mailinfo(), "mi" is already "struct mailinfo *". &mi would make
it "struct mailinfo **" and git_mailinfo_config() would damage some
other memory when it assigns some value to mi->use_scissors.

This is caught by t4150.20. git_mailinfo_config() breaks
mi->name.alloc and makes strbuf_release() in clear_mailinfo() attempt
to free strbuf_slopbuf.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 mailinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailinfo.c b/mailinfo.c
index e157ca6..f289941 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1009,7 +1009,7 @@ void setup_mailinfo(struct mailinfo *mi)
 	mi->header_stage =3D 1;
 	mi->use_inbody_headers =3D 1;
 	mi->content_top =3D mi->content;
-	git_config(git_mailinfo_config, &mi);
+	git_config(git_mailinfo_config, mi);
 }
=20
 void clear_mailinfo(struct mailinfo *mi)
--=20
2.2.0.513.g477eb31
