From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] fetch-pack: objects in our alternates are available to
 us
Date: Fri, 11 Mar 2011 12:51:11 -0800
Message-ID: <1299876671-12838-2-git-send-email-gitster@pobox.com>
References: <1299876671-12838-1-git-send-email-gitster@pobox.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 21:51:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py9J0-0005T6-91
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 21:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444Ab1CKUvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 15:51:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab1CKUvU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 15:51:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D75F4023;
	Fri, 11 Mar 2011 15:52:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Cza4
	pl2xLgY/6hVdFKkvdCilfSM=; b=lCwMpefDLxKeLz/6SeVeeGtYhEmSBII5fcYw
	TT6MsNXb0U5eQoGf8n1CsH1u8EYtrJP5ZmIEnoKCzIHM1EEjv74xvzR7/1MYEh/v
	Xh1Ke4bo47iPWRt5zPvkuzTKhhHn3MrfRFR2Q1mpJi1FOHVss+Ee0vjFxn57OQLH
	PJpaeEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	thsMMw4LFimrZwbI7QGTKmkF5OsY8c7g5XHn12nGkAVfk6x9bG8KhY2LQ1jwpxqR
	AG4rH2o5g1AsbRlJEYI/jpbOtpZCXE0LVey6o6jK+eZmQ3QTPcuDrcKZ65NHbPXl
	ZLHrQfoLdYP5fXjb1rvefyaqZlKo/PkjndOWrKpfzUo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1BAEF4022;
	Fri, 11 Mar 2011 15:52:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 53DE14020; Fri, 11 Mar 2011
 15:52:46 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.404.g62d316
In-Reply-To: <1299876671-12838-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 859AF9B4-4C21-11E0-AC90-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168927>

Use the helper function split from receiving end of "git push" to allow
the same optimization on the receiving end of "git fetch".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch-pack.c             |   12 ++++++++++++
 t/t5501-fetch-push-alternates.sh |    2 +-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index b999413..4c25968 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -9,6 +9,7 @@
 #include "fetch-pack.h"
 #include "remote.h"
 #include "run-command.h"
+#include "transport.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -217,6 +218,16 @@ static void send_request(int fd, struct strbuf *buf)
 		safe_write(fd, buf->buf, buf->len);
 }
 
+static void insert_one_alternate_ref(const struct ref *ref, void *unused)
+{
+	rev_list_insert_ref(NULL, ref->old_sha1, 0, NULL);
+}
+
+static void insert_alternate_refs(void)
+{
+	foreach_alt_odb(refs_from_alternate_cb, insert_one_alternate_ref);
+}
+
 static int find_common(int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
 {
@@ -235,6 +246,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	marked = 1;
 
 	for_each_ref(rev_list_insert_ref, NULL);
+	insert_alternate_refs();
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
diff --git a/t/t5501-fetch-push-alternates.sh b/t/t5501-fetch-push-alternates.sh
index 564ef7c..a0f3644 100755
--- a/t/t5501-fetch-push-alternates.sh
+++ b/t/t5501-fetch-push-alternates.sh
@@ -54,7 +54,7 @@ test_expect_success 'pushing into a repository with the same alternate' '
 	test_cmp one.count receiver.count
 '
 
-test_expect_failure 'fetching from a repository with the same alternate' '
+test_expect_success 'fetching from a repository with the same alternate' '
 	(
 		cd fetcher &&
 		git fetch ../one master:refs/heads/it &&
-- 
1.7.4.1.404.g62d316
