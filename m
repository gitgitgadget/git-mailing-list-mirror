From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 14/16] sha1_file: implement `nth_packed_object_info`
Date: Tue, 25 Jun 2013 01:23:11 +0200
Message-ID: <1372116193-32762-15-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:24:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG7f-0003eB-5y
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab3FXXYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:24:14 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:45252 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab3FXXYL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:24:11 -0400
Received: by mail-we0-f182.google.com with SMTP id p60so8588719wes.41
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1N+QUp1LKguV9mEkM/YWQ2pE3QioWzZQIN93IxzX53w=;
        b=yJzm0WYpYpmulmeTj6gfKf9hllO3ajkuqgfBLoNmuaGC6x+IlQfnaGrMsbTWCMONiv
         3lResYxhy6HA8bc0RTZLtvjSl6cAyAHSrv64FHppKlVe5Wsl3iXx4HiznPnI+9TJbR2n
         iHknwWWtrc4msjpujSQd2/km9K6MUTi7nW42VuA0RYWrczXIUKW12G1Fmvs+E4c5qd4F
         v9lpk1UmV1DNg6h0SVyhsd9AJe3I9DWqqi3pswCGoErwa2yWVqUOiQBOuS6gfujzn3WZ
         ZQyJgMc1hQyU1aUYM8mdjRal6FkdsM/3StVKtRnzhdxEjtU6VFCnF4LGW2MA574htDv7
         eL7g==
X-Received: by 10.180.126.2 with SMTP id mu2mr7346465wib.63.1372116250547;
        Mon, 24 Jun 2013 16:24:10 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.24.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:24:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228931>

A new helper function allows to efficiently query the size and real type
of an object in a packfile based on its position on the packfile index.

This is particularly useful when trying to parse all the information of
an index in memory.
---
 cache.h     |    1 +
 sha1_file.c |    6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/cache.h b/cache.h
index bbe5e2a..26e4567 100644
--- a/cache.h
+++ b/cache.h
@@ -1104,6 +1104,7 @@ extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *, int, int);
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
 extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
+extern int nth_packed_object_info(struct packed_git *p, uint32_t n, unsigned long *sizep);
 extern int find_pack_entry_pos(const unsigned char *sha1, struct packed_git *p);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern int is_pack_valid(struct packed_git *);
diff --git a/sha1_file.c b/sha1_file.c
index 018a847..fd5bd01 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2223,6 +2223,12 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 	}
 }
 
+int nth_packed_object_info(struct packed_git *p, uint32_t n, unsigned long *sizep)
+{
+	off_t offset = nth_packed_object_offset(p, n);
+	return packed_object_info(p, offset, sizep, NULL);
+}
+
 int find_pack_entry_pos(const unsigned char *sha1, struct packed_git *p)
 {
 	const uint32_t *level1_ofs = p->index_data;
-- 
1.7.9.5
