From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH] Prettify log decorations even more
Date: Thu,  7 May 2009 01:45:48 +0300
Message-ID: <1241649948-11765-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 00:46:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1psK-0002aL-RC
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 00:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbZEFWp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 18:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbZEFWp4
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 18:45:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:3386 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbZEFWpz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 18:45:55 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1166027fga.17
        for <git@vger.kernel.org>; Wed, 06 May 2009 15:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1uK/DyPVgTXvOAMuE3BKTRdYxKR9ynbElGQxS+Ic7AU=;
        b=bZchrYysAY6Mtqtt5VaB0KunShN3mTZq3+fenyGmgD7YhgLEW/4cXMD1v0lVnq9shf
         sqyPWlC+IZamsy4w9syBjXRrdDIDZM29+LmAwasu+Q11kY7UAF1X0I01HK0jw32k3+mK
         hnvok0V/EkXTXu5sriNaP5Lo/Ixn2q96KHbkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SZTXjqG102BUsdZSaNhZrMITxdxq8p5zBvVRjmOtznKaoo0vqYRoPVP42dhOmxPYGh
         ik2N7wERxRnb+Idch42mA2q7l7n8xhkQQOnCuyDGMLWvMuvNVIMuEi8BZeNauKpK/saH
         0DosX0rYBrKnPx9WiJ5Gbtjnc7gut+Qc+d5Pc=
Received: by 10.86.90.2 with SMTP id n2mr1817252fgb.61.1241649954199;
        Wed, 06 May 2009 15:45:54 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 3sm785610fge.4.2009.05.06.15.45.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 15:45:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc4.14.g96da.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118396>

"tag: v1.6.2.5" looks much better than "tag: refs/tags/v1.6.2.5".

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 log-tree.c |    1 +
 refs.c     |    3 +--
 refs.h     |    3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 5bd29e6..59d63eb 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -25,6 +25,7 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	struct object *obj = parse_object(sha1);
 	if (!obj)
 		return 0;
+	refname = prettify_refname(refname);
 	add_name_decoration("", refname, obj);
 	while (obj->type == OBJ_TAG) {
 		obj = ((struct tag *)obj)->tagged;
diff --git a/refs.c b/refs.c
index e65a3b4..e74461e 100644
--- a/refs.c
+++ b/refs.c
@@ -750,9 +750,8 @@ int check_ref_format(const char *ref)
 	}
 }
 
-const char *prettify_ref(const struct ref *ref)
+const char *prettify_refname(const char *name)
 {
-	const char *name = ref->name;
 	return name + (
 		!prefixcmp(name, "refs/heads/") ? 11 :
 		!prefixcmp(name, "refs/tags/") ? 10 :
diff --git a/refs.h b/refs.h
index 29d17a4..3de5e1c 100644
--- a/refs.h
+++ b/refs.h
@@ -80,7 +80,8 @@ extern int for_each_reflog(each_ref_fn, void *);
 #define CHECK_REF_FORMAT_WILDCARD (-3)
 extern int check_ref_format(const char *target);
 
-extern const char *prettify_ref(const struct ref *ref);
+extern const char *prettify_refname(const char *refname);
+#define prettify_ref(ref) prettify_refname((ref)->name)
 extern char *shorten_unambiguous_ref(const char *ref, int strict);
 
 /** rename ref, return 0 on success **/
-- 
1.6.3.rc4.14.g96da.dirty
