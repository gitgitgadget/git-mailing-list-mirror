From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/6] ll-merge: let caller decide whether to renormalize
Date: Tue, 3 Aug 2010 22:21:44 -0500
Message-ID: <20100804032144.GD19699@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 05:23:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgUZS-0000DU-Ug
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 05:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271Ab0HDDXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 23:23:05 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37410 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757520Ab0HDDXD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 23:23:03 -0400
Received: by yxg6 with SMTP id 6so1806113yxg.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 20:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8EATp56DEiwC1E26Vq4hl2MuLb11lQY72a6iZu0c0Uk=;
        b=msugeawMcdaLAWzPI6fV6BNBnzt6QGv92+L4AYaNeUqLsMsOq9V/9XqCwoIF+Mk3B5
         Zr7FtvC7BMjjNmgieDnmh0yHj8T7zsupYYQQz2zNREyC10mr5KKjHPuq9iecad+QgMyq
         uLHfwTs89IhJrgR2C+vZERXVvEQNpEEI/seho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TgGvQjTDn7iF27Grbq92Ycr1nM/aC7+DpsC1YI8cMcGMw4qgl0MxZUvAjOjO+QTMcQ
         XpDM+mJ9NAohLZw/8EljyRoqHkCP/605vUmIzJJSeOKvGN8wDYfMBM/UNspcexQ5zHOn
         7fXgcgrlTNZ9YG9jPyyTSOvw+afTvm2ql6Q50=
Received: by 10.100.111.7 with SMTP id j7mr9297316anc.30.1280892181469;
        Tue, 03 Aug 2010 20:23:01 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id t30sm12887302ann.7.2010.08.03.20.23.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 20:23:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100804031935.GA19699@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152558>

Add a "renormalize" parameter to ll_merge so callers can decide on a
case-by-case basis whether the merge is likely to have overlapped with
a change in smudge/clean rules.  This reveals a few commands that have
not been taking that situation into account, though it does not fix
them.

No change in behavior intended.

Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/checkout.c |    6 +++++-
 ll-merge.c         |    4 ++--
 ll-merge.h         |    2 +-
 merge-file.c       |    2 +-
 merge-recursive.c  |    1 +
 rerere.c           |   17 +++++++++++------
 6 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1994be9..5a7ae03 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -150,8 +150,12 @@ static int checkout_merged(int pos, struct checkout *state)
 	read_mmblob(&ours, active_cache[pos+1]->sha1);
 	read_mmblob(&theirs, active_cache[pos+2]->sha1);
 
+	/*
+	 * NEEDSWORK: re-create conflicts from merges with
+	 * merge.renormalize set, too
+	 */
 	status = ll_merge(&result_buf, path, &ancestor, "base",
-			  &ours, "ours", &theirs, "theirs", 0);
+			  &ours, "ours", &theirs, "theirs", 0, 0);
 	free(ancestor.ptr);
 	free(ours.ptr);
 	free(theirs.ptr);
diff --git a/ll-merge.c b/ll-merge.c
index 5068fe0..0a0e04d 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -336,7 +336,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *ancestor, const char *ancestor_label,
 	     mmfile_t *ours, const char *our_label,
 	     mmfile_t *theirs, const char *their_label,
-	     int flag)
+	     int renormalize, int flag)
 {
 	static struct git_attr_check check[2];
 	const char *ll_driver_name = NULL;
@@ -344,7 +344,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	const struct ll_merge_driver *driver;
 	int virtual_ancestor = flag & 01;
 
-	if (merge_renormalize) {
+	if (renormalize) {
 		normalize_file(ancestor, path);
 		normalize_file(ours, path);
 		normalize_file(theirs, path);
diff --git a/ll-merge.h b/ll-merge.h
index 57754cc..dd81a1e 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -10,7 +10,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *ancestor, const char *ancestor_label,
 	     mmfile_t *ours, const char *our_label,
 	     mmfile_t *theirs, const char *their_label,
-	     int flag);
+	     int renormalize, int flag);
 
 int ll_merge_marker_size(const char *path);
 
diff --git a/merge-file.c b/merge-file.c
index db4d0d5..5afdc01 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -37,7 +37,7 @@ static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our
 	 * common ancestor.
 	 */
 	merge_status = ll_merge(&res, path, base, NULL,
-				our, ".our", their, ".their", 0);
+				our, ".our", their, ".their", 0, 0);
 	if (merge_status < 0)
 		return NULL;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 8a49844..4838939 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -647,6 +647,7 @@ static int merge_3way(struct merge_options *o,
 
 	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
 				&src1, name1, &src2, name2,
+				o->renormalize,
 				(!!o->call_depth) | (favor << 1));
 
 	free(name1);
diff --git a/rerere.c b/rerere.c
index 2197890..17dcc3c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -319,9 +319,13 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 		if (!mmfile[i].ptr && !mmfile[i].size)
 			mmfile[i].ptr = xstrdup("");
 	}
+	/*
+	 * NEEDSWORK: handle conflicts from merges with
+	 * merge.renormalize set, too
+	 */
 	ll_merge(&result, path, &mmfile[0], NULL,
 		 &mmfile[1], "ours",
-		 &mmfile[2], "theirs", 0);
+		 &mmfile[2], "theirs", 0, 0);
 	for (i = 0; i < 3; i++)
 		free(mmfile[i].ptr);
 
@@ -361,7 +365,7 @@ static int find_conflict(struct string_list *conflict)
 	return 0;
 }
 
-static int merge(const char *name, const char *path)
+static int merge(const char *name, int renormalize, const char *path)
 {
 	int ret;
 	mmfile_t cur = {NULL, 0}, base = {NULL, 0}, other = {NULL, 0};
@@ -376,7 +380,8 @@ static int merge(const char *name, const char *path)
 		ret = 1;
 		goto out;
 	}
-	ret = ll_merge(&result, path, &base, NULL, &cur, "", &other, "", 0);
+	ret = ll_merge(&result, path, &base, NULL,
+			&cur, "", &other, "", renormalize, 0);
 	if (!ret) {
 		FILE *f = fopen(path, "w");
 		if (!f)
@@ -424,7 +429,7 @@ static int update_paths(struct string_list *update)
 	return status;
 }
 
-static int do_plain_rerere(struct string_list *rr, int fd)
+static int do_plain_rerere(struct string_list *rr, int fd, int renormalize)
 {
 	struct string_list conflict = { NULL, 0, 0, 1 };
 	struct string_list update = { NULL, 0, 0, 1 };
@@ -469,7 +474,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		const char *name = (const char *)rr->items[i].util;
 
 		if (has_rerere_resolution(name)) {
-			if (!merge(name, path)) {
+			if (!merge(name, renormalize, path)) {
 				if (rerere_autoupdate)
 					string_list_insert(path, &update);
 				fprintf(stderr,
@@ -553,7 +558,7 @@ int rerere(int flags)
 	fd = setup_rerere(&merge_rr, flags);
 	if (fd < 0)
 		return 0;
-	return do_plain_rerere(&merge_rr, fd);
+	return do_plain_rerere(&merge_rr, fd, merge_renormalize);
 }
 
 static int rerere_forget_one_path(const char *path, struct string_list *rr)
-- 
1.7.2.1.544.ga752d.dirty
