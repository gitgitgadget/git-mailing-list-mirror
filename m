From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 14/14] dir.c: git-status --ignored: don't scan the work
 tree twice
Date: Mon, 15 Apr 2013 21:15:03 +0200
Message-ID: <516C51B7.7080305@gmail.com>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 15 21:15:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URory-0001DY-Vk
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933603Ab3DOTPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:15:07 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:64116 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932986Ab3DOTPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:15:05 -0400
Received: by mail-ea0-f181.google.com with SMTP id z10so2415091ead.40
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=n35H8G4QTuI+RzuK+NU3qjHzIPeFy/MpjQ7w/ttFRhY=;
        b=BJ2X957EKpIDPr2CyYaeS4wVm3BF68sPbjwm5Ds4z+FbEAe5Zu2QLzNGMOLv2p6jwl
         xUW9YwpB1VDrZV7aawMLchwHigBY9XGq2dAZfKkbytGu6F2WcYFCGqs02zgRsKTZfUFS
         1iywRElptu1iQOwPxlMGOTT2SHMH2OgJwY2LkPwn3D5lHrhQHras++BxVaC+Fea3sNt5
         7L4HIvmG7N62tw4YdmN8T+ELaC82LUaO+EBzJkwfA66fbfV/wnm5IZrULv/yOe76JsNn
         ed8QUl9NgUjYaKoB6XNaFJbGUcg2QOvT9mBzCCIWBxY6mCmo0fLMWl0qdQZSzd6He7Dn
         MFGQ==
X-Received: by 10.15.98.66 with SMTP id bi42mr43979704eeb.39.1366053304162;
        Mon, 15 Apr 2013 12:15:04 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id 8sm11679138eeg.15.2013.04.15.12.15.02
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 12:15:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516C4F27.30203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221304>

'git-status --ignored' still scans the work tree twice to collect
untracked and ignored files, respectively.

