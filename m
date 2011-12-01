From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/5] create_tmp_packfile(): a helper function
Date: Wed, 30 Nov 2011 16:27:40 -0800
Message-ID: <1322699263-14475-3-git-send-email-gitster@pobox.com>
References: <1322699263-14475-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 01:28:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVuVW-0003xt-8C
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 01:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab1LAA1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 19:27:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64883 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab1LAA1t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 19:27:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D96E5D85
	for <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=gxHg
	pgkvx17A2i62QdZF4Eacpps=; b=mUQrk4LY6q8izptpM11FUceRwfUJVo3xMynA
	hl0GMnjuSmEnnCHuSZHnFwkah7n3w++32ds7zJgZ2tBqwGcATKkD5Py2dBTXhUzo
	1c8h5ww36iclkedEk9Df76cQvyojm6omVi9TKQCRkDYBH2u0Z63kQDeOE8HGSRW4
	dNbuzoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=rAQqRZ
	RJta+KfYPwFJqCflpTmVR+jselj0YP6QBU4+bWMF28LH2dnVZcQp56c+uCi4y1/g
	sZEczCvY7aIMjIdQeUmhV99QRkHUBKQJ9NTZmetaED/T5zZq/JMYza5+G6UdE/so
	/Nitfa9cwFtMCXnwTEvZM0g00fF55NIL6R43w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56CE45D84
	for <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C99775D83 for
 <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:48 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.177.g4d64
In-Reply-To: <1322699263-14475-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4C2418B6-1BB3-11E1-9A08-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186149>

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
1.7.8.rc4.177.g4d64
