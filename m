From: Jeff King <peff@peff.net>
Subject: Re: [BUG/RFC] Raw diff output format (git-diff-tree) and
 --relative[=<path>] option
Date: Mon, 9 Aug 2010 10:50:53 -0400
Message-ID: <20100809145053.GA3438@sigill>
References: <201007051015.26995.jnareb@gmail.com>
 <201007081419.42702.jnareb@gmail.com>
 <20100708142341.GA9991@coredump.intra.peff.net>
 <201007081656.23474.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 16:51:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiTgv-0008Qc-GU
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 16:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716Ab0HIOu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 10:50:58 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41802 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756654Ab0HIOu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 10:50:57 -0400
Received: (qmail 22105 invoked by uid 111); 9 Aug 2010 14:50:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.116)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 09 Aug 2010 14:50:55 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Aug 2010 10:50:53 -0400
Content-Disposition: inline
In-Reply-To: <201007081656.23474.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152971>

[Sorry for the long delay in responding. I was moving and am just now
 clearing my backlog of mail.]

On Thu, Jul 08, 2010 at 04:56:20PM +0200, Jakub Narebski wrote:

> > Hmm. That is because the diff output properly eliminates the double "/".
> > But AFAICT, all of the following do what I would expect:
> > 
> >   git diff --relative=sub
> >   git diff --relative=sub/ ;# same as above
> >   git diff --relative=foo- ;# yields "a/10" for file "foo-10"
> > 
> > Doing
> > 
> >   git diff --relative=sub --stat
> > 
> > shows the same issue as your --raw version, as does --name-only. I think
> > the right solution is to clean up a leading "/" for those cases. That
> > leaves the possibility for non-directory prefixes, but should do what
> > the user wants in the directory case (since a leading "/" is
> > nonsensical).
> 
> Perhaps this would be enough:

I think your patch is the right solution. Here it is with a commit
message and some tests.

-- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] diff: strip extra "/" when stripping prefix

There are two ways a user might want to use "diff
--relative":

  1. For a file in a directory, like "subdir/file", the user
     can use "--relative=subdir/" to strip the directory.

  2. To strip part of a filename, like "foo-10", they can
     use "--relative=foo-".

We currently handle both of those situations. However, if
the user passes "--relative=subdir" (without the trailing
slash), we produce inconsistent results. For the unified
diff format, we collapse the double-slash of "a//file"
correctly into "a/file". But for other formats (raw, stat,
name-status), we end up with "/file".

We can do what the user means here and strip the extra "/"
(and only a slash).  We are not hurting any existing users
of (2) above with this behavior change because the existing
output for this case was nonsensical.

Patch by Jakub, tests and commit message by Jeff King.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c                   |   10 ++++++-
 t/t4045-diff-relative.sh |   61 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100755 t/t4045-diff-relative.sh

diff --git a/diff.c b/diff.c
index 782896d..bf65892 100644
--- a/diff.c
+++ b/diff.c
@@ -2704,10 +2704,16 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
 static void strip_prefix(int prefix_length, const char **namep, const char **otherp)
 {
 	/* Strip the prefix but do not molest /dev/null and absolute paths */
-	if (*namep && **namep != '/')
+	if (*namep && **namep != '/') {
 		*namep += prefix_length;
-	if (*otherp && **otherp != '/')
+		if (**namep == '/')
+			++*namep;
+	}
+	if (*otherp && **otherp != '/') {
 		*otherp += prefix_length;
+		if (**otherp == '/')
+			++*otherp;
+	}
 }
 
 static void run_diff(struct diff_filepair *p, struct diff_options *o)
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
new file mode 100755
index 0000000..8a3c63b
--- /dev/null
+++ b/t/t4045-diff-relative.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description='diff --relative tests'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git commit --allow-empty -m empty &&
+	echo content >file1 &&
+	mkdir subdir &&
+	echo other content >subdir/file2 &&
+	git add . &&
+	git commit -m one
+'
+
+check_diff() {
+expect=$1; shift
+cat >expected <<EOF
+diff --git a/$expect b/$expect
+new file mode 100644
+index 0000000..25c05ef
+--- /dev/null
++++ b/$expect
+@@ -0,0 +1 @@
++other content
+EOF
+test_expect_success "-p $*" "
+	git diff -p $* HEAD^ >actual &&
+	test_cmp expected actual
+"
+}
+
+check_stat() {
+expect=$1; shift
+cat >expected <<EOF
+ $expect |    1 +
+ 1 files changed, 1 insertions(+), 0 deletions(-)
+EOF
+test_expect_success "--stat $*" "
+	git diff --stat $* HEAD^ >actual &&
+	test_cmp expected actual
+"
+}
+
+check_raw() {
+expect=$1; shift
+cat >expected <<EOF
+:000000 100644 0000000000000000000000000000000000000000 25c05ef3639d2d270e7fe765a67668f098092bc5 A	$expect
+EOF
+test_expect_success "--raw $*" "
+	git diff --no-abbrev --raw $* HEAD^ >actual &&
+	test_cmp expected actual
+"
+}
+
+for type in diff stat raw; do
+	check_$type file2 --relative=subdir/
+	check_$type file2 --relative=subdir
+	check_$type dir/file2 --relative=sub
+done
+
+test_done
-- 
1.7.2.1.63.g6ffaf
