From: Roger Gammans <rgammans@gammascience.co.uk>
Subject: [PATCH/RFC] Add --force-seen option to git-fast-export
Date: Tue, 1 Jul 2014 17:28:08 +0100
Message-ID: <S1758643AbaGATZM/20140701192515Z+27@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 21:25:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X23g8-0005VB-1e
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 21:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758643AbaGATZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 15:25:12 -0400
Received: from 82-68-162-46.dsl.in-addr.zen.co.uk ([82.68.162.46]:57190 "EHLO
	bath.backslashat.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752050AbaGATZL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 15:25:11 -0400
X-Greylist: delayed 2446 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jul 2014 15:25:11 EDT
Received: from roger by bath.backslashat.org with local (Exim 4.82)
	(envelope-from <roger@backslashat.org>)
	id 1X232U-0002jq-P1
	for git@vger.kernel.org; Tue, 01 Jul 2014 19:44:22 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252740>

I've been playing with git-stitch-repo and similar tools all
of which seem to use the fast export to get their input data with.

I have need to provide these tools with a hints file so they can
be given the extra metadata about parents - to do this they need
to be able to decode marks->commit id's reliably. 

git-stitch-repo reads it input direct from git-fast-export in a 
pipe, so I could change that (by reading from saved output files)
or modify git to have a mode to ensure that the mark/commit id map
could be made stable.

I've chosen the later (mainly because it occurred to me first - but
it does seem the simpler to code )

There are no tests yet, and I'm not entirely sure I like the
new options name.

Comments welcome.

-- Patch follows ->

Allow the use of --import/export-marks options to guarantee
stability of the marks assigned to commits for tools that use
the fast-export format to manipulate history.

Signed-off-by: Roger Gammans <rgammans@gammascience.co.uk>
---
 Documentation/git-fast-export.txt |  5 +++++
 builtin/fast-export.c             | 15 ++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 221506b..10f58fa 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -81,6 +81,11 @@ If the backend uses a similar \--import-marks file, this allows for
 incremental bidirectional exporting of the repository by keeping the
 marks the same across runs.
 
+--force-seen::
+	Only meaningful with \--import-marks . This prevents the suppression
+	of commits listed the \--import-marks file from being exported again.
+	The allows multiple runs with a guaranteed marks/commit id stability
+
 --fake-missing-tagger::
 	Some old repositories have tags without a tagger.  The
 	fast-import protocol was pretty strict about that, and did not
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index ef44816..06f0366 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -29,6 +29,7 @@ static enum { ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = ABORT
 static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ERROR;
 static int fake_missing_tagger;
 static int use_done_feature;
+static int force_seen;
 static int no_data;
 static int full_tree;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
@@ -324,13 +325,18 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
 			export_blob(diff_queued_diff.queue[i]->two->sha1);
 
-	mark_next_object(&commit->object);
+	uint32_t mark = get_object_mark(&commit->object);
+	if (! mark) {
+		mark_next_object(&commit->object);
+		mark = last_idnum;
+	}
+
 	if (!is_encoding_utf8(encoding))
 		reencoded = reencode_string(message, "UTF-8", encoding);
 	if (!commit->parents)
 		printf("reset %s\n", (const char*)commit->util);
 	printf("commit %s\nmark :%"PRIu32"\n%.*s\n%.*s\ndata %u\n%s",
-	       (const char *)commit->util, last_idnum,
+	       (const char *)commit->util, mark,
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer,
 	       (unsigned)(reencoded
@@ -668,7 +674,8 @@ static void import_marks(char *input_file)
 
 		mark_object(object, mark);
 
-		object->flags |= SHOWN;
+		if (! force_seen )
+			object->flags |= SHOWN;
 	}
 	fclose(f);
 }
@@ -713,6 +720,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			 N_("Output full tree for each commit")),
 		OPT_BOOL(0, "use-done-feature", &use_done_feature,
 			     N_("Use the done feature to terminate the stream")),
+		OPT_BOOL(0, "force-seen", &force_seen,
+			     N_("Output commit and blobs even if in an imported marks-file")),
 		OPT_BOOL(0, "no-data", &no_data, N_("Skip output of blob data")),
 		OPT_STRING_LIST(0, "refspec", &refspecs_list, N_("refspec"),
 			     N_("Apply refspec to exported refs")),
-- 
1.8.5.1
