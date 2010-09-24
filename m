From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/24] t9300 (fast-import): avoid hard-coded object names
Date: Fri, 24 Sep 2010 02:05:10 -0500
Message-ID: <20100924070510.GC4666@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 09:08:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2O4-0004C6-Cl
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705Ab0IXHH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:07:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42191 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab0IXHH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:07:58 -0400
Received: by iwn5 with SMTP id 5so2152442iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QJSTMFHx2VgNPb7cf85jbOhjd4Usmh5JSaf2RnJXqsA=;
        b=VX14JnmlDmGVIDByqPDTVrQMhxOdrg0Std1r/KY4NsZm8fd9WLD6KLcLZ2M17otwOH
         UprzULrGUFQuxuPXLnl5dDqFQhNcrchbO0pt6ntlUp5CHV6sriH+pnkGUrFwvvGyisZE
         +KEygiUNyR/aXZ/JaOYWUXi9MzdXWw0UyIE4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=asywhwVtfMYfGxRkXJ5bn/arqXpIfDBvmevW3uuQiXfaM6SsyhDqUUcxLNPnwHE/Fp
         FEdV+x0Q8FXEftGuZd4zFK0EovpclseMX9XY4M4gmlYZMPO55BZUmBdMEUnd0c/QG9bZ
         Gb9ClaX91yx4VChiPWiSzMOCSy32lkQT1Z3mk=
Received: by 10.231.194.219 with SMTP id dz27mr1927365ibb.104.1285312076467;
        Fri, 24 Sep 2010 00:07:56 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm1936694ibe.17.2010.09.24.00.07.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:07:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156936>

compare_diff_raw already ensures most (though not all) of the tests
do not rely on any particular hash function, but still the attentive
reader might be comforted by some less opaque object descriptions.

Tested with

	sed -i s/compare_diff_raw/test_cmp/g t9300-fast-import.sh &&
	sh t9300-fast-import.sh -v -i

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   91 ++++++++++++++++++++++++++++++++---------------
 1 files changed, 62 insertions(+), 29 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 1eef926..ed37a4e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -7,6 +7,8 @@ test_description='test git fast-import utility'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
 
+zeroes=0000000000000000000000000000000000000000
+
 file2_data='file2
 second line of EOF'
 
@@ -31,6 +33,14 @@ verify_packs () {
 	done
 }
 
+test_expect_success 'setup' '
+	file2_id=$(echo "$file2_data" | git hash-object --stdin) &&
+	file3_id=$(echo "$file3_data" | git hash-object --stdin) &&
+	file4_id=$(printf "%s" "$file4_data" | git hash-object --stdin) &&
+	file5_id=$(echo "$file5_data" | git hash-object --stdin) &&
+	file6_id=$(echo "$file6_data" | git hash-object --stdin)
+'
+
 ###
 ### series A
 ###
@@ -165,7 +175,7 @@ test_expect_success \
 	'A: verify pack' \
 	'verify_packs'
 cat >expect <<EOF
-:000000 100755 0000000000000000000000000000000000000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 A	copy-of-file2
+:000000 100755 $zeroes $file2_id A	copy-of-file2
 EOF
 git diff-tree -M -r master verify--import-marks >actual
 test_expect_success \
@@ -345,9 +355,9 @@ test_expect_success \
 	 test_cmp expect actual'
 
 cat >expect <<EOF
-:000000 100755 0000000000000000000000000000000000000000 f1fb5da718392694d0076d677d6d0e364c79b0bc A	file2/newf
-:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 R100	file2	file2/oldf
-:100644 000000 0d92e9f3374ae2947c23aa477cbc68ce598135f1 0000000000000000000000000000000000000000 D	file3
+:000000 100755 $zeroes $newf A	file2/newf
+:100644 100644 $file2_id $file2_id R100	file2	file2/oldf
+:100644 000000 $file3_id $zeroes D	file3
 EOF
 git diff-tree -M -r master branch >actual
 test_expect_success \
@@ -387,8 +397,8 @@ test_expect_success \
 	'verify_packs'
 
 cat >expect <<EOF
-:000000 100755 0000000000000000000000000000000000000000 35a59026a33beac1569b1c7f66f3090ce9c09afc A	newdir/exec.sh
-:000000 100644 0000000000000000000000000000000000000000 046d0371e9220107917db0d0e030628de8a1de9b A	newdir/interesting
+:000000 100755 $zeroes $file6_id A	newdir/exec.sh
+:000000 100644 $zeroes $file5_id A	newdir/interesting
 EOF
 git diff-tree -M -r branch^ branch >actual
 test_expect_success \
@@ -557,11 +567,11 @@ test_expect_success \
 	'verify_packs'
 
 cat >expect <<EOF
