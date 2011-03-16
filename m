From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 1/3] make_absolute_path: return the input path if it points to our buffer
Date: Wed, 16 Mar 2011 17:06:17 +0100
Message-ID: <1300291579-25852-2-git-send-email-cmn@elego.de>
References: <1300291579-25852-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 17:06:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PztEy-0005Dk-PD
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 17:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757Ab1CPQGY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 12:06:24 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:42450 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580Ab1CPQGU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 12:06:20 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 587AD460FF;
	Wed, 16 Mar 2011 17:06:14 +0100 (CET)
Received: (nullmailer pid 25893 invoked by uid 1000);
	Wed, 16 Mar 2011 16:06:20 -0000
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1300291579-25852-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169163>

Some codepaths call make_absolute_path with its own return value as
input. In such a cases, return the path immediately.

This fixes a valgrind-discovered error, whereby we tried to copy a
string onto itself.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 abspath.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/abspath.c b/abspath.c
index 91ca00f..ff14068 100644
--- a/abspath.c
+++ b/abspath.c
@@ -24,6 +24,10 @@ const char *make_absolute_path(const char *path)
 	char *last_elem =3D NULL;
 	struct stat st;
=20
+	/* We've already done it */
+	if (path =3D=3D buf || path =3D=3D next_buf)
+		return path;
+
 	if (strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX)
 		die ("Too long path: %.*s", 60, path);
=20
--=20
1.7.4.1
