From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Subject: [PATCH] fetch-pack: fix object_id of exact sha1
Date: Sat, 27 Feb 2016 17:32:54 -0300
Message-ID: <1456605174-28360-1-git-send-email-gabrielfrancosouza@gmail.com>
References: <CABaesJ+yNJ6_z=sFc+bDEPqDDsw9fkB5bYgxJaAkAMVqHNWwrQ@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 21:34:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZlZ0-0001vm-Eh
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 21:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992535AbcB0UeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 15:34:01 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34064 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992522AbcB0UeA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 15:34:00 -0500
Received: by mail-qg0-f47.google.com with SMTP id b67so89926491qgb.1
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 12:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FXWTM8GSP6Dt8diXuZV/fMSnCEfG9AeyHHj05cbG2jM=;
        b=lUmS9so73enA7TP0yK9qmKC8Vjvv9jasXhLV1ddnivh3y3GBXwsonW/OJLBFQFmAU/
         v6kOSNROx89s6rOMCmmatYxRr/3jIMdL7qKdNBOucj1p3xxV6FLlqI4nDLsfCGmKciEx
         z4v+8TpYKzIUE415hKG9C2e4Jr9JDFDcb5nvb7wvFakh4Qu537ErA0YEROfjLuocwIVL
         mqfB/aFTCmJZc7RxXHkxa0cKTAu6jMW+HXqeZV0fk2LVtfUTcldjSwbYUjdvGIvKpPFn
         0fSG/7MkckvzTrdDuYHVBBhYCCx9iH0ERcJsiOJF2pX6LzQPa2th2VvOf4b0GypTut9p
         pJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FXWTM8GSP6Dt8diXuZV/fMSnCEfG9AeyHHj05cbG2jM=;
        b=HJmrWr9d+SNyT4cHIuMQJLojSqYyUijVqoFuY5nIgidoGLv2x4vMDWPdxrGHe7DWmw
         s3Ni4OjCELnZ2fhMYLjd/oWT8TfZ3XwH9ACn6/HiUDBBPVfd6bgZL0Ml13OXD/ByH4B3
         GP9X8jnKH0iVyQ4NXnvKmKD8nZ0MQVpJdDSwFr68oRO/Fh5Q34/jyTj9KbCH/xm6CsG1
         gHgZOVJfhrSDAS7V18lBjXNk1vEpLm2gxtfmxIn3JzQQTS9qDGXaLN8S6GGaL9uuhcTC
         WwUoBkOc5STb3tjA/DjvD5oqTK8N66uL+Sam6Yo8ZpSuBakxocdRyJI7FKtBzCJbj9NI
         rFkw==
X-Gm-Message-State: AD7BkJI1r4PgwnGd2HHfehuoH4Xaq9EffQd2Lis+XGAIQ/ruMy+V5zCuA/s2oPnAQNF5SQ==
X-Received: by 10.140.107.74 with SMTP id g68mr10129784qgf.82.1456605239702;
        Sat, 27 Feb 2016 12:33:59 -0800 (PST)
Received: from ghost.localdomain ([187.22.88.116])
        by smtp.gmail.com with ESMTPSA id 200sm7778070qhm.47.2016.02.27.12.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Feb 2016 12:33:58 -0800 (PST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <CABaesJ+yNJ6_z=sFc+bDEPqDDsw9fkB5bYgxJaAkAMVqHNWwrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287730>

Commit 58f2ed0 (remote-curl: pass ref SHA-1 to fetch-pack as well,
2013-12-05) added support for specifying a SHA-1 as well as a ref name.
Add support for specifying just a SHA-1 and set the ref name to the same
value in this case.

Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
---
 builtin/fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 79a611f..d7e439a 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -16,10 +16,10 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 	struct ref *ref;
 	struct object_id oid;
 
-	if (!get_oid_hex(name, &oid) && name[GIT_SHA1_HEXSZ] == ' ')
-		name += GIT_SHA1_HEXSZ + 1;
-	else
+	if (get_oid_hex(name, &oid))
 		oidclr(&oid);
+	else if (name[GIT_SHA1_HEXSZ] == ' ')
+		name += GIT_SHA1_HEXSZ + 1;
 
 	ref = alloc_ref(name);
 	oidcpy(&ref->old_oid, &oid);
-- 
2.7.1
