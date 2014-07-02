From: Jeff King <peff@peff.net>
Subject: [RFH] "git clean" deletes excluded files in untracked directories
Date: Wed, 2 Jul 2014 15:11:14 -0400
Message-ID: <20140702191114.GA3474@sigill.intra.peff.net>
References: <20140702184429.GA32538@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 21:11:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2PwE-0007Pq-KI
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 21:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551AbaGBTLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 15:11:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:55085 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757546AbaGBTLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 15:11:16 -0400
Received: (qmail 32508 invoked by uid 102); 2 Jul 2014 19:11:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Jul 2014 14:11:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jul 2014 15:11:14 -0400
Content-Disposition: inline
In-Reply-To: <20140702184429.GA32538@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252832>

If you have an untracked directory that contains excluded files, like
this:

  mkdir foo
  echo content >foo/one
  echo content >foo/two
  echo "foo/one" >.gitignore

then "git clean -d" will notice that "foo" is untracked and recursively
delete it and its contents, including the ignored "foo/one".

Our stance has always been that ignored files are not precious, so in
that sense it is not a big loss. But "git clean" does provide a "-x"
option, and takes care to avoid deleting ignored files when it is not
given. So I'd argue that we should delete "foo/two" but retain
"foo/one", unless "-x" is given.

I'm not sure of the best way to go about that, though. The patch below
is my first attempt. It stops using DIR_SHOW_OTHER_DIRECTORIES when we
find the list of files to delete, which means we get the full set of
paths (so instead of "foo/", we see "foo/one" and "foo/two" after
calling fill_directory). But then we have to notice that "foo" should go
away if all of its contents do. For that, I use remove_path, which just
walks up the pathname, removing leading directories until we hit a
non-empty one.

But there are a few problems:

  1. Is it possible that we want to remove "foo/bar" but not "foo"? The
     obvious case would be that "foo" is excluded but "foo/bar" is not. I
     guess you could get that with negative excludes, like:

       foo/
       !foo/bar

  2. The output is different (we report each file we are removing,
     rather than just the root directory).

  3. The error handling is different. If we have an unreadable untracked
     directory now, fill_directory does not recurse into it; we get the
     directory name and complain when we cannot remove it. But with this
     patch, fill_directory tries to enter it, can't, and simply fails to
     report any entries inside it (this causes test failures in t7300).

So this is probably not the right way to go about it.  I'm not sure of
the best way.

One option is to actually teach clean's recursive remove_dirs function
to actually check excludes itself for each file. That feels hacky,
though, since we should be checking them already in fill_directory.

Another is to add a flag to fill_directory to indicate that it should
recurse into directories to find excluded files, but not otherwise (we
usually avoid it for reasons of efficiency, but since we would be
immediately entering them to delete anyway, I don't think that's a
concern here). I think this makes the fill_directory logic quite
complicated, though.

Suggestions?

---
diff --git a/builtin/clean.c b/builtin/clean.c
index 9a91515..f159eed 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -914,7 +914,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (force > 1)
 		rm_flags = 0;
 
-	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
+	if (!remove_directories)
+		dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
 
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
@@ -985,7 +986,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		} else {
-			res = dry_run ? 0 : unlink(abs_path.buf);
+			res = dry_run ? 0 : remove_path(abs_path.buf);
 			if (res) {
 				qname = quote_path_relative(item->string, NULL, &buf);
 				warning(_(msg_warn_remove_failed), qname);
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 04118ad..647844f 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -527,4 +527,12 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
 	test_path_is_dir foobar
 '
 
+test_expect_success 'clean -d does not clean ignored files' '
+	mkdir -p foo &&
+	echo content >foo/file &&
+	echo "foo/*" >.gitignore &&
+	git clean -df </dev/tty &&
+	test_path_is_file foo/file
+'
+
 test_done
