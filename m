From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Show submodules as modified when they contain a dirty work tree
Date: Fri, 15 Jan 2010 22:32:21 +0900
Message-ID: <20100115223221.6117@nanako3.lavabit.com>
References: <4B4BA096.5000909@web.de> <7vtyusb6rv.fsf@alter.siamese.dyndns.org> <4B4CA13F.6020505@web.de> <7vbpgyqy4a.fsf@alter.siamese.dyndns.org> <4B4E1817.1070202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 15 14:33:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVmIX-00043l-F8
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 14:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab0AONc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 08:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755046Ab0AONc7
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 08:32:59 -0500
Received: from karen.lavabit.com ([72.249.41.33]:54154 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755005Ab0AONc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 08:32:58 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 2749516F486;
	Fri, 15 Jan 2010 07:32:58 -0600 (CST)
Received: from 5526.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 2GPZMPXSWBSI; Fri, 15 Jan 2010 07:32:58 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Ii6pZ7z/YpjM/6rAa7LDfndez0mYtuWlRrNVmwp/f0LeyG5kcpWgBtKp8/KEhvyb3p4jdor+583/e/UG61jIUYY3OfX2wsATTlPegLrxmKV3Wpt0ZtBcrCQedpxRp1Skq9ZQG29FAV3Gq/KpIPId02vmNHfUXH6H1eRjRvlI2U0=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <7vbpgyqy4a.fsf@alter.siamese.dyndns.org> <4B4E1817.1070202@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137067>

Quoting Jens Lehmann <Jens.Lehmann@web.de>

> diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
> index 3ca17ab..47e205b 100755
> --- a/t/t7506-status-submodule.sh
> +++ b/t/t7506-status-submodule.sh
> @@ -10,8 +10,12 @@ test_expect_success 'setup' '
>  	: >bar &&
>  	git add bar &&
>  	git commit -m " Add bar" &&
> +	: >foo &&
> +	git add foo &&
> +	git commit -m " Add foo" &&
>  	cd .. &&
> -	git add sub &&
> +	echo output > .gitignore
> +	git add sub .gitignore &&
>  	git commit -m "Add submodule sub"
>  '

This is not a new problem you introduced, but if some commands
before 'cd ..' fails, the next test will run in 'sub'. Other
tests run operations inside () to avoid this problem.

> @@ -23,6 +27,31 @@ test_expect_success 'commit --dry-run -a clean' '
>  	git commit --dry-run -a |
>  	grep "nothing to commit"
>  '
> +
> +echo "changed" > sub/foo

Have it inside the next test_expect_success.

> +test_expect_success 'status with modified file in submodule' '
> +	git status | grep "modified:   sub"
> +'

To catch failure from 'git status' this is better written like this.
    git status >output &&
    grep "modified:   sub" output

> +test_expect_success 'status with modified file in submodule (porcelain)' '
> +	git status --porcelain >output &&
> +	diff output - <<-EOF
> + M sub
> +EOF
> +'

If you use -EOF you may want to align it with tab to make it
easier to read. The one in t7005-editor.sh is a good example
(t7401 is a bad example to imitate).

> +(cd sub && git checkout foo)
> +
> +echo "content" > sub/new-file

Move this part to the next test_expect_success to catch broken
checkout.

> +test_expect_success 'status with untracked file in submodule' '
> +	git status | grep "modified:   sub"
> +'

Same comment as before.

> +test_expect_success 'status with untracked file in submodule (porcelain)' '
> +	git status --porcelain >output &&
> +	diff output - <<-EOF
> + M sub
> +EOF
> +'

Same comment as before.

> +rm sub/new-file
> +

Do you need this? If so, move it inside the next
test_expect_success.

>  test_expect_success 'rm submodule contents' '
>  	rm -rf sub/* sub/.git
>  '
> -- 
> 1.6.6.203.g28a8ba.dirty

The following can be squashed to 4519d9cf092a173ac7b0a5570b0d5d602086ecf2

diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 47e205b..253c334 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -5,63 +5,87 @@ test_description='git status for submodule'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	test_create_repo sub
-	cd sub &&
-	: >bar &&
-	git add bar &&
-	git commit -m " Add bar" &&
-	: >foo &&
-	git add foo &&
-	git commit -m " Add foo" &&
-	cd .. &&
-	echo output > .gitignore
+	test_create_repo sub &&
+	(
+		cd sub &&
+		: >bar &&
+		git add bar &&
+		git commit -m " Add bar" &&
+		: >foo &&
+		git add foo &&
+		git commit -m " Add foo"
+	) &&
+	echo output > .gitignore &&
 	git add sub .gitignore &&
 	git commit -m "Add submodule sub"
 '
 
 test_expect_success 'status clean' '
-	git status |
-	grep "nothing to commit"
+	git status >output &&
+	grep "nothing to commit" output
 '
+
 test_expect_success 'commit --dry-run -a clean' '
-	git commit --dry-run -a |
-	grep "nothing to commit"
+	test_must_fail git commit --dry-run -a >output &&
+	grep "nothing to commit" output
 '
 
-echo "changed" > sub/foo
 test_expect_success 'status with modified file in submodule' '
-	git status | grep "modified:   sub"
+	(cd sub && git reset --hard) &&
+	echo "changed" >sub/foo &&
+	git status >output &&
+	grep "modified:   sub" output
 '
+
 test_expect_success 'status with modified file in submodule (porcelain)' '
+	(cd sub && git reset --hard) &&
+	echo "changed" >sub/foo &&
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
+'
+
+test_expect_success 'status with added file in submodule' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	git status >output &&
+	grep "modified:   sub" output
+'
+
+test_expect_success 'status with added file in submodule (porcelain)' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status --porcelain >output &&
-	diff output - <<-EOF
- M sub
-EOF
+	diff output - <<-\EOF
+	 M sub
+	EOF
 '
-(cd sub && git checkout foo)
 
-echo "content" > sub/new-file
 test_expect_success 'status with untracked file in submodule' '
-	git status | grep "modified:   sub"
+	(cd sub && git reset --hard) &&
+	echo "content" >sub/new-file &&
+	git status >output &&
+	grep "modified:   sub" output
 '
+
 test_expect_success 'status with untracked file in submodule (porcelain)' '
 	git status --porcelain >output &&
-	diff output - <<-EOF
- M sub
-EOF
+	diff output - <<-\EOF
+	 M sub
+	EOF
 '
-rm sub/new-file
 
 test_expect_success 'rm submodule contents' '
 	rm -rf sub/* sub/.git
 '
+
 test_expect_success 'status clean (empty submodule dir)' '
-	git status |
-	grep "nothing to commit"
+	git status >output &&
+	grep "nothing to commit" output
 '
+
 test_expect_success 'status -a clean (empty submodule dir)' '
-	git commit --dry-run -a |
-	grep "nothing to commit"
+	test_must_fail git commit --dry-run -a >output &&
+	grep "nothing to commit" output
 '
 
 test_done


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
