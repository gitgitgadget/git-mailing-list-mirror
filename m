From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] apply: fix adding new files on i-t-a entries
Date: Tue, 23 Jun 2015 19:34:15 +0700
Message-ID: <1435062855-26274-1-git-send-email-pclouds@gmail.com>
References: <CACfKtTAvH7FH2AkC5hUNFEQ620gF401SNYaULLy62iE8S55-7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, phiggins@google.com,
	snoksrud@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 14:33:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7NOl-0001VO-1N
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 14:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbbFWMdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 08:33:50 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36854 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbbFWMds (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 08:33:48 -0400
Received: by pdcu2 with SMTP id u2so6521089pdc.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 05:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=T5dIaY9ze86CVyNAyCXDqlt8Ao5Shr6xImmiLBoscHY=;
        b=t93grFY3ogJEgzYwfT42DTkUa2p8g6Ykp5YtaoruoExfCbA5vOQ5pb8lIXXGFfFReF
         fecgtLT3aAL9HJMy7rGnQRhRVYuo38AhHP4zuUunBx91XRucvJhCax72f9NkQ9y5hfwT
         KvI4d0sWdhcrEyfVp0EwcmEODKRyNrXskNggTQMJFN4vfdBOLmmkxK/M5tAn2fCCXAyd
         5qzlQArKOyAe4TKZHEo92CA23FBKndMQ3zwJ3FWJQ31pfnjwGpz/UFxUXlycAgfyv4OI
         Tqgtr5cebuXb6uV6B+y1Z9igUa9laT+bwpXFbCCFmdvL1tKaqWA13breJ9Ku1/n56zoh
         mHIg==
X-Received: by 10.70.43.136 with SMTP id w8mr68662433pdl.157.1435062827716;
        Tue, 23 Jun 2015 05:33:47 -0700 (PDT)
Received: from lanh ([115.73.16.237])
        by mx.google.com with ESMTPSA id d6sm23177666pdp.88.2015.06.23.05.33.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 05:33:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Jun 2015 19:34:16 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <CACfKtTAvH7FH2AkC5hUNFEQ620gF401SNYaULLy62iE8S55-7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272455>

Since d95d728 (diff-lib.c: adjust position of i-t-a entries in diff -
2015-03-16), a normal "git diff" on i-t-a entries would produce a diff
that _adds_ those files, not just adding content to existing and empty
files like before.

This is correct. Unfortunately, applying such a patch on the same
repository that has the same i-t-a entries will fail with message
"already exists in index" because git-apply checks, sees those i-t-a
entries and aborts. git-apply does not realize those are for
bookkeeping only, they do not really exist in the index.

This patch tightens the "exists in index" check, ignoring i-t-a
entries. For fixing the above problem, only the change in
check_to_create() is needed. For other changes,

 - load_current(), reporting "not exists in index" is better than "does
   not match index"

 - check_preimage(), similar to load_current(), but it may also use
   ce_mode from i-t-a entry which is always zero

 - get_current_sha1(), or actually build_fake_ancestor(), we should not
   add i-t-a entries to the temporary index, at least not without also
   adding i-t-a flag back

Since "git add -p" and "git am" use "git apply" underneath, they are
broken too before this patch and fixed now.

Reported-by: Patrick Higgins <phiggins@google.com>
Reported-by: Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I think I'm opening a can of worms with d95d728. There's nothing
 wrong with that patch per se, but with this issue popping up, I need
 to go over all {cache,index}_name_pos call sites and see what would be
 the sensible behavior when i-t-a entries are involved.
=20
 So far blame, rm and checkout-entry and "checkout <paths>" are on my
 to-think-or-fix list. But this patch can get in early to fix a real
 regression instead of waiting for one big series. A lot more
 discussions will be had before that series gets in good shape.

 builtin/apply.c       |  8 ++++----
 cache.h               |  2 ++
 read-cache.c          | 12 ++++++++++++
 t/t2203-add-intent.sh | 10 ++++++++++
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 146be97..4f813ac 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3344,7 +3344,7 @@ static int load_current(struct image *image, stru=
ct patch *patch)
 	if (!patch->is_new)
 		die("BUG: patch to %s is not a creation", patch->old_name);
=20
-	pos =3D cache_name_pos(name, strlen(name));
+	pos =3D exists_in_cache(name, strlen(name));
 	if (pos < 0)
 		return error(_("%s: does not exist in index"), name);
 	ce =3D active_cache[pos];
@@ -3497,7 +3497,7 @@ static int check_preimage(struct patch *patch, st=
ruct cache_entry **ce, struct s
 	}
=20
 	if (check_index && !previous) {
-		int pos =3D cache_name_pos(old_name, strlen(old_name));
+		int pos =3D exists_in_cache(old_name, strlen(old_name));
 		if (pos < 0) {
 			if (patch->is_new < 0)
 				goto is_new;
@@ -3551,7 +3551,7 @@ static int check_to_create(const char *new_name, =
int ok_if_exists)
 	struct stat nst;
=20
 	if (check_index &&
-	    cache_name_pos(new_name, strlen(new_name)) >=3D 0 &&
+	    exists_in_cache(new_name, strlen(new_name)) >=3D 0 &&
 	    !ok_if_exists)
 		return EXISTS_IN_INDEX;
 	if (cached)
@@ -3824,7 +3824,7 @@ static int get_current_sha1(const char *path, uns=
igned char *sha1)
=20
 	if (read_cache() < 0)
 		return -1;
-	pos =3D cache_name_pos(path, strlen(path));
+	pos =3D exists_in_cache(path, strlen(path));
 	if (pos < 0)
 		return -1;
 	hashcpy(sha1, active_cache[pos]->sha1);
diff --git a/cache.h b/cache.h
index 571c98f..6a44cb6 100644
--- a/cache.h
+++ b/cache.h
@@ -341,6 +341,7 @@ extern void free_name_hash(struct index_state *ista=
te);
 #define discard_cache() discard_index(&the_index)
 #define unmerged_cache() unmerged_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name)=
,(namelen))
+#define exists_in_cache(name, namelen) exists_in_index(&the_index,(nam=
e),(namelen))
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), =
(option))
 #define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&th=
