From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCH] pretty.c: Don't expand %N without --show-notes
Date: Sat, 10 Apr 2010 09:05:27 +0200
Message-ID: <1270883127-11488-1-git-send-email-heipei@hackvalue.de>
References: <201004061127.01471.trast@student.ethz.ch>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Gilger <heipei@hackvalue.de>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 10 09:05:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0UlS-0007CP-2z
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 09:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab0DJHFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 03:05:53 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:36971 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab0DJHFw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 03:05:52 -0400
Received: from u-6-099.vpn.rwth-aachen.de ([137.226.102.99]:45734 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1O0UlF-0007VU-I4; Sat, 10 Apr 2010 09:05:45 +0200
X-Mailer: git-send-email 1.7.0.2.201.g80978
In-Reply-To: <201004061127.01471.trast@student.ethz.ch>
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.102.99
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144522>

The %N placeholder will only work if --show-notes was provided to log.
By not expanding the user is given feedback that he won't be shown any
notes.

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
 Ok, this is another stab. I don't really know whether we want %N to expand to
 an empty string or not expand at all in case of no --show-notes. Obviously
 using 'return 1;' would implement the former behaviour, while I chose the
 latter because it prevents people like me from building useless log aliases.

 Documentation/pretty-formats.txt |    3 ++-
 pretty.c                         |    3 +++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 1686a54..bf7813f 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -143,7 +143,8 @@ NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
 insert an empty string unless we are traversing reflog entries (e.g., by
 `git log -g`). The `%d` placeholder will use the "short" decoration
-format if `--decorate` was not already provided on the command line.
+format if `--decorate` was not already provided on the command line. The %N
+placeholder won't be expanded unless `--show-notes` was provided.
 
 If you add a `{plus}` (plus sign) after '%' of a placeholder, a line-feed
 is inserted immediately before the expansion if and only if the
diff --git a/pretty.c b/pretty.c
index 6ba3da8..b39e2d5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -775,6 +775,9 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
+		if (!c->pretty_ctx->show_notes)
+			return 0;
+
 		format_display_notes(commit->object.sha1, sb,
 			    git_log_output_encoding ? git_log_output_encoding
 						    : git_commit_encoding, 0);
-- 
1.7.0.2.201.g80978
