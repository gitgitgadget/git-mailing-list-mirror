From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] diff: add a special SYMLINK user-diff driver
Date: Tue, 21 Sep 2010 17:13:03 -0400
Message-ID: <20100921211303.GB1188@sigill.intra.peff.net>
References: <20100921205914.GA1166@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 23:13:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyA9K-0005B9-G7
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 23:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab0IUVNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 17:13:07 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56904 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149Ab0IUVNG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 17:13:06 -0400
Received: (qmail 12087 invoked by uid 111); 21 Sep 2010 21:13:03 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 21 Sep 2010 21:13:03 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Sep 2010 17:13:03 -0400
Content-Disposition: inline
In-Reply-To: <20100921205914.GA1166@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156763>

As of the previous patch, there is no way to impact the diff
characteristics of a symbolic link. So if you wanted to use
a custom external driver or textconv for a symbolic link,
you can't. This patch enables that. See the added
documentation for an example use.

Signed-off-by: Jeff King <peff@peff.net>
---
And this provides any people who really were using the symlink behavior
fixed in patch 1/2 with a less buggy way to do the same thing. In
addition, it now allows them to use textconv, which can be used to
address the "no newline at end of file" complaint.

Writing this, though, made me wonder if diff is alone in having this
bug. If I have "*.pdf merge=pdf" in my .gitattributes file, will we try
to merge a symoblic link to a pdf like a pdf? That seems just as wrong
as diffing.

So I wonder if the problem really is not in the userdiff code at all,
and we should be disabling gitattribute lookup entirely for non-regular
files.

Also, this special SYMLINK driver assumes you want to treat all symlinks
the same. Which is probably good enough in practice. But if
gitattributes were aware of file modes, it would be nice to be able to
be able to apply multiple criteria (i.e., something besides just a
pathname match) to matching files. And then you could do something like
this in your gitattributes file:

  # all symlinks match this
  * is_symlink diff=symlink-diff-driver
  # only a symlink that matches this filename will get this
  some-particular-symlink is_symlink diff=other-symlink-diff-driver
  # and here we can explicitly say that only regular files get this
  # treatment
  *.pdf is_regular diff=pdf
  # and since that's what you want 99% of the time, we can imply
  # is_regular, which is backwards compatible and syntactically nicer.
  # So this is equivalent to the above
  *.pdf diff=pdf

which is more flexible, and neatly solves the "attributes shouldn't
affect symlinks at all" issue.

It does feel like overengineering, though. I really don't think people
are going to want to treat various symlinks differently. There is also
the question of submodule links. In theory they could match
gitattributes, too, and maybe there is something more useful people
could do there. I dunno.

 Documentation/gitattributes.txt |   32 ++++++++++++++++++++++++++++++++
 diff.c                          |    2 ++
 t/t4011-diff-symlink.sh         |   11 +++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e5a27d8..cc3bddf 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -405,6 +405,8 @@ String::
 	by the configuration variables in the "diff.foo" section of the
 	git config file.
 
+NOTE: Diff attributes apply only to regular files, not symlinks or
+submodules. See the section on special diff drivers below.
 
 Defining an external diff driver
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -572,6 +574,36 @@ and now produces better output), you can remove the cache
 manually with `git update-ref -d refs/notes/textconv/jpg` (where
 "jpg" is the name of the diff driver, as in the example above).
 
+Special diff drivers
+^^^^^^^^^^^^^^^^^^^^
+
+Diff drivers matched by attributes are used only for regular files. They
+do not apply to symbolic links, as a diff of symbolic links is not
+performed on the content of the files the links point to, but rather
+on the names of the files pointed to by the links. This makes a
+configuration like the following work as expected:
+
+-----------------------------
+$ echo '*.pdf diff=pdf' >.gitattributes
+$ git config diff.pdf.textconv pdftotext
+$ ln -s file.pdf link.pdf
+-----------------------------
+
+The regular file "file.pdf" will be converted to text for diffing, but
+the symlink "link.pdf", whose diffed contents are not PDF at all but
+rather the pathname "file.pdf", will not be affected.
+
+However, it may happen that you do want to change the diff parameters
+specifically for symlinks. You can do that by configuring the special
+"SYMLINK" diff driver. For example, to add a newline to the end of
+the symlink contents (and suppress the usual "no newline at end of file"
+warning), you could configure:
+
+-----------------------------
+[diff "SYMLINK"]
+	textconv = perl -pe 's/$/\n/'
+-----------------------------
+
 Performing a three-way merge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/diff.c b/diff.c
index 276e029..281b74a 100644
--- a/diff.c
+++ b/diff.c
@@ -1777,6 +1777,8 @@ static void diff_filespec_load_driver(struct diff_filespec *one)
 
 	if (S_ISREG(one->mode))
 		one->driver = userdiff_find_by_path(one->path);
+	else if(S_ISLNK(one->mode))
+		one->driver = userdiff_find_by_name("SYMLINK");
 
 	/* Fallback to default settings */
 	if (!one->driver)
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 408a19c..aa1daa2 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -114,4 +114,15 @@ test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
 	test_cmp expect actual
 '
 
+cat >expect <<'EOF'
+diff --git a/link.bin b/link.bin
+index e69de29..dce41ec 120000
+Binary files a/link.bin and b/link.bin differ
+EOF
+test_expect_success SYMLINKS 'symlinks do respect SYMLINK userdiff config' '
+	git config diff.SYMLINK.binary true &&
+	git diff link.bin >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.3.256.gb9713
