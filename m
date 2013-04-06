From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] fast-export: Allow pruned-references in mark file
Date: Sat,  6 Apr 2013 19:04:31 +0200
Message-ID: <1365267871-2904-1-git-send-email-apelisse@gmail.com>
References: <CALWbr2x4aia4DcdnmfEEBsZwCYasTEp2Jc0jwJgvsUqWSDaWTQ@mail.gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 20:00:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWaX-0005z6-6t
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab3DFREv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 13:04:51 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:38563 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab3DFREu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 13:04:50 -0400
Received: by mail-we0-f171.google.com with SMTP id d46so3631216wer.16
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 10:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=1toQ1lqYgVsuhesB5RTlzldHWUp4ERgewqEpczsgetU=;
        b=0giCgFNWdpUsl/QEcot0o4eSbvNPKcidh1/IokpAo7vETwJ+8wUNmTM6oOtPQUk0Ue
         7D5nKJvIuq55N1xdX0+5trXC8ahcAP+QaebwPLoL0KKbPZ1dBjIZ+r1sd+ykXqYAJOds
         Yl6MrvJVXMtDS4X1nBSQa/EJ7SuqbsFc7zK+JOP30hivGjwlpiSabuHNxzDt5YcYKqGR
         UD/Eceq4kZbeK37vtGeZ2nX09lelU+b84EOHt8W5RLLh/lGzA1wa3AYlgiHDogdTBxpa
         fFRxLTD/6kCnvn2dLIASRF//Ie9cVE4d2e8ptKfuwauvYB29Dv2yQ3Rnq5bdnrh56Q9S
         eh+Q==
X-Received: by 10.180.73.212 with SMTP id n20mr4934017wiv.11.1365267889502;
        Sat, 06 Apr 2013 10:04:49 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id bo1sm11357559wib.0.2013.04.06.10.04.48
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 06 Apr 2013 10:04:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CALWbr2x4aia4DcdnmfEEBsZwCYasTEp2Jc0jwJgvsUqWSDaWTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220250>

fast-export can fail because of some pruned-reference when importing a
mark file.

The problem happens in the following scenario:

    $ git fast-export --export-marks=MARKS master
    (rewrite master)
    $ git prune
    $ git fast-export --import-marks=MARKS master

This might fail if some references have been removed by prune
because some marks will refer to no longer existing commits.
git-fast-export will not need these objects anyway as they were no
longer reachable.

We still need to update last_numid so we don't change the mapping
between marks and objects for remote-helpers.
Unfortunately, the mark file should not be rewritten without lost marks
if no new objects has been exported, as we could lose track of the last
last_numid.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 Documentation/git-fast-export.txt |    2 ++
 builtin/fast-export.c             |   11 +++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index d6487e1..feab7a3 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -66,6 +66,8 @@ produced incorrect results if you gave these options.
 	incremental runs.  As <file> is only opened and truncated
 	at completion, the same path can also be safely given to
 	\--import-marks.
+	The file will not be written if no new object has been
+	marked/exported.
 
 --import-marks=<file>::
 	Before processing any input, load the marks specified in
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d380155..f44b76c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -618,9 +618,12 @@ static void import_marks(char *input_file)
 			|| *mark_end != ' ' || get_sha1(mark_end + 1, sha1))
 			die("corrupt mark line: %s", line);
 
+		if (last_idnum < mark)
+			last_idnum = mark;
+
 		object = parse_object(sha1);
 		if (!object)
-			die ("Could not read blob %s", sha1_to_hex(sha1));
+			continue;
 
 		if (object->flags & SHOWN)
 			error("Object %s already has a mark", sha1_to_hex(sha1));
@@ -630,8 +633,6 @@ static void import_marks(char *input_file)
 			continue;
 
 		mark_object(object, mark);
-		if (last_idnum < mark)
-			last_idnum = mark;
 
 		object->flags |= SHOWN;
 	}
@@ -645,6 +646,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 	struct commit *commit;
 	char *export_filename = NULL, *import_filename = NULL;
+	uint32_t lastimportid;
 	struct option options[] = {
 		OPT_INTEGER(0, "progress", &progress,
 			    N_("show progress after <n> objects")),
@@ -688,6 +690,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	if (import_filename)
 		import_marks(import_filename);
+	lastimportid = last_idnum;
 
 	if (import_filename && revs.prune_data.nr)
 		full_tree = 1;
@@ -710,7 +713,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	handle_tags_and_duplicates(&extra_refs);
 
-	if (export_filename)
+	if (export_filename && lastimportid != last_idnum)
 		export_marks(export_filename);
 
 	if (use_done_feature)
-- 
1.7.9.5
