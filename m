From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] git submodule: add submodules with git add -f <path>
Date: Mon,  5 Jul 2010 17:33:03 +0000
Message-ID: <1278351183-18734-1-git-send-email-avarab@gmail.com>
References: <1278098521-5321-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 19:33:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVpXj-0007zn-8f
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 19:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab0GERdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jul 2010 13:33:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49523 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab0GERdN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 13:33:13 -0400
Received: by bwz1 with SMTP id 1so2871416bwz.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FG8JgUwFP7VZrkaiVMX3ftx8/sqF2EmWf0JqXPvo1ZY=;
        b=sP3uyOXSf7T7D3lNJk2lNEbse+VpwVe0fN50eRjh2pWhLqxqUAbHf1IHlQmmdalsP+
         L4jN7zjCXV0EGphAuNnl2vd1kv6kVzrRCDOwCsXCAv7OcKA8VC4MPs3Lbkw4TuZ0uiby
         ZBqBIS7ym64VnkLImT5GL4+Ae+QSwg7FFInJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=i1DpvDExFC/9dXRXOBoXCHYoNPYD6gmuqG/fqsEv2rpYbci/EiSC1+N5OsviwIrRxD
         8M384sDXV4pHnD6Yj2X3nZMiiJItHFCX7UFLHgbuKjtSvqTb5mtwt7Jeq40MKk54m55Y
         c0DC/uZm6EbmUW+MtQOuEPQZ+nRnYe3VLOgHs=
Received: by 10.204.84.99 with SMTP id i35mr2637299bkl.165.1278351191258;
        Mon, 05 Jul 2010 10:33:11 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id bq20sm17995105bkb.16.2010.07.05.10.33.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 05 Jul 2010 10:33:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc1.192.g262ff.dirty
In-Reply-To: <1278098521-5321-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150279>

Change `git submodule add' to add the new submodule <path> with `git
add --force'.

I keep my /etc in .git with a .gitignore that contains just
"*". I.e. `git status' will ignore everything that isn't in the tree
already. When I do:

    git submodule add <url> hlagh

git-submodule will get as far as checking out the remote repository
into hlagh, but it'll die right afterwards when it fails to add the
new path:

    The following paths are ignored by one of your .gitignore files:
    hlagh
    Use -f if you really want to add them.
    fatal: no files added
    Failed to add submodule 'hlagh'

Currently there's no way to add a submodule in this situation other
than to remove the ignored path from the .gitignore while I'm at it.

That's silly, when you run `git submodule add' you're explicitly
saying that you want to add something *new* to the repository. Instead
it should just add the path with `git add --force'.

Initially I implemented this by adding new -f and --force options to
`git submodule add'. But if the --force option isn't supplied it'll
get as far as cloning `hlagh', but won't add it.

So the first thing the user has to do is to remove `hlagh' and then
try again with the --force option.

That sucks, it should just add the path to begin with. I can't think
of any usecase where you've gone through the trouble of typing out
`git submodule add ..', but wish to be overriden by a `gitignore'. The
submodule semantics should be more like `git init', not `git add'.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Resubmitting this as a non-RFC. I think it's sane and ready for
inclusion.

 Documentation/git-submodule.txt |    4 ++++
 git-submodule.sh                |    4 ++--
 t/t7400-submodule-basic.sh      |   24 +++++++++++++++++++++++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
index cdabfd2..76a832a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -95,6 +95,10 @@ is the superproject and submodule repositories will =
be kept
 together in the same relative location, and only the
 superproject's URL needs to be provided: git-submodule will correctly
 locate the submodule using the relative URL in .gitmodules.
++
+The submodule will be added with "git add --force <path>". I.e. git
+doesn't care if the new path is in a `gitignore`. Your invocation of
+"git submodule add" is considered enough to override it.
=20
 status::
 	Show the status of the submodules. This will print the SHA-1 of the
diff --git a/git-submodule.sh b/git-submodule.sh
index d9950c2..ad2417d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -234,12 +234,12 @@ cmd_add()
 		) || die "Unable to checkout submodule '$path'"
 	fi
=20
-	git add "$path" ||
+	git add --force "$path" ||
 	die "Failed to add submodule '$path'"
=20
 	git config -f .gitmodules submodule."$path".path "$path" &&
 	git config -f .gitmodules submodule."$path".url "$repo" &&
-	git add .gitmodules ||
+	git add --force .gitmodules ||
 	die "Failed to register submodule '$path'"
 }
=20
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 97ff074..d9f2785 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -42,7 +42,8 @@ test_expect_success 'setup - hide init subdirectory' =
'
 '
=20
 test_expect_success 'setup - repository to add submodules to' '
-	git init addtest
+	git init addtest &&
+	git init addtest-ignore
 '
=20
 # The 'submodule add' tests need some repository to add as a submodule=
=2E
@@ -85,6 +86,27 @@ test_expect_success 'submodule add' '
 	test_cmp empty untracked
 '
=20
+test_expect_success 'submodule add to .gitignored path' '
+	echo "refs/heads/master" >expect &&
+	>empty &&
+
+	(
+		cd addtest-ignore &&
+		# Does not use test_commit due to the ignore
+		echo "*" > .gitignore &&
+		git add --force .gitignore &&
+		git commit -m"Ignore everything" &&
+		git submodule add "$submodurl" submod &&
+		git submodule init
+	) &&
+
+	rm -f heads head untracked &&
+	inspect addtest/submod ../.. &&
+	test_cmp expect heads &&
+	test_cmp expect head &&
+	test_cmp empty untracked
+'
+
 test_expect_success 'submodule add --branch' '
 	echo "refs/heads/initial" >expect-head &&
 	cat <<-\EOF >expect-heads &&
--=20
1.7.2.rc1.192.g262ff.dirty
