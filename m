From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/9] read-cache.c: move code to copy incore to ondisk cache
 to a helper function
Date: Tue,  3 Apr 2012 15:53:14 -0700
Message-ID: <1333493596-14202-8-git-send-email-gitster@pobox.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 00:53:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCbh-0006ve-BN
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830Ab2DCWxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:53:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755825Ab2DCWxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:53:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2878D7F88
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dwnl
	LamXgRex1sHyHMICrziX8OA=; b=nTfcmelketoIYpZHs5dJoRAKUW/qAsT23wdV
	8gt1jT6reyxqZ+V2v5xqsdVa/Paj58NHvUbOg9CfrcqZzDP3JgTikLMUPusc+W4f
	DZSqTrA0hGUimjfmj7q7bDTcWnUbFekCXfBo5GBKPUyaTq3sbfjIxWZIeTx6iyYY
	FPB+4+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=G2zYp9
	LS/40v2fcp9cAGV1T9ktw9/L79W+Y0IQDbfNCcPXp6McERdlFjkj6OEr2K9OiJTO
	fAbdbjnaMsU+1YWKYu4xmOpgAGU15kuNKMjzB6wacAIOoqdlxDo6v/2uwTpVwQWZ
	QRFzcbk0T3y7dh8j82QeKPnJ0ss/bWf8H1tyU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 181567F87
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 864657F82 for
 <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:30 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc4.54.g1d5dd3
In-Reply-To: <1333493596-14202-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D52E84C8-7DDF-11E1-BDB2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194668>

This makes the change in a later patch look less scary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 82711c2..c159351 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1605,13 +1605,10 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 	}
 }
 
-static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
+/* Copy miscellaneous fields but not the name */
+static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
+				       struct cache_entry *ce)
 {
-	int size = ondisk_ce_size(ce);
-	struct ondisk_cache_entry *ondisk = xcalloc(1, size);
-	char *name;
-	int result;
-
 	ondisk->ctime.sec = htonl(ce->ce_ctime.sec);
 	ondisk->mtime.sec = htonl(ce->ce_mtime.sec);
 	ondisk->ctime.nsec = htonl(ce->ce_ctime.nsec);
@@ -1628,10 +1625,21 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
 		struct ondisk_cache_entry_extended *ondisk2;
 		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
 		ondisk2->flags2 = htons((ce->ce_flags & CE_EXTENDED_FLAGS) >> 16);
-		name = ondisk2->name;
+		return ondisk2->name;
 	}
-	else
-		name = ondisk->name;
+	else {
+		return ondisk->name;
+	}
+}
+
+static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
+{
+	int size = ondisk_ce_size(ce);
+	struct ondisk_cache_entry *ondisk = xcalloc(1, size);
+	char *name;
+	int result;
+
+	name = copy_cache_entry_to_ondisk(ondisk, ce);
 	memcpy(name, ce->name, ce_namelen(ce));
 
 	result = ce_write(c, fd, ondisk, size);
-- 
1.7.10.rc4.54.g1d5dd3
