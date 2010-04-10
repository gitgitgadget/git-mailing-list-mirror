From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCH] Notes: Connect the %N flag to --{show,no}-notes
Date: Sat, 10 Apr 2010 23:30:32 +0200
Message-ID: <1270935032-10536-1-git-send-email-heipei@hackvalue.de>
References: <7vaatbw00u.fsf@alter.siamese.dyndns.org>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Gilger <heipei@hackvalue.de>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 10 23:30:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0iGD-0003yy-NO
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 23:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075Ab0DJVa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 17:30:27 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:57198 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab0DJVa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 17:30:27 -0400
Received: from u-6-099.vpn.rwth-aachen.de ([137.226.102.99]:39238 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1O0iFx-0001dw-5D; Sat, 10 Apr 2010 23:30:21 +0200
X-Mailer: git-send-email 1.7.0.2.201.g80978
In-Reply-To: <7vaatbw00u.fsf@alter.siamese.dyndns.org>
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.102.99
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144597>

This improves the behaviour of the %N flag when using --pretty:

- If only --pretty is used, notes will only be initialized if %N is
  actually part of the format.
- If %N and --no-notes is used, %N will expand to the empty string.
- Behaviour for regular log with --no-notes and --show-notes remains the
  same.

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
I reread a lot of code and think I've found a solution that's intuitive and
doesn't automatically initialize the trees with --pretty unless %N is actually
used. Basically what could happen is this:

- --show-notes (with eventual options) is supplied and
  init_display_notes(&rev.notes_opt) is called from log.c, %N is sucessfully
  expanded

- Only %N is used, no --no-notes was supplied. format_display_notes is called,
  notices the missing notes_trees and initializes it. this obviously happens
  only if an %N is used, otherwise no display trees will be initialized.
  init_display_notes could not have been called with any other options, since
  no --show-notes was given, so NULL is fine here.

- %N is used and --no-notes is supplied, format_display_notes is not
  called and %N is expanded to the empty string. This last case also
  applies to --pretty=full etc.

I tested a lot of cases and tried to make sure I understood all the possible
caveats. If you have any further questions feel free to ask.

 builtin/log.c |    4 ++--
 notes.c       |    4 +++-
 pretty.c      |    7 ++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index b706a5f..029d7b8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -58,9 +58,9 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		usage(builtin_log_usage);
 	argc = setup_revisions(argc, argv, rev, opt);
 
-	if (!rev->show_notes_given && !rev->pretty_given)
+	if (!rev->show_notes_given)
 		rev->show_notes = 1;
-	if (rev->show_notes)
+	if (rev->show_notes && (!rev->pretty_given || rev->show_notes_given))
 		init_display_notes(&rev->notes_opt);
 
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
diff --git a/notes.c b/notes.c
index e425e19..ad14a8b 100644
--- a/notes.c
+++ b/notes.c
@@ -1183,7 +1183,9 @@ void format_display_notes(const unsigned char *object_sha1,
 			  struct strbuf *sb, const char *output_encoding, int flags)
 {
 	int i;
-	assert(display_notes_trees);
+	if(!display_notes_trees)
+		init_display_notes(NULL);
+
 	for (i = 0; display_notes_trees[i]; i++)
 		format_note(display_notes_trees[i], object_sha1, sb,
 			    output_encoding, flags);
diff --git a/pretty.c b/pretty.c
index 6ba3da8..8e828a1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -775,9 +775,10 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
-		format_display_notes(commit->object.sha1, sb,
-			    git_log_output_encoding ? git_log_output_encoding
-						    : git_commit_encoding, 0);
+		if (c->pretty_ctx->show_notes)
+			format_display_notes(commit->object.sha1, sb,
+					     git_log_output_encoding ? git_log_output_encoding
+					     : git_commit_encoding, 0);
 		return 1;
 	}
 
-- 
1.7.0.2.201.g80978
