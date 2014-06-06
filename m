From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 18/40] replace.c: use the ref transaction functions for updates
Date: Fri,  6 Jun 2014 15:28:56 -0700
Message-ID: <1402093758-3162-19-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2e6-0002R3-Tw
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbaFFW3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:29:31 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:54767 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-ig0-f202.google.com with SMTP id h18so128626igc.5
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3h2Z/jyDnSAq//sTvmD8jAAUuJUk/AeJ1TF2koizIrw=;
        b=YlCaWcxf2vsWfzRopmWWFenWMihRDisgTmgzq2q7lOOZ+eNAx6U9sXkj9CABbEC2Z0
         P0bepqLo3GEbZLqV+PoZTE8ID5JB+xhaWUl6qXkKKTmKvIm6JMWGOKm/BWTV/M5RcC4/
         vudXEmKi7kDyzVkIhrDY563+WMgTMFvcnwEZgfl21Bry8IewKmJtRLRXIk+Mn7QBHzjQ
         XG4tqzVVuClnyUsnkLjHYulTXe1N3eXBXHZctrW2jAEwPy9mm+P9QoYgrkBI3jy9SQAh
         QY8+UMIWkiH1uexJf8BeFKSQwIAKcq0IZwsIHP1cCGu0sro/epmhJjPAjocS/3DFQfq3
         x8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3h2Z/jyDnSAq//sTvmD8jAAUuJUk/AeJ1TF2koizIrw=;
        b=D8fLYBwH0T/DOohHyyuWB94c28UUSZ/hi4PbV9J5uiSpnw1V4ZP6fq70nY3wUtr6bV
         nJaRgm93e0YPZiLRr3aAbRKdbmgfYPuzbOkguSkGFbfmtoUPXOibeS69iN90Gmqb0UDW
         48dZQZ5914DXeLStcg0STpXq6WWxLHJybV3OH2A/A88qe8u90UyF9G5qRCdgS8if3J0f
         TDTuwNn6hDbhlAzke26r8YxFAuIt2P1Qdn8p0bhYHIZLo3DpxDst42Xtuoa6HmvNQlEr
         gzM/bTutvpn3d9ZJsxl1wByKvWJzOLVOTWzVJgXM0RLr3Ch2ThcWwT5aLxz4r+hoUimt
         4RrA==
X-Gm-Message-State: ALoCoQlGgg8kHMp76/LgbnxUWN3+Ej+DcIEuQf6a1PGCE2ySAd3EL8uS1z/COW85TNRisZ+h/SEB
X-Received: by 10.182.226.166 with SMTP id rt6mr4434855obc.47.1402093762411;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si751215vda.3.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2C14F31C629;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 061E3E10DE; Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250983>

Update replace.c to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 4b3705d..cf92e5d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -154,7 +154,8 @@ static int replace_object_sha1(const char *object_ref,
 	unsigned char prev[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	obj_type = sha1_object_info(object, NULL);
 	repl_type = sha1_object_info(repl, NULL);
@@ -167,12 +168,14 @@ static int replace_object_sha1(const char *object_ref,
 
 	check_ref_valid(object, prev, ref, sizeof(ref), force);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.582.ge25c160
