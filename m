From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/12] streaming_write_entry(): support files with holes
Date: Fri, 20 May 2011 23:56:32 -0700
Message-ID: <1305960995-25738-10-git-send-email-gitster@pobox.com>
References: <1305960995-25738-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:57:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg8F-0006ID-EQ
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396Ab1EUG5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:57:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab1EUG5r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:57:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 14D7B5DCD
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=wyHh
	fZDDlQF+SI5uGrTILs1LqbY=; b=dZMEWB689Qk+Ey8fDnIZJl68oZVjVlQE5thh
	X+MJUbZS2f6ircVQjt/ghNxz2Hujasweq1SSwgZ0lXSp9/DPX24eVLpyaaUX1uCw
	TZuQtCjjVhpq+4HCfJzkiAKwlAk8aajzKg8nQHhC5D1Se/jbb/FXgmIAlk5+KtYH
	qJER6Jc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=u++x2Y
	ZfpjYpxnNNlawOZp7BnzO+m/ZdfuYVZSvOoFoIhplco+bUlABrWG0WI4X7zx1l6u
	KggKIQsIQg6xZg7eLGCRoA03GxIwoCBbIVQxXdtX8hS2LVVkGpNO8LEEM+glN0Zj
	6MtAchmQGrj5TBW8fzOncfqjzy++Mm9PF+N9E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 102065DCC
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 611425DCB for
 <git@vger.kernel.org>; Sat, 21 May 2011 02:59:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305960995-25738-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EE159A3E-8377-11E0-ADB3-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174102>

One typical use of a large binary file is to hold a sparse on-disk hash
table with a lot of holes. Help preserving the holes with lseek().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 entry.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index da37d01..e2dc16c 100644
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
1.7.5.2.369.g8fc017
