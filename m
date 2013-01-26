From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] commit: drop useless xstrdup of commit message
Date: Sat, 26 Jan 2013 04:42:45 -0500
Message-ID: <20130126094236.GA6999@sigill.intra.peff.net>
References: <20130126094026.GA9646@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathon Mah <jmah@me.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 10:43:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tz2IM-0003fJ-Jn
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 10:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116Ab3AZJnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 04:43:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51364 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024Ab3AZJnH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 04:43:07 -0500
Received: (qmail 21135 invoked by uid 107); 26 Jan 2013 09:44:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Jan 2013 04:44:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jan 2013 04:42:45 -0500
Content-Disposition: inline
In-Reply-To: <20130126094026.GA9646@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214616>

When git-commit is asked to reuse a commit message via "-c",
we call read_commit_message, which looks up the commit and
hands back either the re-encoded result, or a copy of the
original. We make a copy in the latter case so that the
ownership semantics of the return value are clear (in either
case, it can be freed).

However, since we return a "const char *", and since the
resulting buffer's lifetime is the same as that of the whole
program, we never bother to free it at all.

Let's just drop the copy. That saves us a copy in the common
case. While it does mean we leak in the re-encode case, it
doesn't matter, since we are relying on program exit to free
the memory anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
This one isn't strictly necessary, but it makes it a lot more obvious
what is going on with the memory ownership of this code in the next
patch.

 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 38b9a9c..fbbb40f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -962,7 +962,7 @@ static const char *read_commit_message(const char *name)
 	 * encodings are identical.
 	 */
 	if (out == NULL)
-		out = xstrdup(commit->buffer);
+		out = commit->buffer;
 	return out;
 }
 
-- 
1.8.0.2.16.g72e2fc9
