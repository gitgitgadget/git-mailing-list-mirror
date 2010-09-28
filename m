From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH v3 2/3] blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
Date: Tue, 28 Sep 2010 16:07:30 +0400
Message-ID: <20100928120730.GB29525@landau.phys.spbu.ru>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru> <4805c18603a79e265c1bb1a1858ece8c33b17e2b.1285351816.git.kirr@landau.phys.spbu.ru> <7vocbjyrbw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 14:07:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0YyL-0005h3-CU
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 14:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab0I1MHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 08:07:32 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:56890 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab0I1MHb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 08:07:31 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 5E602FF719; Tue, 28 Sep 2010 16:07:30 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <7vocbjyrbw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157413>

On Mon, Sep 27, 2010 at 11:27:47AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
> 
> > diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
> > index d0f8d62..7d42e96 100755
> > --- a/t/t8006-blame-textconv.sh
> > +++ b/t/t8006-blame-textconv.sh
> > @@ -17,10 +17,12 @@ chmod +x helper
> >  test_expect_success 'setup ' '
> >  	echo "bin: test 1" >one.bin &&
> >  	echo "bin: test number 2" >two.bin &&
> > +	ln -s one.bin symlink.bin &&
> >  	git add . &&
> >  	GIT_AUTHOR_NAME=Number1 git commit -a -m First --date="2010-01-01 18:00:00" &&
> >  	echo "bin: test 1 version 2" >one.bin &&
> >  	echo "bin: test number 2 version 2" >>two.bin &&
> > +	ln -sf two.bin symlink.bin &&
> >  	GIT_AUTHOR_NAME=Number2 git commit -a -m Second --date="2010-01-01 20:00:00"
> >  '
> 
> Doesn't this need some test prereq marker?

Yes, I forgot about symlink prereqs.

Below is interdiff of the fixes to this patch. Updated series with all
queued fixes will be reposted shortly.
 

Thanks,
Kirill


---- 8< ----

diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 917d362..324f127 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -17,12 +17,16 @@ chmod +x helper
 test_expect_success 'setup ' '
 	echo "bin: test 1" >one.bin &&
 	echo "bin: test number 2" >two.bin &&
-	ln -s one.bin symlink.bin &&
+	if test_have_prereq SYMLINKS; then
+		ln -s one.bin symlink.bin
+	fi &&
 	git add . &&
 	GIT_AUTHOR_NAME=Number1 git commit -a -m First --date="2010-01-01 18:00:00" &&
 	echo "bin: test 1 version 2" >one.bin &&
 	echo "bin: test number 2 version 2" >>two.bin &&
-	ln -sf two.bin symlink.bin &&
+	if test_have_prereq SYMLINKS; then
+		ln -sf two.bin symlink.bin
+	fi &&
 	GIT_AUTHOR_NAME=Number2 git commit -a -m Second --date="2010-01-01 20:00:00"
 '
 
@@ -84,14 +88,14 @@ cat >expected <<EOF
 (Number2 2010-01-01 20:00:00 +0000 1) two.bin
 EOF
 
-test_expect_success 'blame with --no-textconv (on symlink)' '
+test_expect_success SYMLINKS 'blame with --no-textconv (on symlink)' '
 	git blame --no-textconv symlink.bin >blame &&
 	find_blame <blame >result &&
 	test_cmp expected result
 '
 
 # fails with '...symlink.bin is not "binary" file'
-test_expect_failure 'blame --textconv (on symlink)' '
+test_expect_failure SYMLINKS 'blame --textconv (on symlink)' '
 	git blame --textconv symlink.bin >blame &&
 	find_blame <blame >result &&
 	test_cmp expected result
@@ -99,7 +103,7 @@ test_expect_failure 'blame --textconv (on symlink)' '
 
 # cp two.bin three.bin  and make small tweak
 # (this will direct blame -C -C three.bin to consider two.bin and symlink.bin)
-test_expect_success 'make another new commit' '
+test_expect_success SYMLINKS 'make another new commit' '
 	cat >three.bin <<\EOF &&
 bin: test number 2
 bin: test number 2 version 2
@@ -111,7 +115,7 @@ EOF
 '
 
 # fails with '...symlink.bin is not "binary" file'
-test_expect_failure 'blame on last commit (-C -C, symlink)' '
+test_expect_failure SYMLINKS 'blame on last commit (-C -C, symlink)' '
 	git blame -C -C three.bin >blame &&
 	find_blame <blame >result &&
 	cat >expected <<\EOF &&
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index 7bec265..03af7ae 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -12,7 +12,9 @@ chmod +x helper
 
 test_expect_success 'setup ' '
 	echo "bin: test" >one.bin &&
-	ln -s one.bin symlink.bin &&
+	if test_have_prereq SYMLINKS; then
+		ln -s one.bin symlink.bin
+	fi &&
 	git add . &&
 	GIT_AUTHOR_NAME=Number1 git commit -a -m First --date="2010-01-01 18:00:00" &&
 	echo "bin: test version 2" >one.bin &&
@@ -70,7 +72,7 @@ test_expect_success 'cat-file --textconv on previous commit' '
 	test_cmp expected result
 '
 
-test_expect_success 'cat-file without --textconv (symlink)' '
+test_expect_success SYMLINKS 'cat-file without --textconv (symlink)' '
 	git cat-file blob :symlink.bin >result &&
 	printf "%s" "one.bin" >expected
 	test_cmp expected result
@@ -78,7 +80,7 @@ test_expect_success 'cat-file without --textconv (symlink)' '
 
 
 # fails because cat-file tries to run converter on symlink.bin
-test_expect_failure 'cat-file --textconv on index (symlink)' '
+test_expect_failure SYMLINKS 'cat-file --textconv on index (symlink)' '
 	! git cat-file --textconv :symlink.bin 2>result &&
 	cat >expected <<\EOF &&
 fatal: git cat-file --textconv: unable to run textconv on :symlink.bin
@@ -87,7 +89,7 @@ EOF
 '
 
 # fails because cat-file tries to run converter on symlink.bin
-test_expect_failure 'cat-file --textconv on HEAD (symlink)' '
+test_expect_failure SYMLINKS 'cat-file --textconv on HEAD (symlink)' '
 	! git cat-file --textconv HEAD:symlink.bin 2>result &&
 	cat >expected <<EOF &&
 fatal: git cat-file --textconv: unable to run textconv on HEAD:symlink.bin
