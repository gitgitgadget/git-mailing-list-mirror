From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use strbuf_addbuf for adding strbufs
Date: Thu, 10 Jul 2014 10:52:21 +0200
Message-ID: <53BE5445.20401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 10:53:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5A6G-0007o5-Se
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 10:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbaGJIxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 04:53:01 -0400
Received: from mout.web.de ([212.227.17.12]:51599 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130AbaGJIwp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 04:52:45 -0400
Received: from [192.168.178.27] ([79.253.174.99]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MgfFr-1XGtmj0wh5-00NvJV; Thu, 10 Jul 2014 10:52:30
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:jrJ4HqrIgV9XtjhIFkrHMxyFma0D/RW7GvkKzMcP5ZemB0lrrpj
 heBdUOctISrl9QO/mb7EnfgSb/yaOjlA7Q3ljN3AffRpOsgSqIbE9fgdbRRhfAY3DtPNJqk
 n86S1qA34X6sY9ISRo0nZ9sbpKuZzin/VfwCDUDpOsfOBIaXbXGjawgwyf8SXzOdsI2fhd9
 H3UgYNi8nPfaPDw201CbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253177>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/log.c | 2 +-
 pretty.c      | 2 +-
 rerere.c      | 4 ++--
 sha1_name.c   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 27c1b65..4389722 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -861,7 +861,7 @@ static void add_branch_description(struct strbuf *buf, const char *branch_name)
 	read_branch_desc(&desc, branch_name);
 	if (desc.len) {
 		strbuf_addch(buf, '\n');
-		strbuf_add(buf, desc.buf, desc.len);
+		strbuf_addbuf(buf, &desc);
 		strbuf_addch(buf, '\n');
 	}
 }
diff --git a/pretty.c b/pretty.c
index 8d201f6..6e54934 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1376,7 +1376,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 		case trunc_none:
 			break;
 		}
-		strbuf_addstr(sb, local_sb.buf);
+		strbuf_addbuf(sb, &local_sb);
 	} else {
 		int sb_len = sb->len, offset = 0;
 		if (c->flush_type == flush_left)
diff --git a/rerere.c b/rerere.c
index d55aa8a..04d923d 100644
--- a/rerere.c
+++ b/rerere.c
@@ -207,11 +207,11 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
 			strbuf_reset(&one);
 			strbuf_reset(&two);
 		} else if (hunk == RR_SIDE_1)
-			strbuf_addstr(&one, buf.buf);
+			strbuf_addbuf(&one, &buf);
 		else if (hunk == RR_ORIGINAL)
 			; /* discard */
 		else if (hunk == RR_SIDE_2)
-			strbuf_addstr(&two, buf.buf);
+			strbuf_addbuf(&two, &buf);
 		else
 			rerere_io_putstr(buf.buf, io);
 		continue;
diff --git a/sha1_name.c b/sha1_name.c
index 5bfa841..6ccd3a5 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -946,7 +946,7 @@ static int interpret_nth_prior_checkout(const char *name, int namelen,
 	retval = 0;
 	if (0 < for_each_reflog_ent_reverse("HEAD", grab_nth_branch_switch, &cb)) {
 		strbuf_reset(buf);
-		strbuf_add(buf, cb.buf.buf, cb.buf.len);
+		strbuf_addbuf(buf, &cb.buf);
 		retval = brace - name + 1;
 	}
 
-- 
2.0.0
