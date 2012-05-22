From: Jeff King <peff@peff.net>
Subject: [PATCH] pretty: avoid buffer overflow in format_person_part
Date: Tue, 22 May 2012 01:45:08 -0400
Message-ID: <20120522054508.GA10576@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 07:45:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWhuY-0008UK-Bj
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 07:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab2EVFpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 01:45:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51485
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754133Ab2EVFpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 01:45:11 -0400
Received: (qmail 12835 invoked by uid 107); 22 May 2012 05:45:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 01:45:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 01:45:08 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198177>

When we parse the name and email from a commit to
pretty-print them, we usually can just put the result
directly into our strbuf result. However, if we are going to
use the mailmap, then we must first copy them into a
NUL-terminated buffer to feed to the mailmap machinery.

We did so by using strlcpy into a static buffer, but we used
it wrong. We fed it the length of the substring we wanted to
copy, but never checked that that length was less than the
size of the destination buffer.

The simplest fix is to just use snprintf to copy the
substring properly while still respecting the destination
buffer's size. It might seem like replacing the static
buffer with a strbuf would help, but we need to feed a
static buffer to the mailmap machinery anyway, so there's
not much benefit to handling arbitrary sizes.

A more ideal solution would be for mailmap to grow an
interface that:

  1. Takes a pointer and length combination, instead of
     assuming a NUL-terminated string.

  2. Returns a pointer to the mailmap's allocated string,
     rather than copying it into the buffer.

Then we could avoid the need for an extra buffer entirely.
However, doing this would involve a lot of refactoring of
mailmap and of string_list (which mailmap uses to store the
map itself). For now, let's do the simplest thing to fix the
bug.

Signed-off-by: Jeff King <peff@peff.net>
---
Current git will not generate commits with names long enough to overflow
here. With my recent series, that is no longer the case. Of course, that
is not really relevant; a malicious attacker is free to craft a bogus
commit directly with hash-object.

 pretty.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 02a0a2b..986e114 100644
--- a/pretty.c
+++ b/pretty.c
@@ -547,8 +547,10 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	mail_end = s.mail_end;
 
 	if (part == 'N' || part == 'E') { /* mailmap lookup */
-		strlcpy(person_name, name_start, name_end - name_start + 1);
-		strlcpy(person_mail, mail_start, mail_end - mail_start + 1);
+		snprintf(person_name, sizeof(person_name), "%.*s",
+			 (int)(name_end - name_start), name_start);
+		snprintf(person_mail, sizeof(person_mail), "%.*s",
+			 (int)(mail_end - mail_start), mail_start);
 		mailmap_name(person_mail, sizeof(person_mail), person_name, sizeof(person_name));
 		name_start = person_name;
 		name_end = name_start + strlen(person_name);
-- 
1.7.9.7.33.gc430a50
