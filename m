From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] attribute regression fix for maint-1.8.1 and upward
Date: Wed, 27 Mar 2013 08:13:09 +0700
Message-ID: <20130327011309.GA10946@duynguyen-vnpc.dek-tpc.internal>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 02:13:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKevz-0005dY-06
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 02:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab3C0BNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 21:13:18 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:65305 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab3C0BNR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 21:13:17 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so721592pab.35
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 18:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=qcvUPxWjEzbmqju9Wvtl4mmQ54i2rzFLZxkvDJZIoFw=;
        b=DEpr/eKNd/j/uUGN91owm+TBP0sa2JxwzwzJbRK1ugrbYmS4LuoTtlzVf8q6wRD2qf
         tt83OB32G4+9lA8Ckgy15AnC7Mv+VEvSHIxgPXUAGB8+AqExGbhVMsW0Z63hyAjCDSl+
         Z2xE3y56A4LL2zWm1G8dJI9VmzLeTFt83H9IrRAxYMcFgaCWk7TKkjrho0SfZg/EOEHE
         WFlgtgNIBZU77TrqgXjSLa+pRzfSmOxqmQPjXQWnA4GtLMLSxr0d07dELNg7iExW3dWZ
         J+VClX4VygtVBIm3Ws+iDTkJ127lyfI7SDCcxHb02NsycKhWIjg7iRoqxXU7bKLmuVkT
         Tgqw==
X-Received: by 10.68.223.138 with SMTP id qu10mr26463355pbc.89.1364346796478;
        Tue, 26 Mar 2013 18:13:16 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id tf8sm14750372pbc.42.2013.03.26.18.13.12
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 26 Mar 2013 18:13:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Mar 2013 08:13:09 +0700
Content-Disposition: inline
In-Reply-To: <1364323171-20299-1-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219231>

qOn Tue, Mar 26, 2013 at 11:39:27AM -0700, Junio C Hamano wrote:
> So here is an attempt to fix the unintended regression, on top of
> 9db9eecfe5c2 (attr: avoid calling find_basename() twice per path,
> 2013-01-16).  It consists of four patches.

Not that I disagree with this. Just wanted to see how far the "dtype"
idea went. How about this? git_check_attr() now takes dtype as an
argument and the caller must not add the trailing slash. This could be
split into two patches, one for git_check_attr prototype change, and
the other the real meat.

-- 8< --
diff --git a/archive.c b/archive.c
index 93e00bb..ab811b3 100644
--- a/archive.c
+++ b/archive.c
@@ -112,7 +112,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	write_archive_entry_fn_t write_entry = c->write_entry;
 	struct git_attr_check check[2];
 	const char *path_without_prefix;
-	int err;
+	int err, dtype;
 
 	args->convert = 0;
 	strbuf_reset(&path);
@@ -120,18 +120,18 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	strbuf_add(&path, args->base, args->baselen);
 	strbuf_add(&path, base, baselen);
 	strbuf_addstr(&path, filename);
-	if (S_ISDIR(mode) || S_ISGITLINK(mode))
-		strbuf_addch(&path, '/');
+	dtype = S_ISDIR(mode) || S_ISGITLINK(mode) ? DT_DIR : DT_REG;
 	path_without_prefix = path.buf + args->baselen;
 
 	setup_archive_check(check);
