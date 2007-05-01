From: Dana How <danahow@gmail.com>
Subject: [PATCH] Create pack-write.c for common pack writing code
Date: Tue, 01 May 2007 11:26:30 -0700
Message-ID: <46378656.9080109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 20:28:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hix54-0008Oo-DE
	for gcvg-git@gmane.org; Tue, 01 May 2007 20:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031230AbXEAS1z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 14:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030998AbXEAS0n
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 14:26:43 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:38769 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031045AbXEAS0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 14:26:35 -0400
Received: by py-out-1112.google.com with SMTP id a29so1632173pyi
        for <git@vger.kernel.org>; Tue, 01 May 2007 11:26:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=jiGVDhbi00gWve87uhOA+hoHjauEHFP+rs0cvdCtbng0fl2hCE1lg5v2KTo6y7RIJA9es/T9U9X4DDeRKEWX+QsSnwOJFNUjDdMs5kqs0Dpgtwoh4OFKuOUcYdLFrxhZ9xTGO164rJb9NzPt8BDGdb92MtvBR4waF473zpyrlsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=jGP5qDxaNIVfFUXX3CjiwEwqseOGFFZ8Jp9o/qqIHtgyAUSoY2awjpX7uEFQOJQcQWd2VK5lgqLYs0Fdof3W2moiSNvypjpLSoXXodeNYTavM7CUe0gSKheKLqwp5NtlujGxs6CdYcAgeNPsywwikpdetS8u8ITtZPNRxXmt2nY=
Received: by 10.35.43.10 with SMTP id v10mr2575065pyj.1178043993588;
        Tue, 01 May 2007 11:26:33 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id n45sm11955938pyh.2007.05.01.11.26.31;
        Tue, 01 May 2007 11:26:32 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45966>


Include a generalized fixup_header_footer() in this new file.
Needed by git-repack --max-pack-size feature in a later patchset.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 Makefile      |    4 ++--
 fast-import.c |   39 ++-------------------------------------
 pack-write.c  |   38 ++++++++++++++++++++++++++++++++++++++
 pack.h        |    3 +++
 4 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/Makefile b/Makefile
index 2fea115..e0a1308 100644
--- a/Makefile
+++ b/Makefile
@@ -301,8 +301,8 @@ LIB_OBJS = \
 	interpolate.o \
 	lockfile.o \
 	patch-ids.o \
-	object.o pack-check.o patch-delta.o path.o pkt-line.o sideband.o \
-	reachable.o reflog-walk.o \
+	object.o pack-check.o pack-write.o patch-delta.o path.o pkt-line.o \
+	sideband.o reachable.o reflog-walk.o \
 	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
diff --git a/fast-import.c b/fast-import.c
index b4cbcd9..276e0e0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -651,42 +651,6 @@ static void start_packfile(void)
 	all_packs[pack_id] = p;
 }
 
-static void fixup_header_footer(void)
-{
-	static const int buf_sz = 128 * 1024;
-	int pack_fd = pack_data->pack_fd;
-	SHA_CTX c;
-	struct pack_header hdr;
-	char *buf;
-
-	if (lseek(pack_fd, 0, SEEK_SET) != 0)
-		die("Failed seeking to start: %s", strerror(errno));
-	if (read_in_full(pack_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
-		die("Unable to reread header of %s", pack_data->pack_name);
-	if (lseek(pack_fd, 0, SEEK_SET) != 0)
-		die("Failed seeking to start: %s", strerror(errno));
-	hdr.hdr_entries = htonl(object_count);
-	write_or_die(pack_fd, &hdr, sizeof(hdr));
-
-	SHA1_Init(&c);
-	SHA1_Update(&c, &hdr, sizeof(hdr));
-
-	buf = xmalloc(buf_sz);
-	for (;;) {
-		ssize_t n = xread(pack_fd, buf, buf_sz);
-		if (!n)
-			break;
-		if (n < 0)
-			die("Failed to checksum %s", pack_data->pack_name);
-		SHA1_Update(&c, buf, n);
-	}
-	free(buf);
-
-	SHA1_Final(pack_data->sha1, &c);
-	write_or_die(pack_fd, pack_data->sha1, sizeof(pack_data->sha1));
-	close(pack_fd);
-}
-
 static int oecmp (const void *a_, const void *b_)
 {
 	struct object_entry *a = *((struct object_entry**)a_);
@@ -802,7 +766,8 @@ static void end_packfile(void)
 		struct branch *b;
 		struct tag *t;
 
-		fixup_header_footer();
+		fixup_header_footer(pack_data->pack_fd, pack_data->sha1,
+				    pack_data->pack_name, object_count);
 		idx_name = keep_pack(create_index());
 
 		/* Register the packfile with core git's machinary. */
diff --git a/pack-write.c b/pack-write.c
new file mode 100644
index 0000000..e4c1408
--- /dev/null
+++ b/pack-write.c
@@ -0,0 +1,38 @@
+#include "cache.h"
+#include "pack.h"
+
+void fixup_header_footer(int pack_fd, unsigned char *pack_file_sha1,
+			 const char *pack_name, uint32_t object_count)
+{
+	static const int buf_sz = 128 * 1024;
+	SHA_CTX c;
+	struct pack_header hdr;
+	char *buf;
+
+	if (lseek(pack_fd, 0, SEEK_SET) != 0)
+		die("Failed seeking to start: %s", strerror(errno));
+	if (read_in_full(pack_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
+		die("Unable to reread header of %s", pack_name);
+	if (lseek(pack_fd, 0, SEEK_SET) != 0)
+		die("Failed seeking to start: %s", strerror(errno));
+	hdr.hdr_entries = htonl(object_count);
+	write_or_die(pack_fd, &hdr, sizeof(hdr));
+
+	SHA1_Init(&c);
+	SHA1_Update(&c, &hdr, sizeof(hdr));
+
+	buf = xmalloc(buf_sz);
+	for (;;) {
+		size_t n = xread(pack_fd, buf, buf_sz);
+		if (!n)
+			break;
+		if (n < 0)
+			die("Failed to checksum %s", pack_name);
+		SHA1_Update(&c, buf, n);
+	}
+	free(buf);
+
+	SHA1_Final(pack_file_sha1, &c);
+	write_or_die(pack_fd, pack_file_sha1, 20);
+	close(pack_fd);
+}
diff --git a/pack.h b/pack.h
index d4d412c..dc296cc 100644
--- a/pack.h
+++ b/pack.h
@@ -45,6 +45,9 @@ struct pack_idx_header {
 
 extern int verify_pack(struct packed_git *, int);
 
+void fixup_header_footer(int pack_fd, unsigned char *pack_file_sha1,
+			 const char *pack_name, uint32_t object_count);
+
 #define PH_ERROR_EOF		(-1)
 #define PH_ERROR_PACK_SIGNATURE	(-2)
 #define PH_ERROR_PROTOCOL	(-3)
-- 
1.5.2.rc0.789.gd951
