From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH RFC] parse_object: pass on the original sha1, not the replaced one
Date: Sat, 31 Jul 2010 19:36:42 +0700
Message-ID: <1280579802-8606-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, chriscool@tuxfamily.org
X-From: git-owner@vger.kernel.org Sat Jul 31 14:36:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfBJC-0006tt-Sw
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 14:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab0GaMgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 08:36:54 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55608 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab0GaMgx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 08:36:53 -0400
Received: by pzk26 with SMTP id 26so860645pzk.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 05:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=e8BpesjgRyoHmNfq6jS6EzaIx1MAeipCkxaOUQI2WIc=;
        b=qu/hGlYqPczqMcHUtnlwfXlupcygQup86NZLaLJLZ1qBNoCwLIVh3nY4Uud+5DDv3C
         3xT5aYTiSJCbdr99ck7ejT2sjMYU9Vmh+NVrH/jrrLYUO/eaBwYqzYjOVKjgcW+0/wDK
         bX74RKqnY+Bnsmmmr1SgOy8hmW2EKZz/CpzUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=W1/BLAcRl0G9G9UBnh+xAn93/VMTwF5K/YvFtSw8566hq0U4lJ5zNNSG8nIuWgdd1z
         h/hKITwsUwlt4Q7tuPaQlSokuOwkszmixIGybqGsnrPWbPlymGYtzX5tKONGp38UTPTE
         +7m5BuxAmhKWcT0F1Y1bYdUveOF1PYMvzhH4Y=
Received: by 10.142.178.21 with SMTP id a21mr2969252wff.220.1280579812972;
        Sat, 31 Jul 2010 05:36:52 -0700 (PDT)
Received: from dektop ([123.200.231.45])
        by mx.google.com with ESMTPS id y16sm4176597wff.2.2010.07.31.05.36.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 05:36:51 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 19:36:43 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152321>

Commit 0e87c36 (object: call "check_sha1_signature" with the
replacement sha1) did this. I'm not sure if it's should be done this
way.

With "repl" as the first argument to parse_object_buffer, the returned
obj pointer will have the replaced SHA1 in obj->sha1, not the original
one. I sort of expect that, no matter the object is replaced,
obj->sha1 should stay the same.

This was observed by replacing commit tip. git log would show the
replaced sha1, not the original one.
---
 object.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/object.c b/object.c
index 277b3dd..7adfda7 100644
--- a/object.c
+++ b/object.c
@@ -199,7 +199,7 @@ struct object *parse_object(const unsigned char *sha1)
 			return NULL;
 		}
 
-		obj = parse_object_buffer(repl, type, size, buffer, &eaten);
+		obj = parse_object_buffer(sha1, type, size, buffer, &eaten);
 		if (!eaten)
 			free(buffer);
 		return obj;
-- 
1.7.1.rc1.69.g24c2f7
