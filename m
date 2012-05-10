From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/8] apply: split load_preimage() helper function out
Date: Wed,  9 May 2012 23:02:20 -0700
Message-ID: <1336629745-22436-4-git-send-email-gitster@pobox.com>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 08:03:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSMTI-0002fI-9I
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 08:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab2EJGCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 02:02:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996Ab2EJGCd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 02:02:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BCF75FD2
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hti4
	XCJt8+c+PG317xs700D8TZ0=; b=kMPnnD8a2vPQoA+2loCaHh4UTF1qHmbq17T+
	sMmdrH/evj4HqRr1YPYkQnNaaT4E4RE9Tww0BWqqTCpxSQ+KyDN12KnkP7L/A2MR
	+751wC9aGnaI0a2PjQNC5KWH2EetkH3ZYqDJp7UA6vKd4y14EbqyZm+kagSxLH8S
	bccBnVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Pag87Z
	CmBXVhl13bK1+Nv/6xdnpFiOT6SRwDAnebOsoMq2J7cij5heoSA3wR6zYtpb+yPz
	im3DF5jsA9IIPdUqqie/6CtTXiH2SXinMt8ObHeD8kwz8kxmgmcarYyiLTcNQfae
	fUkwxOaOhP8ibR3xTd8iaU9b5TIzg+qyCggO0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 144C25FC8
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C18D5FC7 for
 <git@vger.kernel.org>; Thu, 10 May 2012 02:02:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.562.gfc79b1c
In-Reply-To: <1336629745-22436-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BB88935E-9A65-11E1-9823-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197543>

The function apply_data() gets a patch for a single path, reads the
preimage in core, and applies the change represented in the patch.

Separate out the first part that reads the preimage into a separate
helper function load_preimage().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index cb6aad5..9f6f74f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3025,15 +3025,10 @@ static void prepare_fn_table(struct patch *patch)
 	}
 }
 
-static int try_threeway_fallback(struct image *image, struct patch *patch)
-{
-	return -1; /* for now */
-}
-
-static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
+static int load_preimage(struct image *image,
+			 struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct image image;
 	size_t len;
 	char *img;
 	struct patch *tpatch;
@@ -3070,7 +3065,21 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	}
 
 	img = strbuf_detach(&buf, &len);
-	prepare_image(&image, img, len, !patch->is_binary);
+	prepare_image(image, img, len, !patch->is_binary);
+	return 0;
+}
+
+static int try_threeway_fallback(struct image *image, struct patch *patch)
+{
+	return -1; /* for now */
+}
+
+static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
+{
+	struct image image;
+
+	if (load_preimage(&image, patch, st, ce) < 0)
+		return -1;
 
 	if (apply_fragments(&image, patch) < 0) {
 		/* Note: with --reject, the above call succeeds. */
-- 
1.7.10.1.562.gfc79b1c
