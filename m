From: Dana How <danahow@gmail.com>
Subject: [PATCH 1/8] git-repack --max-pack-size: Add new file statics and
 struct fields
Date: Sun, 08 Apr 2007 16:19:33 -0700
Message-ID: <46197885.3060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 01:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hagfb-0006o4-Lr
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 01:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbXDHXTh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 19:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbXDHXTh
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 19:19:37 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:62867 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbXDHXTg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 19:19:36 -0400
Received: by py-out-1112.google.com with SMTP id a29so896592pyi
        for <git@vger.kernel.org>; Sun, 08 Apr 2007 16:19:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=dYxHa9rHZJ8kjsUtSmi0Mn3DZyaIEfc6v9zIPQ+8U9tXJWLi7piAlNAriez77eWBkyaMume2If+CIPEED0UMZV6lnbK/56YFUvNGa57saiXJj5YbTgSRHDaGgywDYckpQDggw5WzEAk8xeBqPhhDeKu3QRabUJp3FtVhwx2rHPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=SxTxAdPbgLfMDJWvqi8kzBuWyBb84imG0WaCZymcvsCQ2BfFV/V81+hXuXjwZomngn5lLHufJhmMG3R4ogq9qhaPUuwGlPWjtk1SUaGBjLVYhgKBt2iHdbecA7sUGcRmDcam1yc/1jK1yLp4kKWqLe9IHbbDHYWabrL7L9J0I5U=
Received: by 10.65.242.10 with SMTP id u10mr10478563qbr.1176074375624;
        Sun, 08 Apr 2007 16:19:35 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 38sm8760078nzf.2007.04.08.16.19.34;
        Sun, 08 Apr 2007 16:19:34 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44010>


This adds "offset_limit", which will contain the limit
specified by --max-pack-size, "written_list", the actual
list of objects written to the current pack, and "nr_written",
the number of objects in written_list.  "prev_pack" is
added to struct object_entry to indicate when an object
has already been written but to a previous pack.  The fields
in object_entry are re-arranged & shrunk to save memory.

Signed-off-by: Dana How <how@deathvalley.cswitch.com>
---
 builtin-pack-objects.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 45ac3e4..64318b3 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -21,18 +21,15 @@ git-pack-objects [{ -q | --progress | --all-progress }] \n\
 	[<ref-list | <object-list]";
 
 struct object_entry {
-	unsigned char sha1[20];
 	unsigned long size;	/* uncompressed size */
+	unsigned long delta_size;	/* delta data size (uncompressed) */
+#define in_pack_header_size delta_size	/* only when reusing pack data */
 	off_t offset;	/* offset into the final pack file;
 				 * nonzero if already written.
 				 */
-	unsigned int depth;	/* delta depth */
-	unsigned int delta_limit;	/* base adjustment for in-pack delta */
 	unsigned int hash;	/* name hint hash */
-	enum object_type type;
-	enum object_type in_pack_type;	/* could be delta */
-	unsigned long delta_size;	/* delta data size (uncompressed) */
-#define in_pack_header_size delta_size	/* only when reusing pack data */
+	unsigned short depth;	/* delta depth */
+	unsigned short delta_limit;	/* base adjustment for in-pack delta */
 	struct object_entry *delta;	/* delta base object */
 	struct packed_git *in_pack; 	/* already in pack */
 	off_t in_pack_offset;
@@ -40,10 +37,14 @@ struct object_entry {
 	struct object_entry *delta_sibling; /* other deltified objects who
 					     * uses the same base as me
 					     */
-	int preferred_base;	/* we do not pack this, but is encouraged to
+	enum object_type type;
+	enum object_type in_pack_type;	/* could be delta */
+	char preferred_base;	/* we do not pack this, but is encouraged to
 				 * be used as the base objectto delta huge
 				 * objects against.
 				 */
+	char prev_pack;		/* written to previous pack? */
+	unsigned char sha1[20];
 };
 
 /*
@@ -66,9 +67,11 @@ static int local;
 static int incremental;
 static int allow_ofs_delta;
 
+static struct object_entry **written_list;
 static struct object_entry **sorted_by_sha, **sorted_by_type;
 static struct object_entry *objects;
-static uint32_t nr_objects, nr_alloc, nr_result;
+static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
+static uint32_t offset_limit;
 static const char *base_name;
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
-- 
1.5.1.89.g8abf0
