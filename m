From: Dana How <danahow@gmail.com>
Subject: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Sun, 08 Apr 2007 16:22:56 -0700
Message-ID: <46197950.3080804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 01:23:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hagit-0007VY-Si
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 01:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbXDHXXA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 19:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbXDHXW7
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 19:22:59 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:65141 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbXDHXW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 19:22:59 -0400
Received: by py-out-1112.google.com with SMTP id a29so897012pyi
        for <git@vger.kernel.org>; Sun, 08 Apr 2007 16:22:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=By6fV+JRoF0oLvDzlVAH3t/pH2nEjljwyTV4IHjjPzOWmQMo6wDlCD6KfJCqJxaGrJv7Fxk9R9H8l7fndyLhz+lai/8IRwxnzxS2wpGM1nrq2tG/T6+KSUCds/fhvCcoWs1YQ6pJOPua71GE5E6Gvd8lBd8nh0geapOS1RCpglo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Z9zAtbH15cc6OXR/rYPg7QK+DxhQpmoNdFBT637ws8NuSigc35gY/bucdgdxajXwsPg7cxnW7ruOCnRh16raNOsxbFm7JGyMjxcffeL/VZTNHu6GeF9gRM/+a002pewwbo1gnHVaLSJtFwDq5gyursxIsow+vKqLyyc8zBzSxws=
Received: by 10.65.59.11 with SMTP id m11mr10468252qbk.1176074578452;
        Sun, 08 Apr 2007 16:22:58 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 37sm8768103nzf.2007.04.08.16.22.57;
        Sun, 08 Apr 2007 16:22:57 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44014>


Add our own version of the one in fast-import.c here.
Will need this later to correct an incorrect object
count in the pack header.

Signed-off-by: Dana How <how@deathvalley.cswitch.com>
---
 builtin-pack-objects.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 8415549..7ab0712 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -518,6 +518,46 @@ static off_t write_one(struct sha1file *f,
 	return offset + write_object(f, e);
 }
 
+/*
+ * Move this, the version in fast-import.c,
+ * and index_pack.c:readjust_pack_header_and_sha1 into sha1_file.c ?
+ */
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
 typedef int (*entry_sort_t)(const struct object_entry *, const struct object_entry *);
 
 static entry_sort_t current_sort;
-- 
1.5.1.89.g8abf0
