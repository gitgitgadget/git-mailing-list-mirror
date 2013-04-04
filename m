From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/7] sha1_file: write ref_name to link object
Date: Fri,  5 Apr 2013 00:00:43 +0530
Message-ID: <1365100243-13676-8-git-send-email-artagnon@gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:30:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNovE-0007fT-VR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764557Ab3DDS3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:29:32 -0400
Received: from mail-da0-f47.google.com ([209.85.210.47]:42991 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764494Ab3DDS3a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:29:30 -0400
Received: by mail-da0-f47.google.com with SMTP id s35so1242614dak.20
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/tmTKDAavP363tA8cvYBHGXikplsBu0VrgVfNQSMmwU=;
        b=lMYyIw/ZPtRqDOVLTWlZThmS1ZWzHksfZ6MILP8MJlECc3Tk2rLNk6QgnhbDLfYT0A
         MlvTvS6r2fU6b+3C+/rJC9LjAc9R4JLe6FX/xdX4VHQlXfpmy5ATefSPPNXVCajk63pU
         SfD959Qc1O5rm3ygl4uP76PJ+P7mXVUh+3QX4HckzXLkCArXvI3uwY+9iyYON05P0OJG
         ov6LWsHVta8gI7MwedfO+OSDx4R/x+HQL9Dz4SxaJyr67Hz4GFhkrySne5fm3kGw5zD3
         8QSCA/ymbyvWo3TwQBfZvd2cl+brlQ3GKHAXpFKB4ejn4QjUrxlKE8DczPSvbtmamgh2
         ZQhw==
X-Received: by 10.68.194.193 with SMTP id hy1mr10038627pbc.191.1365100169750;
        Thu, 04 Apr 2013 11:29:29 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.36])
        by mx.google.com with ESMTPS id xl10sm12418525pac.15.2013.04.04.11.29.27
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 11:29:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.380.g0d4e79b
In-Reply-To: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220054>

Great.  Now, we just have to write refs/modules/<branch>/* at
commit-time.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index a8a6d72..2ea101a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2874,6 +2874,7 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned
 	char pathbuf[PATH_MAX];
 	const char *submodule_gitdir;
 	unsigned char checkout_rev[20];
+	char *ref_name;
 
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
@@ -2915,9 +2916,18 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned
 		if (resolve_gitlink_ref(path, "HEAD", checkout_rev) < 0)
 			die("Unable to resolve submodule HEAD");
 
+		/* Construct a ref_name from path */
+		sprintf(pathbuf, "%s", path);
+		pathbuf[strlen(pathbuf) - 1] = '\0'; /* Remove trailing slash */
+		if (strchr(pathbuf, '/'))
+			ref_name = xstrdup(strrchr(pathbuf, '/') + 1);
+		else
+			ref_name = xstrdup(pathbuf);
+
 		/* Add fields to the strbuf */
 		strbuf_addf(&sb, "upstream_url = %s\n", (char *) upstream_url);
 		strbuf_addf(&sb, "checkout_rev = %s\n", sha1_to_hex(checkout_rev));
+		strbuf_addf(&sb, "ref_name = %s\n", ref_name);
 		if (!(flags & HASH_WRITE_OBJECT))
 			hash_sha1_file(sb.buf, sb.len, link_type, sha1);
 		else if (write_sha1_file(sb.buf, sb.len, link_type, sha1))
-- 
1.8.2.380.g0d4e79b