-	if (!git_check_attr(path_without_prefix, ARRAY_SIZE(check), check)) {
+	if (!git_check_attr(path_without_prefix, dtype, ARRAY_SIZE(check), check)) {
 		if (ATTR_TRUE(check[0].value))
 			return 0;
 		args->convert = ATTR_TRUE(check[1].value);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
+		strbuf_addch(&path, '/');
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
 		err = write_entry(args, sha1, path.buf, path.len, mode);
diff --git a/attr.c b/attr.c
index e2f9377..ab6422c 100644
--- a/attr.c
+++ b/attr.c
@@ -255,6 +255,8 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 				      &res->u.pat.patternlen,
 				      &res->u.pat.flags,
 				      &res->u.pat.nowildcardlen);
+		if (res->u.pat.flags & EXC_FLAG_MUSTBEDIR)
+			p[res->u.pat.patternlen] = '\0';
 		if (res->u.pat.flags & EXC_FLAG_NEGATIVE) {
 			warning(_("Negative patterns are ignored in git attributes\n"
 				  "Use '\\!' for literal leading exclamation."));
@@ -657,15 +659,14 @@ static void prepare_attr_stack(const char *path, int dirlen)
 }
 
 static int path_matches(const char *pathname, int pathlen,
-			const char *basename,
+			const char *basename, int dtype,
 			const struct pattern *pat,
 			const char *base, int baselen)
 {
 	const char *pattern = pat->pattern;
 	int prefix = pat->nowildcardlen;
 
-	if ((pat->flags & EXC_FLAG_MUSTBEDIR) &&
-	    ((!pathlen) || (pathname[pathlen-1] != '/')))
+	if ((pat->flags & EXC_FLAG_MUSTBEDIR) && dtype != DT_DIR)
 		return 0;
 
 	if (pat->flags & EXC_FLAG_NODIR) {
@@ -704,7 +705,7 @@ static int fill_one(const char *what, struct match_attr *a, int rem)
 }
 
 static int fill(const char *path, int pathlen, const char *basename,
-		struct attr_stack *stk, int rem)
+		int dtype, struct attr_stack *stk, int rem)
 {
 	int i;
 	const char *base = stk->origin ? stk->origin : "";
@@ -713,7 +714,7 @@ static int fill(const char *path, int pathlen, const char *basename,
 		struct match_attr *a = stk->attrs[i];
 		if (a->is_macro)
 			continue;
-		if (path_matches(path, pathlen, basename,
+		if (path_matches(path, pathlen, basename, dtype,
 				 &a->u.pat, base, stk->originlen))
 			rem = fill_one("fill", a, rem);
 	}
@@ -748,20 +749,17 @@ static int macroexpand_one(int attr_nr, int rem)
  * Collect all attributes for path into the array pointed to by
  * check_all_attr.
  */
-static void collect_all_attrs(const char *path)
+static void collect_all_attrs(const char *path, int dtype)
 {
 	struct attr_stack *stk;
 	int i, pathlen, rem, dirlen;
-	const char *basename, *cp, *last_slash = NULL;
+	const char *basename, *cp;
 
-	for (cp = path; *cp; cp++) {
-		if (*cp == '/' && cp[1])
-			last_slash = cp;
-	}
-	pathlen = cp - path;
-	if (last_slash) {
-		basename = last_slash + 1;
-		dirlen = last_slash - path;
+	cp = strrchr(path, '/');
+	pathlen = strlen(path);
+	if (cp) {
+		basename = cp + 1;
+		dirlen = cp - path;
 	} else {
 		basename = path;
 		dirlen = 0;
@@ -773,14 +771,14 @@ static void collect_all_attrs(const char *path)
 
 	rem = attr_nr;
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
-		rem = fill(path, pathlen, basename, stk, rem);
+		rem = fill(path, pathlen, basename, dtype, stk, rem);
 }
 
-int git_check_attr(const char *path, int num, struct git_attr_check *check)
+int git_check_attr(const char *path, int dtype, int num, struct git_attr_check *check)
 {
 	int i;
 
-	collect_all_attrs(path);
+	collect_all_attrs(path, dtype);
 
 	for (i = 0; i < num; i++) {
 		const char *value = check_all_attr[check[i].attr->attr_nr].value;
@@ -796,7 +794,7 @@ int git_all_attrs(const char *path, int *num, struct git_attr_check **check)
 {
 	int i, count, j;
 
-	collect_all_attrs(path);
+	collect_all_attrs(path, DT_REG);
 
 	/* Count the number of attributes that are set. */
 	count = 0;
diff --git a/attr.h b/attr.h
index 8b08d33..ce39c9c 100644
--- a/attr.h
+++ b/attr.h
@@ -36,7 +36,7 @@ struct git_attr_check {
  */
 char *git_attr_name(struct git_attr *);
 
-int git_check_attr(const char *path, int, struct git_attr_check *);
+int git_check_attr(const char *path, int, int, struct git_attr_check *);
 
 /*
  * Retrieve all attributes that apply to the specified path.  *num
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 075d01d..261e57d 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -49,7 +49,7 @@ static void check_attr(const char *prefix, int cnt,
 	char *full_path =
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 	if (check != NULL) {
-		if (git_check_attr(full_path, cnt, check))
+		if (git_check_attr(full_path, DT_REG, cnt, check))
 			die("git_check_attr died");
 		output_attr(cnt, check, file);
 	} else {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f069462..7a77288 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -894,7 +894,7 @@ static int no_try_delta(const char *path)
 	struct git_attr_check check[1];
 
 	setup_delta_attr_check(check);
-	if (git_check_attr(path, ARRAY_SIZE(check), check))
+	if (git_check_attr(path, DT_REG, ARRAY_SIZE(check), check))
 		return 0;
 	if (ATTR_FALSE(check->value))
 		return 1;
diff --git a/convert.c b/convert.c
index 3520252..3f09cbb 100644
--- a/convert.c
+++ b/convert.c
@@ -755,7 +755,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		git_config(read_convert_config, NULL);
 	}
 
-	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
+	if (!git_check_attr(path, DT_REG, NUM_CONV_ATTRS, ccheck)) {
 		ca->crlf_action = git_path_check_crlf(path, ccheck + 4);
 		if (ca->crlf_action == CRLF_GUESS)
 			ca->crlf_action = git_path_check_crlf(path, ccheck + 0);
diff --git a/ll-merge.c b/ll-merge.c
index fb61ea6..1944392 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -342,7 +342,7 @@ static int git_path_check_merge(const char *path, struct git_attr_check check[2]
 		check[0].attr = git_attr("merge");
 		check[1].attr = git_attr("conflict-marker-size");
 	}
-	return git_check_attr(path, 2, check);
+	return git_check_attr(path, DT_REG, 2, check);
 }
 
 static void normalize_file(mmfile_t *mm, const char *path)
@@ -399,7 +399,7 @@ int ll_merge_marker_size(const char *path)
 
 	if (!check.attr)
 		check.attr = git_attr("conflict-marker-size");
-	if (!git_check_attr(path, 1, &check) && check.value) {
+	if (!git_check_attr(path, DT_REG, 1, &check) && check.value) {
 		marker_size = atoi(check.value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
index 0c847fb..98ccc3c 100755
--- a/t/t5002-archive-attr-pattern.sh
+++ b/t/t5002-archive-attr-pattern.sh
@@ -27,6 +27,10 @@ test_expect_success 'setup' '
 	echo ignored-only-if-dir/ export-ignore >>.git/info/attributes &&
 	git add ignored-only-if-dir &&
 
+	mkdir -p ignored-without-slash &&
+	echo ignored without slash >ignored-without-slash/foo &&
+	git add ignored-without-slash/foo &&
+	echo ignored-without-slash export-ignore >>.git/info/attributes &&
 
 	mkdir -p one-level-lower/two-levels-lower/ignored-only-if-dir &&
 	echo ignored by ignored dir >one-level-lower/two-levels-lower/ignored-only-if-dir/ignored-by-ignored-dir &&
@@ -49,6 +53,8 @@ test_expect_exists	archive/not-ignored-dir/ignored-only-if-dir
 test_expect_exists	archive/not-ignored-dir/
 test_expect_missing	archive/ignored-only-if-dir/
 test_expect_missing	archive/ignored-ony-if-dir/ignored-by-ignored-dir
+test_expect_missing	archive/ignored-without-slash/ &&
+test_expect_missing	archive/ignored-without-slash/foo &&
 test_expect_exists	archive/one-level-lower/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-only-if-dir/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-ony-if-dir/ignored-by-ignored-dir
diff --git a/userdiff.c b/userdiff.c
index ea43a03..fd4f576 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -260,7 +260,7 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
 
 	if (!path)
 		return NULL;
-	if (git_check_attr(path, 1, &check))
+	if (git_check_attr(path, DT_REG, 1, &check))
 		return NULL;
 
 	if (ATTR_TRUE(check.value))
diff --git a/ws.c b/ws.c
index b498d75..34c2145 100644
--- a/ws.c
+++ b/ws.c
@@ -88,7 +88,7 @@ unsigned whitespace_rule(const char *pathname)
 	struct git_attr_check attr_whitespace_rule;
 
 	setup_whitespace_attr_check(&attr_whitespace_rule);
-	if (!git_check_attr(pathname, 1, &attr_whitespace_rule)) {
+	if (!git_check_attr(pathname, DT_REG, 1, &attr_whitespace_rule)) {
 		const char *value;
 
 		value = attr_whitespace_rule.value;
-- 8< --
