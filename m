From: Jeff King <peff@peff.net>
Subject: [PATCH v2 13/25] sha1_file: add for_each iterators for loose and
 packed objects
Date: Wed, 15 Oct 2014 18:41:21 -0400
Message-ID: <20141015224121.GM25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:41:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXG3-0008A9-VN
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbaJOWlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:41:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:58978 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751173AbaJOWlY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:41:24 -0400
Received: (qmail 2476 invoked by uid 102); 15 Oct 2014 22:41:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:41:23 -0500
Received: (qmail 28098 invoked by uid 107); 15 Oct 2014 22:41:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:41:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:41:21 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We typically iterate over the reachable objects in a
repository by starting at the tips and walking the graph.
There's no easy way to iterate over all of the objects,
including unreachable ones. Let's provide a way of doing so.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     | 11 +++++++++++
 sha1_file.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/cache.h b/cache.h
index 8ffefaa..d24dd32 100644
--- a/cache.h
+++ b/cache.h
@@ -1254,6 +1254,17 @@ int for_each_loose_file_in_objdir(const char *path,
 				  each_loose_subdir_fn subdir_cb,
 				  void *data);
 
+/*
+ * Iterate over loose and packed objects in both the local
+ * repository and any alternates repositories.
+ */
+typedef int each_packed_object_fn(const unsigned char *sha1,
+				  struct packed_git *pack,
+				  uint32_t pos,
+				  void *data);
+extern int for_each_loose_object(each_loose_object_fn, void *);
+extern int for_each_packed_object(each_packed_object_fn, void *);
+
 struct object_info {
 	/* Request */
 	enum object_type *typep;
diff --git a/sha1_file.c b/sha1_file.c
index a20240b..eb410a2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3349,3 +3349,65 @@ int for_each_loose_file_in_objdir(const char *path,
 	strbuf_release(&buf);
 	return r;
 }
+
+struct loose_alt_odb_data {
+	each_loose_object_fn *cb;
+	void *data;
+};
+
+static int loose_from_alt_odb(struct alternate_object_database *alt,
+			      void *vdata)
+{
+	struct loose_alt_odb_data *data = vdata;
+	return for_each_loose_file_in_objdir(alt->base,
+					     data->cb, NULL, NULL,
+					     data->data);
+}
+
+int for_each_loose_object(each_loose_object_fn cb, void *data)
+{
+	struct loose_alt_odb_data alt;
+	int r;
+
+	r = for_each_loose_file_in_objdir(get_object_directory(),
+					  cb, NULL, NULL, data);
+	if (r)
+		return r;
+
+	alt.cb = cb;
+	alt.data = data;
+	return foreach_alt_odb(loose_from_alt_odb, &alt);
+}
+
+static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
+{
+	uint32_t i;
+	int r = 0;
+
+	for (i = 0; i < p->num_objects; i++) {
+		const unsigned char *sha1 = nth_packed_object_sha1(p, i);
+
+		if (!sha1)
+			return error("unable to get sha1 of object %u in %s",
+				     i, p->pack_name);
+
+		r = cb(sha1, p, i, data);
+		if (r)
+			break;
+	}
+	return r;
+}
+
+int for_each_packed_object(each_packed_object_fn cb, void *data)
+{
+	struct packed_git *p;
+	int r = 0;
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		r = for_each_object_in_pack(p, cb, data);
+		if (r)
+			break;
+	}
+	return r;
+}
-- 
2.1.2.596.g7379948
