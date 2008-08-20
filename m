From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] allow '%d' pretty format specifier to show decoration
Date: Wed, 20 Aug 2008 14:00:34 -0400
Message-ID: <20080820180034.GB32005@sigill.intra.peff.net>
References: <20080820175325.GD27773@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Wed Aug 20 20:02:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVs06-00053f-BZ
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 20:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbYHTSAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 14:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbYHTSAi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 14:00:38 -0400
Received: from peff.net ([208.65.91.99]:4364 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbYHTSAh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 14:00:37 -0400
Received: (qmail 25761 invoked by uid 111); 20 Aug 2008 18:00:36 -0000
Received: from lawn-128-61-25-158.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.25.158)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 20 Aug 2008 14:00:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Aug 2008 14:00:34 -0400
Content-Disposition: inline
In-Reply-To: <20080820175325.GD27773@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93004>

Previously, specifying

  git log --pretty=format:'%H %s' --decorate

would calculate decorations, but not show them. You can now
do:

  git log --pretty=format:'%H (%d) %s' --decorate

to see them.

Signed-off-by: Jeff King <peff@peff.net>
---
There is a lot of room for discussion here.

For example:

  - what should %d show? Right now it shows each decoration, split by
    commas. It doesn't show the enclosing parentheses automatically.

    Is this too strict? Should there be some way of pulling out
    individual decorations from the list, or specifying a different
    delimiter? If so, probably that should be part of a general
    improvement in the format expansion macro language.

    Is it too loose? Perhaps the enclosing parentheses should be
    automatic, so that %d expands to nothing if there is no decoration,
    or the whole thing otherwise. Right now you are stuck with empty ()
    if there is no decoration. Alternatively, we could support some kind
    of conditional expansion in the formatting language (but I don't
    know how crazy we want to get wit new formatting features).

  - should this turn on --decorate automatically? If you use '%d'
    without --decorate, you will just get no decorations. I think that
    makes sense, though, since that opens room for specifying other
    types of decorations (e.g., there could be a --decorate-tags that
    only looks at tags).

 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index c11d495..55a5954 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -116,6 +116,7 @@ The placeholders are:
 - '%cr': committer date, relative
 - '%ct': committer date, UNIX timestamp
 - '%ci': committer date, ISO 8601 format
+- '%d': decoration (if you specified --decorate)
 - '%e': encoding
 - '%s': subject
 - '%b': body
diff --git a/pretty.c b/pretty.c
index 33ef34a..00f19e1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -519,6 +519,21 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 			return 3;
 		} else
 			return 0;
+	case 'd':
+		{
+			struct name_decoration *d;
+			const char *prefix = "";
+			d = lookup_decoration(&name_decoration,
+					&commit->object);
+			while (d) {
+				strbuf_addstr(sb, prefix);
+				prefix = ", ";
+				strbuf_addstr(sb, d->name);
+				d = d->next;
+			}
+		}
+		return 1;
+
 	}
 
 	/* these depend on the commit */
-- 
1.6.0.90.g00a5c.dirty
