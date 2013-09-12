From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] urlmatch: append_normalized_escapes can reallocate norm.buf
Date: Thu, 12 Sep 2013 11:57:31 +0200
Message-ID: <75d702a744eb33a456622dd2ff901abef83e51d8.1378979451.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 12 11:57:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK3ej-0002lc-R4
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 11:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497Ab3ILJ5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 05:57:42 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:23375 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab3ILJ5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 05:57:41 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 12 Sep
 2013 11:57:39 +0200
Received: from linux-k42r.v.cablecom.net (129.132.210.212) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 12 Sep
 2013 11:57:38 +0200
X-Mailer: git-send-email 1.8.4.609.g4395a4f
X-Originating-IP: [129.132.210.212]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234638>

The calls to strbuf_add* within append_normalized_escapes() can
reallocate the buffer passed to it.  Therefore, the seg_start pointer
into the string cannot be kept across such calls.

The actual bug is from 3402a8d (config: add helper to normalize and
match URLs, 2013-07-31).  It can first be detected by valgrind after
6a56993 (config: parse http.<url>.<variable> using urlmatch,
2013-08-05) introduced tests covering url_normalize().

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

My apologies if this is redundant; I didn't have time to watch the
list over the last two weeks.  However it seems today's pu is still
broken.

The valgrind error looks like this:

  ==4607== Invalid read of size 1
  ==4607==    at 0x4C2D3A1: __GI_strcmp (mc_replace_strmem.c:731)
  ==4607==    by 0x404C68: url_normalize (urlmatch.c:300)
  ==4607==    by 0x403F33: main (test-urlmatch-normalization.c:34)
  ==4607==  Address 0x5be9046 is 6 bytes inside a block of size 24 free'd
  ==4607==    at 0x4C2BFC6: realloc (vg_replace_malloc.c:687)
  ==4607==    by 0x405F6B: xrealloc (wrapper.c:100)
  ==4607==    by 0x40794E: strbuf_grow (strbuf.c:74)
  ==4607==    by 0x40854D: strbuf_vaddf (strbuf.c:268)
  ==4607==    by 0x40817E: strbuf_addf (strbuf.c:203)
  ==4607==    by 0x404300: append_normalized_escapes (urlmatch.c:58)
  ==4607==    by 0x404C0A: url_normalize (urlmatch.c:291)
  ==4607==    by 0x403F33: main (test-urlmatch-normalization.c:34)

It went undetected for a while because it does not fail the test: the
calls to test-urlmatch-normalization happen inside a $() substitution.

I checked the other call sites to append_normalized_escapes() for the
same type of problem, and they seem to be okay.

 urlmatch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/urlmatch.c b/urlmatch.c
index 1db76c8..59abc80 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -281,7 +281,8 @@ char *url_normalize(const char *url, struct url_info *out_info)
 		url_len--;
 	}
 	for (;;) {
-		const char *seg_start = norm.buf + norm.len;
+		const char *seg_start;
+		size_t prev_len = norm.len;
 		const char *next_slash = url + strcspn(url, "/?#");
 		int skip_add_slash = 0;
 		/*
@@ -297,6 +298,7 @@ char *url_normalize(const char *url, struct url_info *out_info)
 			strbuf_release(&norm);
 			return NULL;
 		}
+		seg_start = norm.buf + prev_len;
 		if (!strcmp(seg_start, ".")) {
 			/* ignore a . segment; be careful not to remove initial '/' */
 			if (seg_start == path_start + 1) {
-- 
1.8.4.609.g4395a4f
