From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/9] apply: refactor read_file_or_gitlink()
Date: Thu, 10 May 2012 15:32:46 -0700
Message-ID: <1336689173-15822-3-git-send-email-gitster@pobox.com>
References: <1336689173-15822-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 00:33:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSbv6-00066r-1G
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 00:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531Ab2EJWdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 18:33:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36640 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761732Ab2EJWc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 18:32:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCC338429
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:32:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=l1M+
	oGgp0tPLDdgVAXZ5nEBX51Q=; b=nfEJiDeJxpVe159Ti+UqPD19lJSWxjnnY7iF
	TwGQAb0GD00VcquB9x5HboyXbxhNpeqvMEpvKK4MhGqLvqBn5W7A+ky9OPOO4ATf
	MWYsaR+IOJeFfQKVyeLEYw/Lq/aFMhb67YijB4RK0hbcRVUAoleZjCYHbRugwC0i
	+NxQ6nQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=OvIdP0
	zfs7Ref+0JUF9+IscNOZErDGaWziyrfv6ODlCmD7IcXR57jo2zZTlRLjUqjQat0o
	5TeX4im8fmQGrK7uwCm+iNHhbcWqY6u/1AFaocsrp9HZ8SrUOTFQOY/VP4zwO8dl
	i5JFI3x97/KunFmdb1HGRFqsQ7/vBFjZWre2c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3F0A8428
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:32:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54FCA8427 for
 <git@vger.kernel.org>; Thu, 10 May 2012 18:32:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.574.g840b38f
In-Reply-To: <1336689173-15822-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1803FDA0-9AF0-11E1-A6D6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197638>

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
index 99b1608..ca330e3 100644
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
1.7.10.1.574.g840b38f
