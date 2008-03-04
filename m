From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] fsck.c: fix bogus "empty tree" check
Date: Tue, 4 Mar 2008 22:48:01 +0100
Message-ID: <20080304214801.GA5595@auto.tuwien.ac.at>
References: <7vbq5u91lf.fsf@gitster.siamese.dyndns.org> <20080304152635.40451f7c.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Tue Mar 04 22:48:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWf0F-00021p-1D
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 22:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763495AbYCDVsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 16:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762950AbYCDVsE
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 16:48:04 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55745 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762760AbYCDVsD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 16:48:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id AA5D16A63A78;
	Tue,  4 Mar 2008 22:48:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X+l5p6dBOb28; Tue,  4 Mar 2008 22:48:01 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 8DE27680BF73; Tue,  4 Mar 2008 22:48:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080304152635.40451f7c.vsu@altlinux.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76142>

On Tue, Mar 04, 2008 at 03:26:35PM +0300, Sergey Vlasov wrote:
> On Tue, 04 Mar 2008 03:21:16 -0800 Junio C Hamano wrote:
> The simplest way to fix this would be to duplicate the added_object()
> call in all branches; invoking hash_sha1_file() unconditionally will
> work too, but may be wasteful if we need to call write_sha1_file()
> afterwards.

This is only a part of the problem. Moving added_object only makes
forward reference for deltas work.

unpack_delta_entry checks for OBJ_REF_DELTA, if there is a sha1 file.
This must not be true, if --strict is passed. It needs to check the
cache too.

>From 843d84fa52ff546bf88f135522e5739070d712aa Mon Sep 17 00:00:00 2001
From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Tue, 4 Mar 2008 22:38:21 +0100
Subject: [PATCH] unpack-objects: fix delta handling

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-unpack-objects.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 1845abc..c0d3c9a 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -206,16 +206,17 @@ static void added_object(unsigned nr, enum object_type type,
 static void write_object(unsigned nr, enum object_type type,
 			 void *buf, unsigned long size)
 {
-	added_object(nr, type, buf, size);
 	if (!strict) {
 		if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
 			die("failed to write object");
+		added_object(nr, type, buf, size);
 		free(buf);
 		obj_list[nr].obj = 0;
 	} else if (type == OBJ_BLOB) {
 		struct blob *blob;
 		if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
 			die("failed to write object");
+		added_object(nr, type, buf, size);
 		free(buf);
 
 		blob = lookup_blob(obj_list[nr].sha1);
@@ -228,6 +229,7 @@ static void write_object(unsigned nr, enum object_type type,
 		struct object *obj;
 		int eaten;
 		hash_sha1_file(buf, size, typename(type), obj_list[nr].sha1);
+		added_object(nr, type, buf, size);
 		obj = parse_object_buffer(obj_list[nr].sha1, type, size, buf, &eaten);
 		if (!obj)
 			die("invalid %s", typename(type));
@@ -301,7 +303,10 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			free(delta_data);
 			return;
 		}
-		if (!has_sha1_file(base_sha1)) {
+		obj = lookup_object(base_sha1);
+		if (obj && lookup_object_buffer(obj))
+			;
+		else if (!has_sha1_file(base_sha1)) {
 			hashcpy(obj_list[nr].sha1, null_sha1);
 			add_delta_to_list(nr, base_sha1, 0, delta_data, delta_size);
 			return;
-- 
1.5.4.GIT


