From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] t7400: clarify 'submodule add' tests
Date: Sat, 10 Apr 2010 00:39:04 -0500
Message-ID: <20100410053904.GB17649@progeny.tock>
References: <20100410053729.GA17595@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 07:38:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0TP0-0003Gn-5k
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 07:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027Ab0DJFih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 01:38:37 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:34790 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab0DJFig (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 01:38:36 -0400
Received: by yxe1 with SMTP id 1so1695998yxe.33
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 22:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xqGDLXc8tLZjPbCLpk+shEodvN4QdDuthx+eqElfm3w=;
        b=PYEp9vFSNrRCHwKMqr8vhLmSPZbtjteISx/bwg4VQITrNwdVl2/hNGDjTx0/+lU+vW
         3VY4HRDbU6W72BTUaPFb7bZ/6fMjk/cmNAsYPLlF85svqn0UGpPICXtWFf1N9A4K4Gb/
         IHJghh7krKYn4Uvzdr4eF+YPysuG03jOxTeyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=auryo3VUIXr8qQ8AvWrE8hc1t+o3t+i4FY2CMKie7hIhDi3A/GSrP3pxCfOvCq3Yat
         22Lnp3lmZnrbJWRLfa45w9TG3k1Nfm+8LPvxb75C4e9zIn7gYFQXqQsOnD3MSf6rdhms
         aPlMcXl8QdBcL1og/YoE60sL6udM/fQI5JCTc=
Received: by 10.101.173.7 with SMTP id a7mr1795557anp.90.1270877915627;
        Fri, 09 Apr 2010 22:38:35 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1497727iwn.10.2010.04.09.22.38.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 22:38:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100410053729.GA17595@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144510>

A new reader may not realize what properties the $submodurl
repository needs to have.

One of the tests is checking that =E2=80=98submodule add -b foo=E2=80=99=
 creates
a =E2=80=98foo=E2=80=99 branch.  Put this test in context by checking t=
hat
without -b, no =E2=80=98foo=E2=80=99 branch is created.

While at it, make sure each added submodule is a reasonable
repository, with clean index, no stray files, and so on.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7400-submodule-basic.sh |  103 ++++++++++++++++++++++++++++++++++++=
+------
 1 files changed, 88 insertions(+), 15 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 1f468e5..dbc8338 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -49,63 +49,136 @@ test_expect_success 'setup - add an example entry =
to .gitmodules' '
 	git config submodule.example.url git://example.com/init.git
 '
=20
-test_expect_success 'Prepare submodule add testing' '
-	submodurl=3D$(pwd)
+test_expect_success 'setup - repository to add submodules to' '
+	git init addtest
+'
+
+# The 'submodule add' tests need some repository to add as a submodule=
=2E
+# The trash directory is a good one as any.
+submodurl=3D$TRASH_DIRECTORY
+
+listbranches() {
+	git for-each-ref --format=3D'%(refname)' 'refs/heads/*'
+}
+
+inspect() {
+	dir=3D$1 &&
+	dotdot=3D"${2:-..}" &&
+
 	(
-		mkdir addtest &&
-		cd addtest &&
-		git init
+		cd "$dir" &&
+		listbranches >"$dotdot/heads" &&
+		{ git symbolic-ref HEAD || :; } >"$dotdot/head" &&
+		git update-index --refresh &&
+		git diff-files --exit-code &&
+		git clean -n -d -x >"$dotdot/untracked"
 	)
-'
+}
=20
+rm -f heads head untracked
 test_expect_success 'submodule add' '
+	echo "refs/heads/master" >expect &&
+	>empty &&
+
 	(
 		cd addtest &&
 		git submodule add "$submodurl" submod &&
 		git submodule init
-	)
+	) &&
+
+	inspect addtest/submod ../.. &&
+	test_cmp expect heads &&
+	test_cmp expect head &&
+	test_cmp empty untracked
 '
=20
+rm -f heads head untracked
 test_expect_success 'submodule add --branch' '
+	echo "refs/heads/initial" >expect-head &&
+	cat <<-\EOF >expect-heads &&
+	refs/heads/initial
+	refs/heads/master
+	EOF
+	>empty &&
+
 	(
 		cd addtest &&
 		git submodule add -b initial "$submodurl" submod-branch &&
-		git submodule init &&
-		cd submod-branch &&
-		git branch | grep initial
-	)
+		git submodule init
+	) &&
+
+	inspect addtest/submod-branch ../.. &&
+	test_cmp expect-heads heads &&
+	test_cmp expect-head head &&
+	test_cmp empty untracked
 '
=20
+rm -f heads head untracked
 test_expect_success 'submodule add with ./ in path' '
+	echo "refs/heads/master" >expect &&
+	>empty &&
+
 	(
 		cd addtest &&
 		git submodule add "$submodurl" ././dotsubmod/./frotz/./ &&
 		git submodule init
-	)
+	) &&
+
+	inspect addtest/dotsubmod/frotz ../../.. &&
+	test_cmp expect heads &&
+	test_cmp expect head &&
+	test_cmp empty untracked
 '
=20
+rm -f heads head untracked
 test_expect_success 'submodule add with // in path' '
+	echo "refs/heads/master" >expect &&
+	>empty &&
+
 	(
 		cd addtest &&
 		git submodule add "$submodurl" slashslashsubmod///frotz// &&
 		git submodule init
-	)
+	) &&
+
+	inspect addtest/slashslashsubmod/frotz ../../.. &&
+	test_cmp expect heads &&
+	test_cmp expect head &&
+	test_cmp empty untracked
 '
=20
+rm -f heads head untracked
 test_expect_success 'submodule add with /.. in path' '
+	echo "refs/heads/master" >expect &&
+	>empty &&
+
 	(
 		cd addtest &&
 		git submodule add "$submodurl" dotdotsubmod/../realsubmod/frotz/.. &=
&
 		git submodule init
-	)
+	) &&
+
+	inspect addtest/realsubmod ../.. &&
+	test_cmp expect heads &&
+	test_cmp expect head &&
+	test_cmp empty untracked
 '
=20
+rm -f heads head untracked
 test_expect_success 'submodule add with ./, /.. and // in path' '
+	echo "refs/heads/master" >expect &&
+	>empty &&
+
 	(
 		cd addtest &&
 		git submodule add "$submodurl" dot/dotslashsubmod/./../..////realsub=
mod2/a/b/c/d/../../../../frotz//.. &&
 		git submodule init
-	)
+	) &&
+
+	inspect addtest/realsubmod2 ../.. &&
+	test_cmp expect heads &&
+	test_cmp expect head &&
+	test_cmp empty untracked
 '
=20
 test_expect_success 'status should fail for unmapped paths' '
--=20
1.7.0.4
