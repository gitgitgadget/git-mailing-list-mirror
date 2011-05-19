From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/11] streaming_write_entry(): support files with holes
Date: Thu, 19 May 2011 14:33:43 -0700
Message-ID: <1305840826-7783-9-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAsH-00074u-5H
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934871Ab1ESVfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:35:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33629 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934849Ab1ESVeI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:34:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BEE4252BA
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=x1v9
	sB6hi48DkJVxmuUGV6zuYIg=; b=uXaZxJa/1SKvGRMCC2sLZ3WgrZzbvwB+d1DZ
	TRtaunaaHoidqjrVZt4F8Wb7aLWcNP1feJtMeV12ADpENmRk3A4N8RZv6QfWxh0g
	pvZMqK1FnJthog+7Lacg7iKcKsRVJ5LGNuu0zBFSA5rspOCiVNgpKW7+nu97tuWx
	XbmnYE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=FZvCnP
	7jTzJOyZHgTP/biDwQgquVVCY5+qe8Z3joSEgHhPpGj+pp8URzLOA7bqfjaHKSxO
	IbYpCQHhwwE5UwJu/usj/BqDymU2Ur/DKLtalUco2ptsRWkVi2yx3svChbRySF3F
	9s/hOx6iqDO8MA44lZ7Kai3p8YUrqU9wZfgV0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC6DB52B9
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 32CD152B7 for
 <git@vger.kernel.org>; Thu, 19 May 2011 17:36:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.416.gac10c8
In-Reply-To: <1305840826-7783-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0665931E-8260-11E0-A4B9-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174022>

One typical use of a large binary file is to hold a sparse on-disk hash
table with a lot of holes. Help preserving the holes with lseek().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 entry.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 7733a6b..f751c60 100644
--- a/entry.c
+++ b/entry.c
@@ -123,6 +123,7 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
 	enum object_type type;
 	unsigned long sz;
 	int result = -1;
+	ssize_t kept = 0;
 	int fd = -1;
 
 	st = open_istream(ce->sha1, &type, &sz);
@@ -136,18 +137,34 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
 		goto close_and_exit;
 
 	for (;;) {
-		char buf[10240];
-		ssize_t wrote;
+		char buf[1024 * 16];
+		ssize_t wrote, holeto;
 		ssize_t readlen = read_istream(st, buf, sizeof(buf));
 
 		if (!readlen)
 			break;
+		if (sizeof(buf) == readlen) {
+			for (holeto = 0; holeto < readlen; holeto++)
+				if (buf[holeto])
+					break;
+			if (readlen == holeto) {
+				kept += holeto;
+				continue;
+			}
+		}
 
+		if (kept && lseek(fd, kept, SEEK_CUR) == (off_t) -1)
+			goto close_and_exit;
+		else
+			kept = 0;
 		wrote = write_in_full(fd, buf, readlen);
 
 		if (wrote != readlen)
 			goto close_and_exit;
 	}
+	if (kept && (lseek(fd, kept - 1, SEEK_CUR) == (off_t) -1 ||
+		     write(fd, "", 1) != 1))
+		goto close_and_exit;
 	*fstat_done = fstat_output(fd, state, statbuf);
 
 close_and_exit:
-- 
1.7.5.1.416.gac10c8
