From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/11] streaming_write_entry(): support files with holes
Date: Sun, 15 May 2011 17:30:28 -0700
Message-ID: <1305505831-31587-9-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:31:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLliU-0004Hp-Mp
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 02:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847Ab1EPAay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 20:30:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab1EPAaw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 20:30:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3FCB55F90
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=sxdm
	avvvVT87M4gxeph32woku0o=; b=JUiWhY5xOdnH/Q6ZDQnN0JN8fVOUfpM25ktg
	7V4oKOJV9PSiPbRMxtOKY63g00yVCLZGJicrto3fyQzHRk2R6fpBTXoGtEG2i68p
	G6vTVH0EfnLxb3aV2U8ZfJO4fnXnmPKnH6xkLpgIDKmHnzdJMr1StfbS9T0MIJ2p
	JUlN8U8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=owVqQI
	0qd0Sh1b/iqTUAV3y1thW6AW257efovdHxEjhezEFjqtBQjjvCb+eVITd/E4Jtow
	+NcHkEyt4fv+wEN2mIaluLcDge9ZIhjtFNxVq2zIY1155Ec4wLLcB69VVukr7YB8
	MRoyScGhTOSHROp1Mq4aP9IVoRSVXKjndWZug=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C85B5F8E
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A3E4A5F8D for
 <git@vger.kernel.org>; Sun, 15 May 2011 20:32:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.365.g32b65
In-Reply-To: <1305505831-31587-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0CE717E4-7F54-11E0-B451-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173691>

One typical use of a large binary file is to hold a sparse on-disk hash
table with a lot of holes. Help preserving the holes with lseek().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 entry.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/entry.c b/entry.c
index 7733a6b..d50e388 100644
--- a/entry.c
+++ b/entry.c
@@ -123,6 +123,7 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
 	enum object_type type;
 	unsigned long sz;
 	int result = -1;
+	ssize_t kept = 0;
 	int fd = -1;
 
 	st = open_istream(ce->sha1, &type, &sz);
@@ -137,17 +138,32 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
 
 	for (;;) {
 		char buf[10240];
-		ssize_t wrote;
+		ssize_t wrote, holeto;
 		ssize_t readlen = read_istream(st, buf, sizeof(buf));
 
 		if (!readlen)
 			break;
+		for (holeto = 0; holeto < readlen; holeto++)
+			if (buf[holeto])
+				break;
+		if (readlen == holeto) {
+			kept += holeto;
+			continue;
+		}
 
+		if (kept && lseek(fd, kept, SEEK_CUR) == (off_t) -1)
+			goto close_and_exit;
+		else
+			kept = 0;
 		wrote = write_in_full(fd, buf, readlen);
 
 		if (wrote != readlen)
 			goto close_and_exit;
 	}
+	if (kept &&
+	    ((  lseek(fd, kept - 1, SEEK_CUR) == (off_t) -1)
+	     || write(fd, "", 1) != 1))
+		goto close_and_exit;
 	*fstat_done = fstat_output(fd, state, statbuf);
 
 close_and_exit:
-- 
1.7.5.1.365.g32b65
