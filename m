From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/3] fast-export: add --signed-tags=warn-strip mode
Date: Sun, 14 Apr 2013 11:57:06 +0100
Message-ID: <8716b887972b0eb1671afd2692416efd588f7d1d.1365936811.git.john@keeping.me.uk>
References: <CAGdFq_g+kk-Fy1fcV6D5x4kroRXX63T8wjKNUqqfu39wUkSO6A@mail.gmail.com>
 <cover.1365936811.git.john@keeping.me.uk>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 14 12:57:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URKcu-0002hF-HE
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 12:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab3DNK5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 06:57:36 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:48204 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab3DNK5f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 06:57:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E8D666064C8;
	Sun, 14 Apr 2013 11:57:34 +0100 (BST)
X-Quarantine-ID: <aLwnWG3IJxnb>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aLwnWG3IJxnb; Sun, 14 Apr 2013 11:57:34 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 3DDE760650E;
	Sun, 14 Apr 2013 11:57:25 +0100 (BST)
X-Mailer: git-send-email 1.8.2.694.ga76e9c3.dirty
In-Reply-To: <cover.1365936811.git.john@keeping.me.uk>
In-Reply-To: <cover.1365936811.git.john@keeping.me.uk>
References: <cover.1365936811.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221093>

This issues a warning while stripping signatures from signed tags, which
allows us to use it as default behaviour for remote helpers which cannot
specify how to handle signed tags.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-fast-export.txt | 10 ++++++----
 builtin/fast-export.c             |  8 +++++++-
 t/t9350-fast-export.sh            |  6 ++++++
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index feab7a3..03fc8c3 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -27,15 +27,17 @@ OPTIONS
 	Insert 'progress' statements every <n> objects, to be shown by
 	'git fast-import' during import.
 
---signed-tags=(verbatim|warn|strip|abort)::
+--signed-tags=(verbatim|warn|warn-strip|strip|abort)::
 	Specify how to handle signed tags.  Since any transformation
 	after the export can change the tag names (which can also happen
 	when excluding revisions) the signatures will not match.
 +
 When asking to 'abort' (which is the default), this program will die
-when encountering a signed tag.  With 'strip', the tags will be made
-unsigned, with 'verbatim', they will be silently exported
-and with 'warn', they will be exported, but you will see a warning.
+when encountering a signed tag.  With 'strip', the tags will silently
+be made unsigned, with 'warn-strip' they will be made unsigned but a
+warning will be displayed, with 'verbatim', they will be silently
+exported and with 'warn', they will be exported, but you will see a
+warning.
 
 --tag-of-filtered-object=(abort|drop|rewrite)::
 	Specify how to handle tags whose tagged object is filtered out.
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 725c0a7..d60d675 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -24,7 +24,7 @@ static const char *fast_export_usage[] = {
 };
 
 static int progress;
-static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode = ABORT;
+static enum { ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = ABORT;
 static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ERROR;
 static int fake_missing_tagger;
 static int use_done_feature;
@@ -40,6 +40,8 @@ static int parse_opt_signed_tag_mode(const struct option *opt,
 		signed_tag_mode = VERBATIM;
 	else if (!strcmp(arg, "warn"))
 		signed_tag_mode = WARN;
+	else if (!strcmp(arg, "warn-strip"))
+		signed_tag_mode = WARN_STRIP;
 	else if (!strcmp(arg, "strip"))
 		signed_tag_mode = STRIP;
 	else
@@ -428,6 +430,10 @@ static void handle_tag(const char *name, struct tag *tag)
 				/* fallthru */
 			case VERBATIM:
 				break;
+			case WARN_STRIP:
+				warning ("Stripping signature from tag %s",
+					 sha1_to_hex(tag->object.sha1));
+				/* fallthru */
 			case STRIP:
 				message_size = signature + 1 - message;
 				break;
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 9320b4f..2471bc6 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -146,6 +146,12 @@ test_expect_success 'signed-tags=strip' '
 
 '
 
+test_expect_success 'signed-tags=warn-strip' '
+	git fast-export --signed-tags=warn-strip sign-your-name >output 2>err &&
+	! grep PGP output &&
+	test -s err
+'
+
 test_expect_success 'setup submodule' '
 
 	git checkout -f master &&
-- 
1.8.2.694.ga76e9c3.dirty
