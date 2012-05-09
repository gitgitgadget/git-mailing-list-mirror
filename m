From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [RFC PATCH 09/19] completion: platform-specific helper function to
	get physical path
Date: Wed,  9 May 2012 02:44:40 +0200
Message-ID: <1336524290-30023-10-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:46:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv37-00056b-Ew
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276Ab2EIAqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:46:34 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:57667 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701Ab2EIAqd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:46:33 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MNzUl-1SUMpM3CSx-007b43; Wed, 09 May 2012 02:46:28 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:hP7JihWex8a1Mlva6obgTPjzgSCgrGgPpv7BvzwPFv1
 vJPko0yXN3GiA37//cNPall3ccLZwJMNl5PEof7ophMks2lj2d
 H0iFOGmcN85nQawoPK7Ax2dopszkMroelaGCNKGgCRIcT7yRXG
 sUYraTst3/8kT64ELiN98sGbNZ7v7bKadm+Adq75Rvw9HAdkl8
 uMAbD3pc0rtN3ReBTdw5WeR0qZatpmpW18qzZMpUZQlgYkvY0O
 u8g6HTZKV5N3qooYVe0kXVWnBBzGKOmUftq8L4CS/ooLbflmTq
 cRoI4T24S6VatPa3wUrKdTW4QD0V/ikPg+Vt/zJBC2Q60tt+DP
 Tn0zDXnuqwV9ZFldqM0WME4SWR6pVdoNPEmdOQeYjL3b+W2o3w
 Re5jvb80qMDTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197439>

Two upcoming optimizations will replace invocations of git commands in
command substitutions with bash builtins examining the path of the
current working directory.  Since git works with physical paths, we
can't use logical path provided in $PWD, but have to resort to the
'$(pwd -P)' command substitution to get the physical path of the
current directory.

However, on platforms not supporting symbolic links, such as MinGW,
the path in $PWD is bound to be the physical path.  So on those
platforms we could avoid the command substitution and use $PWD
directly.  Great for MinGW, because the overhead of forking a subshell
is relatively large there.

So add a platform-specific helper function to get the physical path of
the current directory: on MinGW it's defined such that it gets the
physical path from $PWD, while on other platforms from '$(pwd -P)'.
The path is stored in a variable whose name is passed as argument, so
no command substitution is needed when invoking this function.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

I'm not sure how to check for MinGW; I just looked through the output f=
rom
'set', and saw OSTYPE=3Dmsys there.

 contrib/completion/git-completion.bash | 14 ++++++++++++++
 t/t9903-bash-prompt.sh                 | 21 +++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 5c8d4aea..bd7d39e3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -70,6 +70,20 @@ case "$COMP_WORDBREAKS" in
 *)   COMP_WORDBREAKS=3D"$COMP_WORDBREAKS:"
 esac
=20
+# __git_pwd_p() stores the physical path of the current working direct=
ory
+# in the variable whose name is given as argument
+if [ ${OSTYPE-} =3D "msys" ]; then
+__git_pwd_p ()
+{
+	eval $1=3D"$PWD"
+}
+else
+__git_pwd_p ()
+{
+	eval $1=3D\"$(pwd -P)\"
+}
+fi
+
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # Prints the path to the .git directory, and stores it in $__git_dir a=
s well.
 __gitdir ()
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 496e04ad..3d722b25 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -32,6 +32,27 @@ test_expect_success 'setup for prompt tests' '
 	git checkout master
 '
=20
+test_expect_success 'getting pwd -P' '
+	echo "$TRASH_DIRECTORY" > expected &&
+	(
+		__git_pwd_p p &&
+		echo "$p" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success SYMLINKS 'getting pwd -P - avoids symlinks' '
+	echo "$TRASH_DIRECTORY/otherrepo" > expected &&
+	ln -s otherrepo link &&
+	test_when_finished "rm -f link" &&
+	(
+		cd link &&
+		__git_pwd_p p &&
+		echo "$p" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success 'gitdir - from command line (through $__git_dir)' =
'
 	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
 	(
--=20
1.7.10.1.541.gb1be298
