From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: shell compatibility issues with SunOS 5.10
Date: Wed, 6 May 2009 15:59:13 +1000
Message-ID: <20090506055913.GA9701@dektop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 07:59:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1aAC-0006n0-Kt
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 07:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbZEFF7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 01:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZEFF7T
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 01:59:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:17232 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbZEFF7T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 01:59:19 -0400
Received: by wf-out-1314.google.com with SMTP id 26so4279613wfd.4
        for <git@vger.kernel.org>; Tue, 05 May 2009 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=J3Bnm9vq3fRBXD75HCvFOWLYbzEcyeggAcSSKhWGc8k=;
        b=LzstS+TpbTQx+lNiij40GVOLUfeXPnh9wCAK3Kj1hdOSXIXlSy+y3B5rEEtegMjxDm
         HzXvRj29EybW8OLe/9847tjCu0fXBu8GSA7Sk96hnEpyDhGqyTPJ6gGpVRtB5uKnEyXi
         UvPEqKrpkrjdJxhd5sTyepEx25uqQ37A3EwHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=xkzRko7BEL+CBMi30taszCXh/7pd5ZwrGpYKSKVBD/GaspNjzBspp5QtEXJnhY87SR
         755N7Ff2x++1wAud5iNz1DzGAxAW1NGvZsom77bgIcHR04+8COTgGM6N5pJlwqIj8jX1
         vzyoeRexslJ7B4WLTjZp048XVN4keBgmbdazw=
Received: by 10.142.147.15 with SMTP id u15mr341645wfd.230.1241589559313;
        Tue, 05 May 2009 22:59:19 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id 20sm6925401wfi.0.2009.05.05.22.59.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 May 2009 22:59:18 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  6 May 2009 15:59:13 +1000
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118324>

Hi,

I did "make test" on a SunOS 5.10 and it failed. With the below patch,
only t7400 and t8005 kept failing. For the first case, t7400.5 failed
because extensive use of sed to normalize path in git-submodule.sh

	# normalize path:
	# multiple //; leading ./; /./; /../; trailing /
	path=$(printf '%s/\n' "$path" |
		sed -e '
			s|//*|/|g
			s|^\(\./\)*||
			s|/\./|/|g
			:start
			s|\([^/]*\)/\.\./||
			tstart
			s|/*$||
		')

The second failed because it used extended regexp

grep "^\(author\|summary\) "

I'm no sed/grep wizard (and quite new to SunOS too), no clue how to do
it properly. Any help?

diff --git a/git-am.sh b/git-am.sh
index 6d1848b..5a91d52 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -46,7 +46,7 @@ fi
 sq () {
 	for sqarg
 	do
-		printf "%s" "$sqarg" |
+		printf "%s\n" "$sqarg" |
 		sed -e 's/'\''/'\''\\'\'''\''/g' -e 's/.*/ '\''&'\''/'
 	done
 }
diff --git a/t/t2019-checkout-sparse.sh b/t/t2019-checkout-sparse.sh
index 4ea1ee6..6949a59 100755
--- a/t/t2019-checkout-sparse.sh
+++ b/t/t2019-checkout-sparse.sh
@@ -68,13 +68,13 @@ test_expect_success 'update narrow prefix with modification' '
 	test -f work1/one &&
 	test -f work2/two &&
 	! test -f work3/three &&
-	grep -q modified work2/two &&
+	grep modified work2/two &&
 
 	! git checkout --sparse=work1/:work3/ &&
 	test -f work1/one &&
 	test -f work2/two &&
 	! test -f work3/three &&
-	grep -q modified work2/two &&
+	grep modified work2/two &&
 	git checkout work2/two
 '
 
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index b68ab11..61ccdee 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -57,7 +57,7 @@ test_expect_success 'conflicting merge' '
 	test_must_fail git merge first
 '
 
-sha1=$(sed -e 's/	.*//' .git/MERGE_RR)
+sha1=$(cut -f 1 .git/MERGE_RR)
 rr=.git/rr-cache/$sha1
 test_expect_success 'recorded preimage' "grep ^=======$ $rr/preimage"
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index e2aa254..9a916d3 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -315,7 +315,7 @@ test_expect_success 'unpacking with --strict' '
 	head -n 10 LIST | git update-index --index-info &&
 	LI=$(git write-tree) &&
 	rm -f .git/index &&
-	tail -n 10 LIST | git update-index --index-info &&
+	tail -10 LIST | git update-index --index-info &&
 	ST=$(git write-tree) &&
 	PACK5=$( git rev-list --objects "$LIST" "$LI" "$ST" | \
 		git pack-objects test-5 ) &&
@@ -362,7 +362,7 @@ test_expect_success 'index-pack with --strict' '
 	head -n 10 LIST | git update-index --index-info &&
 	LI=$(git write-tree) &&
 	rm -f .git/index &&
-	tail -n 10 LIST | git update-index --index-info &&
+	tail -10 LIST | git update-index --index-info &&
 	ST=$(git write-tree) &&
 	PACK5=$( git rev-list --objects "$LIST" "$LI" "$ST" | \
 		git pack-objects test-5 ) &&
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index e2ef532..b3633d0 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -142,10 +142,10 @@ test_expect_success \
 	'editor not invoked if -F is given' '
 	 echo "moo" >file &&
 	 VISUAL=./editor git commit -a -F msg &&
-	 git show -s --pretty=format:"%s" | grep -q good &&
+	 git show -s --pretty=format:"%s" | grep good &&
 	 echo "quack" >file &&
 	 echo "Another good message." | VISUAL=./editor git commit -a -F - &&
-	 git show -s --pretty=format:"%s" | grep -q good
+	 git show -s --pretty=format:"%s" | grep good
 	 '
 # We could just check the head sha1, but checking each commit makes it
 # easier to isolate bugs.
