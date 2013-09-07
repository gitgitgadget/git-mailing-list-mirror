From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v3] Document pack v4 format
Date: Sat, 07 Sep 2013 00:52:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309070043420.20709@syhkavp.arg>
References: <1377917393-28460-1-git-send-email-pclouds@gmail.com>
 <1378433643-15638-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Fv5ZyHbogjQOIhuNjP8Uzw)"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 06:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIAVX-0000Wg-Rz
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 06:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814Ab3IGEwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 00:52:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53536 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab3IGEwL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 00:52:11 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSQ001ANO6YJV70@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 07 Sep 2013 00:52:10 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 5D9F32DA0547; Sat, 07 Sep 2013 00:52:10 -0400 (EDT)
In-reply-to: <1378433643-15638-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234113>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Fv5ZyHbogjQOIhuNjP8Uzw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Fri, 6 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Should be up to date with Nico's latest implementation and also cover
>  additions to the format that everybody seems to agree on:
> 
>   - new types for canonical trees and commits
>   - sha-1 table covering missing objects in thin packs

Yes, I've tweaked the format again.  I've implemented the code needed to 
carry canonical commit and tree objects in pack v4.  And things are much 
simpler if the canonical commit and tree types are identical to pack v2.  
Therefore the new types are used for the pack v4 optimized commit and 
tree representations.

I've therefore added this patch to my tree (with the needed changes to 
the documentation patch):

commit 98d4b75aff266015b5dff0a324a2984c2a8f7fa2
Author: Nicolas Pitre <nico@fluxnic.net>
Date:   Fri Sep 6 23:45:49 2013 -0400

    pack v4: allow canonical commit and tree objects
    
    If for some reason we can't transcode a commit or tree object (lossy
    encoding such as the zero-padded file mode for example) then we can still
    store the canonical object like in pack v2.
    
    This is also useful for completing a thin pack without having to add
    missing entries to the dictionary tables.
    
    To simplify things, the canonical commit and tree types retain their type
    number 1 and 2 respectively, and the transcoded types are now 9 and 10
    i.e. with bit 3 added.
    
    Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

diff --git a/cache.h b/cache.h
index a6d016b..b68ad5a 100644
--- a/cache.h
+++ b/cache.h
@@ -330,6 +330,8 @@ enum object_type {
 	/* 5 for future expansion */
 	OBJ_OFS_DELTA = 6,
 	OBJ_REF_DELTA = 7,
+	OBJ_PV4_COMMIT = (8 + 1),
+	OBJ_PV4_TREE = (8 + 2),
 	OBJ_ANY,
 	OBJ_MAX
 };
diff --git a/packv4-create.c b/packv4-create.c
index 11cfe6f..38fa594 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -981,10 +981,15 @@ static off_t packv4_write_object(struct sha1file *f, struct packed_git *p,
 		die("unexpected object type %d", type);
 	}
 	free(src);
-	if (!result)
-		die("can't convert %s object %s",
-		    typename(type), sha1_to_hex(obj->sha1));
+	if (!result) {
+		warning("can't convert %s object %s",
+			typename(type), sha1_to_hex(obj->sha1));
+		/* fall back to copy the object in its original form */
+		return copy_object_data(f, p, obj->offset);
+	}
 
+	/* Use bit 3 to indicate a special type encoding */
+	type += 8;
 	hdrlen = write_object_header(f, type, obj_size);
 	sha1write(f, result, buf_size);
 	free(result);
diff --git a/packv4-parse.c b/packv4-parse.c
index 86ec535..63bba03 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -266,7 +266,7 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 			if (++scp - src >= avail - 20)
 				return -1;
 		/* let's still make sure this is actually a tree */
-		if ((*scp++ & 0xf) != OBJ_TREE)
+		if ((*scp++ & 0xf) != OBJ_PV4_TREE)
 			return -1;
 	}
 
diff --git a/sha1_file.c b/sha1_file.c
index 79e1293..c7bf677 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1806,6 +1806,11 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 	}
 
 	switch (type) {
+	case OBJ_PV4_COMMIT:
+	case OBJ_PV4_TREE:
+		/* hide pack v4 special object types */
+		type -= 8;
+		break;
 	case OBJ_BAD:
 	case OBJ_COMMIT:
 	case OBJ_TREE:
@@ -2171,17 +2176,16 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		if (data)
 			die("BUG in unpack_entry: left loop at a valid delta");
 		break;
+	case OBJ_PV4_COMMIT:
+		data = pv4_get_commit(p, &w_curs, curpos, size);
+		type -= 8;
+		break;
+	case OBJ_PV4_TREE:
+		data = pv4_get_tree(p, &w_curs, curpos, size);
+		type -= 8;
+		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
-		if (p->version >= 4 && !base_from_cache) {
-			if (type == OBJ_COMMIT) {
-				data = pv4_get_commit(p, &w_curs, curpos, size);
-			} else {
-				data = pv4_get_tree(p, &w_curs, curpos, size);
-			}
-			break;
-		}
-		/* fall through */
 	case OBJ_BLOB:
 	case OBJ_TAG:
 		if (!base_from_cache)


--Boundary_(ID_Fv5ZyHbogjQOIhuNjP8Uzw)--
