From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] clone: tighten "local paths with colons" check a bit
Date: Fri, 27 Sep 2013 20:48:13 +0700
Message-ID: <1380289693-593-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Morten Stenshorne <mstensho@opera.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 27 15:45:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPYM1-0001Uo-Ex
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 15:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756Ab3I0Noy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Sep 2013 09:44:54 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:62542 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab3I0Nov (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 09:44:51 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so2813682pad.37
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=uq6AieO1re1ft2w3qe9QOtibrgTAn7yXpuxnxC1Tz5Q=;
        b=PTFSZhwCgLkC0f81keG7YskcxcJcSqNT5wniUNvnLEjT1BsbybEQcksvbU0hFilXcG
         bQ5TK38xa4m16kBKvo+LE2CC2JV4sVQzK1NHJtfYZvWRPYm1ul3WJxm9DNVhGtFF0j2P
         CDrgMO59lKLftnBlOqXndtROUYRdk3zxUJ6t0n/WGzn+H5wGc9n6NJkWTGsmUMp/lkwo
         pBJsPVCXLVZ63sf0/wUVs+4Kff+FGF1v15uLWZlKhk76kbVR0nhaV1AgYKft62GID8sR
         3z50U9sWaNaoVOTsdy1QLiFlauWxgkGItHVpUvF7zjCGWhygmL9vd//u+vPJTaPJUEsp
         V1xQ==
X-Received: by 10.68.224.131 with SMTP id rc3mr1855236pbc.204.1380289490471;
        Fri, 27 Sep 2013 06:44:50 -0700 (PDT)
Received: from lanh ([115.73.244.34])
        by mx.google.com with ESMTPSA id yg3sm12710839pab.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 06:44:48 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 27 Sep 2013 20:48:18 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235459>

commit 6000334 (clone: allow cloning local paths with colons in them -
2013-05-04) is added to make it possible to specify a path that has
colons in it without file://, e.g. ../foo:bar/somewhere. But the check
is a bit loose.

Consider the url '[foo]:bar', the '[]' unwrapping code will turn the
string to 'foo\0:bar'. The effect of this new string is the same as
'foo/:bar' to the expression "path < strchrnul(host, '/')", which
mistakes it as a sign of local paths while it's actually not.

Make sure we only check so when no protocol is specified and the url
is not started with '['.

Noticed-by: Morten Stenshorne <mstensho@opera.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I wanted to add a test then realized there were no ssh tests in the
 test suite. So laziness won :p

 connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index a0783d4..303f850 100644
--- a/connect.c
+++ b/connect.c
@@ -551,7 +551,7 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 	path =3D strchr(end, c);
 	if (path && !has_dos_drive_prefix(end)) {
 		if (c =3D=3D ':') {
-			if (path < strchrnul(host, '/')) {
+			if (host !=3D url || path < strchrnul(host, '/')) {
 				protocol =3D PROTO_SSH;
 				*path++ =3D '\0';
 			} else /* '/' in the host part, assume local path */
--=20
1.8.2.83.gc99314b
