From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t7610: cd inside subshell instead of around
Date: Mon, 23 Aug 2010 22:05:24 -0500
Message-ID: <20100824030524.GF17406@burratino>
References: <1282617444-641-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 05:07:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onjr4-0004Am-Dq
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 05:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab0HXDHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 23:07:13 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62457 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0HXDHL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 23:07:11 -0400
Received: by ywe9 with SMTP id 9so1729492ywe.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 20:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uQ63MXf0/uq5uv3+UfV2FpJQ3vKNrOWdkwb5N+BHp1g=;
        b=XHfZpd30rQeKCQ4uR6lEiloj0XRVvX65H6fhHoj4AgDydeq6CES+rsYhk89UT57CQg
         KRtyRMJYNs0Q+NxNDibTp4Ecc2yqvAjKksJjfKV6LMnOcYA8zdD+pEH6JRqKqjQuWIZC
         rONJxoEOl34Jm+NyD+vFVLGA5xvGaHPVCl4PE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dpAahO/sUl47mzLr8IRdMZMjWC86lkVfiC2Y1P06BkHBdvEc3WHIDvkAa+o7dCMABk
         Ho5lbsJAJdF2ZaAghXJ/9ZJg7Tx7YKTFMrZ4hOARd/Cef/G0k7suA+D8K9tPVS2ugA9E
         v9mh7T7DiCRsB+Rj1fpbK3yLHbMZ4feKjWFEE=
Received: by 10.100.210.6 with SMTP id i6mr6457146ang.143.1282619229393;
        Mon, 23 Aug 2010 20:07:09 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w1sm510015ana.16.2010.08.23.20.07.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 20:07:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282617444-641-1-git-send-email-brian@gernhardtsoftware.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154280>

Brian Gernhardt wrote:

> Instead of using `cd dir && (...) && cd..` use `(cd dir && ...)`

Thank you.

