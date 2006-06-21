From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Odd behavior with git and cairo-devel repo
Date: Wed, 21 Jun 2006 11:01:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606211054500.5498@g5.osdl.org>
References: <20060621010030.GP2820@artsapartment.org> <20060621024605.GO11245@skl-net.de>
 <20060621120618.GR2820@artsapartment.org> <20060621174632.GP11245@skl-net.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Art Haas <ahaas@airmail.net>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 20:01:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft714-0002Ty-DR
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 20:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWFUSBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 14:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWFUSBX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 14:01:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21977 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751096AbWFUSBX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 14:01:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5LI1Dgt031020
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Jun 2006 11:01:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5LI1CtT030722;
	Wed, 21 Jun 2006 11:01:12 -0700
To: Andre Noll <maan@systemlinux.org>
In-Reply-To: <20060621174632.GP11245@skl-net.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.77__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22284>



On Wed, 21 Jun 2006, Andre Noll wrote:
>
> Fix grow_refs_hash()

Ouch. 

Actually, the alternate patch is the one I had intended to do but for some 
reasons didn't.

This one also removes two more lines than it adds, but it's obviously a 
bigger patch.

Junio, depending on which one you prefer, add the appropriate

	Acked-by: Linus Torvalds <torvalds@osdl.org>

(for Andre's one) or

	Signed-off-by: Linus Torvalds <torvalds@osdl.org>

if you take this one.

		Linus
---
 object-refs.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/object-refs.c b/object-refs.c
index a7d49c6..b1b8065 100644
--- a/object-refs.c
+++ b/object-refs.c
@@ -12,6 +12,18 @@ static unsigned int hash_obj(struct obje
 	return hash % n;
 }
 
+static void insert_ref_hash(struct object_refs *ref, struct object_refs **hash, unsigned int size)
+{
+	int j = hash_obj(ref->base, size);
+
+	while (hash[j]) {
+		j++;
+		if (j >= size)
+			j = 0;
+	}
+	hash[j] = ref;
+}
+
 static void grow_refs_hash(void)
 {
 	int i;
@@ -20,30 +32,16 @@ static void grow_refs_hash(void)
 
 	new_hash = calloc(new_hash_size, sizeof(struct object_refs *));
 	for (i = 0; i < refs_hash_size; i++) {
-		int j;
 		struct object_refs *ref = refs_hash[i];
 		if (!ref)
 			continue;
-		j = hash_obj(ref->base, new_hash_size);
-		new_hash[j] = ref;
+		insert_ref_hash(ref, new_hash, new_hash_size);
 	}
 	free(refs_hash);
 	refs_hash = new_hash;
 	refs_hash_size = new_hash_size;
 }
 
-static void insert_ref_hash(struct object_refs *ref)
-{
-	int j = hash_obj(ref->base, refs_hash_size);
-
-	while (refs_hash[j]) {
-		j++;
-		if (j >= refs_hash_size)
-			j = 0;
-	}
-	refs_hash[j] = ref;
-}
-
 static void add_object_refs(struct object *obj, struct object_refs *ref)
 {
 	int nr = nr_object_refs + 1;
@@ -51,7 +49,7 @@ static void add_object_refs(struct objec
 	if (nr > refs_hash_size * 2 / 3)
 		grow_refs_hash();
 	ref->base = obj;
-	insert_ref_hash(ref);
+	insert_ref_hash(ref, refs_hash, refs_hash_size);
 	nr_object_refs = nr;
 }
 