-:100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file2/newf
-:100644 000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 0000000000000000000000000000000000000000 D	file2/oldf
-:100755 000000 85df50785d62d3b05ab03d9cbf7e4a0b49449730 0000000000000000000000000000000000000000 D	file4
-:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 R100	newdir/interesting	h/e/l/lo
-:100755 000000 e74b7d465e52746be2b4bae983670711e6e66657 0000000000000000000000000000000000000000 D	newdir/exec.sh
+:100755 000000 $newf $zeroes D	file2/newf
+:100644 000000 $oldf $zeroes D	file2/oldf
+:100755 000000 $file4_id $zeroes D	file4
+:100644 100644 $file5_id $file5_id R100	newdir/interesting	h/e/l/lo
+:100755 000000 $file6_id $zeroes D	newdir/exec.sh
 EOF
 git diff-tree -M -r H^ H >actual
 test_expect_success \
@@ -698,16 +708,39 @@ M 644 :2 b/other
 M 644 :2 ba
 INPUT_END
 
+test_expect_success 'setup: object names for expected diff' '
+	some_data=$(
+		echo some data |
+		git hash-object -w --stdin
+	) &&
+	other_data=$(
+		echo other data |
+		git hash-object -w --stdin
+	) &&
+	some_tree=$(
+		rm -f tmp_index &&
+		echo "100644 blob $some_data	other" |
+		GIT_INDEX_FILE=tmp_index git update-index --index-info &&
+		GIT_INDEX_FILE=tmp_index git write-tree
+	) &&
+	other_tree=$(
+		rm -f tmp_index &&
+		echo "100644 blob $other_data	other" |
+		GIT_INDEX_FILE=tmp_index git update-index --index-info &&
+		GIT_INDEX_FILE=tmp_index git write-tree
+	)
+'
+
 cat >expect <<EXPECT_END
-:100644 100644 4268632... 55d3a52... M	b.
-:040000 040000 0ae5cac... 443c768... M	b
-:100644 100644 4268632... 55d3a52... M	ba
+:100644 100644 $some_data $other_data M	b.
+:040000 040000 $some_tree $other_tree M	b
+:100644 100644 $some_data $other_data M	ba
 EXPECT_END
 
 test_expect_success \
     'L: verify internal tree sorting' \
 	'git fast-import <input &&
-	 git diff-tree --abbrev --raw L^ L >output &&
+	 git diff-tree L^ L >output &&
 	 test_cmp expect output'
 
 ###
@@ -728,7 +761,7 @@ R file2/newf file2/n.e.w.f
 INPUT_END
 
 cat >expect <<EOF
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	file2/n.e.w.f
+:100755 100755 $newf $newf R100	file2/newf	file2/n.e.w.f
 EOF
 test_expect_success \
 	'M: rename file in same subdirectory' \
@@ -749,7 +782,7 @@ R file2/newf i/am/new/to/you
 INPUT_END
 
 cat >expect <<EOF
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	i/am/new/to/you
+:100755 100755 $newf $newf R100	file2/newf	i/am/new/to/you
 EOF
 test_expect_success \
 	'M: rename file to new subdirectory' \
@@ -770,7 +803,7 @@ R i other/sub
 INPUT_END
 
 cat >expect <<EOF
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	other/sub/am/new/to/you
+:100755 100755 $newf $newf R100	i/am/new/to/you	other/sub/am/new/to/you
 EOF
 test_expect_success \
 	'M: rename subdirectory to new subdirectory' \
@@ -796,7 +829,7 @@ C file2/newf file2/n.e.w.f
 INPUT_END
 
 cat >expect <<EOF
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file2/n.e.w.f
+:100755 100755 $newf $newf C100	file2/newf	file2/n.e.w.f
 EOF
 test_expect_success \
 	'N: copy file in same subdirectory' \
@@ -828,9 +861,9 @@ EOF
 INPUT_END
 
 cat >expect <<EOF
-:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
-:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+:100644 100644 $file5_id $file5_id C100	newdir/interesting	file3/file5
+:100755 100755 $newf $newf C100	file2/newf	file3/newf
+:100644 100644 $oldf $oldf C100	file2/oldf	file3/oldf
 EOF
 test_expect_success \
 	'N: copy then modify subdirectory' \
@@ -863,9 +896,9 @@ test_expect_success \
 
 test_expect_success \
 	'N: copy directory by id' \
-	'cat >expect <<-\EOF &&
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
-	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+	'cat >expect <<-EOF &&
+	:100755 100755 $newf $newf C100	file2/newf	file3/newf
+	:100644 100644 $oldf $oldf C100	file2/oldf	file3/oldf
 	EOF
 	 subdir=$(git rev-parse refs/heads/branch^0:file2) &&
 	 cat >input <<-INPUT_END &&
@@ -884,10 +917,10 @@ test_expect_success \
 
 test_expect_success \
 	'N: modify copied tree' \
-	'cat >expect <<-\EOF &&
-	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
-	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+	'cat >expect <<-EOF &&
+	:100644 100644 $file5_id $file5_id C100	newdir/interesting	file3/file5
+	:100755 100755 $newf $newf C100	file2/newf	file3/newf
+	:100644 100644 $oldf $oldf C100	file2/oldf	file3/oldf
 	EOF
 	 subdir=$(git rev-parse refs/heads/branch^0:file2) &&
 	 cat >input <<-INPUT_END &&
-- 
1.7.2.3
