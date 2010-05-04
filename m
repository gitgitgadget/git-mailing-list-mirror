From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: jn/shortlog
Date: Mon, 3 May 2010 20:56:35 -0500
Message-ID: <20100504015635.GA7258@progeny.tock>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
 <1272912875.3537.6.camel@dreddbeard>
 <20100504002526.GA7061@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 03:56:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O97N9-0002UJ-RC
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 03:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924Ab0EDB40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 21:56:26 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:56971 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab0EDB4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 21:56:25 -0400
Received: by gxk9 with SMTP id 9so1918881gxk.8
        for <git@vger.kernel.org>; Mon, 03 May 2010 18:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=deerkXhzNRxvrcf+ZE08FZdKPLULRLFrW7mdgDvwHAk=;
        b=s+/Hg6bJACRShZt3VBeqdepZzfLuwC9i7uMbO5T01Pzq5J21hZwe9tJKPKdEqA5f1c
         WWXSRzZb05xE8jlP1Q6BzJG59XTWysR93scAH5GdqTdQA9rLYSRDDrnWRLJaWATDWO23
         Ov9nFVacWPVzo4Z+Z8tdEQ19hJzW4jRpT33yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xC8dlBFStHOtLlorhueDgWyiO8g9qWr/ILNNxlEXmHajlwJJ4krgEInuFjpb9RII+H
         0cJK6dN3G3xwG5KezGSQcsyz8pEoJi0LXwbR+sFp3U5VvMzyzX55lwlVsYkT0F2ojbP9
         bra3rqVfYqpYGuqIv0bAvPqsLAZO6LpykGwS8=
Received: by 10.90.233.3 with SMTP id f3mr2173745agh.120.1272938184575;
        Mon, 03 May 2010 18:56:24 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm4808650iwn.15.2010.05.03.18.56.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 18:56:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100504002526.GA7061@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146278>

Jonathan Nieder wrote:
> Will Palmer wrote:

>> Haven't been able to reproduce here (just running make -m4 in a
>> while-loop all night) Any specific tests failing?
>
> In t4201-shortlog.sh:
> 
> --- expect.template     2010-05-04 00:17:41.609754167 +0000
> +++ log.predictable     2010-05-04 00:17:41.613754428 +0000
> @@ -1,10 +0,0 @@
[etc]

So apparently shortlog does not default to HEAD when stdin is not a
tty.

Possible fixes:

 - document the current unfriendly behavior
 - default to HEAD when input is empty

Jonathan

-- 8< --
Subject: t4200 (rerere): guard setup with test_expect_success

Ensure that GIT_SKIP_TESTS='t4200.*' actually suppresses all of t4200.

Also quote some stray dollar signs and test the result from some
git config invocations.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4200-rerere.sh |  189 ++++++++++++++++++++++++++++++-----------------------
 1 files changed, 106 insertions(+), 83 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 70856d0..d9b87c9 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -56,23 +56,27 @@ test_expect_success 'conflicting merge' '
 	git reset --hard &&
 	mkdir .git/rr-cache &&
 	git config --unset rerere.enabled &&
-	test_must_fail git merge first
+	test_must_fail git merge first &&
+	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
+	rr=.git/rr-cache/$sha1
 '
 
-sha1=$(perl -pe 's/	.*//' .git/MERGE_RR)
-rr=.git/rr-cache/$sha1
-test_expect_success 'recorded preimage' "grep ^=======$ $rr/preimage"
+test_expect_success 'recorded preimage' '
+	grep "^=======\$" "$rr/preimage"
+'
 
 test_expect_success 'rerere.enabled works, too' '
 	rm -rf .git/rr-cache &&
 	git config rerere.enabled true &&
 	git reset --hard &&
 	test_must_fail git merge first &&
-	grep ^=======$ $rr/preimage
+	grep "^=======\$" "$rr/preimage"
 '
 
