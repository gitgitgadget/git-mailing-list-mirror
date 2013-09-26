From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/10] receive-pack: request for packv4 if it's the preferred version
Date: Thu, 26 Sep 2013 09:26:46 +0700
Message-ID: <1380162409-18224-8-git-send-email-pclouds@gmail.com>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 04:27:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP1Iw-0002su-IP
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 04:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755437Ab3IZC1n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 22:27:43 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:55545 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab3IZC1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 22:27:42 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so635277pad.21
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 19:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kLRBZO7e331PsifUvtiUwB5xauJEPynbN8g15wlon9g=;
        b=avUVJeXYmdkZ4Z5/kFUiMcTgWv92MamydI0iSfg1TXWD+pANuM6Gh7jXR8mIKiYbrr
         qgnjbYIPWou8pPvUrewkx8iU6e86dbg+Go82BzxTPHyAbAitGK7CLxZuTEyb3I+J8Q8Q
         6yUsc3M9XHzlH2vz6DdtHmEe94TwnOSwMG23tOhFp43WE0Q2J+V/ekrJKujfSkSOVL9j
         9KbuSK5ENUaGI2f5D+IzZSiNzN2fP/pS4wIl3Ip/QF7jhD7tZVAylDXdBkAFx+66r5DW
         FTKdAHjRXOFl+7y2mBVhM2/fOZE0duR3pYMz3R//CwKGnCVX4T6gB2TaRJlkpJZZRwIX
         wzKg==
X-Received: by 10.66.14.3 with SMTP id l3mr2533634pac.162.1380162461677;
        Wed, 25 Sep 2013 19:27:41 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id ed3sm26835887pbc.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 19:27:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 26 Sep 2013 09:27:36 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235394>

This is the only plumbing command that is controlled by
core.preferredPackVersion so far.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/protocol-capabilities.txt | 4 ++++
 builtin/receive-pack.c                            | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
index be09792..32153cd 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -226,4 +226,8 @@ this capability, the server may send a pack version=
 4. The server can
 choose to send pack version 2 even if the client accepts this
 capability.
=20
+The receive-pack server advertises this capability if it wants to
+receive the pack in format version 4 and the client should send in
+this format.
+
 This capability does not include multi-base tree support.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3eb5fc..288b0bc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -130,10 +130,11 @@ static void show_ref(const char *path, const unsi=
gned char *sha1)
 	if (sent_capabilities)
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
 	else
-		packet_write(1, "%s %s%c%s%s agent=3D%s\n",
+		packet_write(1, "%s %s%c%s%s%s agent=3D%s\n",
 			     sha1_to_hex(sha1), path, 0,
 			     " report-status delete-refs side-band-64k quiet",
 			     prefer_ofs_delta ? " ofs-delta" : "",
+			     core_default_pack_version =3D=3D 4 ? " packv4" : "",
 			     git_user_agent_sanitized());
 	sent_capabilities =3D 1;
 }
--=20
1.8.2.82.gc24b958
