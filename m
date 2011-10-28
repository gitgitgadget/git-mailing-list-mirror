From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] create_tmp_packfile(): a helper function
Date: Fri, 28 Oct 2011 16:54:09 -0700
Message-ID: <1319846051-462-3-git-send-email-gitster@pobox.com>
References: <1319846051-462-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 01:54:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJwFl-0002Xd-Qp
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 01:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933878Ab1J1XyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 19:54:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933872Ab1J1XyR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 19:54:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78A496ADD
	for <git@vger.kernel.org>; Fri, 28 Oct 2011 19:54:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=sNYq
	oI/L9Ew7GuoWIkAQVzAXvr0=; b=q6KrCH6NOj7EIDUE8MTIiZCRsouAW89zcaGA
	EGObcD1zcbOv85OOWuiRKaoXUT98BjBk+Ipon6sog2zbY8LwvknOppKgHZZwwzTw
	QOH5JeU2RWiedv4siH3YUJ2NV54tZlGiaMkFVzFaNiWiQED4NIdklPBvQglu9r4k
	N6ynGsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=EjtA8G
	+U6j0KAbHASjIREHbckJEHVnx0x4cJ9r/Fta7FDYcv0SYaUXOo3PqicIbQSIZiJ0
	OLOZqq3ndRWeoXI/11roBcCb3K8rueun07al3i8U6HOA0qKGSeIKjeBojWX1aifB
	teRWe2HnEb/U3k745aa5nbfu3aeHPmvGCsjiU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FDD96ADC
	for <git@vger.kernel.org>; Fri, 28 Oct 2011 19:54:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E1196ADB for
 <git@vger.kernel.org>; Fri, 28 Oct 2011 19:54:16 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.1.573.ga40d2
In-Reply-To: <1319846051-462-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 25285CA2-01C0-11E1-878B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184439>

Factor out a small logic out of the private write_pack_file() function
in builtin/pack-objects.c

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c |   12 +++---------
 pack-write.c           |   10 ++++++++++
 pack.h                 |    3 +++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6643c16..3258fa9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -584,16 +584,10 @@ static void write_pack_file(void)
 		unsigned char sha1[20];
 		char *pack_tmp_name = NULL;
 
-		if (pack_to_stdout) {
+		if (pack_to_stdout)
 			f = sha1fd_throughput(1, "<stdout>", progress_state);
-		} else {
-			char tmpname[PATH_MAX];
-			int fd;
-			fd = odb_mkstemp(tmpname, sizeof(tmpname),
-					 "pack/tmp_pack_XXXXXX");
-			pack_tmp_name = xstrdup(tmpname);
-			f = sha1fd(fd, pack_tmp_name);
-		}
+		else
+			f = create_tmp_packfile(&pack_tmp_name);
 
 		offset = write_pack_header(f, nr_remaining);
 		if (!offset)
diff --git a/pack-write.c b/pack-write.c
index 46f3f84..863cce8 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -328,3 +328,13 @@ int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned
 	*hdr = c;
 	return n;
 }
+
+struct sha1file *create_tmp_packfile(char **pack_tmp_name)
+{
+	char tmpname[PATH_MAX];
+	int fd;
+
+	fd = odb_mkstemp(tmpname, sizeof(tmpname), "pack/tmp_pack_XXXXXX");
+	*pack_tmp_name = xstrdup(tmpname);
+	return sha1fd(fd, *pack_tmp_name);
+}
diff --git a/pack.h b/pack.h
index d429d8a..0027ac6 100644
--- a/pack.h
+++ b/pack.h
@@ -84,4 +84,7 @@ extern int encode_in_pack_object_header(enum object_type, uintmax_t, unsigned ch
 #define PH_ERROR_PACK_SIGNATURE	(-2)
 #define PH_ERROR_PROTOCOL	(-3)
 extern int read_pack_header(int fd, struct pack_header *);
+
+extern struct sha1file *create_tmp_packfile(char **pack_tmp_name);
+
 #endif
-- 
1.7.7.1.573.ga40d2
