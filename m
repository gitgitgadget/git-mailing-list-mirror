From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] revision.c: introduce --notes-ref= to use one notes ref only
Date: Tue, 29 Mar 2011 12:05:09 +0200
Message-ID: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 12:08:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Vr2-00065K-Pk
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 12:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab1C2KIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 06:08:47 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:51072 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752249Ab1C2KIq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 06:08:46 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 46AF620298;
	Tue, 29 Mar 2011 06:08:46 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 29 Mar 2011 06:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=gYqPEIe3R4WWsG4SIVd1EMcNu1w=; b=roqoDJb9o6kuNNXryXhfcEKJPwR3pEFa7mXhK/3oeeLHvaDmGmIXypZpgZlWCIPI2lvUHg7tlZJXYu4Vv4dz82Udv2USLzxZbweGRMOvIsOdTWl4tpILrDIFZQU/GfUGgAjbuQ5S4S2myGczyRLc/S34/wGeEtd5uRvVUDfEVBE=
X-Sasl-enc: axHaJiHhvpnPxvgOhBB8PLsnRhlVLh1y8sdAY8Z75qSg 1301393325
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8E40F448927;
	Tue, 29 Mar 2011 06:08:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.607.g888da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170251>

As notes become increasingly popular, it's often interesting to show
notes from a particular notes ref only. Introduce '--notes-ref=<ref>'
as a convenience shortcut for '--no-standard-notes --show-notes=<ref>'.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
The idea is to use the same name as in "git notes --ref=<ref>" but make
it clear for the rev-list option to be about notes, thus "--notes-ref=<ref>".

 Documentation/git-log.txt        |    3 ++-
 Documentation/pretty-options.txt |    4 ++++
 revision.c                       |   15 +++++++++++----
 t/t3301-notes.sh                 |    5 +++++
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 2c84028..56ffccd 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -179,7 +179,8 @@ multiple times.  A warning will be issued for refs that do not exist,
 but a glob that does not match any refs is silently ignored.
 +
 This setting can be disabled by the `--no-standard-notes` option,
-overridden by the 'GIT_NOTES_DISPLAY_REF' environment variable,
+overridden by the 'GIT_NOTES_DISPLAY_REF' environment variable
+or the `--notes-ref` option,
 and supplemented by the `--show-notes` option.
 
 GIT
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 50923e2..ef5eed4 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -46,3 +46,7 @@ is taken to be in `refs/notes/` if it is not qualified.
 	'core.notesRef' and 'notes.displayRef' variables (or
 	corresponding environment overrides).  Enabled by default.
 	See linkgit:git-config[1].
+
+--notes-ref[=<ref>]::
+	This is the same as `--no-standard-notes --show-notes=<ref>`,
+	i.e. it shows only the notes from the notes tree at `<ref>`.
diff --git a/revision.c b/revision.c
index 0f38364..d620926 100644
--- a/revision.c
+++ b/revision.c
@@ -1368,19 +1368,26 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--show-notes")) {
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
-	} else if (!prefixcmp(arg, "--show-notes=")) {
+	} else if (!prefixcmp(arg, "--show-notes=") || !prefixcmp(arg, "--notes-ref=")) {
 		struct strbuf buf = STRBUF_INIT;
+		int offset = strlen("--show-notes=");
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
+		if (!prefixcmp(arg, "--notes-ref=")) {
+			offset = strlen("--notes-ref=");
+			if (revs->notes_opt.extra_notes_refs)
+				string_list_clear(revs->notes_opt.extra_notes_refs, 0);
+			revs->notes_opt.suppress_default_notes = 1;
+		}
 		if (!revs->notes_opt.extra_notes_refs)
 			revs->notes_opt.extra_notes_refs = xcalloc(1, sizeof(struct string_list));
-		if (!prefixcmp(arg+13, "refs/"))
+		if (!prefixcmp(arg+offset, "refs/"))
 			/* happy */;
-		else if (!prefixcmp(arg+13, "notes/"))
+		else if (!prefixcmp(arg+offset, "notes/"))
 			strbuf_addstr(&buf, "refs/");
 		else
 			strbuf_addstr(&buf, "refs/notes/");
-		strbuf_addstr(&buf, arg+13);
+		strbuf_addstr(&buf, arg+offset);
 		string_list_append(revs->notes_opt.extra_notes_refs,
 				   strbuf_detach(&buf, NULL));
 	} else if (!strcmp(arg, "--no-notes")) {
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 1921ca3..3fcfdc7 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -625,6 +625,11 @@ test_expect_success '--show-notes=ref accumulates' '
 	test_cmp expect-both-reversed output
 '
 
+test_expect_success '--notes-ref=' '
+	git log --notes-ref=other -1 > output &&
+	test_cmp expect-other output
+'
+
 test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
 	git config core.notesRef refs/notes/other &&
 	echo "Note on a tree" > expect &&
-- 
1.7.4.1.607.g888da