> +++ b/t/t7610-mergetool.sh
> @@ -68,22 +68,24 @@ test_expect_success 'mergetool crlf' '
>  '
>  
>  test_expect_success 'mergetool in subdir' '
> -    git checkout -b test3 branch1
> -    cd subdir && (
> -    test_must_fail git merge master >/dev/null 2>&1 &&
> -    ( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
> -    test "$(cat file3)" = "master new sub") &&
> -    cd ..
> +    git checkout -b test3 branch1 &&
> +    (
> +        cd subdir &&
> +        test_must_fail git merge master >/dev/null 2>&1 &&
> +        ( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
> +        test "$(cat file3)" = "master new sub"
> +    )


While we're looking at this test script, some more nitpicks for
squashing in. :)

-- 8< --
Subject: t7610 (mergetool): more nitpicks

 - use tabs to indent
 - do not redirect output away unnecessarily
 - avoid a subshell for 'yes "" | git mergetool file3'
 - use test_tick for reproducible, increasing timestamps
 - use test_cmp instead of 'test $foo = bar'; the former is much
   nicer to debug with --verbose since it produces a diff.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7610-mergetool.sh |  186 ++++++++++++++++++++++++++++---------------------
 1 files changed, 106 insertions(+), 80 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 3c436e1..908f934 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -3,112 +3,138 @@
 # Copyright (c) 2008 Charles Bailey
 #
 
-test_description='git mergetool
+test_description='Testing basic merge tool invocation
 
-Testing basic merge tool invocation'
+All the mergetool tests work by checking out a temporary branch based
+off branch1 and then merging in master and checking the results of
+running mergetool.
+'
 
 . ./test-lib.sh
 
-# All the mergetool test work by checking out a temporary branch based
-# off 'branch1' and then merging in master and checking the results of
-# running mergetool
-
 test_expect_success 'setup' '
-    git config rerere.enabled true &&
-    echo master >file1 &&
-    mkdir subdir &&
-    echo master sub >subdir/file3 &&
-    git add file1 subdir/file3 &&
-    git commit -m "added file1" &&
+	git config rerere.enabled true &&
+	echo master >file1 &&
+	mkdir subdir &&
+	echo master sub >subdir/file3 &&
+	git add file1 subdir/file3 &&
+	test_tick &&
+	git commit -m "added file1" &&
 
-    git checkout -b branch1 master &&
-    echo branch1 change >file1 &&
-    echo branch1 newfile >file2 &&
-    echo branch1 sub >subdir/file3 &&
-    git add file1 file2 subdir/file3 &&
-    git commit -m "branch1 changes" &&
+	git checkout -b branch1 master &&
+	echo branch1 change >file1 &&
+	echo branch1 newfile >file2 &&
+	echo branch1 sub >subdir/file3 &&
+	git add file1 file2 subdir/file3 &&
+	test_tick &&
+	git commit -m "branch1 changes" &&
 
-    git checkout master &&
-    echo master updated >file1 &&
-    echo master new >file2 &&
-    echo master new sub >subdir/file3 &&
-    git add file1 file2 subdir/file3 &&
-    git commit -m "master updates" &&
+	git checkout master &&
+	echo master updated >file1 &&
+	echo master new >file2 &&
+	echo master new sub >subdir/file3 &&
+	git add file1 file2 subdir/file3 &&
+	test_tick &&
+	git commit -m "master updates" &&
 
-    git config merge.tool mytool &&
-    git config mergetool.mytool.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
-    git config mergetool.mytool.trustExitCode true
+	git config merge.tool mytool &&
+	git config mergetool.mytool.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
+	git config mergetool.mytool.trustExitCode true
 '
 
 test_expect_success 'custom mergetool' '
-    git checkout -b test1 branch1 &&
-    test_must_fail git merge master >/dev/null 2>&1 &&
-    ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
-    ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
-    ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
-    test "$(cat file1)" = "master updated" &&
-    test "$(cat file2)" = "master new" &&
-    test "$(cat subdir/file3)" = "master new sub" &&
-    git commit -m "branch1 resolved with mergetool"
+	echo master updated >file1.expected &&
+	echo master new >file2.expected &&
+	echo master new sub >sub.expected &&
+
+	git checkout -b test1 branch1 &&
+	test_must_fail git merge master &&
+	yes "" | git mergetool file1 &&
+	yes "" | git mergetool file2 &&
+	yes "" | git mergetool subdir/file3 &&
+
+	test_cmp file1.expected file1 &&
+	test_cmp file2.expected file2 &&
+	test_cmp sub.expected subdir/file3 &&
+
+	git commit -m "branch1 resolved with mergetool"
 '
 
 test_expect_success 'mergetool crlf' '
-    git config core.autocrlf true &&
-    git checkout -b test2 branch1
-    test_must_fail git merge master >/dev/null 2>&1 &&
-    ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
-    ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
-    ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
-    test "$(printf x | cat file1 -)" = "$(printf "master updated\r\nx")" &&
-    test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
-    test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
-    git commit -m "branch1 resolved with mergetool - autocrlf" &&
-    git config core.autocrlf false &&
-    git reset --hard
+	git config core.autocrlf true &&
+	test_when_finished "git config --unset core.autocrlf" &&
+	echo master updated | append_cr >file1.expected &&
+	echo master new | append_cr >file2.expected &&
+	echo master new sub | append_cr >sub.expected &&
+
+	git checkout -b test2 branch1 &&
+	test_must_fail git merge master &&
+	test_when_finished "git reset --hard" &&
+	yes "" | git mergetool file1 &&
+	yes "" | git mergetool file2 &&
+	yes "" | git mergetool subdir/file3 &&
+
+	test_cmp file1.expected file1 &&
+	test_cmp file2.expected file2 &&
+	test_cmp sub.expected subdir/file3 &&
+
+	git commit -m "branch1 resolved with mergetool - autocrlf"
 '
 
 test_expect_success 'mergetool in subdir' '
-    git checkout -b test3 branch1 &&
-    (
-        cd subdir &&
-        test_must_fail git merge master >/dev/null 2>&1 &&
-        ( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
-        test "$(cat file3)" = "master new sub"
-    )
+	echo master new sub >sub.expected &&
+	git checkout -b test3 branch1 &&
+	(
+		cd subdir &&
+		test_must_fail git merge master &&
+		yes "" | git mergetool file3 &&
+		test_cmp ../sub.expected file3
+	)
 '
 
 test_expect_success 'mergetool on file in parent dir' '
-    (
-        cd subdir && 
-        ( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
-        ( yes "" | git mergetool ../file2 >/dev/null 2>&1 ) &&
-        test "$(cat ../file1)" = "master updated" &&
-        test "$(cat ../file2)" = "master new" &&
-        git commit -m "branch1 resolved with mergetool - subdir"
-    )
+	echo master updated >file1.expected &&
+	echo master new >file2.expected &&
+	(
+		cd subdir &&
+		yes "" | git mergetool ../file1 &&
+		yes "" | git mergetool ../file2 &&
+		test_cmp ../file1.expected ../file1 &&
+		test_cmp ../file2.expected ../file2 &&
+		git commit -m "branch1 resolved with mergetool - subdir"
+	)
 '
 
 test_expect_success 'mergetool skips autoresolved' '
-    git checkout -b test4 branch1 &&
-    test_must_fail git merge master &&
-    test -n "$(git ls-files -u)" &&
-    output="$(git mergetool --no-prompt)" &&
-    test "$output" = "No files need merging" &&
-    git reset --hard
+	echo "No files need merging" >expected &&
+	git checkout -b test4 branch1 &&
+	test_must_fail git merge master &&
+	test_when_finished "git reset --hard" &&
+	test_must_fail git update-index --refresh &&
+	git mergetool --no-prompt >actual &&
+	test_cmp expected actual
 '
 
 test_expect_success 'mergetool merges all from subdir' '
-    (
-        cd subdir &&
-        git config rerere.enabled false &&
-        test_must_fail git merge master &&
-        git mergetool --no-prompt &&
-        test "$(cat ../file1)" = "master updated" &&
-        test "$(cat ../file2)" = "master new" &&
-        test "$(cat file3)" = "master new sub" &&
-        git add ../file1 ../file2 file3 &&
-        git commit -m "branch2 resolved by mergetool from subdir"
-    )
+	echo master updated >file1.expected &&
+	echo master new >file2.expected &&
+	echo master new sub >sub.expected &&
+
+	git config rerere.enabled false &&
+	test_when_finished "git config rerere.enabled true" &&
+	mv .git/rr-cache .git/rr-cache-moved &&
+	test_when_finished "mv .git/rr-cache-moved .git/rr-cache" &&
+	(
+		cd subdir &&
+		test_must_fail git merge master &&
+		test_when_finished "git reset --hard" &&
+		git mergetool --no-prompt &&
+		test_cmp ../file1.expected ../file1 &&
+		test_cmp ../file2.expected ../file2 &&
+		test_cmp ../sub.expected file3 &&
+		git add ../file1 ../file2 file3 &&
+		git commit -m "branch2 resolved by mergetool from subdir"
+	)
 '
 
 test_done
-- 
1.7.2.2
