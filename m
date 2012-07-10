From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 04/19] apply: refactor read_file_or_gitlink()
Date: Tue, 10 Jul 2012 00:03:57 -0700
Message-ID: <1341903852-4815-5-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:04:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUUz-0008MO-EI
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070Ab2GJHEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:04:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53053 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab2GJHE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADE147DD1
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=yQrk
	sRM2mhvUQ6/j5U+nzYnskEA=; b=EVolElEQtNtrlqcur4+Om4BvstHhSZlwrPJg
	yS1hVzAg8Cf4YfWN1JFh495Fs3nG7lxd+pr8wXafOZWTq6mC2EjPtyA2XI6ZXzrn
	T+YjL5CTCf37SdF5mS+NM1ES4/dm9TYzsSnlE9hQFLtAxYad6i/TlctBW8TMZg66
	WPSrBiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=pYk49R
	s4CShuIzOK+dHPCdyJxXp/3OmeV6jHG/GDslGgN1o4ypFwVGyHtlSMHTG1+2DmjG
	gWfPo5Sdh6hiRwotGSRzf/1zKuz0tiowwbXADLsHwvFzK9R3vl56ZUP9xlxi7SNx
	ILhw8wKYiT6aEa+xPc3euBOB7TSgFGkbrsLwg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A50A87DD0
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28B977DCF for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:27 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7CC35C1C-CA5D-11E1-9052-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201243>

Reading a blob out of the object store does not have to require that the
caller has a cache entry for it.

Create a read_blob_object() helper function that takes the object name and
mode, and use it to reimplement the original function as a thin wrapper to
it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 09f5df3..15bcbb0 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2930,20 +2930,17 @@ static int apply_fragments(struct image *img, struct patch *patch)
 	return 0;
 }
 
-static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
+static int read_blob_object(struct strbuf *buf, const unsigned char *sha1, unsigned mode)
 {
-	if (!ce)
-		return 0;
-
-	if (S_ISGITLINK(ce->ce_mode)) {
+	if (S_ISGITLINK(mode)) {
 		strbuf_grow(buf, 100);
-		strbuf_addf(buf, "Subproject commit %s\n", sha1_to_hex(ce->sha1));
+		strbuf_addf(buf, "Subproject commit %s\n", sha1_to_hex(sha1));
 	} else {
 		enum object_type type;
 		unsigned long sz;
 		char *result;
 
-		result = read_sha1_file(ce->sha1, &type, &sz);
+		result = read_sha1_file(sha1, &type, &sz);
 		if (!result)
 			return -1;
 		/* XXX read_sha1_file NUL-terminates */
@@ -2952,6 +2949,13 @@ static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
 	return 0;
 }
 
+static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
+{
+	if (!ce)
+		return 0;
+	return read_blob_object(buf, ce->sha1, ce->ce_mode);
+}
+
 static struct patch *in_fn_table(const char *name)
 {
 	struct string_list_item *item;
-- 
1.7.11.1.294.g68a9409
