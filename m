From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 12/20] fast-export: support done feature
Date: Sun, 19 Jun 2011 17:18:37 +0200
Message-ID: <1308496725-22329-13-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:20:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJnX-00042G-Mw
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab1FSPUC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:20:02 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52873 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396Ab1FSPTy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:19:54 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so294388eyx.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=TfOuPpsmtu/D2gHcYoyPVWDkq/VKatnmW0RceGiy6i0=;
        b=B8VpEL5/25JN5LXjxXKSXbenYuJNk8NTw9lskZGHf6GpqYE57Le1JiEF/eTb7n5+nR
         Q39XZPE03cmdIwfZWJMAko3rb+F/nynjAZEZMW6RLiOWup+YIUHf4nTe7upficVPkmHJ
         L09XcC62iR4Rvkq0Mw+T7aOj11QuVYZJT5FUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=er4o3fv6hiQQEymrtjCplHx/QX7SznMWve1+7lIkXL6oUy7YVaE1YlxXTgyG2lMYcr
         XhcQHfLRkaN0l2bUaQMBwHPThdkzea4V4VEK7XCaTDoTA3W8huA5JYu3Pctzl5w2fshM
         nN5df2FHQ07vFRolVsBPiCpSe/tc5FaFHFaTc=
Received: by 10.14.16.89 with SMTP id g65mr1683093eeg.242.1308496794005;
        Sun, 19 Jun 2011 08:19:54 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.19.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:19:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176014>

If fast-export is being used to generate a fast-import stream that
will be used afterwards it is desirable to indicate the end of the
stream with the new 'done' command.

Add a flag that causes fast-export to end with 'done'.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged.

 Documentation/git-fast-export.txt |    4 ++++
 builtin/fast-export.c             |    9 +++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 781bd6e..e3f8453 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -82,6 +82,10 @@ marks the same across runs.
 	allow that.  So fake a tagger to be able to fast-import the
 	output.
 
+--use-done-feature::
+	Start the stream with a 'feature done' stanza, and terminate
+	it with a 'done' command.
+
 --no-data::
 	Skip output of blob objects and instead refer to blobs via
 	their original SHA-1 hash.  This is useful when rewriting the
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index daf1945..becef85 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -26,6 +26,7 @@ static int progress;
 static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode = ABORT;
 static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ABORT;
 static int fake_missing_tagger;
+static int use_done_feature;
 static int no_data;
 static int full_tree;
 
@@ -627,6 +628,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			     "Fake a tagger when tags lack one"),
 		OPT_BOOLEAN(0, "full-tree", &full_tree,
 			     "Output full tree for each commit"),
+		OPT_BOOLEAN(0, "use-done-feature", &use_done_feature,
+			     "Use the done feature to terminate the stream"),
 		{ OPTION_NEGBIT, 0, "data", &no_data, NULL,
 			"Skip output of blob data",
 			PARSE_OPT_NOARG | PARSE_OPT_NEGHELP, NULL, 1 },
@@ -648,6 +651,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (argc > 1)
 		usage_with_options (fast_export_usage, options);
 
+	if (use_done_feature)
+		printf("feature done\n");
+
 	if (import_filename)
 		import_marks(import_filename);
 
@@ -675,5 +681,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (export_filename)
 		export_marks(export_filename);
 
+	if (use_done_feature)
+		printf("done\n");
+
 	return 0;
 }
-- 
1.7.5.1.292.g728120