-test_expect_success 'no postimage or thisimage yet' \
-	"test ! -f $rr/postimage -a ! -f $rr/thisimage"
+test_expect_success 'no postimage or thisimage yet' '
+	! test -f "$rr/postimage" &&
+	! test -f "$rr/thisimage"
+'
 
 test_expect_success 'preimage has right number of lines' '
 
@@ -81,56 +85,60 @@ test_expect_success 'preimage has right number of lines' '
 
 '
 
-git show first:a1 > a1
-
-cat > expect << EOF
---- a/a1
-+++ b/a1
-@@ -1,4 +1,4 @@
--Some Title
-+Some title
- ==========
- Whether 'tis nobler in the mind to suffer
- The slings and arrows of outrageous fortune,
-@@ -8,21 +8,11 @@
- The heart-ache and the thousand natural shocks
- That flesh is heir to, 'tis a consummation
- Devoutly to be wish'd.
--<<<<<<<
--Some Title
--==========
--To die! To sleep;
--=======
- Some title
- ==========
- To die, to sleep;
-->>>>>>>
- To sleep: perchance to dream: ay, there's the rub;
- For in that sleep of death what dreams may come
- When we have shuffled off this mortal coil,
- Must give us pause: there's the respect
- That makes calamity of so long life;
--<<<<<<<
--=======
--* END *
-->>>>>>>
-EOF
-git rerere diff > out
-
-test_expect_success 'rerere diff' 'test_cmp expect out'
-
-cat > expect << EOF
-a1
-EOF
-
-git rerere status > out
-
-test_expect_success 'rerere status' 'test_cmp expect out'
+test_expect_success 'rerere diff' "
+	git show first:a1 >a1 &&
+
+	cat >expect <<-\EOF
+	--- a/a1
+	+++ b/a1
+	@@ -1,4 +1,4 @@
+	-Some Title
+	+Some title
+	 ==========
+	 Whether 'tis nobler in the mind to suffer
+	 The slings and arrows of outrageous fortune,
+	@@ -8,21 +8,11 @@
+	 The heart-ache and the thousand natural shocks
+	 That flesh is heir to, 'tis a consummation
+	 Devoutly to be wish'd.
+	-<<<<<<<
+	-Some Title
+	-==========
+	-To die! To sleep;
+	-=======
+	 Some title
+	 ==========
+	 To die, to sleep;
+	->>>>>>>
+	 To sleep: perchance to dream: ay, there's the rub;
+	 For in that sleep of death what dreams may come
+	 When we have shuffled off this mortal coil,
+	 Must give us pause: there's the respect
+	 That makes calamity of so long life;
+	-<<<<<<<
+	-=======
+	-* END *
+	->>>>>>>
+	EOF
+	git rerere diff >out &&
+	test_cmp expect out
+"
+
+test_expect_success 'rerere status' '
+	cat >expect <<-\EOF &&
+	a1
+	EOF
+
+	git rerere status >out &&
+	test_cmp expect out
+'
 
 test_expect_success 'commit succeeds' \
 	"git commit -q -a -m 'prefer first over second'"
 
-test_expect_success 'recorded postimage' "test -f $rr/postimage"
+test_expect_success 'recorded postimage' '
+	test -f "$rr/postimage"
+'
 
 test_expect_success 'another conflicting merge' '
 	git checkout -b third master &&
@@ -139,47 +147,62 @@ test_expect_success 'another conflicting merge' '
 	test_must_fail git pull . first
 '
 
-git show first:a1 | sed 's/To die: t/To die! T/' > expect
-test_expect_success 'rerere kicked in' "! grep ^=======$ a1"
+test_expect_success 'rerere kicked in' '
+	! grep "^=======\$" a1
+'
 
-test_expect_success 'rerere prefers first change' 'test_cmp a1 expect'
+test_expect_success 'rerere prefers first change' '
+	git show first:a1 | sed "s/To die: t/To die! T/" >expect &&
+	test_cmp a1 expect
+'
 
