From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 02/13] fast-export: support done feature
Date: Sat, 28 Aug 2010 22:45:29 -0500
Message-ID: <1283053540-27042-3-git-send-email-srabbelier@gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 05:47:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpYrL-0006pV-VO
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 05:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab0H2Dq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 23:46:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab0H2DqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 23:46:13 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so3824467iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 20:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=iEuGQevsxUrNmzZcgVjyOKKh/BZgG+l9v2NCfPkSQyU=;
        b=EjUb1z5Kgg5hvrR8VvvHqOuB0LYPISQJKkhGWwf9TvCNP18JgIgEKlyfDGTPngQjEF
         lvbTYG8n4eLuzRRxxjzGZuBMH/FiRJY6y3F7YarAhfWSO6LAdG3GlT7HzO6BYUzpuNsI
         cY6+RHpPAN1xlHcLjMMdOw711qwWgom3Eu6mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QvLBecX+KuG5GtjZ4lOJXXNCRFCAdjk10TXkr4BCqDe04If47lXbJQR8QJNqG7QXoY
         974RsdwfjbeyCZIy/xxd1q73XalgzwZlpdXdVIVkzECCfOVhjnxlfHkD5HJoTlfhrugy
         IwotrK91vR9DdsgYRL/n4su90UU9Ta1upLudk=
Received: by 10.231.159.203 with SMTP id k11mr3263420ibx.115.1283053573111;
        Sat, 28 Aug 2010 20:46:13 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-237-184-184.dsl.chcgil.sbcglobal.net [76.237.184.184])
        by mx.google.com with ESMTPS id n20sm5647049ibe.17.2010.08.28.20.46.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 20:46:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.240.g6a95c3
In-Reply-To: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154676>

If fast-export is being used to generate a fast-import stream that
will be used afterwards it is desirable to indicate the end of the
stream with the new 'done' command.

Add a flag that causes fast-export to end with 'done'.
---

  Also very trivial, obviously if the corresponding feature is
  removed the flag should be named differently.

 Documentation/git-fast-export.txt |    4 ++++
 builtin/fast-export.c             |    9 +++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 98ec6b5..912562e 100644
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
index 9fe25ff..0c39c2e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -26,6 +26,7 @@ static int progress;
 static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode = ABORT;
 static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ABORT;
 static int fake_missing_tagger;
+static int use_done_feature;
 static int no_data;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -584,6 +585,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			     "Import marks from this file"),
 		OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
 			     "Fake a tagger when tags lack one"),
+		OPT_BOOLEAN(0, "use-done-feature", &use_done_feature,
+			     "Use the done feature to terminate the stream"),
 		{ OPTION_NEGBIT, 0, "data", &no_data, NULL,
 			"Skip output of blob data",
 			PARSE_OPT_NOARG | PARSE_OPT_NEGHELP, NULL, 1 },
@@ -605,6 +608,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (argc > 1)
 		usage_with_options (fast_export_usage, options);
 
+	if (use_done_feature)
+		printf("feature done\n");
+
 	if (import_filename)
 		import_marks(import_filename);
 
@@ -629,5 +635,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (export_filename)
 		export_marks(export_filename);
 
+	if (use_done_feature)
+		printf("done\n");
+
 	return 0;
 }
-- 
1.7.2.1.240.g6a95c3
