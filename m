From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] lookup_object: remove hashtable_index() and optimize hash_obj()
Date: Tue, 10 Sep 2013 18:17:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309101811510.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 00:17:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJWFJ-0003zg-5r
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 00:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250Ab3IJWRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 18:17:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44263 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab3IJWRM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 18:17:12 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSX00IUNKKO4600@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Sep 2013 18:17:12 -0400 (EDT)
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234491>


hashtable_index() appears to be a close duplicate of hash_obj().
Keep only the later and make it usable for all cases.

Also remove the modulus as this is an expansive operation.
The size argument is always a power of 2 anyway, so a simple
mask operation provides the same result.

On a 'git rev-list --all --objects' run this decreased the time spent
in lookup_object from 27.5% to 24.1%.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

I discovered this patch in my git work tree dating from 2 years ago.

diff --git a/object.c b/object.c
index d8a4b1f..e2dae22 100644
--- a/object.c
+++ b/object.c
@@ -43,16 +43,16 @@ int type_from_string(const char *str)
 	die("invalid object type \"%s\"", str);
 }
 
-static unsigned int hash_obj(struct object *obj, unsigned int n)
+static unsigned int hash_obj(const unsigned char *sha1, unsigned int n)
 {
 	unsigned int hash;
-	memcpy(&hash, obj->sha1, sizeof(unsigned int));
-	return hash % n;
+	memcpy(&hash, sha1, sizeof(unsigned int));
+	return hash & (n - 1);
 }
 
 static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
 {
-	unsigned int j = hash_obj(obj, size);
+	unsigned int j = hash_obj(obj->sha1, size);
 
 	while (hash[j]) {
 		j++;
@@ -62,13 +62,6 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
 	hash[j] = obj;
 }
 
-static unsigned int hashtable_index(const unsigned char *sha1)
-{
-	unsigned int i;
-	memcpy(&i, sha1, sizeof(unsigned int));
-	return i % obj_hash_size;
-}
-
 struct object *lookup_object(const unsigned char *sha1)
 {
 	unsigned int i, first;
@@ -77,7 +70,7 @@ struct object *lookup_object(const unsigned char *sha1)
 	if (!obj_hash)
 		return NULL;
 
-	first = i = hashtable_index(sha1);
+	first = i = hash_obj(sha1, obj_hash_size);
 	while ((obj = obj_hash[i]) != NULL) {
 		if (!hashcmp(sha1, obj->sha1))
 			break;
