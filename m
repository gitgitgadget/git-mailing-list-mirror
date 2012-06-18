From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/9] sha1_name.c: teach get_short_sha1() a commit-only option
Date: Mon, 18 Jun 2012 15:05:38 -0700
Message-ID: <1340057139-8311-10-git-send-email-gitster@pobox.com>
References: <1340057139-8311-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 00:06:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgk5F-0000AS-V6
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab2FRWF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:05:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57499 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752982Ab2FRWF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:05:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6965F97FE
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uwlb
	505+fApkIlA8gkYltnPYfK4=; b=sFJzQdZEr/Bsu2MxehNyx1F3M2A/j+0x56c4
	rbkMc+gg/vYKptyXBO/X6BBV15ROhpACpVMvZdNCV4cuvePZ/LPmMa6rUsQu8Drj
	OG+eKeMIGkFM0BgWWw+6KPuE9Lay5wnfjxlmrGUGtpCGzsh7x1rX/1uY90y4dCoH
	BGHg99c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=pEpadx
	icGagaiR9KHWB2CXGUkX4/bcxY4nnUG6kvxpbyWShGpiI2mWBG/fnv0tZlju7u5B
	bC463SwbQ/Vlmf5O6caCz11yOlaXXni5Oihp99nsbdaxTYhBHjV6cZnhGyBgRNz4
	55ACY0Kxn33MCew9GRqKFZsnQH5TaMhnw9ws4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61E7597FD
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E75E597FC for
 <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.11
In-Reply-To: <1340057139-8311-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C7B24BCA-B991-11E1-986F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200167>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index df11ded..4a0fefd 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -170,14 +170,17 @@ static int find_short_packed_object(int len, const unsigned char *match,
 #define SHORT_NAME_AMBIGUOUS (-2)
 
 static int find_unique_short_object(int len, char *canonical,
-				    unsigned char *res, unsigned char *sha1)
+				    unsigned char *res, unsigned char *sha1,
+				    int commit_only)
 {
 	int has_unpacked, has_packed;
 	unsigned char unpacked_sha1[20], packed_sha1[20];
 
 	prepare_alt_odb();
-	has_unpacked = find_short_object_filename(len, canonical, unpacked_sha1, 0);
-	has_packed = find_short_packed_object(len, res, packed_sha1, 0);
+	has_unpacked = find_short_object_filename(len, canonical, unpacked_sha1,
+						  commit_only);
+	has_packed = find_short_packed_object(len, res, packed_sha1,
+					      commit_only);
 	if (!has_unpacked && !has_packed)
 		return SHORT_NAME_NOT_FOUND;
 	if (1 < has_unpacked || 1 < has_packed)
@@ -194,6 +197,7 @@ static int find_unique_short_object(int len, char *canonical,
 }
 
 #define GET_SHORT_QUIETLY 01
+#define GET_SHORT_COMMIT_ONLY 02
 
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  unsigned flags)
@@ -226,7 +230,8 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 		res[i >> 1] |= val;
 	}
 
-	status = find_unique_short_object(i, canonical, res, sha1);
+	status = find_unique_short_object(i, canonical, res, sha1,
+					  !!(flags & GET_SHORT_COMMIT_ONLY));
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS))
 		return error("short SHA1 %.*s is ambiguous.", len, canonical);
 	return status;
-- 
1.7.11