e_index, (pos), (new_name))
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (=
pos))
@@ -512,6 +513,7 @@ extern int verify_path(const char *path);
 extern struct cache_entry *index_dir_exists(struct index_state *istate=
, const char *name, int namelen);
 extern struct cache_entry *index_file_exists(struct index_state *istat=
e, const char *name, int namelen, int igncase);
 extern int index_name_pos(const struct index_state *, const char *name=
, int namelen);
+extern int exists_in_index(const struct index_state *, const char *nam=
e, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
diff --git a/read-cache.c b/read-cache.c
index 5dee4e2..d3b50cb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -506,6 +506,18 @@ int index_name_pos(const struct index_state *istat=
e, const char *name, int namel
 	return index_name_stage_pos(istate, name, namelen, 0);
 }
=20
+/* This is the same as index_name_pos, except that i-t-a entries are i=
nvisible */
+int exists_in_index(const struct index_state *istate, const char *name=
, int namelen)
+{
+	int pos =3D index_name_stage_pos(istate, name, namelen, 0);
+
+	if (pos < 0)
+		return pos;
+	if (istate->cache[pos]->ce_flags & CE_INTENT_TO_ADD)
+		return -pos-1;
+	return pos;
+}
+
 /* Remove entry, return true if there are more entries to go.. */
 int remove_index_entry_at(struct index_state *istate, int pos)
 {
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 7c641bf..a10a96a 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -97,5 +97,15 @@ test_expect_success 'cache-tree invalidates i-t-a pa=
ths' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'apply on i-t-a entries' '
+	git init apply &&
+	(
+		cd apply &&
+		echo content >file &&
+		git add -N file &&
+		git diff | git apply --cached
+	)
+'
+
 test_done
=20
--=20
2.3.0.rc1.137.g477eb31
