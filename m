From: Jeff King <peff@peff.net>
Subject: [PATCH v3 01/19] upload-pack: use get_sha1_hex to parse "shallow"
 lines
Date: Wed, 20 Feb 2013 14:53:33 -0500
Message-ID: <20130220195333.GA25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 20:54:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Fjs-0007UB-Tl
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 20:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934831Ab3BTTxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 14:53:36 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54544 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934450Ab3BTTxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 14:53:35 -0500
Received: (qmail 17500 invoked by uid 107); 20 Feb 2013 19:55:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 14:55:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 14:53:33 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216715>

When we receive a line like "shallow <sha1>" from the
client, we feed the <sha1> part to get_sha1. This is a
mistake, as the argument on a shallow line is defined by
Documentation/technical/pack-protocol.txt to contain an
"obj-id".  This is never defined in the BNF, but it is clear
from the text and from the other uses that it is meant to be
a hex sha1, not an arbitrary identifier (and that is what
fetch-pack has always sent).

We should be using get_sha1_hex instead, which doesn't allow
the client to request arbitrary junk like "HEAD@{yesterday}".
Because this is just marking shallow objects, the client
couldn't actually do anything interesting (like fetching
objects from unreachable reflog entries), but we should keep
our parsing tight to be on the safe side.

Because get_sha1 is for the most part a superset of
get_sha1_hex, in theory the only behavior change should be
disallowing non-hex object references. However, there is
one interesting exception: get_sha1 will only parse
a 40-character hex sha1 if the string has exactly 40
characters, whereas get_sha1_hex will just eat the first 40
characters, leaving the rest. That means that current
versions of git-upload-pack will not accept a "shallow"
packet that has a trailing newline, even though the protocol
documentation is clear that newlines are allowed (even
encouraged) in non-binary parts of the protocol.

This never mattered in practice, though, because fetch-pack,
contrary to the protocol documentation, does not include a
newline in its shallow lines. JGit follows its lead (though
it correctly is strict on the parsing end about wanting a
hex object id).

We do not adjust fetch-pack to send newlines here, as it
would break communication with older versions of git (and
there is no actual benefit to doing so, except for
consistency with other parts of the protocol).

Signed-off-by: Jeff King <peff@peff.net>
---
I couldn't trigger anything interestingly malicious from this, but I
didn't look very hard. Maybe somebody who knows the shallow protocol
better could think of something clever (not that it matters much).

 upload-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 30146a0..b058e8d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -596,7 +596,7 @@ static void receive_needs(void)
 		if (!prefixcmp(line, "shallow ")) {
 			unsigned char sha1[20];
 			struct object *object;
-			if (get_sha1(line + 8, sha1))
+			if (get_sha1_hex(line + 8, sha1))
 				die("invalid shallow line: %s", line);
 			object = parse_object(sha1);
 			if (!object)
-- 
1.8.2.rc0.9.g352092c
