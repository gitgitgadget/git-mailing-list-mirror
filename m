From: Dana How <danahow@gmail.com>
Subject: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Mon, 30 Apr 2007 16:21:15 -0700
Message-ID: <463679EB.2010301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 01:22:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HifCK-0002l8-10
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946884AbXD3XVW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946886AbXD3XVV
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:21:21 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:41092 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946883AbXD3XVS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:21:18 -0400
Received: by py-out-1112.google.com with SMTP id a29so1463060pyi
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 16:21:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=AM/B10vbekRJvd5Qn87a1Sd5IrtcvxaTQ7WiVN5cZA//XjyoeegvUx+d8IzrcCG4dD8kgPQn9tiaTfPyreuDMC/lf3JC+mtiHuwhyHCEah/KpRk5lsavdKZt5mwCz8HGaschXBSG/wZyFkKVc2NfM7b9k7xP82D2b5sWCxt++to=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=f7w6UiErXLJFthi2+HJ81YRYVWJLGtUFIXhTdNDS9fr8BaA1AlAi15U4JrWRxa19D3opkP7ASIMNtyz5uZuoei9k/R0+h2qmIZj7S8CizShRYhzaRa7AIPfFRGr409rZUwjJrF/PstWU7I8pTEse4bxe2y1v8FvYbKojbZhjeWE=
Received: by 10.35.91.10 with SMTP id t10mr12186859pyl.1177975277752;
        Mon, 30 Apr 2007 16:21:17 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 38sm7909775nzf.2007.04.30.16.21.16;
        Mon, 30 Apr 2007 16:21:17 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45895>


Add our own version of the one in fast-import.c here.
Needed later to correct bad object count in header for split pack.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index bc45ca6..98066bf 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -562,6 +562,42 @@ static off_t write_one(struct sha1file *f,
 	return offset + size;
 }
 
+static void fixup_header_footer(int pack_fd, unsigned char *pack_file_sha1,
+				char *pack_name, uint32_t object_count)
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
+
 /* forward declarations for write_pack_file */
 static void write_index_file(off_t last_obj_offset, unsigned char *sha1);
 static int adjust_perm(const char *path, mode_t mode);
-- 
1.5.2.rc0.766.gba60-dirty