fill_directory / read_directory already supports collecting untracked and
ignored files in a single directory scan. However, the DIR_COLLECT_IGNORED
flag to enable this has some git-add specific side-effects (e.g. it
doesn't recurse into ignored directories, so listing ignored files with
--untracked=all doesn't work).

The DIR_SHOW_IGNORED flag doesn't list untracked files and returns ignored
files in dir_struct.entries[] (instead of dir_struct.ignored[] as
DIR_COLLECT_IGNORED). DIR_SHOW_IGNORED is used all throughout git.

We don't want to break the existing API, so lets introduce a new flag
DIR_SHOW_IGNORED_TOO that lists untracked as well as ignored files similar
to DIR_COLLECT_FILES, but will recurse into sub-directories based on the
other flags as DIR_SHOW_IGNORED does.

In dir.c::read_directory_recursive, add ignored files to either
dir_struct.entries[] or dir_struct.ignored[] based on the flags. Also move
the DIR_COLLECT_IGNORED case here so that filling result lists is in a
common place.

In wt-status.c::wt_status_collect_untracked, use the new flag and read
results from dir_struct.ignored[]. Remove the extra fill_directory call.

builtin/check-ignore.c doesn't call fill_directory, setting the git-add
specific DIR_COLLECT_IGNORED flag has no effect here. Remove for clarity.

Update API documentation to reflect the changes.

Performance: with this patch, 'git-status --ignored' is typically as fast
as 'git-status'.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/technical/api-directory-listing.txt | 25 ++++++++++++++++++++---
 builtin/check-ignore.c                            |  1 -
 dir.c                                             | 10 +++++----
 dir.h                                             |  3 ++-
 wt-status.c                                       | 24 ++++++++++------------
 5 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index 1f349b2..7f8e78d 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -22,12 +22,23 @@ The notable options are:
 
 `flags`::
 
-	A bit-field of options:
+	A bit-field of options (the `*IGNORED*` flags are mutually exclusive):
 
 `DIR_SHOW_IGNORED`:::
 
-	The traversal is for finding just ignored files, not unignored
-	files.
+	Return just ignored files in `entries[]`, not untracked files.
+
+`DIR_SHOW_IGNORED_TOO`:::
+
+	Similar to `DIR_SHOW_IGNORED`, but return ignored files in `ignored[]`
+	in addition to untracked files in `entries[]`.
+
+`DIR_COLLECT_IGNORED`:::
+
+	Special mode for git-add. Return ignored files in `ignored[]` and
+	untracked files in `entries[]`. Only returns ignored files that match
+	pathspec exactly (no wildcards). Does not recurse into ignored
+	directories.
 
 `DIR_SHOW_OTHER_DIRECTORIES`:::
 
@@ -57,6 +68,14 @@ The result of the enumeration is left in these fields:
 
 	Internal use; keeps track of allocation of `entries[]` array.
 
+`ignored[]`::
+
+	An array of `struct dir_entry`, used for ignored paths with the
+	`DIR_SHOW_IGNORED_TOO` and `DIR_COLLECT_IGNORED` flags.
+
+`ignored_nr`::
+
+	The number of members in `ignored[]` array.
 
 Calling sequence
 ----------------
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 7388346..854a88a 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -66,7 +66,6 @@ static int check_ignore(const char *prefix, const char **pathspec)
 		die(_("index file corrupt"));
 
 	memset(&dir, 0, sizeof(dir));
-	dir.flags |= DIR_COLLECT_IGNORED;
 	setup_standard_excludes(&dir);
 
 	if (!pathspec || !*pathspec) {
diff --git a/dir.c b/dir.c
index 5770ed4..847e2f2 100644
--- a/dir.c
+++ b/dir.c
@@ -1139,15 +1139,12 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		return path_none;
 
 	exclude = is_excluded(dir, path->buf, &dtype);
-	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
-	    && exclude_matches_pathspec(path->buf, path->len, simplify))
-		dir_add_ignored(dir, path->buf, path->len);
 
 	/*
 	 * Excluded? If we don't explicitly want to show
 	 * ignored files, ignore it
 	 */
-	if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
+	if (exclude && !(dir->flags & (DIR_SHOW_IGNORED|DIR_SHOW_IGNORED_TOO)))
 		return path_excluded;
 
 	switch (dtype) {
@@ -1236,6 +1233,11 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		case path_excluded:
 			if (dir->flags & DIR_SHOW_IGNORED)
 				dir_add_name(dir, path.buf, path.len);
+			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
+				((dir->flags & DIR_COLLECT_IGNORED) &&
+				exclude_matches_pathspec(path.buf, path.len,
+					simplify)))
+				dir_add_ignored(dir, path.buf, path.len);
 			break;
 
 		case path_untracked:
diff --git a/dir.h b/dir.h
index bfe726e..3d6b80c 100644
--- a/dir.h
+++ b/dir.h
@@ -79,7 +79,8 @@ struct dir_struct {
 		DIR_SHOW_OTHER_DIRECTORIES = 1<<1,
 		DIR_HIDE_EMPTY_DIRECTORIES = 1<<2,
 		DIR_NO_GITLINKS = 1<<3,
-		DIR_COLLECT_IGNORED = 1<<4
+		DIR_COLLECT_IGNORED = 1<<4,
+		DIR_SHOW_IGNORED_TOO = 1<<5
 	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
diff --git a/wt-status.c b/wt-status.c
index 79eb124..7b3cc8e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -503,9 +503,12 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
 		dir.flags |=
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+	if (s->show_ignored_files)
+		dir.flags |= DIR_SHOW_IGNORED_TOO;
 	setup_standard_excludes(&dir);
 
 	fill_directory(&dir, s->pathspec);
+
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		if (cache_name_is_other(ent->name, ent->len) &&
@@ -514,22 +517,17 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		free(ent);
 	}
 
-	if (s->show_ignored_files) {
-		dir.nr = 0;
-		dir.flags = DIR_SHOW_IGNORED;
-		if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
-			dir.flags |= DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
-		fill_directory(&dir, s->pathspec);
-		for (i = 0; i < dir.nr; i++) {
-			struct dir_entry *ent = dir.entries[i];
-			if (cache_name_is_other(ent->name, ent->len) &&
-			    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
-				string_list_insert(&s->ignored, ent->name);
-			free(ent);
-		}
+	for (i = 0; i < dir.ignored_nr; i++) {
+		struct dir_entry *ent = dir.ignored[i];
+		if (cache_name_is_other(ent->name, ent->len) &&
+		    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
+			string_list_insert(&s->ignored, ent->name);
+		free(ent);
 	}
 
 	free(dir.entries);
+	free(dir.ignored);
+	clear_directory(&dir);
 }
 
 void wt_status_collect(struct wt_status *s)
-- 
1.8.1.2.8026.g2b66448.dirty
