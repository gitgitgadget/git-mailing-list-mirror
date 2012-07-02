From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 11/18] sha1_name.c: teach get_short_sha1() a commit-only
 option
Date: Mon,  2 Jul 2012 15:34:02 -0700
Message-ID: <1341268449-27801-12-git-send-email-gitster@pobox.com>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 00:35:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlpDZ-0004Xx-49
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 00:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933155Ab2GBWe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 18:34:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756335Ab2GBWee (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 18:34:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07D99908B
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=yvUS
	d8ImXC/1Rfu2NmOvnpc5kwY=; b=uukBcBZ3NV7+2vO7xTH8BoKi46jO5xNhh1Wy
	9KjdoHY39XtOhNmv6c/UNJSylMp8d0Y45mWgErm4Pi2sreUpO0QHQC2lTcSIRqzD
	9zGA1xhL57ADe8DMVU7mYKZp5D0FHsICzKYualwG9vjrvVXWf7bzbAR08jB7mGTe
	/0egj0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=GuBXDh
	tEMGc5Uy1G5K5t0qohgrhmmPaIml4hmn1pSkvZnb14nTimu/RtSaKMrL20TyzL3L
	2mIoSi1Zu/Vzl/ZdKHM1itAxirflUqF1DPPmamwwA0NVnM897aKFW22P7ZbQuj1M
	93ALrAhrGSm15cyTqAaSn7Q7GzvdQV9vmhHCk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC56F908A
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DE569089 for
 <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.212.g52fe12e
In-Reply-To: <1341268449-27801-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 18A249C2-C496-11E1-9967-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200881>

When the caller knows that the parameter is meant to name a commit,
e.g. "56789a" in describe name "v1.2.3-4-g56789a", pass that as a
hint so that lower level can use it to disambiguate objects when
there is only one commit whose name begins with 56789a even if there
are objects of other types whose names share the same prefix.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     | 1 +
 sha1_name.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/cache.h b/cache.h
index fd5b7f6..29f0b2a 100644
--- a/cache.h
+++ b/cache.h
@@ -812,6 +812,7 @@ struct object_context {
 };
 
 #define GET_SHA1_QUIETLY 01
+#define GET_SHA1_COMMIT 02
 
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern void die_on_misspelt_object_name(const char *name, const char *prefix);
diff --git a/sha1_name.c b/sha1_name.c
index 01cce9f..be15d94 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -218,6 +218,12 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 	return 0;
 }
 
+static int disambiguate_commit_only(const unsigned char *sha1, void *cb_data_unused)
+{
+	int kind = sha1_object_info(sha1, NULL);
+	return kind == OBJ_COMMIT;
+}
+
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  unsigned flags)
 {
@@ -253,6 +259,9 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	prepare_alt_odb();
 
 	memset(&ds, 0, sizeof(ds));
+	if (flags & GET_SHA1_COMMIT)
+		ds.fn = disambiguate_commit_only;
+
 	find_short_object_filename(len, hex_pfx, &ds);
 	find_short_packed_object(len, bin_pfx, &ds);
 	status = finish_object_disambiguation(&ds, sha1);
-- 
1.7.11.1.212.g52fe12e
