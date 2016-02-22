From: Jeff King <peff@peff.net>
Subject: [PATCH v3 13/22] write_untracked_extension: use FLEX_ALLOC helper
Date: Mon, 22 Feb 2016 17:44:42 -0500
Message-ID: <20160222224442.GM10075@sigill.intra.peff.net>
References: <20160222224059.GA3857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:44:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzDk-0005Dn-Mb
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109AbcBVWoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:44:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:47098 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752980AbcBVWop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:44:45 -0500
Received: (qmail 21726 invoked by uid 102); 22 Feb 2016 22:44:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:45 -0500
Received: (qmail 23123 invoked by uid 107); 22 Feb 2016 22:44:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:44:42 -0500
Content-Disposition: inline
In-Reply-To: <20160222224059.GA3857@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286983>

We perform unchecked additions when computing the size of a
"struct ondisk_untracked_cache". This is unlikely to have an
integer overflow in practice, but we'd like to avoid this
dangerous pattern to make further audits easier.

Note that there's one subtlety here, though.  We protect
ourselves against a NULL exclude_per_dir entry in our
source, and avoid calling strlen() on it, keeping "len" at
0. But later, we unconditionally memcpy "len + 1" bytes to
get the trailing NUL byte. If we did have a NULL
exclude_per_dir, we would read from bogus memory.

As it turns out, though, we always create this field
pointing to a string literal, so there's no bug. We can just
get rid of the pointless extra conditional.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 2c91541..a4a9d9f 100644
--- a/dir.c
+++ b/dir.c
@@ -2360,16 +2360,15 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	struct ondisk_untracked_cache *ouc;
 	struct write_data wd;
 	unsigned char varbuf[16];
-	int len = 0, varint_len;
-	if (untracked->exclude_per_dir)
-		len = strlen(untracked->exclude_per_dir);
-	ouc = xmalloc(sizeof(*ouc) + len + 1);
+	int varint_len;
+	size_t len = strlen(untracked->exclude_per_dir);
+
+	FLEX_ALLOC_MEM(ouc, exclude_per_dir, untracked->exclude_per_dir, len);
 	stat_data_to_disk(&ouc->info_exclude_stat, &untracked->ss_info_exclude.stat);
 	stat_data_to_disk(&ouc->excludes_file_stat, &untracked->ss_excludes_file.stat);
 	hashcpy(ouc->info_exclude_sha1, untracked->ss_info_exclude.sha1);
 	hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.sha1);
 	ouc->dir_flags = htonl(untracked->dir_flags);
-	memcpy(ouc->exclude_per_dir, untracked->exclude_per_dir, len + 1);
 
 	varint_len = encode_varint(untracked->ident.len, varbuf);
 	strbuf_add(out, varbuf, varint_len);
-- 
2.7.2.645.g4e1306c
