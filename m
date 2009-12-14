From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/23] excluded_1(): support exclude files in index
Date: Mon, 14 Dec 2009 17:30:56 +0700
Message-ID: <1260786666-8405-14-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:33:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8FK-0007wL-6l
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144AbZLNKdR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756157AbZLNKdM
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:33:12 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:62201 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144AbZLNKdB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:33:01 -0500
Received: by mail-px0-f174.google.com with SMTP id 4so1691169pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/5kRFDDExXonALsQ/RyonZC7KF0DCtX7RCFeac5KW7c=;
        b=XKWnIPGWenUXmYYZueOHkDhkfI6RH9r7W6bnYXExU+srQ9iAfZn9ZI5vUMscJmke8u
         z7rSK7cHXOwtK/NKCU8WXmMC6PZuINAWd+raXQDl8KnnYS5s6T7hwhGKv07QiUya3pv4
         53hLWWizWh3iDY9R5AI2pY/UZ0qrdaY96X2Ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QQXDBuLwbPtMkhjairHe2sMHEfSRR39dLs4v6p7a3stY/tXBAwZunGsdlYcNpxqMg7
         QdwZSt+5WOZn6fQu8qXDUVvwdA2/GCbRJZ9miQgoDpkkSSmfvTu7Rv+JflgVrAB14TQ3
         5f5wf1jFY4nvWNByzon+n7wFZa8zuT0KDXKT8=
Received: by 10.142.8.34 with SMTP id 34mr3061716wfh.103.1260786778451;
        Mon, 14 Dec 2009 02:32:58 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 21sm4904619pzk.7.2009.12.14.02.32.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:32:57 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:32:16 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135184>

Index does not really have "directories", attempts to match "foo/"
against index will fail unless someone tries to reconstruct directories
from a list of file.

Observing that dtype in this function can never be NULL (otherwise
it would segfault), dtype NULL will be used to say "hey.. you are
matching against index" and behave properly.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index e8e5b79..7735cea 100644
--- a/dir.c
+++ b/dir.c
@@ -349,6 +349,12 @@ static int excluded_1(const char *pathname,
 			int to_exclude =3D x->to_exclude;
=20
 			if (x->flags & EXC_FLAG_MUSTBEDIR) {
+				if (!dtype) {
+					if (!prefixcmp(pathname, exclude))
+						return to_exclude;
+					else
+						continue;
+				}
 				if (*dtype =3D=3D DT_UNKNOWN)
 					*dtype =3D get_dtype(NULL, pathname, pathlen);
 				if (*dtype !=3D DT_DIR)
--=20
1.6.5.2.216.g9c1ec
