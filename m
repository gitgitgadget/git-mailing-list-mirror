From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/3] Unify signedness in hashing calls
Date: Mon, 18 May 2009 23:34:02 -0500
Message-ID: <1242707644-29893-1-git-send-email-dpmcgee@gmail.com>
References: <449c10960905182132h2c1b38b4jd28721adaeb38484@mail.gmail.com>
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 06:34:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6H1z-0004yy-9x
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 06:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbZESEeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 00:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbZESEeP
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 00:34:15 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:50589 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbZESEeO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 00:34:14 -0400
Received: by yx-out-2324.google.com with SMTP id 3so2267774yxj.1
        for <git@vger.kernel.org>; Mon, 18 May 2009 21:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sqDtNfHu3mLGzCH9FXde8Sdflx8CXmybBJMM/7xlKAA=;
        b=N3DeyKqTdSTUp8qjeCC47K03BnSpbVRPkpDVMQlQmhXIQiI32DyumQJhPPWSRVy+lX
         faUT+Rs8sh+NbNeTCq4cnUNO2k6w3tSjQx6oV4iOBlpYcuOfG4BTPfnYXmYvtegcKKoI
         NSi3yw5AhClxZNW6oEXbWBPvopTUYdRr1qkPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Vd7bTw/aOza4jttuRg/2OCD3ykiUYsjMFcrRSpNzCLMhMprqGyVOd1zT5ALk4paifh
         E5Svoq6aByZwuzit2Yqn+ymdYQkrHNEhcwbv9cCYVqGiwWlMwdOxFkO0RzccK6Znp2rZ
         GIeFl9Ow2YjQpp03vRbtA1t6dGplXKDQc8avM=
Received: by 10.90.113.11 with SMTP id l11mr6569842agc.7.1242707655531;
        Mon, 18 May 2009 21:34:15 -0700 (PDT)
Received: from localhost (adsl-76-197-232-78.dsl.chcgil.sbcglobal.net [76.197.232.78])
        by mx.google.com with ESMTPS id 39sm8927850aga.21.2009.05.18.21.34.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 21:34:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <449c10960905182132h2c1b38b4jd28721adaeb38484@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119488>

Our hash_obj and hashtable_index calls and functions were doing a lot of
funny things with signedness. Unify all of it to 'unsigned int'.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 decorate.c |    4 ++--
 object.c   |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/decorate.c b/decorate.c
index e6fd8a7..2f8a63e 100644
--- a/decorate.c
+++ b/decorate.c
@@ -18,7 +18,7 @@ static void *insert_decoration(struct decoration *n, const struct object *base,
 {
 	int size = n->size;
 	struct object_decoration *hash = n->hash;
-	int j = hash_obj(base, size);
+	unsigned int j = hash_obj(base, size);
 
 	while (hash[j].base) {
 		if (hash[j].base == base) {
@@ -70,7 +70,7 @@ void *add_decoration(struct decoration *n, const struct object *obj,
 /* Lookup a decoration pointer */
 void *lookup_decoration(struct decoration *n, const struct object *obj)
 {
-	int j;
+	unsigned int j;
 
 	/* nothing to lookup */
 	if (!n->size)
diff --git a/object.c b/object.c
index e1feef9..a6ef439 100644
--- a/object.c
+++ b/object.c
@@ -52,7 +52,7 @@ static unsigned int hash_obj(struct object *obj, unsigned int n)
 
 static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
 {
-	int j = hash_obj(obj, size);
+	unsigned int j = hash_obj(obj, size);
 
 	while (hash[j]) {
 		j++;
@@ -62,16 +62,16 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
 	hash[j] = obj;
 }
 
-static int hashtable_index(const unsigned char *sha1)
+static unsigned int hashtable_index(const unsigned char *sha1)
 {
 	unsigned int i;
 	memcpy(&i, sha1, sizeof(unsigned int));
-	return (int)(i % obj_hash_size);
+	return i % obj_hash_size;
 }
 
 struct object *lookup_object(const unsigned char *sha1)
 {
-	int i;
+	unsigned int i;
 	struct object *obj;
 
 	if (!obj_hash)
-- 
1.6.3.1
