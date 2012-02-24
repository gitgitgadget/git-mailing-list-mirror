From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] do not stream large files to pack when filters are in use
Date: Fri, 24 Feb 2012 04:48:05 -0500
Message-ID: <20120224094805.GB11846@sigill.intra.peff.net>
References: <20120224093924.GA11680@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 10:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0rl9-0008VS-LS
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 10:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549Ab2BXJsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 04:48:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55476
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756395Ab2BXJsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 04:48:09 -0500
Received: (qmail 22440 invoked by uid 107); 24 Feb 2012 09:48:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 04:48:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 04:48:05 -0500
Content-Disposition: inline
In-Reply-To: <20120224093924.GA11680@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191421>

Because git's object format requires us to specify the
number of bytes in the object in its header, we must know
the size before streaming a blob into the object database.
This is not a problem when adding a regular file, as we can
get the size from stat(). However, when filters are in use
(such as autocrlf, or the ident, filter, or eol
gitattributes), we have no idea what the ultimate size will
be.

The current code just punts on the whole issue and ignores
filter configuration entirely for files larger than
core.bigfilethreshold. This can generate confusing results
if you use filters for large binary files, as the filter
will suddenly stop working as the file goes over a certain
size.  Rather than try to handle unknown input sizes with
streaming, this patch just turns off the streaming
optimization when filters are in use.

This has a slight performance regression in a very specific
case: if you have autocrlf on, but no gitattributes, a large
binary file will avoid the streaming code path because we
don't know beforehand whether it will need conversion or
not. But if you are handling large binary files, you should
be marking them as such via attributes (or at least not
using autocrlf, and instead marking your text files as
such). And the flip side is that if you have a large
_non_-binary file, there is a correctness improvement;
before we did not apply the conversion at all.

The first half of the new t1051 script covers these failures
on input. The second half tests the matching output code
paths. These already work correctly, and do not need any
adjustment.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm on the fence about the performance regression above. On the one
hand, if you're telling git to autocrlf your gigantic binary files, you
should fix your attributes, and expect not to use the streaming
optimization until you do. On the other hand, while I can see a remote
possibility of using filter.*.clean on a large binary file, the
probability that autocrlf would apply seems quite absurdly unlikely.

So rather than be pessimistic that filters will be used in the "auto"
case, perhaps we should be optimistic that they would not be. Or another
way of thinking about it is: from the CRLF code's perspective, anything
larger than core.bigfilethreshold should be considered binary without
actually looking at it, and we can say for sure (not the "might" from
the last patch) that such large things would not be converted in the
CRLF_GUESS case.

 sha1_file.c                 |    3 +-
 t/t1051-large-conversion.sh |   86 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100755 t/t1051-large-conversion.sh

diff --git a/sha1_file.c b/sha1_file.c
index f9f8d5e..61f597b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2720,7 +2720,8 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 
 	if (!S_ISREG(st->st_mode))
 		ret = index_pipe(sha1, fd, type, path, flags);
-	else if (size <= big_file_threshold || type != OBJ_BLOB)
+	else if (size <= big_file_threshold || type != OBJ_BLOB ||
+		 convert_to_git(path, NULL, 0, NULL, 0))
 		ret = index_core(sha1, fd, size, type, path, flags);
 	else
 		ret = index_stream(sha1, fd, size, type, path, flags);
diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
new file mode 100755
index 0000000..8b7640b
--- /dev/null
+++ b/t/t1051-large-conversion.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+test_description='test conversion filters on large files'
+. ./test-lib.sh
+
+set_attr() {
+	test_when_finished 'rm -f .gitattributes' &&
+	echo "* $*" >.gitattributes
+}
+
+check_input() {
+	git read-tree --empty &&
+	git add small large &&
+	git cat-file blob :small >small.index &&
+	git cat-file blob :large | head -n 1 >large.index &&
+	test_cmp small.index large.index
+}
+
+check_output() {
+	rm -f small large &&
+	git checkout small large &&
+	head -n 1 large >large.head &&
+	test_cmp small large.head
+}
+
+test_expect_success 'setup input tests' '
+	printf "\$Id: foo\$\\r\\n" >small &&
+	cat small small >large &&
+	git config core.bigfilethreshold 20 &&
+	git config filter.test.clean "sed s/.*/CLEAN/"
+'
+
+test_expect_success 'autocrlf=true converts on input' '
+	test_config core.autocrlf true &&
+	check_input
+'
+
+test_expect_success 'eol=crlf converts on input' '
+	set_attr eol=crlf &&
+	check_input
+'
+
+test_expect_success 'ident converts on input' '
+	set_attr ident &&
+	check_input
+'
+
+test_expect_success 'user-defined filters convert on input' '
+	set_attr filter=test &&
+	check_input
+'
+
+test_expect_success 'setup output tests' '
+	echo "\$Id\$" >small &&
+	cat small small >large &&
+	git add small large &&
+	git config core.bigfilethreshold 7 &&
+	git config filter.test.smudge "sed s/.*/SMUDGE/"
+'
+
+test_expect_success 'autocrlf=true converts on output' '
+	test_config core.autocrlf true &&
+	check_output
+'
+
+test_expect_success 'eol=crlf converts on output' '
+	set_attr eol=crlf &&
+	check_output
+'
+
+test_expect_success 'user-defined filters convert on output' '
+	set_attr filter=test &&
+	check_output
+'
+
+test_expect_success 'ident converts on output' '
+	set_attr ident &&
+	rm -f small large &&
+	git checkout small large &&
+	sed -n "s/Id: .*/Id: SHA/p" <small >small.clean &&
+	head -n 1 large >large.head &&
+	sed -n "s/Id: .*/Id: SHA/p" <large.head >large.clean &&
+	test_cmp small.clean large.clean
+'
+
+test_done
-- 
1.7.9.9.g04d94
