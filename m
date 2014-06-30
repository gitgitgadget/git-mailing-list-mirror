From: Jeff King <peff@peff.net>
Subject: [PATCH 9/9] prepare_packed_git_one: refactor duplicate-pack check
Date: Mon, 30 Jun 2014 13:04:03 -0400
Message-ID: <20140630170403.GI16637@sigill.intra.peff.net>
References: <20140630165526.GA15690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 19:04:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1ezy-0004HQ-R3
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 19:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbaF3REG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 13:04:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:53680 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754563AbaF3REF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 13:04:05 -0400
Received: (qmail 8066 invoked by uid 102); 30 Jun 2014 17:04:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 12:04:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 13:04:03 -0400
Content-Disposition: inline
In-Reply-To: <20140630165526.GA15690@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252691>

When we are reloading the list of packs, we check whether a
particular pack has been loaded. This is slightly tricky,
because we load packs based on the presence of their ".idx"
files, but record the name of the matching ".pack" file.
Therefore we want to compare their bases.

The existing code stripped off ".idx" from a file we found,
then compared that whole base length to strings containing
the ".pack" version. This meant we could end up comparing
bytes past what the ".pack" string contained, if the ".idx"
file name was much longer.

In practice, it worked OK because memcmp would end up seeing
a difference in the two strings and would return early
before hitting the full length. However, memcmp may
sometimes read extra bytes past a difference (e.g., because
it is comparing 64-bit words), or is even free to compare in
reverse order.

Furthermore, our memcmp made no guarantees that we matched
the whole pack name, up to ".pack". So "foo.idx" would match
"foo-bar.pack", which is wrong (but does not typically
happen, because our pack names have a fixed size).

We can fix both issues, avoid magic numbers, and document
that we expect to compare against a string with ".pack" by
using strip_suffix.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a teeny bit less efficient than it could be, because we are
verifying our assumption at run-time that each pack name ends in
".pack". I'd venture to say if we cared about efficiency here, the low
hanging fruit would be to avoid the O(n^2) loop to find duplicate pack
names in the first place.

 sha1_file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 93b794f..129a4c5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1197,6 +1197,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 	dirnamelen = path.len;
 	while ((de = readdir(dir)) != NULL) {
 		struct packed_git *p;
+		size_t base_len;
 
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
@@ -1204,10 +1205,14 @@ static void prepare_packed_git_one(char *objdir, int local)
 		strbuf_setlen(&path, dirnamelen);
 		strbuf_addstr(&path, de->d_name);
 
-		if (ends_with(de->d_name, ".idx")) {
+		base_len = path.len;
+		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
 			/* Don't reopen a pack we already have. */
 			for (p = packed_git; p; p = p->next) {
-				if (!memcmp(path.buf, p->pack_name, path.len - 4))
+				size_t len;
+				if (strip_suffix(p->pack_name, ".pack", &len) &&
+				    len == base_len &&
+				    !memcmp(p->pack_name, path.buf, len))
 					break;
 			}
 			if (p == NULL &&
-- 
2.0.0.566.gfe3e6b2
