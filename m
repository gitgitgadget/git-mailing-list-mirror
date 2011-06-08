From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 11/19] fast-export: support done feature
Date: Wed,  8 Jun 2011 20:48:42 +0200
Message-ID: <1307558930-16074-12-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNpM-00087c-N0
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955Ab1FHStz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:55 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49219 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab1FHSto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:44 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so282606ewy.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=e0CwJdN5jDMyZ7WxfSQlxeeAO0vEgv0mRFvX/nxFWeQ=;
        b=O8BsmmbRJzJBglvHlAubxG3pJ4w/JcRC8Cvg71E+kD3KbULIvh3Sf2Gess9AUXDTPI
         IDt94+qh5Nou2fLe8snHWHCR6Yi2tO/sa5NEWznkPrusZF6m/bWOTq9oGm1aQ+EZvYGU
         V7MDF4LeBBiIvBqcHTycQL6/jwIx1Xlb2gaGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fuZD5iBsb1rVxqbNBqr0XwO3RJ+EPOr+D5O3wOUXj0e0UMzvbAXE4AgQvJHBBmVAfw
         0C8fpc/iO0lWw+mkmX65r1vWmoH4tKCv1csm/zLERMp3GKlmf8yS7P6ANKNrCdQV98NU
         LcCqNj4Hn4d/YKd+npUiwx2dgwpCr50oep19U=
Received: by 10.213.34.74 with SMTP id k10mr2149371ebd.98.1307558983424;
        Wed, 08 Jun 2011 11:49:43 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175429>

If fast-export is being used to generate a fast-import stream that
will be used afterwards it is desirable to indicate the end of the
stream with the new 'done' command.

Add a flag that causes fast-export to end with 'done'.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged from my original series.

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
