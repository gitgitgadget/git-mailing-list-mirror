From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 5 Dec 2007 23:32:48 -0500
Message-ID: <20071206043247.GC5499@coredump.intra.peff.net>
References: <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org> <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org> <7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 05:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J08QD-00058D-4J
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 05:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbXLFEcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 23:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbXLFEcv
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 23:32:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3558 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968AbXLFEcu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 23:32:50 -0500
Received: (qmail 27418 invoked by uid 111); 6 Dec 2007 04:32:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 05 Dec 2007 23:32:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2007 23:32:48 -0500
Content-Disposition: inline
In-Reply-To: <7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67232>

On Wed, Dec 05, 2007 at 02:59:16AM -0800, Junio C Hamano wrote:

> * jc/clean-fix (Tue Dec 4 23:55:41 2007 -0800) 1 commit
>  - git-clean: Honor pathspec.
> 
> This does fix limited test cases I tried, but I didn't check the
> directory related options at all.  Sanity checking appreciated.  We need
> a regression fix before v1.5.4

Hrm, I took a look at this and I'm a bit stumped.

I think the logic in builtin-clean is a bit suspect, and I have a patch
below that fixes it.

However, I still can't get something as simple as:

  mkdir dir.clean &&
  touch dir.clean/file &&
  git clean -d "*.clean/"

to work, and I think the pathspec matching is to blame. If I use
"*.clean/", then read_directory assumes that "*.clean" is a directory to
be opened, without considering that it might be a wildcard, which is
just wrong. If I use "*.clean", then I get the correct directory
listing, but match_pathspec fails because read_directory returns
"dir.clean/". We could fix this by passing match_pathspec ent->len - 1,
but that actually ends up getting ignored! It ends up handing the string
to fnmatch, which treats it like a C string.

Am I crazy, or do we need to fix the wildcard semantics for directories
with both read_directory and with match_pathspec?

Below is my partial patch for reference.

-Peff

---
diff --git a/builtin-clean.c b/builtin-clean.c
index 61ae851..f4cf39f 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -117,7 +117,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 
 		if (!lstat(ent->name, &st) && (S_ISDIR(st.st_mode))) {
-			int matched_path = 0;
+			int matched_path = !pathspec;
 			strbuf_addstr(&directory, ent->name);
 			if (pathspec) {
 				/*
@@ -128,11 +128,11 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 						   baselen, seen))
 					matched_path = 1;
 			}
-			if (show_only && (remove_directories || matched_path)) {
+			if (show_only && (remove_directories && matched_path)) {
 				printf("Would remove %s\n", directory.buf);
-			} else if (quiet && (remove_directories || matched_path)) {
+			} else if (quiet && (remove_directories && matched_path)) {
 				remove_dir_recursively(&directory, 0);
-			} else if (remove_directories || matched_path) {
+			} else if (remove_directories && matched_path) {
 				printf("Removing %s\n", directory.buf);
 				remove_dir_recursively(&directory, 0);
 			} else if (show_only) {
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index dfd1188..f204a50 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -192,6 +192,34 @@ test_expect_success 'git-clean -d src/ examples/' '
 
 '
 
+test_expect_success 'git-clean with directory wildcards' '
+
+	mkdir -p dir.clean dir.stay &&
+	touch dir.clean/file dir.stay/file &&
+	git clean "*.clean" &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f dir.stay/file &&
+	test -f dir.clean/file
+
+'
+
+test_expect_success 'git-clean -d with directory wildcards' '
+
+	mkdir -p dir.clean dir.stay &&
+	touch dir.clean/file dir.stay/file &&
+	git clean -d "*.clean" &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f dir.stay/file &&
+	test ! -f dir.clean/file
+
+'
+
 test_expect_success 'git-clean -x' '
 
 	mkdir -p build docs &&
