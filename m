From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] add '%d' pretty format specifier to show decoration
Date: Thu, 04 Sep 2008 23:40:03 +0200
Message-ID: <48C055B3.3030204@lsrfire.ath.cx>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org> <20080903203616.GB32223@coredump.intra.peff.net> <7vsksh9c9m.fsf@gitster.siamese.dyndns.org> <48BF0A5A.2040502@lsrfire.ath.cx> <20080904035139.GA28123@sigill.intra.peff.net> <48C002FB.9010401@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Thu Sep 04 23:41:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbMZn-00012X-OA
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 23:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbYIDVkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 17:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754559AbYIDVkG
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 17:40:06 -0400
Received: from india601.server4you.de ([85.25.151.105]:47263 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbYIDVkF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 17:40:05 -0400
Received: from [10.0.1.200] (p57B7E7FB.dip.t-dialin.net [87.183.231.251])
	by india601.server4you.de (Postfix) with ESMTPSA id C515D2F8045;
	Thu,  4 Sep 2008 23:40:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <48C002FB.9010401@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94962>

Add a new format placeholder, %d, which expands to a ref name decoration
(think git log --decorate).  It expands to an empty string if the commit
has no decoration, or otherwise to a comma (and space) separated list of
decorations, surrounded by parentheses and a leading space.

Michael Dressel implemented an initial version and chose the letter d,
Junio suggested to add a leading space and parentheses.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 388d492..f18d33e 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -116,6 +116,7 @@ The placeholders are:
 - '%cr': committer date, relative
 - '%ct': committer date, UNIX timestamp
 - '%ci': committer date, ISO 8601 format
+- '%d': ref names, like the --decorate option of linkgit:git-log[1]
 - '%e': encoding
 - '%s': subject
 - '%b': body
diff --git a/pretty.c b/pretty.c
index a29c290..8beafa0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -5,6 +5,7 @@
 #include "revision.h"
 #include "string-list.h"
 #include "mailmap.h"
+#include "log-tree.h"
 
 static char *user_format;
 
@@ -481,6 +482,23 @@ static void parse_commit_header(struct format_commit_context *context)
 	context->commit_header_parsed = 1;
 }
 
+static void format_decoration(struct strbuf *sb, const struct commit *commit)
+{
+	struct name_decoration *d;
+	const char *prefix = " (";
+
+	load_ref_decorations();
+	d = lookup_decoration(&name_decoration, &commit->object);
+	while (d) {
+		strbuf_addstr(sb, prefix);
+		prefix = ", ";
+		strbuf_addstr(sb, d->name);
+		d = d->next;
+	}
+	if (prefix[0] == ',')
+		strbuf_addch(sb, ')');
+}
+
 static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
                                void *context)
 {
@@ -573,6 +591,9 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 		                 ? '<'
 		                 : '>');
 		return 1;
+	case 'd':
+		format_decoration(sb, commit);
+		return 1;
 	}
 
 	/* For the rest we have to parse the commit header. */
-- 
1.6.0.1.161.g7f314
