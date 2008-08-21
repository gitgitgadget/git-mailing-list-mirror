From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] sha1_object_info(): pay attention to cached objects
Date: Thu, 21 Aug 2008 01:43:09 -0700
Message-ID: <7vej4ikbc2.fsf_-_@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7viqtukbec.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 10:44:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW5mG-0000bi-8t
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 10:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbYHUInQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 04:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbYHUInQ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 04:43:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60603 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbYHUInP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 04:43:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BD39B59429;
	Thu, 21 Aug 2008 04:43:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BD25459428; Thu, 21 Aug 2008 04:43:11 -0400 (EDT)
In-Reply-To: <7viqtukbec.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Aug 2008 01:41:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31B5D79A-6F5D-11DD-8B24-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93121>

We have some hardcoded objects (e.g. "empty tree") and also an interface
to pretend we have objects in-core without ever writing them out to the
disk.  read_sha1_file() are aware of these cached objects.  However,
some codepaths use sha1_object_info() to find out the availability and
size of the object without reading the object data, without using
read_sha1_file().

This teaches sha1_object_info() about these cached objects.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 2aff59b..d9e342e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1926,10 +1926,25 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 	return status;
 }
 
+struct cached_object {
+	unsigned char sha1[20];
+	enum object_type type;
+	void *buf;
+	unsigned long size;
+};
+static struct cached_object *find_cached_object(const unsigned char *sha1);
+
 int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 {
 	struct pack_entry e;
 	int status;
+	struct cached_object *co;
+
+	co = find_cached_object(sha1);
+	if (co) {
+		*sizep = co->size;
+		return co->type;
+	}
 
 	if (!find_pack_entry(sha1, &e, NULL)) {
 		/* Most likely it's a loose object. */
@@ -1975,12 +1990,7 @@ static void *read_packed_sha1(const unsigned char *sha1,
  * to write them into the object store (e.g. a browse-only
  * application).
  */
-static struct cached_object {
-	unsigned char sha1[20];
-	enum object_type type;
-	void *buf;
-	unsigned long size;
-} *cached_objects;
+static struct cached_object *cached_objects;
 static int cached_object_nr, cached_object_alloc;
 
 static struct cached_object empty_tree = {
-- 
1.6.0.51.g078ae
