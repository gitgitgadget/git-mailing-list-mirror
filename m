From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/19] apply: split load_preimage() helper function out
Date: Wed, 13 Jun 2012 12:32:47 -0700
Message-ID: <1339615980-19727-7-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:33:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetJj-0007rf-AN
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767Ab2FMTdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab2FMTdO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 332968705
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=L8Bu
	K/YfIuDTliDkgOfLZdsl4Kk=; b=c6RYQ4tTf2ZayPvET1PPjcAX9yOzXv2wCxGq
	11F/P8vWP/7wVFkos6KAwN6vlDY1tsNr3ti0TXdb87ls3jTI4KuY9YD5HxTtS7VH
	k7sH3aZq3ONFXkuv7h2+/VtmDBJXzBkD9PuHk0fvcnCF05W6syfprnXD2tD77Qeh
	yJXvNi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=RX5G5s
	Bh20xqCzpopXXe6I5tMpeFTGXi+1p5NRJr6Fx4gRuWC54zrQFjgde+ecI7Q9N12Y
	BX3rnW5hjBzYhQCIzjtxOczfqk+XHhAwaZWSZycvt/JzHvymjUleQvOKV51NEqBP
	3tByzQkFzWpLlXr4bCSmN4tnTZvLzolYJZK2w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A5AF8704
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFE978700 for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9DEC0440-B58E-11E1-A2AF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199921>

The function apply_data() gets a patch for a single path, reads the
preimage in core, and applies the change represented in the patch.

Separate out the first part that reads the preimage into a separate
helper function load_preimage().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6a1fdc0..8496db5 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3046,10 +3046,10 @@ static int checkout_target(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
-static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
+static int load_preimage(struct image *image,
+			 struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct image image;
 	size_t len;
 	char *img;
 	struct patch *tpatch;
@@ -3086,7 +3086,16 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	}
 
 	img = strbuf_detach(&buf, &len);
-	prepare_image(&image, img, len, !patch->is_binary);
+	prepare_image(image, img, len, !patch->is_binary);
+	return 0;
+}
+
+static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
+{
+	struct image image;
+
+	if (load_preimage(&image, patch, st, ce) < 0)
+		return -1;
 
 	if (apply_fragments(&image, patch) < 0)
 		return -1; /* note with --reject this succeeds. */
-- 
1.7.11.rc3.30.g3bdace2
