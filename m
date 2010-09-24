From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/24] t9300 (fast-import): avoid exiting early on failure
Date: Fri, 24 Sep 2010 02:04:19 -0500
Message-ID: <20100924070418.GB4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:07:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2NK-0003uj-2w
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab0IXHHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:07:08 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43017 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab0IXHHH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:07:07 -0400
Received: by yxp4 with SMTP id 4so855892yxp.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EeQ/j/l2NrS7ZaQsxsF6mv88RllyJWPCv7S6T2uq1yY=;
        b=n3giR1wa/zkI3tk9sTZKlT+Igb9l+mzlAP/aC2zFq9FC/Laotgs/NyG8VRDlufKx00
         4wg2vWJc7SAusN58KaHxIyaZAPlA/CUGf+eGRxAV/qZq9R+pzylRY0toClQiwGgNErHQ
         0wx8k6imbHo6GPmsXe7qv5f345RzvwivndW9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JNL83VG9yvzfk9bJHbalG/jtdKbSXiTqR9YhQfEkW+sn7XsGh9WYqhMQnQE0TvGHIT
         M/LbYXeCYVX9nyEDVAAV/+5zlssk82U9+PKP6RaouNAA/bYgTNcz0lFo5QxQx62ZZlvc
         W5/fLV2yrh0mSXROxk9GwPnSSC9CLg330SyrI=
Received: by 10.150.190.6 with SMTP id n6mr3908794ybf.310.1285312026195;
        Fri, 24 Sep 2010 00:07:06 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q3sm1943905ybe.14.2010.09.24.00.07.04
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:07:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156935>

Exiting is not an appropriate way to signal a test failure, since it
bypasses the usual expect_success/expect_failure logic and prevents
later tests that might be able to help diagnose the problem from
running.

Still, exiting is a temptingly easy way to catch errors in shell
loops.  Alternatives:

 1) Ignore errors in the loop body.  This can leave problems hidden
    and undiagnosed so it is not really an option.

 2) Enclose the loop in a subshell which can catch the exit on
    failure.

 3) Enclose the loop in a function and return the exit code on
    failure.

 4) More ad-hoc methods.

Most instances in t9300 lend themselves well to (3), with the nice
side effect of avoiding some repetitive code.  Introduce a new
verify_packs () helper in this spirit.

One instance uses "verify-pack -v", making it slightly different from
the others; rather than spending effort on making the helper general
enough to be usable for it, too, enclose the strange loop in
a subshell (strategy (2)).  While at it, simplify the code a little
by redirecting stdout of the loop instead of its body.

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   38 ++++++++++++++++++++++++--------------
 1 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 7c05920..1eef926 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -23,6 +23,14 @@ file5_data='an inline file.
 file6_data='#!/bin/sh
 echo "$@"'
 
+verify_packs () {
+	for p in .git/objects/pack/*.pack
+	do
+		git verify-pack $p ||
+		return
+	done
+}
+
 ###
 ### series A
 ###
@@ -69,7 +77,7 @@ test_expect_success \
 	 git whatchanged master'
 test_expect_success \
 	'A: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+	'verify_packs'
 
 cat >expect <<EOF
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -155,7 +163,7 @@ test_expect_success \
 	 git whatchanged verify--import-marks'
 test_expect_success \
 	'A: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+	'verify_packs'
 cat >expect <<EOF
 :000000 100755 0000000000000000000000000000000000000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 A	copy-of-file2
 EOF
@@ -318,7 +326,7 @@ test_expect_success \
 	 git whatchanged branch'
 test_expect_success \
 	'C: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+	'verify_packs'
 test_expect_success \
 	'C: validate reuse existing blob' \
 	'test $newf = `git rev-parse --verify branch:file2/newf`
@@ -376,7 +384,7 @@ test_expect_success \
 	 git whatchanged branch'
 test_expect_success \
 	'D: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+	'verify_packs'
 
 cat >expect <<EOF
 :000000 100755 0000000000000000000000000000000000000000 35a59026a33beac1569b1c7f66f3090ce9c09afc A	newdir/exec.sh
@@ -422,7 +430,7 @@ test_expect_success \
     'git fast-import --date-format=rfc2822 <input'
 test_expect_success \
 	'E: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+	'verify_packs'
 
 cat >expect <<EOF
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 1170778938 -0500
@@ -473,7 +481,7 @@ test_expect_success \
 	'
 test_expect_success \
 	'F: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+	'verify_packs'
 
 cat >expect <<EOF
 tree `git rev-parse branch~1^{tree}`
@@ -509,7 +517,7 @@ test_expect_success \
     'git fast-import --force <input'
 test_expect_success \
 	'G: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+	'verify_packs'
 test_expect_success \
 	'G: branch changed, but logged' \
 	'test $old_branch != `git rev-parse --verify branch^0` &&
@@ -546,7 +554,7 @@ test_expect_success \
 	 git whatchanged H'
 test_expect_success \
 	'H: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+	'verify_packs'
 
 cat >expect <<EOF
 :100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file2/newf
@@ -1327,7 +1335,7 @@ test_expect_success \
 	 git whatchanged notes-test'
 test_expect_success \
 	'Q: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+	'verify_packs'
 
 commit1=$(git rev-parse notes-test~2)
 commit2=$(git rev-parse notes-test^)
@@ -1675,11 +1683,13 @@ test_expect_success \
 	 git --git-dir=R/.git fast-import --big-file-threshold=1 <input'
 test_expect_success \
 	'R: verify created pack' \
-	': >verify &&
-	 for p in R/.git/objects/pack/*.pack;
-	 do
-	   git verify-pack -v $p >>verify || exit;
-	 done'
+	'(
+		for p in R/.git/objects/pack/*.pack
+		do
+			git verify-pack -v $p ||
+			exit
+		done
+	 ) >verify'
 test_expect_success \
 	'R: verify written objects' \
 	'git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
-- 
1.7.2.3
