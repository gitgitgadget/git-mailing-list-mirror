From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Subject: [PATCH v3] fetch-pack: fix object_id of exact sha1
Date: Mon, 29 Feb 2016 23:12:56 -0300
Message-ID: <1456798376-29904-1-git-send-email-gabrielfrancosouza@gmail.com>
References: <CABaesJK+zuuYAJ6YaEugLMFywMqE8V0W1=_4mJPGDAnfT9yXJg@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 03:13:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZot-0005qT-NP
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 03:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbcCACNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 21:13:48 -0500
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33091 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbcCACNr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 21:13:47 -0500
Received: by mail-yw0-f173.google.com with SMTP id u200so138005557ywf.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o5G0eBW51BBkFUG8yg7IPf9J6ei8uWg6Mb1XMS/LI7A=;
        b=CV0d+l3lqwzlOqGPXZRYA4T8GQmsZ+pBvWZngqoTR5zUErBrQcpB+8S0NLpmcQFTUs
         2qLgza6I7Q8K2mFKbTRsGleNh2IhratwK7vqO86arKC1eGaadbqCIeaQcnf4E/aeUiT2
         0OvX3A7edxH+oUhFi4H9Qcr6zsMe/qCj2Q8bbE/W8camUGlbR0yGByfgA6gVAF1FaSoQ
         Z1vaz7fRKfw9annqrxRIelSD0Ob8ll4xJUi4RB9fWDZaX+dOk5BWknYdp4NOFSIDU48w
         x1LHJk8sI7cEdHYeCmGGJ/pk+Y3XjvHnzYGYZ1RIDVpMGDexq7xWVAzQUuuV+1TjT+A8
         BWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o5G0eBW51BBkFUG8yg7IPf9J6ei8uWg6Mb1XMS/LI7A=;
        b=HIcT4uoNTVjYoByECMrIqpGuk7zSgMzLwVsE8JqM+ms4GpQc6faZeaERmAkeRyN2Gb
         mF+eYPggIrDlUQaLSb5tyOWTM1Uf+xnM0ME1TOoo7jk99lLYC8jYvtBJjKXPdR9drgJ2
         dsSBGBaO7dFdjljT7EwsdOPCRFlvd4EhMWr4dUax871IpeCWeaI4E5sV8nQMGd4gdssT
         eERphYaPy/lG030TOgep97i+F15Wft2XyO8fh8lsnJCC6WYm0ljgJYJS4qTPU5tzpP3q
         OUNPs9DoRAZ9DmFdPZE9awSgc0EeJy8t0deQMOVrLQRmRcos0nCWqSfcvMhJJ5WTMC3E
         odEw==
X-Gm-Message-State: AD7BkJJAq9GWrDhnoGhHCMled2//9OIj9Oufilox+Xt4bLHjC4ng6WFG5juPeQTJGmzjGg==
X-Received: by 10.129.38.135 with SMTP id m129mr10432209ywm.155.1456798426779;
        Mon, 29 Feb 2016 18:13:46 -0800 (PST)
Received: from ghost.localdomain ([201.82.54.180])
        by smtp.gmail.com with ESMTPSA id h131sm23019956ywb.25.2016.02.29.18.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 18:13:46 -0800 (PST)
X-Mailer: git-send-email 2.7.2
In-Reply-To: <CABaesJK+zuuYAJ6YaEugLMFywMqE8V0W1=_4mJPGDAnfT9yXJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287995>

Commit 58f2ed0 (remote-curl: pass ref SHA-1 to fetch-pack as well,
2013-12-05) added support for specifying a SHA-1 as well as a ref name.
Add support for specifying just a SHA-1 and set the ref name to the same
value in this case.

Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
---

I did keep the oid variable because ref is uninitialized at that point,
and this means having to copy either name or old_oid afterwards anyway.

 builtin/fetch-pack.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 79a611f..50c9901 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -16,10 +16,20 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 	struct ref *ref;
 	struct object_id oid;
 
-	if (!get_oid_hex(name, &oid) && name[GIT_SHA1_HEXSZ] == ' ')
-		name += GIT_SHA1_HEXSZ + 1;
-	else
+	if (!get_oid_hex(name, &oid)) {
+		if (name[GIT_SHA1_HEXSZ] == ' ') {
+			/* <sha1> <ref>, find refname */
+			name += GIT_SHA1_HEXSZ + 1;
+		} else if (name[GIT_SHA1_HEXSZ] == '\0') {
+			/* <sha1>, leave sha1 as name */
+		} else {
+			/* <ref>, clear cruft from oid */
+			oidclr(&oid);
+		}
+	} else {
+		/* <ref>, clear cruft from get_oid_hex */
 		oidclr(&oid);
+	}
 
 	ref = alloc_ref(name);
 	oidcpy(&ref->old_oid, &oid);
-- 
2.7.2
