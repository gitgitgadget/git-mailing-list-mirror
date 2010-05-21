From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] git-submodule foreach: Add $toplevel variable
Date: Fri, 21 May 2010 16:10:10 +0000
Message-ID: <1274458210-4685-1-git-send-email-avarab@gmail.com>
References: <1273965617-26731-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 18:10:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFUnv-00006U-5U
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 18:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934007Ab0EUQKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 12:10:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34519 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933985Ab0EUQKV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 12:10:21 -0400
Received: by fxm5 with SMTP id 5so1003466fxm.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=743RK1bhZjD967e2I6CtYJvRrU3PMIVegbAJnlXlsNM=;
        b=gC1B8P/XUWJnqBc08Md1fs+L8sGMXx9/yCY7AkST2CZc8xL48lYizpimh5YCuCbp1Q
         eMbu+WJ5cwDd7phtMyOikGKxytMQ2oGBUFCIBGdmHONoU6p0yAdp05DN9Kt3bLsGpLMa
         P1iCDDuYa2zOxFLxtKb3d9NpY7PT5eDyUVf2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QGmixsVFVFkGYNd7IBtQrQqDDPK3sJzPy06W9pWABvn8NRasNW1eUv0+TGkeAIz3dS
         DZ/DyWiQRAS0Ox+KOgfQb9gNzy5T4asIAcPAnIxxOhJos8UXK72GfaLkeXOpHJAyGF8n
         0voA+vYUDieBl6GQPBjWfDf6KciMPfW9HEEcA=
Received: by 10.223.161.211 with SMTP id s19mr1636741fax.47.1274458219134;
        Fri, 21 May 2010 09:10:19 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id g10sm5150597fai.12.2010.05.21.09.10.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 09:10:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.98.g4a5f
In-Reply-To: <1273965617-26731-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147477>

Add a $toplevel variable accessible to `git submodule foreach`, it
contains the absolute path of the top level directory (where
=2Egitmodules is).

This makes it possible to e.g. read data in .gitmodules from within
foreach commands. I'm using this to configure the branch names I want
to track for each submodule:

    git submodule foreach 'git checkout $(git config --file $toplevel/.=
gitmodules submodule.$name.branch) && git pull'

=46or a little history: This patch is borne out of my continuing fight
of trying to have Git track the branches of submodules, not just their
commits.

Obviously that's not how they work (they only track commits), but I'm
just interested in being able to do:

    git submodule foreach 'git pull'

Of course that won't work because the submodule is in a disconnected
head, so I first have to connect it, but connect it *to what*.

=46or a while I was happy with this because as fate had it, it just so
happened to do what I meant:

    git submodule foreach 'git checkout $(git describe --all --always) =
&& git pull'

But then that broke down, if there's a tag and a branch the tag will
win out, and I can't git pull a branch:

    $ git branch -a
    * master
      remotes/origin/HEAD -> origin/master
      remotes/origin/master
    $ git tag -l
    release-0.0.6
    $ git describe --always --all
    release-0.0.6

So I figured that I might as well start tracking the branches I want
in .gitmodules itself:

    [submodule "yaml-mode"]
        path =3D yaml-mode
        url =3D git://github.com/yoshiki/yaml-mode.git
        branch =3D master

So now I can just do (as stated above):

    git submodule foreach 'git checkout $(git config --file $toplevel/.=
gitmodules submodule.$name.branch) && git pull'

Maybe there's a less painful way to do *that* (I'd love to hear about
it). But regardless of that I think it's a good idea to be able to
know what the top-level is from git submodule foreach.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Submitting as a non-RFC as nobody has commented on the RFC for a
week. It works for me.

 Documentation/git-submodule.txt |    6 ++++--
 git-submodule.sh                |    2 ++
 t/t7407-submodule-foreach.sh    |   10 +++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
index 2502531..cdabfd2 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -145,10 +145,12 @@ summary::
=20
 foreach::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $name, $path and $sha1:
+	The command has access to the variables $name, $path, $sha1 and
+	$toplevel:
 	$name is the name of the relevant submodule section in .gitmodules,
 	$path is the name of the submodule directory relative to the
-	superproject, and $sha1 is the commit as recorded in the superproject=
=2E
+	superproject, $sha1 is the commit as recorded in the superproject,
+	and $toplevel is the absolute path to the top-level of the superproje=
ct.
 	Any submodules defined in the superproject but not checked out are
 	ignored by this command. Unless given --quiet, foreach prints the nam=
e
 	of each submodule before evaluating the command.
diff --git a/git-submodule.sh b/git-submodule.sh
index 8175cb2..8c562a7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -271,6 +271,8 @@ cmd_foreach()
 		shift
 	done
=20
+	toplevel=3D$(pwd)
+
 	module_list |
 	while read mode sha1 stage path
 	do
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.s=
h
index 2a52775..db9365b 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -59,11 +59,13 @@ test_expect_success 'setup a submodule tree' '
 sub1sha1=3D$(cd super/sub1 && git rev-parse HEAD)
 sub3sha1=3D$(cd super/sub3 && git rev-parse HEAD)
=20
+pwd=3D$(pwd)
+
 cat > expect <<EOF
 Entering 'sub1'
-foo1-sub1-$sub1sha1
+$pwd/clone-foo1-sub1-$sub1sha1
 Entering 'sub3'
-foo3-sub3-$sub3sha1
+$pwd/clone-foo3-sub3-$sub3sha1
 EOF
=20
 test_expect_success 'test basic "submodule foreach" usage' '
@@ -71,7 +73,9 @@ test_expect_success 'test basic "submodule foreach" u=
sage' '
 	(
 		cd clone &&
 		git submodule update --init -- sub1 sub3 &&
-		git submodule foreach "echo \$name-\$path-\$sha1" > ../actual
+		git submodule foreach "echo \$toplevel-\$name-\$path-\$sha1" > ../ac=
tual &&
+		git config foo.bar zar &&
+		git submodule foreach "git config --file \"\$toplevel/.git/config\" =
foo.bar"
 	) &&
 	test_cmp expect actual
 '
--=20
1.7.1.98.g4a5f
