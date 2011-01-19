From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] fast-export: Introduce --inline-blobs
Date: Wed, 19 Jan 2011 11:14:58 +0530
Message-ID: <1295415899-1192-5-git-send-email-artagnon@gmail.com>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 19 06:44:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfQqY-0001OM-A9
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 06:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab1ASFoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 00:44:30 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55115 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1ASFo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 00:44:29 -0500
Received: by gxk9 with SMTP id 9so124270gxk.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 21:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=g80226G9J07mB+DgQz/ARW1ZspFzdPAhndq1m5VoJKw=;
        b=H4XbX6dtZBvDhmxZwCqfyzu5SIXIMtmDGOXjosMLvQpJ+xJPiiQisChmUSSpPmN9iI
         4kyoGOLE1rarXcsvkQ/3E7EUa+pVHEsRVISUaKzUmnOW+xLJfA4J/0ovlLkTbtmkYmR4
         bYtJKr0HPSWz9V/HyVtxR5UI+2AYloLvbhwCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xCiR02UsiPgPRVz8f4zpG7Xb/n0+bTUc1PR4y6JCvBNdHe1AZeVviHeo/LZYQbF9Yb
         HqD6XNnbTz+1DhFTib+qM4G2kgyZGK0Mrkv5z0+Jl4lOZPVQppIG5i1XWUbJ7dKxitO1
         45ovkZt6ugE11rt6jSfarXF/EMcCCgb5JWpq0=
Received: by 10.91.103.1 with SMTP id f1mr372699agm.182.1295415868675;
        Tue, 18 Jan 2011 21:44:28 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d15sm7968646ana.35.2011.01.18.21.44.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 21:44:28 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165242>

Introduce a new command-line option --inline-blobs that always inlines
blobs instead of referring to them via marks or their original SHA-1
hash.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-fast-export.txt |    5 +++++
 builtin/fast-export.c             |   23 +++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index e05b686..cd48b4b 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -90,6 +90,11 @@ marks the same across runs.
 	resulting stream can only be used by a repository which
 	already contains the necessary objects.
 
+--inline-blobs::
+	Inline all blobs, instead of referring to them via marks or
+	their original SHA-1 hash.  This is useful to parsers, as they
+	don't need to persist blobs.
+
 --full-tree::
 	This option will cause fast-export to issue a "deleteall"
 	directive for each commit followed by a full list of all files
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c8fd46b..202a3b9 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -27,6 +27,7 @@ static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode = ABORT;
 static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ABORT;
 static int fake_missing_tagger;
 static int no_data;
+static int inline_blobs;
 static int full_tree;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -118,7 +119,7 @@ static void handle_object(const unsigned char *sha1)
 	char *buf;
 	struct object *object;
 
-	if (no_data)
+	if (no_data || inline_blobs)
 		return;
 
 	if (is_null_sha1(sha1))
@@ -218,7 +219,23 @@ static void show_filemodify(struct diff_queue_struct *q,
 			if (no_data || S_ISGITLINK(spec->mode))
 				printf("M %06o %s %s\n", spec->mode,
 				       sha1_to_hex(spec->sha1), spec->path);
-			else {
+			else if (inline_blobs) {
+				unsigned long size;
+				enum object_type type;
+				char *buf;
+
+				buf = read_sha1_file(spec->sha1, &type, &size);
+				if (!buf)
+					die ("Could not read blob %s",
+						sha1_to_hex(spec->sha1));
+				printf("M %06o inline %s\n", spec->mode, spec->path);
+				printf("data %lu\n", size);
+				if (size && fwrite(buf, size, 1, stdout) != 1)
+					die_errno ("Could not write blob '%s'",
+						sha1_to_hex(spec->sha1));
+				printf("\n");
+
+			} else {
 				struct object *object = lookup_object(spec->sha1);
 				printf("M %06o :%d %s\n", spec->mode,
 				       get_object_mark(object), spec->path);
@@ -627,6 +644,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			     "Fake a tagger when tags lack one"),
 		OPT_BOOLEAN(0, "full-tree", &full_tree,
 			     "Output full tree for each commit"),
+		OPT_BOOLEAN(0, "inline-blobs", &inline_blobs,
+			     "Output all blobs inline"),
 		{ OPTION_NEGBIT, 0, "data", &no_data, NULL,
 			"Skip output of blob data",
 			PARSE_OPT_NOARG | PARSE_OPT_NEGHELP, NULL, 1 },
-- 
1.7.4.rc1.7.g2cf08.dirty
