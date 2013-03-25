From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] attr.c: fix matching "subdir" without the trailing
 slash
Date: Mon, 25 Mar 2013 16:24:24 +0700
Message-ID: <20130325092424.GA17291@duynguyen-vnpc.dek-tpc.internal>
References: <20130319175756.GA13760@sigill.intra.peff.net>
 <1364191510-8900-1-git-send-email-pclouds@gmail.com>
 <1364191510-8900-5-git-send-email-pclouds@gmail.com>
 <CACsJy8CNjKP1y925mb8_t_hs0QCZwaY6mYTe6EMvbJk2pPifew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, avila.jn@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 10:25:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK3eI-0003x8-I6
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 10:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758127Ab3CYJYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 05:24:35 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40899 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758121Ab3CYJYe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 05:24:34 -0400
Received: by mail-pd0-f176.google.com with SMTP id h6so713828pdn.35
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xXjShQK61lVIJ9gVyLAMH56G6MaElP5Agt6GyhD4n9s=;
        b=GqeqXLHxJRZ11sl3a1M7CKpGsZgipXlewCBh3XsObsONeJfijWdfBlO2m24uRAeK27
         zrEnSDZi1qCEu9x2Tknw1Lec8kCNsYohLbrNB3h9j0vj3Dzt/isElUbBWhjWJNaWBLML
         Y4u1jsPDYhGYfHMckWRn76SmaGKlTq2WYw/Cbl9W/NVaxGhip8owH07driYEtmgCeFG5
         h1Zue/hZ/ARpOS9ga17kI8x1nB5jWpEClw1j8kIAsX20iiYV6frh0OVL51f9oH/faYFq
         ziRd2gyvO4hh1KM1n3v0GjtuCLzdzo2I4r5iKbipgROwvo25U0jKXmnEvOBtYjKs0ceS
         RZ9Q==
X-Received: by 10.68.184.33 with SMTP id er1mr16724650pbc.151.1364203473665;
        Mon, 25 Mar 2013 02:24:33 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ab1sm12762845pbd.37.2013.03.25.02.24.29
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 02:24:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 25 Mar 2013 16:24:24 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8CNjKP1y925mb8_t_hs0QCZwaY6mYTe6EMvbJk2pPifew@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219021>

On Mon, Mar 25, 2013 at 02:20:31PM +0700, Duy Nguyen wrote:
> On second thought, maybe we should not pass path "subdir/" at all.
> Instead we create a fake dtype based on the trailing slash and pass it
> down to attr.c:fill() -> path_matches(), just like how
> last_exclude_matching_from_list() is called.

I was hoping to make a small patch, but as it turns out,
collect_all_attrs() takes a const path that contains the trailing
slash, we still need to ignore it in match_{base,path}name so the
whole series is still required. The only difference is in the final
patch, which is a bit longer:

-- 8< --
diff --git a/attr.c b/attr.c
index 1818ba5..0b2b716 100644
--- a/attr.c
+++ b/attr.c
@@ -256,7 +256,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 				      &res->u.pat.flags,
 				      &res->u.pat.nowildcardlen);
 		if (res->u.pat.flags & EXC_FLAG_MUSTBEDIR)
-			res->u.pat.patternlen++;
+			p[res->u.pat.patternlen] = '\0';
 		if (res->u.pat.flags & EXC_FLAG_NEGATIVE) {
 			warning(_("Negative patterns are ignored in git attributes\n"
 				  "Use '\\!' for literal leading exclamation."));
@@ -659,15 +659,14 @@ static void prepare_attr_stack(const char *path, int dirlen)
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
@@ -706,7 +705,7 @@ static int fill_one(const char *what, struct match_attr *a, int rem)
 }
 
 static int fill(const char *path, int pathlen, const char *basename,
-		struct attr_stack *stk, int rem)
+		int dtype, struct attr_stack *stk, int rem)
 {
 	int i;
 	const char *base = stk->origin ? stk->origin : "";
@@ -715,7 +714,7 @@ static int fill(const char *path, int pathlen, const char *basename,
 		struct match_attr *a = stk->attrs[i];
 		if (a->is_macro)
 			continue;
-		if (path_matches(path, pathlen, basename,
+		if (path_matches(path, pathlen, basename, dtype,
 				 &a->u.pat, base, stk->originlen))
 			rem = fill_one("fill", a, rem);
 	}
@@ -755,11 +754,17 @@ static void collect_all_attrs(const char *path)
 	struct attr_stack *stk;
 	int i, pathlen, rem, dirlen;
 	const char *basename, *cp, *last_slash = NULL;
+	int dtype;
 
 	for (cp = path; *cp; cp++) {
 		if (*cp == '/' && cp[1])
 			last_slash = cp;
 	}
+	if (cp > path && cp[-1] == '/') {
+		dtype = DT_DIR;
+		cp--;
+	} else
+		dtype = DT_REG;
 	pathlen = cp - path;
 	if (last_slash) {
 		basename = last_slash + 1;
@@ -775,7 +780,7 @@ static void collect_all_attrs(const char *path)
 
 	rem = attr_nr;
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
-		rem = fill(path, pathlen, basename, stk, rem);
+		rem = fill(path, pathlen, basename, dtype, stk, rem);
 }
 
 int git_check_attr(const char *path, int num, struct git_attr_check *check)
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
-- 8<--
