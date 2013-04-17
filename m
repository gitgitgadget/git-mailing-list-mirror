From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2-pu 14/14] dir.c: git-status --ignored: don't scan the work
 tree twice
Date: Wed, 17 Apr 2013 21:51:55 +0200
Message-ID: <516EFD5B.7000602@gmail.com>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com> <7v1uabsin7.fsf@alter.siamese.dyndns.org> <7vwqs3r3m4.fsf@alter.siamese.dyndns.org> <516C5DBF.1010102@gmail.com> <7vli8jr17i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 21:52:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USYOe-0004cQ-I5
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 21:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935529Ab3DQTv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 15:51:56 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:58118 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758812Ab3DQTvz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 15:51:55 -0400
Received: by mail-ee0-f44.google.com with SMTP id c41so959363eek.31
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 12:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=MFzl6BCnmIQ/iXsaG/GNqHLC9wsXwWI/s7m6afAtGeg=;
        b=mB+AUeZAqWkjPYuqF/NOPf25cTqMGFoY4+VydSTuHzymLbPQddGfIgWtEOqlK2TheV
         bZ8Z+wmTcnyqRatu/36CffVTxQq/Hj05fhUyW2ItWLkKb/TnJcGwBjoJ+WOO+Ds9ex/r
         cOI0b7kU29RHiKNzi4MuZBndeOYP0KuB9g6Nhf3+lOhoKiN/eYqc2TwBTzBrSwlbRysq
         +8ixu6wG7aZO2FWfg+SSX6Z50RF4V2GlOAhlDFkem+Vf8ctWjG39bZNUB49IWG6f2uRZ
         wMPHzcbHTpfl9CK4KOYA6VT/lc3PkB4YmrOTAZtv8IsL8qgibIM0CuF9sJFvdhifLkfy
         wGBQ==
X-Received: by 10.15.31.197 with SMTP id y45mr21687800eeu.18.1366228314354;
        Wed, 17 Apr 2013 12:51:54 -0700 (PDT)
Received: from [10.1.100.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id x42sm11175359eee.0.2013.04.17.12.51.52
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 12:51:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vli8jr17i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221568>

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
index a4357fb..4a8fc70 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -161,7 +161,6 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 		die(_("index file corrupt"));
 
 	memset(&dir, 0, sizeof(dir));
-	dir.flags |= DIR_COLLECT_IGNORED;
 	setup_standard_excludes(&dir);
 
 	if (stdin_paths) {
diff --git a/dir.c b/dir.c
index 2088891..ee4d04d 100644
--- a/dir.c
+++ b/dir.c
@@ -1183,15 +1183,12 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
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
@@ -1280,6 +1277,11 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
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
index 676b058..bf84a86 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -511,9 +511,12 @@ static void wt_status_collect_untracked(struct wt_status *s)
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
@@ -522,22 +525,17 @@ static void wt_status_collect_untracked(struct wt_status *s)
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
 
 	if (advice_status_u_option) {
 		struct timeval t_end;
-- 
1.8.1.2.8038.ge6fb49b.dirty
