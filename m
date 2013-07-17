From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] parse_object_buffer: Correct freeing the buffer.
Date: Thu, 18 Jul 2013 00:09:42 +0200
Message-ID: <1374098982-6962-1-git-send-email-stefanbeller@googlemail.com>
References: <51E715D8.9040307@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: philipoakley@iee.org, peff@peff.net, j.sixt@viscovery.net,
	ramsay@ramsay1.demon.co.uk, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 00:09:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzZuz-000406-KD
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 00:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453Ab3GQWJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 18:09:47 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:64241 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192Ab3GQWJq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 18:09:46 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so1321493eek.14
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 15:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XTPXLd02O28JVufsyK0AJ9ppWT5wzFSGBiKUCBuMhFc=;
        b=Mpz7NyEBJCS9imFXAMivDv48wGJPDeIbXS1dtb0XOrz0AnmOSgu0n/oeKWmc7waHLa
         JkEQg6mfQidv0eoM36jg8ZsMhpQSEE3E3A3Tefr9Dcyu0vkJt+Xaa3oQOYGSn+riVoP2
         Ps5oSJcEKXW6I4atzXTb6L39+fjNkTSMTLRgl+z922yu/4u92qnySnDBfaZLxR7lQd7w
         j5poFRiuh/urXNb1ZTa1BAEWnTngxNSHIVRL58FtsxdN3HKSVmkp5lZsaSwUdrUx8sq2
         vCYRMBvPRNEwVF916Mh+Qfgjuo9s1YIU6TarmQ/WVqa05tN7fwoO1R2OEJ9gNccUYm55
         Ac5g==
X-Received: by 10.14.223.199 with SMTP id v47mr8357714eep.32.1374098984955;
        Wed, 17 Jul 2013 15:09:44 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id n45sm14269948eew.1.2013.07.17.15.09.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 15:09:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.754.g9c3c367.dirty
In-Reply-To: <51E715D8.9040307@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230659>

If we exit early in the function parse_object_buffer, we did not
write to *eaten_p. Then the calling function parse_object, which looks
like the following with respect to the eaten variable, cannot rely on a
proper value set in eaten, hence the freeing of the buffer depends
on random values in memory.

	struct object *parse_object(const unsigned char *sha1)
	{
		int eaten;
		...
		obj = parse_object_buffer(sha1, type, size, buffer, &eaten);
		if (!eaten)
			free(buffer);
	}

This change makes sure, the buffer freeing condition is deterministic.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 object.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index cbc7333..d8a4b1f 100644
--- a/object.c
+++ b/object.c
@@ -145,7 +145,7 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 struct object *parse_object_buffer(const unsigned char *sha1, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
 {
 	struct object *obj;
-	int eaten = 0;
+	*eaten_p = 0;
 
 	obj = NULL;
 	if (type == OBJ_BLOB) {
@@ -164,7 +164,7 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 			if (!tree->object.parsed) {
 				if (parse_tree_buffer(tree, buffer, size))
 					return NULL;
-				eaten = 1;
+				*eaten_p = 1;
 			}
 		}
 	} else if (type == OBJ_COMMIT) {
@@ -174,7 +174,7 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 				return NULL;
 			if (!commit->buffer) {
 				commit->buffer = buffer;
-				eaten = 1;
+				*eaten_p = 1;
 			}
 			obj = &commit->object;
 		}
@@ -191,7 +191,6 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 	}
 	if (obj && obj->type == OBJ_NONE)
 		obj->type = type;
-	*eaten_p = eaten;
 	return obj;
 }
 
-- 
1.8.3.3.754.g9c3c367.dirty
