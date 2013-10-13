From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] clone: local URLs are not for ssh
Date: Sun, 13 Oct 2013 22:00:12 +0200
Message-ID: <525AFBCC.4080303@web.de>
References: <201309282137.21802.tboegi@web.de> <CACsJy8B-wA=bX6+E6O6UvX2vEtOwnR1PCMZNoi-q0x_jacB89Q@mail.gmail.com> <524C6885.8020602@web.de> <CACsJy8DjPiwpMvLe2p+dGBdpU6iTg2my7tddBsQwLnHiHdG8wQ@mail.gmail.com> <20131003013127.GA7917@sigill.intra.peff.net> <52506D15.9040206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 13 22:00:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVRq4-0006Ov-Hd
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 22:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210Ab3JMUA2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Oct 2013 16:00:28 -0400
Received: from mout-xforward.web.de ([82.165.159.3]:51617 "EHLO
	mout-xforward.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab3JMUA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 16:00:27 -0400
Received: from [192.168.209.20] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MfYj1-1V6sOw1pyF-00P4RJ for <git@vger.kernel.org>;
 Sun, 13 Oct 2013 22:00:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <52506D15.9040206@web.de>
X-Provags-ID: V03:K0:wzWJSAtZ2tFAx4MfmajD1B5pocC3PyZcoP7Q5Fj5pDa7sRjrTQ/
 NdJlPZSx2u1rCSvGBUEXkTqxBo22obcZpJ9mXlMXCFud+h4Xg2ObiMloSNyk7ANJv5J46Tj
 c7CXM67lR0X/s8V5IS5qWlEbpAuVUl0OJ4ZLwnBw/fOpqtM9G2nXu8nwmIhitZ99YdFved/
 X/c8ytbIuCEpzYu/kxXqw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236079>

On 05.10.13 21:48, Torsten B=C3=B6gershausen wrote:
> On 2013-10-03 03.31, Jeff King wrote:
>>
>>   http://article.gmane.org/gmane.comp.version-control.git/235473
What do we think about extending the test a little bit:


git diff 771cf1dab9303bab3c8198b8b6 -- t5602-clone-remote-exec.sh=20

diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.s=
h
index 3f353d9..790896f 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -30,5 +30,124 @@ test_expect_success 'clone calls specified git uplo=
ad-pack with -u option' '
 	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''=
" >expected &&
 	test_cmp expected not_ssh_output
 '
+test_expect_success 'setup ssh wrapper' '
+	write_script "$TRASH_DIRECTORY/ssh-wrapper" <<-\EOF &&
+	echo >>"$TRASH_DIRECTORY/ssh-output" "ssh: $*" &&
+	# throw away all but the last argument, which should be the
+	# command
+	while test $# -gt 1; do shift; done
+	eval "$1"
+	EOF
+
+	GIT_SSH=3D"$TRASH_DIRECTORY/ssh-wrapper" &&
+	export GIT_SSH &&
+	export TRASH_DIRECTORY
+'
+
+clear_ssh () {
+	>"$TRASH_DIRECTORY/ssh-output"
+}
+
+expect_ssh () {
+	{
+		case "$1" in
+		none)
+			;;
+		*)
+			echo "ssh: $1 git-upload-pack '$2'"
+		esac
+	} >"$TRASH_DIRECTORY/ssh-expect" &&
+	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
+}
+
+test_expect_success 'create src.git' '
+	mkdir src.git &&
+	(=20
+		cd src.git &&
+		git init &&
+		>file &&
+		git add file &&
+		git commit -m "add file"
+	)
+'
+
+# git clone could fail, so break the && chain and ignore the exit code
+# clone local
+test_expect_success './foo:bar is not ssh' '
+	clear_ssh &&
+	git clone "./foo:bar" foobar
+	expect_ssh none
+'
+
+test_expect_success './[nohost:123]:src is not ssh' '
+	clear_ssh &&
+	git clone "./[nohost:123]:src" 1_2_3
+	expect_ssh none
+'
+
+test_expect_success '[nohost:234] is not ssh' '
+	clear_ssh &&
+	git clone "[nohost:234]" 2_3_4
+	expect_ssh none
+'
+
+test_expect_success ':345 is not ssh' '
+	clear_ssh &&
+	git clone ":345" 3_4_5=20
+	expect_ssh none
+'
+
+test_expect_success '456: is not ssh' '
+	clear_ssh &&
+	git clone "456:" 4_5_6=20
+	expect_ssh none
+'
+
+# clone via ssh
+# the expect_ssh checks that git clone tried to use ssh
+test_expect_success 'myhost:567 is ssh' '
+	clear_ssh &&
+	git clone myhost:567 myhost_567
+	expect_ssh myhost 567
+'
+
+test_expect_success '[myhost:678]:src is ssh' '
+	clear_ssh &&
+	git clone "[myhost:678]:src" myhost_678
+	expect_ssh myhost:678 src
+'
+
+#clone url looks like ssh, but is on disk
+test_expect_success SYMLINKS 'dir:123 on disk' '
+	clear_ssh &&
+	ln -s src.git dir:123 &&
+	git clone dir:123 dir_123 &&
+	expect_ssh none
+'
+
+test_expect_success SYMLINKS '[dir:234]:src on disk' '
+	clear_ssh &&
+	ln -s src.git [dir:234]:src &&
+	git clone [dir:234]:src dir_234_src &&
+	expect_ssh none
+'
+
+test_expect_success 'ssh://host.xz/~user/repo' '
+	clear_ssh &&
+	git clone "ssh://host.xz/~user/repo" user-repo
+	expect_ssh host.xz "~user/repo"
+'
+
+test_expect_success 'ssh://host.xz:22/~user/repo' '
+	clear_ssh &&
+	git clone "ssh://host.xz:22/~user/repo" user-repo
+	expect_ssh "-p 22 host.xz" "~user/repo"
+'
+
+test_expect_success 'ssh://[::1]:22/~user/repo' '
+	clear_ssh &&
+	git clone "ssh://[::1]:22/~user/repo" user-repo6
+	expect_ssh "-p 22 ::1" "~user/repo"
+'
=20
 test_done

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
And we need this on top of Duys patch:

diff --git a/connect.c b/connect.c
index e8473f3..09be2b3 100644
--- a/connect.c
+++ b/connect.c
@@ -611,7 +611,7 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
                end =3D host;
=20
        path =3D strchr(end, c);
-       if (path && !has_dos_drive_prefix(end)) {
+       if (path && host !=3D path && !has_dos_drive_prefix(end)) {
                if (c =3D=3D ':') {
       if (host !=3D url || path < strchrnul(host, '/')) {
                                protocol =3D PROTO_SSH;
