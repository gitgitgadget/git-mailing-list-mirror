From: Phil Hord <hordp@cisco.com>
Subject: [PATCH 1/1] transport: Add is_bundle() to detect bundle urls
Date: Thu, 13 Oct 2011 16:26:02 -0400
Message-ID: <1318537562-18581-2-git-send-email-hordp@cisco.com>
References: <1318537562-18581-1-git-send-email-hordp@cisco.com>
Cc: Phil Hord <hordp@cisco.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 22:26:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RERri-0008Em-5E
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 22:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570Ab1JMU0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 16:26:50 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:53030 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab1JMU0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 16:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2365; q=dns/txt;
  s=iport; t=1318537609; x=1319747209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=L3vNPNcxQTKij+IayqJ/VQDQ2DT6oUNeYEYDgYrRBws=;
  b=Uz0lneaKQ2Qply6gHftZ1074A0w7qdVd5Jb3wfN20Oa/nSJ0LRf3O0zu
   44SVc7BxOh8v2uszXwRJpppusSfSPwsixGGPjDSTS53c972iu1sUNmjvA
   BbW/l3U4vrllx650o/zT/faczx5KJkIz3yHit4muLPoHtOlrhCs2bwRte
   4=;
X-IronPort-AV: E=Sophos;i="4.69,342,1315180800"; 
   d="scan'208";a="28290926"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-7.cisco.com with ESMTP; 13 Oct 2011 20:26:48 +0000
Received: from hordp-wxp.cisco.com (dhcp-64-100-104-107.cisco.com [64.100.104.107])
	by rcdn-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id p9DKQSVq028401;
	Thu, 13 Oct 2011 20:26:50 GMT
X-Mailer: git-send-email 1.7.7.334.g311c9.dirty
In-Reply-To: <1318537562-18581-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183523>

Transport decides that any local url which is a file
must be a bundle.  This is wrong if the local url is a
gitfile. Teach transport to verify the file is
really a bundle instead of just assuming it is so.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phil Hord <hordp@cisco.com>
---
 bundle.c    |   16 ++++++++++++++++
 bundle.h    |    1 +
 transport.c |   10 +---------
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/bundle.c b/bundle.c
index f82baae..cc0624d 100644
--- a/bundle.c
+++ b/bundle.c
@@ -23,6 +23,22 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
 	list->nr++;
 }
 
+int is_bundle(const char *path)
+{
+	char buffer[100];
+	FILE *ffd = fopen(path, "rb");
+	int ret=1;
+
+	if (!ffd)
+		return 0;
+
+	if (!fgets(buffer, sizeof(buffer), ffd) ||
+			strcmp(buffer, bundle_signature))
+		ret=0;
+	fclose(ffd);
+	return ret;
+}
+
 /* returns an fd */
 int read_bundle_header(const char *path, struct bundle_header *header)
 {
diff --git a/bundle.h b/bundle.h
index c5a22c8..35aa0eb 100644
--- a/bundle.h
+++ b/bundle.h
@@ -14,6 +14,7 @@ struct bundle_header {
 	struct ref_list references;
 };
 
+int is_bundle(const char *path);
 int read_bundle_header(const char *path, struct bundle_header *header);
 int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv);
diff --git a/transport.c b/transport.c
index 57138d9..c76f5b7 100644
--- a/transport.c
+++ b/transport.c
@@ -881,14 +881,6 @@ static int is_gitfile(const char *url)
 	return !prefixcmp(buf, "gitdir: ");
 }
 
-static int is_file(const char *url)
-{
-	struct stat buf;
-	if (stat(url, &buf))
-		return 0;
-	return S_ISREG(buf.st_mode);
-}
-
 static int external_specification_len(const char *url)
 {
 	return strchr(url, ':') - url;
@@ -929,7 +921,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
 		ret->smart_options = NULL;
-	} else if (is_local(url) && is_file(url) && !is_gitfile(url)) {
+	} else if (is_local(url) && is_bundle(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
 		ret->get_refs_list = get_refs_from_bundle;
-- 
1.7.7.334.g311c9.dirty
