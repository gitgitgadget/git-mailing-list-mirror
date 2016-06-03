From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/38] resolve_gitlink_ref(): avoid memory allocation in many cases
Date: Fri,  3 Jun 2016 23:03:52 +0200
Message-ID: <c126a2bf5e1f48faf48b3b4ee7cc599313a76b99.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHJ-0000Yi-7e
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954AbcFCVFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:08 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61304 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932945AbcFCVE4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:56 -0400
X-AuditID: 1207440c-c3fff70000000b85-9a-5751f0f74c5a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 56.55.02949.7F0F1575; Fri,  3 Jun 2016 17:04:55 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kch003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:54 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqPv9Q2C4wY5dBhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M7Y19nHUjCbs+LpieWMDYwL2bsY
	OTgkBEwkliwL62Lk5BAS2MooMX9/TBcjF5B9nEniy7ep7CAJNgFdiUU9zUwgtohAhETDqxZG
	kCJmgTlMErcfdjKDJIQFgiWef+hnA7FZBFQlZh+bzghi8wpESax5+pAVxJYQkJO4PP0BWA2n
	gIVEy+dVrBCbzSUaTx1mmcDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqFebmaJXmpK
	6SZGSMjx7GD8tk7mEKMAB6MSD2/Bs8BwIdbEsuLK3EOMkhxMSqK8e+8AhfiS8lMqMxKLM+KL
	SnNSiw8xSnAwK4nwprwGyvGmJFZWpRblw6SkOViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiU
	JHgXvQdqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFQHwxMAZAUjxAe8+BtPMW
	FyTmAkUhWk8xKkqJ8x4CSQiAJDJK8+DGwhLJK0ZxoC+FeW+DVPEAkxBc9yugwUxAgwse+YMM
	LklESEk1MIqolm5x5d2W9EF4733zPc4zS69+C6o+VupzYE+H5YTnN+o9mfXE3uw8cXs/q7/u
	F9FNKsv8TsyLmd62vI3X9tyNxH8eW22Ynl8uDb3B91pj4xWu5bsz/oqlXbvWzmKa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296380>

If we don't have to strip trailing '/' from the submodule path, then
don't allocate and copy the submodule name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 5e0777a..7a8ef6d 100644
--- a/refs.c
+++ b/refs.c
@@ -1301,19 +1301,25 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 
 int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
 {
-	int len = strlen(path);
-	struct strbuf submodule = STRBUF_INIT;
+	size_t len, orig_len = strlen(path);
 	struct ref_store *refs;
 	int flags;
 
-	while (len && path[len-1] == '/')
-		len--;
+	for (len = orig_len; len && path[len - 1] == '/'; len--)
+		;
+
 	if (!len)
 		return -1;
 
-	strbuf_add(&submodule, path, len);
-	refs = get_ref_store(submodule.buf);
-	strbuf_release(&submodule);
+	if (len == orig_len) {
+		refs = get_ref_store(path);
+	} else {
+		char *stripped = xmemdupz(path, len);
+
+		refs = get_ref_store(stripped);
+		free(stripped);
+	}
+
 	if (!refs)
 		return -1;
 
-- 
2.8.1
