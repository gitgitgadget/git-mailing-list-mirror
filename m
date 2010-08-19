From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] tests: exercise "git apply" with weird filenames
Date: Wed, 18 Aug 2010 20:48:03 -0500
Message-ID: <20100819014803.GB18922@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C65BCD2.6000701@kdbg.org>
 <20100814022625.GA4199@burratino>
 <201008142037.50833.j6t@kdbg.org>
 <20100819014516.GA7175@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 03:49:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OluGM-0008Ox-Ro
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 03:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086Ab0HSBtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 21:49:46 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61995 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab0HSBto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 21:49:44 -0400
Received: by gxk23 with SMTP id 23so470464gxk.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 18:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=t90TijGZLA3HqcF29pfwZ3FSyW3bv8eE4cuMuZgg9Kc=;
        b=ETOQp5fdwaDI9C+xwba97T+nNb1eKG3VVtWa9HbhzvQ90yqWGLtxkX5CZ8llgFBJBF
         JURnJKqiLduZyIBA6Dlg+lZSVW12giq1fN0Qi5KQe7ILmr0FurDXUkhQq1mnTgjITY6+
         5gZ6MLQ87AGt6gqRJI9yi3SAiHDk9uJL1NLME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=J6jK8Mo2pWAmbi47d6aH1/cG4nVsWekM378ZbmJaL5KF88kBSkVyI7UBIE0Pn6LecB
         x2R7HU2qbr9mi2+vRJW4sCvHRW26ajU9tYCgoLDsrQEmjgu6PGpEtmKEFJeLx9lmKmDo
         Z3K7rdWsQKhUB/e2G7Cqok+CPrJDIO60y4MmI=
Received: by 10.101.204.1 with SMTP id g1mr10311095anq.243.1282182583952;
        Wed, 18 Aug 2010 18:49:43 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id k11sm1390679ani.30.2010.08.18.18.49.42
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 18:49:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100819014516.GA7175@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153903>

Check that "git apply" can cope with strange filenames, particularly
filenames with spaces.

Not all platforms have a sane enough diff -u and expand to
reliably create the such patches and maybe future versions of GNU
diff will handle funny characters differently, so this uses
pre-generated patches.  The script used to generate them is in
t/t4135/make-patches.

Filenames with tabs are not usable on NTFS; use something like the
FUNNYNAMES prerequisite from v1.3.0-rc1~67 (2006-03-03) to skip the
relevant tests when appropriate.  The detection is not shared in
test-lib.sh to avoid wasting time while running other test scripts.

Backslash is the path separator on Windows, so do not used it in
file names there (v1.6.3-rc0~93^2~6, 2009-03-13).

Finally, filenames starting with a quotation mark do not behave well
in msys (see v1.7.0-rc0~94^2, t4030, t4031: work around bogus MSYS
bash path conversion, 2010-01-01), so skip those tests on Windows,
too.

Helped-by: Andreas Schwab <schwab@linux-m68k.org>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4135-apply-weird-filenames.sh |   75 ++++++++++++++++++++++++++++++++++++++
 t/t4135/.gitignore               |    3 ++
 t/t4135/add-plain.diff           |    5 +++
 t/t4135/add-with backslash.diff  |    5 +++
 t/t4135/add-with quote.diff      |    5 +++
 t/t4135/add-with spaces.diff     |    5 +++
 t/t4135/add-with tab.diff        |    5 +++
 t/t4135/damaged.diff             |    5 +++
 t/t4135/diff-plain.diff          |    5 +++
 t/t4135/diff-with backslash.diff |    5 +++
 t/t4135/diff-with quote.diff     |    5 +++
 t/t4135/diff-with spaces.diff    |    5 +++
 t/t4135/diff-with tab.diff       |    5 +++
 t/t4135/git-plain.diff           |    7 ++++
 t/t4135/git-with backslash.diff  |    7 ++++
 t/t4135/git-with quote.diff      |    7 ++++
 t/t4135/git-with spaces.diff     |    7 ++++
 t/t4135/git-with tab.diff        |    7 ++++
 t/t4135/make-patches             |   45 +++++++++++++++++++++++
 19 files changed, 213 insertions(+), 0 deletions(-)
 create mode 100755 t/t4135-apply-weird-filenames.sh
 create mode 100644 t/t4135/.gitignore
 create mode 100644 t/t4135/add-plain.diff
 create mode 100644 t/t4135/add-with backslash.diff
 create mode 100644 t/t4135/add-with quote.diff
 create mode 100644 t/t4135/add-with spaces.diff
 create mode 100644 t/t4135/add-with tab.diff
 create mode 100644 t/t4135/damaged.diff
 create mode 100644 t/t4135/diff-plain.diff
 create mode 100644 t/t4135/diff-with backslash.diff
 create mode 100644 t/t4135/diff-with quote.diff
 create mode 100644 t/t4135/diff-with spaces.diff
 create mode 100644 t/t4135/diff-with tab.diff
 create mode 100644 t/t4135/git-plain.diff
 create mode 100644 t/t4135/git-with backslash.diff
 create mode 100644 t/t4135/git-with quote.diff
 create mode 100644 t/t4135/git-with spaces.diff
 create mode 100644 t/t4135/git-with tab.diff
 create mode 100755 t/t4135/make-patches

diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-filenames.sh
new file mode 100755
index 0000000..9373f64
--- /dev/null
+++ b/t/t4135-apply-weird-filenames.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+
+test_description='git apply with weird postimage filenames'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	vector=$TEST_DIRECTORY/t4135 &&
+
+	test_tick &&
+	git commit --allow-empty -m preimage &&
+	git tag preimage &&
+
+	reset_preimage() {
+		git checkout -f preimage^0 &&
+		git read-tree -u --reset HEAD &&
+		git update-index --refresh
+	} &&
+
+	test_when_finished "rm -f \"tab	embedded.txt\"" &&
+	test_when_finished "rm -f '\''\"quoteembedded\".txt'\''" &&
+	if touch -- "tab	embedded.txt" '\''"quoteembedded".txt'\''
+	then
+		test_set_prereq FUNNYNAMES
+	fi
+'
+
+try_filename() {
+	desc=$1
+	postimage=$2
+	prereq=${3:-}
+	exp1=${4:-success}
+	exp2=${5:-success}
+	exp3=${6:-success}
+
+	test_expect_$exp1 $prereq "$desc, git-style file creation patch" "
+		echo postimage >expected &&
+		reset_preimage &&
+		rm -f '$postimage' &&
+		git apply -v \"\$vector\"/'git-$desc.diff' &&
+		test_cmp expected '$postimage'
+	"
+
+	test_expect_$exp2 $prereq "$desc, traditional patch" "
+		echo postimage >expected &&
+		reset_preimage &&
+		echo preimage >'$postimage' &&
+		git apply -v \"\$vector\"/'diff-$desc.diff' &&
+		test_cmp expected '$postimage'
+	"
+
+	test_expect_$exp3 $prereq "$desc, traditional file creation patch" "
+		echo postimage >expected &&
+		reset_preimage &&
+		rm -f '$postimage' &&
+		git apply -v \"\$vector\"/'add-$desc.diff' &&
+		test_cmp expected '$postimage'
+	"
+}
+
+try_filename 'plain'            'postimage.txt'
+try_filename 'with spaces'      'post image.txt' '' success failure failure
+try_filename 'with tab'         'post	image.txt' FUNNYNAMES success failure failure
+try_filename 'with backslash'   'post\image.txt' BSLASHPSPEC
+try_filename 'with quote'       '"postimage".txt' FUNNYNAMES success failure success
+
+test_expect_success 'whitespace-damaged traditional patch' '
+	echo postimage >expected &&
+	reset_preimage &&
+	rm -f postimage.txt &&
+	git apply -v "$vector/damaged.diff" &&
+	test_cmp expected postimage.txt
+'
+
+test_done
diff --git a/t/t4135/.gitignore b/t/t4135/.gitignore
new file mode 100644
index 0000000..3e58e65
--- /dev/null
+++ b/t/t4135/.gitignore
@@ -0,0 +1,3 @@
+/file-creation/
+/trad-creation/
+/trad-modification/
diff --git a/t/t4135/add-plain.diff b/t/t4135/add-plain.diff
new file mode 100644
index 0000000..cf5970a
--- /dev/null
+++ b/t/t4135/add-plain.diff
@@ -0,0 +1,5 @@
+diff -pruN a/postimage.txt b/postimage.txt
+--- a/postimage.txt	1969-12-31 18:00:00.000000000 -0600
++++ b/postimage.txt	2010-08-18 20:13:31.484002255 -0500
+@@ -0,0 +1 @@
++postimage
diff --git a/t/t4135/add-with backslash.diff b/t/t4135/add-with backslash.diff
new file mode 100644
index 0000000..c6861e1
--- /dev/null
+++ b/t/t4135/add-with backslash.diff	
@@ -0,0 +1,5 @@
+diff -pruN a/post\image.txt b/post\image.txt
+--- a/post\image.txt	1969-12-31 18:00:00.000000000 -0600
++++ b/post\image.txt	2010-08-18 20:13:31.692002255 -0500
+@@ -0,0 +1 @@
++postimage
diff --git a/t/t4135/add-with quote.diff b/t/t4135/add-with quote.diff
new file mode 100644
index 0000000..866de78
--- /dev/null
+++ b/t/t4135/add-with quote.diff	
@@ -0,0 +1,5 @@
+diff -pruN a/"postimage".txt b/"postimage".txt
+--- a/"postimage".txt	1969-12-31 18:00:00.000000000 -0600
++++ b/"postimage".txt	2010-08-18 20:13:31.756002255 -0500
+@@ -0,0 +1 @@
++postimage
diff --git a/t/t4135/add-with spaces.diff b/t/t4135/add-with spaces.diff
new file mode 100644
index 0000000..a9a1212
--- /dev/null
+++ b/t/t4135/add-with spaces.diff	
@@ -0,0 +1,5 @@
+diff -pruN a/post image.txt b/post image.txt
+--- a/post image.txt	1969-12-31 18:00:00.000000000 -0600
++++ b/post image.txt	2010-08-18 20:13:31.556002255 -0500
+@@ -0,0 +1 @@
++postimage
diff --git a/t/t4135/add-with tab.diff b/t/t4135/add-with tab.diff
new file mode 100644
index 0000000..bb67cb7
--- /dev/null
+++ b/t/t4135/add-with tab.diff	
@@ -0,0 +1,5 @@
+diff -pruN a/post	image.txt b/post	image.txt
+--- a/post	image.txt	1969-12-31 18:00:00.000000000 -0600
++++ b/post	image.txt	2010-08-18 20:13:31.628002255 -0500
+@@ -0,0 +1 @@
++postimage
diff --git a/t/t4135/damaged.diff b/t/t4135/damaged.diff
new file mode 100644
index 0000000..68f7ede
--- /dev/null
+++ b/t/t4135/damaged.diff
@@ -0,0 +1,5 @@
+diff -pruN a/postimage.txt b/postimage.txt
+--- a/postimage.txt     1969-12-31 18:00:00.000000000 -0600
++++ b/postimage.txt     2010-08-18 20:13:31.484002255 -0500
+@@ -0,0 +1 @@
++postimage
diff --git a/t/t4135/diff-plain.diff b/t/t4135/diff-plain.diff
new file mode 100644
index 0000000..acedcfa
--- /dev/null
+++ b/t/t4135/diff-plain.diff
@@ -0,0 +1,5 @@
+--- postimage.txt.orig	2010-08-18 20:13:31.432002255 -0500
++++ postimage.txt	2010-08-18 20:13:31.432002255 -0500
+@@ -1 +1 @@
+-preimage
++postimage
diff --git a/t/t4135/diff-with backslash.diff b/t/t4135/diff-with backslash.diff
new file mode 100644
index 0000000..9068a61
--- /dev/null
+++ b/t/t4135/diff-with backslash.diff	
@@ -0,0 +1,5 @@
+--- post\image.txt.orig	2010-08-18 20:13:31.680002255 -0500
++++ post\image.txt	2010-08-18 20:13:31.680002255 -0500
+@@ -1 +1 @@
+-preimage
++postimage
diff --git a/t/t4135/diff-with quote.diff b/t/t4135/diff-with quote.diff
new file mode 100644
index 0000000..c8e8cc1
--- /dev/null
+++ b/t/t4135/diff-with quote.diff	
@@ -0,0 +1,5 @@
+--- "postimage".txt.orig	2010-08-18 20:13:31.744002255 -0500
++++ "postimage".txt	2010-08-18 20:13:31.744002255 -0500
+@@ -1 +1 @@
+-preimage
++postimage
diff --git a/t/t4135/diff-with spaces.diff b/t/t4135/diff-with spaces.diff
new file mode 100644
index 0000000..3512056
--- /dev/null
+++ b/t/t4135/diff-with spaces.diff	
@@ -0,0 +1,5 @@
+--- post image.txt.orig	2010-08-18 20:13:31.544002255 -0500
++++ post image.txt	2010-08-18 20:13:31.544002255 -0500
+@@ -1 +1 @@
+-preimage
++postimage
diff --git a/t/t4135/diff-with tab.diff b/t/t4135/diff-with tab.diff
new file mode 100644
index 0000000..4e6d9b2
--- /dev/null
+++ b/t/t4135/diff-with tab.diff	
@@ -0,0 +1,5 @@
+--- post	image.txt.orig	2010-08-18 20:13:31.616002255 -0500
++++ post	image.txt	2010-08-18 20:13:31.616002255 -0500
+@@ -1 +1 @@
+-preimage
++postimage
diff --git a/t/t4135/git-plain.diff b/t/t4135/git-plain.diff
new file mode 100644
index 0000000..db47d1a
--- /dev/null
+++ b/t/t4135/git-plain.diff
@@ -0,0 +1,7 @@
+diff --git a/postimage.txt b/postimage.txt
+new file mode 100644
+index 0000000..eff0c54
+--- /dev/null
++++ b/postimage.txt
+@@ -0,0 +1 @@
++postimage
diff --git a/t/t4135/git-with backslash.diff b/t/t4135/git-with backslash.diff
new file mode 100644
index 0000000..0e84a10
--- /dev/null
+++ b/t/t4135/git-with backslash.diff	
@@ -0,0 +1,7 @@
+diff --git "a/post\\image.txt" "b/post\\image.txt"
+new file mode 100644
+index 0000000..eff0c54
+--- /dev/null
++++ "b/post\\image.txt"
+@@ -0,0 +1 @@
++postimage
diff --git a/t/t4135/git-with quote.diff b/t/t4135/git-with quote.diff
new file mode 100644
index 0000000..bdbea8a
--- /dev/null
+++ b/t/t4135/git-with quote.diff	
@@ -0,0 +1,7 @@
+diff --git "a/\"postimage\".txt" "b/\"postimage\".txt"
+new file mode 100644
+index 0000000..eff0c54
+--- /dev/null
++++ "b/\"postimage\".txt"
+@@ -0,0 +1 @@
++postimage
diff --git a/t/t4135/git-with spaces.diff b/t/t4135/git-with spaces.diff
new file mode 100644
index 0000000..baaa810
--- /dev/null
+++ b/t/t4135/git-with spaces.diff	
@@ -0,0 +1,7 @@
+diff --git a/post image.txt b/post image.txt
+new file mode 100644
+index 0000000..eff0c54
+--- /dev/null
++++ b/post image.txt	
+@@ -0,0 +1 @@
++postimage
diff --git a/t/t4135/git-with tab.diff b/t/t4135/git-with tab.diff
new file mode 100644
index 0000000..cca3c92
--- /dev/null
+++ b/t/t4135/git-with tab.diff	
@@ -0,0 +1,7 @@
+diff --git "a/post\timage.txt" "b/post\timage.txt"
+new file mode 100644
+index 0000000..eff0c54
+--- /dev/null
++++ "b/post\timage.txt"
+@@ -0,0 +1 @@
++postimage
diff --git a/t/t4135/make-patches b/t/t4135/make-patches
new file mode 100755
index 0000000..f5f45dd
--- /dev/null
+++ b/t/t4135/make-patches
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+do_filename() {
+	desc=$1
+	postimage=$2
+
+	rm -fr file-creation &&
+	git init file-creation &&
+	(
+		cd file-creation &&
+		git commit --allow-empty -m init &&
+		echo postimage >"$postimage" &&
+		git add -N "$postimage" &&
+		git diff HEAD >"../git-$desc.diff"
+	) &&
+
+	rm -fr trad-modification &&
+	mkdir trad-modification &&
+	(
+		cd trad-modification &&
+		echo preimage >"$postimage.orig" &&
+		echo postimage >"$postimage" &&
+		! diff -u "$postimage.orig" "$postimage" >"../diff-$desc.diff"
+	) &&
+
+	rm -fr trad-creation &&
+	mkdir trad-creation &&
+	(
+		cd trad-creation &&
+		mkdir a b &&
+		echo postimage >"b/$postimage" &&
+		! diff -pruN a b >"../add-$desc.diff"
+	)
+}
+
+do_filename plain postimage.txt &&
+do_filename 'with spaces' 'post image.txt' &&
+do_filename 'with tab' 'post	image.txt' &&
+do_filename 'with backslash' 'post\image.txt' &&
+do_filename 'with quote' '"postimage".txt' &&
+expand add-plain.diff >damaged.diff ||
+{
+	echo >&2 Failed. &&
+	exit 1
+}
-- 
1.7.2.1.544.ga752d.dirty
