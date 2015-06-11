From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 12/12] ref-filter: make 'ref_array_item' use a FLEX_ARRAY for refname
Date: Thu, 11 Jun 2015 21:40:03 +0530
Message-ID: <1434039003-10928-12-git-send-email-karthik.188@gmail.com>
References: <5579B253.4020804@gmail.com>
 <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 18:11:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z354b-0006rV-B6
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 18:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447AbbFKQLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 12:11:04 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33483 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbbFKQLB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 12:11:01 -0400
Received: by pablj1 with SMTP id lj1so2431909pab.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=knmYCmTn6DNTcjp3IV7CujhO9AzEe+T4GZql5YXHkEg=;
        b=gwgWOjDz5N3wPVWh9QtpvZUJWJiLIKaLg7qK9Jfl2zkiipEYi16AuxsjOz96D3JEFK
         anJnBFmxpgFvV/B0efmI3PWHi/EtTIhqT0/2oQ6od981WbQ1h9t8airYw9iDb8sfXmvl
         7r57A0c6LHUtzFsM4zLbcMbvt8BX/W8GpEDPRM8aQVsY+iw7EppJSAFgD+gIXbCUAcEs
         caFkZs/fdv4PBILincxHhMDx8TKvd0xFVbveQp1/cDm/0verrKURobrYJNddge+jBzv4
         D0XPNv6ScMMU8kQEGcnVAslo4DjEryUvdcGpkGj5ExaerSXpT65IbsiZvqn+lB9N6ciH
         7ZoQ==
X-Received: by 10.70.41.33 with SMTP id c1mr15935239pdl.114.1434039061504;
        Thu, 11 Jun 2015 09:11:01 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id f4sm1132981pdc.95.2015.06.11.09.10.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 09:11:00 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271432>

This would remove the need of using a pointer to store refname.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 7 ++++---
 ref-filter.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6f7defc..310ecd6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -847,8 +847,10 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 						 const unsigned char *objectname,
 						 int flag)
 {
-	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item));
-	ref->refname = xstrdup(refname);
+	size_t len = strlen(refname);
+	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
+	memcpy(ref->refname, refname, len);
+	ref->refname[len] = '\0';
 	hashcpy(ref->objectname, objectname);
 	ref->flag = flag;
 
@@ -889,7 +891,6 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 static void free_array_item(struct ref_array_item *item)
 {
 	free((char *)item->symref);
-	free(item->refname);
 	free(item);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index f917ebc..6ab2a75 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -32,7 +32,7 @@ struct ref_array_item {
 	int flag;
 	const char *symref;
 	struct atom_value *value;
-	char *refname;
+	char refname[FLEX_ARRAY];
 };
 
 struct ref_array {
-- 
2.4.2