-rm $rr/postimage
-echo "$sha1	a1" | perl -pe 'y/\012/\000/' > .git/MERGE_RR
+test_expect_success 'cleanup' '
+	rm $rr/postimage &&
+	echo "$sha1	a1" |
+		perl -pe "y/\012/\000/" >.git/MERGE_RR
+'
 
 test_expect_success 'rerere clear' 'git rerere clear'
 
 test_expect_success 'clear removed the directory' "test ! -d $rr"
 
-mkdir $rr
-echo Hello > $rr/preimage
-echo World > $rr/postimage
-
-sha2=4000000000000000000000000000000000000000
-rr2=.git/rr-cache/$sha2
-mkdir $rr2
-echo Hello > $rr2/preimage
-
-almost_15_days_ago=$((60-15*86400))
-just_over_15_days_ago=$((-1-15*86400))
-almost_60_days_ago=$((60-60*86400))
-just_over_60_days_ago=$((-1-60*86400))
+test_expect_success 'gc setup' '
+	mkdir "$rr" &&
+	echo Hello >"$rr/preimage" &&
+	echo World >"$rr/postimage" &&
 
-test-chmtime =$almost_60_days_ago $rr/preimage
-test-chmtime =$almost_15_days_ago $rr2/preimage
+	sha2=4000000000000000000000000000000000000000 &&
+	rr2=.git/rr-cache/$sha2 &&
+	mkdir "$rr2" &&
+	echo Hello >"$rr2/preimage" &&
 
-test_expect_success 'garbage collection (part1)' 'git rerere gc'
+	almost_15_days_ago=$((60-15*86400)) &&
+	just_over_15_days_ago=$((-1-15*86400)) &&
+	almost_60_days_ago=$((60-60*86400)) &&
+	just_over_60_days_ago=$((-1-60*86400))
+'
 
-test_expect_success 'young records still live' \
-	"test -f $rr/preimage && test -f $rr2/preimage"
+test_expect_success 'garbage collection (part1)' '
+	test-chmtime "=$almost_60_days_ago" "$rr/preimage" &&
+	test-chmtime "=$almost_15_days_ago" "$rr2/preimage" &&
+	git rerere gc
+'
 
-test-chmtime =$just_over_60_days_ago $rr/preimage
-test-chmtime =$just_over_15_days_ago $rr2/preimage
+test_expect_success 'young records still live' '
+	test -f "$rr/preimage" &&
+	test -f "$rr2/preimage"
+'
 
-test_expect_success 'garbage collection (part2)' 'git rerere gc'
+test_expect_success 'garbage collection (part2)' '
+	test-chmtime "=$just_over_60_days_ago" "$rr/preimage" &&
+	test-chmtime "=$just_over_15_days_ago" "$rr2/preimage" &&
+	git rerere gc
+'
 
-test_expect_success 'old records rest in peace' \
-	"test ! -f $rr/preimage && test ! -f $rr2/preimage"
+test_expect_success 'old records rest in peace' '
+	! test -f "$rr/preimage" &&
+	! test -f "$rr2/preimage"
+'
 
 test_expect_success 'file2 added differently in two branches' '
 	git reset --hard &&
@@ -214,7 +237,7 @@ test_expect_success 'resolution was recorded properly' '
 '
 
 test_expect_success 'rerere.autoupdate' '
-	git config rerere.autoupdate true
+	git config rerere.autoupdate true &&
 	git reset --hard &&
 	git checkout version2 &&
 	test_must_fail git merge fifth &&
@@ -230,7 +253,7 @@ test_expect_success 'merge --rerere-autoupdate' '
 '
 
 test_expect_success 'merge --no-rerere-autoupdate' '
-	git config rerere.autoupdate true
+	git config rerere.autoupdate true &&
 	git reset --hard &&
 	git checkout version2 &&
 	test_must_fail git merge --no-rerere-autoupdate fifth &&
-- 
1.7.1.5.g8d03f
