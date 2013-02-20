From: Jeff King <peff@peff.net>
Subject: [PATCH v3 04/19] fetch-pack: fix out-of-bounds buffer offset in
 get_ack
Date: Wed, 20 Feb 2013 15:00:28 -0500
Message-ID: <20130220200028.GD25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:00:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8FqZ-0003WD-Sv
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934953Ab3BTUAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:00:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54563 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934523Ab3BTUAa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:00:30 -0500
Received: (qmail 17637 invoked by uid 107); 20 Feb 2013 20:02:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:02:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:00:28 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216718>

When we read acks from the remote, we expect either:

  ACK <sha1>

or

  ACK <sha1> <multi-ack-flag>

We parse the "ACK <sha1>" bit from the line, and then start
looking for the flag strings at "line+45"; if we don't have
them, we assume it's of the first type.  But if we do have
the first type, then line+45 is not necessarily inside our
string at all!

It turns out that this works most of the time due to the way
we parse the packets. They should come in with a newline,
and packet_read puts an extra NUL into the buffer, so we end
up with:

  ACK <sha1>\n\0

with the newline at offset 44 and the NUL at offset 45. We
then strip the newline, putting a NUL at offset 44. So
when we look at "line+45", we are looking past the end of
our string; but it's OK, because we hit the terminator from
the original string.

This breaks down, however, if the other side does not
terminate their packets with a newline. In that case, our
packet is one character shorter, and we start looking
through uninitialized memory for the flag. No known
implementation sends such a packet, so it has never come up
in practice.

This patch tightens the check by looking for a short,
flagless ACK before trying to parse the flag.

Signed-off-by: Jeff King <peff@peff.net>
---
This is the absolute minimal fix, which just checks for the no-flag case
early; we still treat arbitrary crud in the flag field as just an ACK.
From my understanding of the protocol, a saner parsing scheme would be:

  const char *flag = line + 44; /* we already parsed "ACK <sha1>" */
  if (!*flag)
          return ACK;
  if (!strcmp(flag, " continue"))
          return ACK_continue;
  if (!strcmp(flag, " common"))
          return ACK_continue;
  if (!strcmp(flag, " ready"))
          return ACK_ready;
  die("fetch-pack expected multi-ack flag, got: %s", line);

But that is much tighter, and I wasn't sure if the looseness was there
to facilitate future expansion or something (though I'd think we would
need a new capability for that).

 fetch-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 6d8926a..27a3e80 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -226,6 +226,8 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 		return NAK;
 	if (!prefixcmp(line, "ACK ")) {
 		if (!get_sha1_hex(line+4, result_sha1)) {
+			if (len < 45)
+				return ACK;
 			if (strstr(line+45, "continue"))
 				return ACK_continue;
 			if (strstr(line+45, "common"))
-- 
1.8.2.rc0.9.g352092c
