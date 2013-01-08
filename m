From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] upload-pack: only accept commits from "shallow" line
Date: Tue,  8 Jan 2013 18:32:36 +0700
Message-ID: <1357644756-18205-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 12:31:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsXPM-0004bG-N5
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 12:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189Ab3AHLbc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2013 06:31:32 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:42655 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114Ab3AHLbb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 06:31:31 -0500
Received: by mail-pa0-f48.google.com with SMTP id fa1so281708pad.21
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 03:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=hUjEegRYsr2ITcJB9qLN6Bi+9qP0wGupoDLcKJyPn1o=;
        b=ZmNFroHMeL1m1VYKUR22cH+boEdrI+KSIqogywpvwtQU6guRPWNyw6bzRZ3hu4/n4b
         Uw0L+oimd39k0o9fCHS5/s2Ga/d7a4cWxjMUukqSxrsOkLxsRQGQpR1MPqTej1u5fOG4
         ZksjxKmV2p995NCw02D2BbSGriEFTzs4PYhq2OSkYL0jVvchMXO/XKOzUywB0+cdsa/z
         pMpBSPx/Y4U9iebNdOMu7848zC3xcRkGvy/Ne6Y7JrNDppQLptqQyxOoNw89Hpps4REz
         3j+JJq79tIgteYtr9gY9gFOuCNoi+RQR7z4/tihbcIiT6JBpX76f7sqO1gLVG5WFN4VM
         WUCg==
X-Received: by 10.68.232.101 with SMTP id tn5mr199112629pbc.125.1357644691492;
        Tue, 08 Jan 2013 03:31:31 -0800 (PST)
Received: from tre ([115.74.46.148])
        by mx.google.com with ESMTPS id kp4sm39487607pbc.52.2013.01.08.03.31.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 03:31:30 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 08 Jan 2013 18:32:49 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212953>

We only allow cuts at commits, not arbitrary objects. upload-pack will
fail eventually in register_shallow if a non-commit is given with a
generic error "Object %s is a %s, not a commit". Check it early and
give a more accurate error.

This should never show up in an ordinary session. It's for buggy
clients, or when the user manually edits .git/shallow.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index 6142421..95d8313 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -603,6 +603,8 @@ static void receive_needs(void)
 			object =3D parse_object(sha1);
 			if (!object)
 				die("did not find object for %s", line);
+			if (object->type !=3D OBJ_COMMIT)
+				die("invalid shallow object %s", sha1_to_hex(sha1));
 			object->flags |=3D CLIENT_SHALLOW;
 			add_object_array(object, NULL, &shallows);
 			continue;
--=20
1.8.0.rc0.19.g7bbb31d
