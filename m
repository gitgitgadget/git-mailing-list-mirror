From: Jeff King <peff@peff.net>
Subject: Re: [regression?] trailing slash required in .gitattributes
Date: Sat, 23 Mar 2013 04:39:29 -0400
Message-ID: <20130323083927.GA25600@sigill.intra.peff.net>
References: <20130319175756.GA13760@sigill.intra.peff.net>
 <20130319181042.GA14295@sigill.intra.peff.net>
 <20130322222438.GA13207@sigill.intra.peff.net>
 <7vzjxv3uef.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 09:40:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJJzx-0005qJ-Hf
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 09:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396Ab3CWIjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 04:39:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36669 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754939Ab3CWIju (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 04:39:50 -0400
Received: (qmail 9000 invoked by uid 107); 23 Mar 2013 08:41:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Mar 2013 04:41:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Mar 2013 04:39:29 -0400
Content-Disposition: inline
In-Reply-To: <7vzjxv3uef.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218900>

On Fri, Mar 22, 2013 at 04:08:08PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   if (pathlen && pathname[pathlen-1] == '/')
> >           pathlen--;
> >
> > would work. But it seems that match_basename, despite taking the length
> > of all of the strings we pass it, will happily use NUL-terminated
> > functions like strcmp or fnmatch. Converting the former to check lengths
> > should be pretty straightforward. But there is no version of fnmatch
> > that does what we want. I wonder if we using wildmatch can get around
> > this limitation.
> 
> Or save away pathname[pathlen], temporarily NUL terminate and call
> these functions?

Yeah, that is a possibility, though it involves casting away some
constness. Patch is below, which seems to work.

It still feels really ugly to me, and like match_basename is misdesigned
and should respect the lengths we pass it. Also, if it does respect the
lengths, it should be able to go much faster (e.g., in the common case,
we can drop a ton of strcmp_icase calls if we just check the lengths
beforehand). I feel like Duy was working on something like this
recently, but I don't see anything in pu.

---
diff --git a/attr.c b/attr.c
index e2f9377..bd00a78 100644
--- a/attr.c
+++ b/attr.c
@@ -663,20 +663,58 @@ static int path_matches(const char *pathname, int pathlen,
 {
 	const char *pattern = pat->pattern;
 	int prefix = pat->nowildcardlen;
+	char path_munge = 0;
+	char pattern_munge = 0;
+	int ret;
 
 	if ((pat->flags & EXC_FLAG_MUSTBEDIR) &&
 	    ((!pathlen) || (pathname[pathlen-1] != '/')))
 		return 0;
 
+	/*
+	 * Drop trailing slash from path, as we would want
+	 * an unadorned pattern like "foo" to match both the
+	 * file "foo" and the directory "foo/".
+	 */
+	if (pathlen && pathname[pathlen-1] == '/') {
+		pathlen--;
+
+		/*
+		 * The match_* functions, despite taking a string length, will
+		 * happily read all the way up to the NUL-terminating character.
+		 * So we must not only shrink pathlen, but munge the buffer
+		 * to NUL-terminate it.
+		 */
+		path_munge = pathname[pathlen];
+		((char *)pathname)[pathlen] = '\0';
+	}
+
+	/*
+	 * The pattern up to patternlen will not include a
+	 * trailing slash, but it may still be present in the string.
+	 * And since the match_* functions will read up to the NUL,
+	 * we need to terminate the buffer.
+	 */
+	pattern_munge = pattern[pat->patternlen];
+	((char *)pattern)[pat->patternlen] = '\0';
+
 	if (pat->flags & EXC_FLAG_NODIR) {
-		return match_basename(basename,
-				      pathlen - (basename - pathname),
-				      pattern, prefix,
-				      pat->patternlen, pat->flags);
-	}
-	return match_pathname(pathname, pathlen,
-			      base, baselen,
-			      pattern, prefix, pat->patternlen, pat->flags);
+		ret = match_basename(basename,
+				     pathlen - (basename - pathname),
+				     pattern, prefix,
+				     pat->patternlen, pat->flags);
+	}
+	else {
+		ret = match_pathname(pathname, pathlen,
+				     base, baselen,
+				     pattern, prefix,
+				     pat->patternlen, pat->flags);
+	}
+
+	if (path_munge)
+		((char *)pathname)[pathlen] = path_munge;
+	((char *)pattern)[pat->patternlen] = pattern_munge;
+	return ret;
 }
 
 static int macroexpand_one(int attr_nr, int rem);
diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
index 0c847fb..3be809c 100755
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
@@ -49,6 +53,8 @@ test_expect_missing	archive/ignored-ony-if-dir/ignored-by-ignored-dir
 test_expect_exists	archive/not-ignored-dir/
 test_expect_missing	archive/ignored-only-if-dir/
 test_expect_missing	archive/ignored-ony-if-dir/ignored-by-ignored-dir
+test_expect_missing     archive/ignored-without-slash/ &&
+test_expect_missing     archive/ignored-without-slash/foo &&
 test_expect_exists	archive/one-level-lower/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-only-if-dir/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-ony-if-dir/ignored-by-ignored-dir
