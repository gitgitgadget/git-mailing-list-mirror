From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] add: add --bulk to index all objects into a pack file
Date: Fri,  4 Oct 2013 13:57:51 +0700
Message-ID: <1380869871-31631-1-git-send-email-pclouds@gmail.com>
References: <1380772811-15415-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 04 08:58:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRzLG-0003FF-89
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 08:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab3JDG6W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Oct 2013 02:58:22 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:39861 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab3JDG6U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 02:58:20 -0400
Received: by mail-pa0-f52.google.com with SMTP id kl14so3696306pab.25
        for <git@vger.kernel.org>; Thu, 03 Oct 2013 23:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2qFchKdEtFpygxQTE9quPOkzSMLE1iSHrcN8Q0YP598=;
        b=euRdCSau2qcMTLsPncOv2317HzE6OxiQyDmUCs2BXI1+q/dWczEVsPNmfGUFqFwU23
         xE6sGFOA8mStxuKfEj5AogmyanLlbEH8mQiVE7UjZjF2n969WiI/mkR04lETQ5ugfNBY
         2CqPuk4tnY7nVJohYWRWYA2DbS0SXrfUdZI+Lea8a6GNk6xWPd/5cXuQA6xHKLkFZRlF
         ArP7kLmMuqztCFTAMt/Ihr5kTO9+ijx7KFfmRcK7lKRgcoWkGmmbIdSGwP5qQuMsTrV6
         Jiem7TQjkZ4hodD98oA0hMl/fNsOypmMeWZNiIL5v2zGNYwzm7c3qn5hfysA7G1tYffm
         3K/w==
X-Received: by 10.68.20.69 with SMTP id l5mr12772590pbe.93.1380869900434;
        Thu, 03 Oct 2013 23:58:20 -0700 (PDT)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id jj1sm12646774pbb.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 03 Oct 2013 23:58:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 04 Oct 2013 13:57:54 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1380772811-15415-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235700>

The use case is

    tar -xzf bigproject.tar.gz
    cd bigproject
    git init
    git add .
    # git grep or something

The first add will generate a bunch of loose objects. With --bulk, all
of them are forced into a single pack instead, less clutter on disk
and maybe faster object access.

On gdb-7.5.1 source directory, the loose .git directory takes 66M
according to `du` while the packed one takes 32M. Timing of
"git grep --cached":

          loose     packed
real    0m1.671s   0m1.372s
user    0m1.542s   0m1.313s
sys     0m0.126s   0m0.056s

It's not an all-win situation though. --bulk is slower than --no-bulk
because:

 - Triple hashing: we need to calculate both object SHA-1s _and_ pack
   SHA-1. At the end we have to fix up the pack, which means rehashing
   the entire pack again. --no-bulk only cares about object SHA-1s.

 - We write duplicate objects to the pack then truncate it, because we
   don't know if it's a duplicate until we're done writing, and cannot
   keep it in core because it's potentially big. So extra I/O (but
   hopefully not too much because duplicate objects should not happen
   often).

 - Sort and write .idx file.

 - (For the future) --no-bulk could benefit from multithreading
   because this is CPU bound operation. --bulk could not.

But again this comparison is not fair, --bulk is closer to:

    git add . &&
    git ls-files --stage | awk '{print $2;}'| \
        git pack-objects .git/objects/pack-

except that it does not deltifies nor sort objects.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v2 examines pros and cons of --bulk and I'm not sure if turning it on
 automatically (with heuristics) is a good idea anymore.

 Oh and it fixes not packing empty files.

 Documentation/git-add.txt | 10 ++++++++++
 builtin/add.c             | 10 +++++++++-
 sha1_file.c               |  3 ++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 48754cb..147d191 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -160,6 +160,16 @@ today's "git add <pathspec>...", ignoring removed =
files.
 	be ignored, no matter if they are already present in the work
 	tree or not.
=20
+--bulk::
+	Normally new objects are indexed and stored in loose format,
+	one file per new object in "$GIT_DIR/objects". This option
+	forces putting all objects into a single new pack. This may
+	be useful when you need to add a lot of files initially.
++
+This option is equivalent to running `git -c core.bigFileThreshold=3D0=
 add`.
+If you want to only pack files larger than a size threshold, use the
+long form.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
diff --git a/builtin/add.c b/builtin/add.c
index 226f758..40cbb71 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -336,7 +336,7 @@ static struct lock_file lock_file;
 static const char ignore_error[] =3D
 N_("The following paths are ignored by one of your .gitignore files:\n=
");
=20
-static int verbose, show_only, ignored_too, refresh_only;
+static int verbose, show_only, ignored_too, refresh_only, bulk_index;
 static int ignore_add_errors, intent_to_add, ignore_missing;
=20
 #define ADDREMOVE_DEFAULT 0 /* Change to 1 in Git 2.0 */
@@ -368,6 +368,7 @@ static struct option builtin_add_options[] =3D {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh t=
he index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip file=
s which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even =
missing - files are ignored in dry run")),
+	OPT_BOOL( 0 , "bulk", &bulk_index, N_("pack all objects instead of cr=
eating loose ones")),
 	OPT_END(),
 };
=20
@@ -560,6 +561,13 @@ int cmd_add(int argc, const char **argv, const cha=
r *prefix)
 		free(seen);
 	}
=20
+	if (bulk_index)
+		/*
+		 * Pretend all blobs are "large" files, forcing them
+		 * all into a pack
+		 */
+		big_file_threshold =3D 0;
+
 	plug_bulk_checkin();
=20
 	if ((flags & ADD_CACHE_IMPLICIT_DOT) && prefix) {
diff --git a/sha1_file.c b/sha1_file.c
index f80bbe4..8b66840 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3137,7 +3137,8 @@ int index_fd(unsigned char *sha1, int fd, struct =
stat *st,
=20
 	if (!S_ISREG(st->st_mode))
 		ret =3D index_pipe(sha1, fd, type, path, flags);
-	else if (size <=3D big_file_threshold || type !=3D OBJ_BLOB ||
+	else if ((big_file_threshold && size <=3D big_file_threshold) ||
+		 type !=3D OBJ_BLOB ||
 		 (path && would_convert_to_git(path, NULL, 0, 0)))
 		ret =3D index_core(sha1, fd, size, type, path, flags);
 	else
--=20
1.8.2.82.gc24b958
