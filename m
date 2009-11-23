From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] unset GREP_OPTIONS in test-lib.sh
Date: Tue, 24 Nov 2009 00:18:51 +0100
Message-ID: <4B0B185B.4090305@lsrfire.ath.cx>
References: <1258560919-28054-1-git-send-email-bert.wesarg@googlemail.com> <7v1vjvebem.fsf@alter.siamese.dyndns.org> <4B095F91.8030305@lsrfire.ath.cx> <20091123112221.GA7175@sajinet.com.pe> <7vtywlyu43.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 00:19:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCiBT-0001l4-9L
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 00:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786AbZKWXSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 18:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756199AbZKWXSu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 18:18:50 -0500
Received: from india601.server4you.de ([85.25.151.105]:34504 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755883AbZKWXSu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 18:18:50 -0500
Received: from [10.0.1.101] (p57B7BDDD.dip.t-dialin.net [87.183.189.221])
	by india601.server4you.de (Postfix) with ESMTPSA id 55A352F8051;
	Tue, 24 Nov 2009 00:18:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vtywlyu43.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133541>

Junio C Hamano schrieb:
> Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe> writes:
>=20
>> why not better to apply the proposed patch from Junio in :
>>
>>   http://article.gmane.org/gmane.comp.version-control.git/127980/
>>
>> it would IMHO correct all reported issues and serve as well as a cat=
ch
>> all from other tools that could be introduced in the future and that
>> will be similarly affected by this misfeature.
>=20
> I think Ren=C3=A9's patch is more sensible than $gmane/127980 because=
 we have
> no business mucking with these environment variables when we are runn=
ing
> things other than external grep.  You could be using system's "grep" =
in
> your pre-commit hook to find some stuff, and your hook either may rel=
y
> on your having a particular set of GREP_OPTIONS in your environment, =
or
> may be designed to work well with GREP_OPTIONS.

Yes, but what about git commands that are implemented as shell scripts
and use grep?  Something like the following patch?

We'd need to run this from time to time to make sure no new grep calls
creep in:

   git grep -L "unset GREP_OPTIONS" -- $(git grep -l "grep" git-*.sh)

-- 8< --
Unset GREP_OPTIONS at the top of git commands that are implemented as
shell scripts and call grep, in order to avoid side effects caused by
unexpected default options of users.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 git-am.sh                  |    3 +++
 git-bisect.sh              |    3 +++
 git-filter-branch.sh       |    3 +++
 git-instaweb.sh            |    3 +++
 git-notes.sh               |    3 +++
 git-rebase--interactive.sh |    3 +++
 git-rebase.sh              |    3 +++
 git-submodule.sh           |    3 +++
 8 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 151512a..1390eec 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -38,6 +38,9 @@ set_reflog_action am
 require_work_tree
 cd_to_toplevel
=20
+# Make sure we're in full control when calling grep in this script.
+unset GREP_OPTIONS
+
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
=20
diff --git a/git-bisect.sh b/git-bisect.sh
index a5ea843..fcf500f 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -30,6 +30,9 @@ OPTIONS_SPEC=3D
 . git-sh-setup
 require_work_tree
=20
+# Make sure we're in full control when calling grep in this script.
+unset GREP_OPTIONS
+
 _x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
=20
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 6b8b6a4..d3a8b3e 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -107,6 +107,9 @@ USAGE=3D"[--env-filter <command>] [--tree-filter <c=
ommand>]
 OPTIONS_SPEC=3D
 . git-sh-setup
=20
+# Make sure we're in full control when calling grep in this script.
+unset GREP_OPTIONS
+
 if [ "$(is_bare_repository)" =3D false ]; then
 	git diff-files --ignore-submodules --quiet &&
 	git diff-index --cached --quiet HEAD -- ||
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 622a5f0..86916e1 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -21,6 +21,9 @@ restart        restart the web server
=20
 . git-sh-setup
=20
+# Make sure we're in full control when calling grep in this script.
+unset GREP_OPTIONS
+
 fqgitdir=3D"$GIT_DIR"
 local=3D"$(git config --bool --get instaweb.local)"
 httpd=3D"$(git config --get instaweb.httpd)"
diff --git a/git-notes.sh b/git-notes.sh
index e642e47..e5f0edf 100755
--- a/git-notes.sh
+++ b/git-notes.sh
@@ -3,6 +3,9 @@
 USAGE=3D"(edit [-F <file> | -m <msg>] | show) [commit]"
 . git-sh-setup
=20
+# Make sure we're in full control when calling grep in this script.
+unset GREP_OPTIONS
+
 test -z "$1" && usage
 ACTION=3D"$1"; shift
=20
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 27daaa9..d0bb8a3 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -33,6 +33,9 @@ root               rebase all reachable commmits up t=
o the root(s)
 . git-sh-setup
 require_work_tree
=20
+# Make sure we're in full control when calling grep in this script.
+unset GREP_OPTIONS
+
 DOTEST=3D"$GIT_DIR/rebase-merge"
 TODO=3D"$DOTEST"/git-rebase-todo
 DONE=3D"$DOTEST"/done
diff --git a/git-rebase.sh b/git-rebase.sh
index 6830e16..18c680b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -34,6 +34,9 @@ set_reflog_action rebase
 require_work_tree
 cd_to_toplevel
=20
+# Make sure we're in full control when calling grep in this script.
+unset GREP_OPTIONS
+
 OK_TO_SKIP_PRE_REBASE=3D
 RESOLVEMSG=3D"
 When you have resolved this problem run \"git rebase --continue\".
diff --git a/git-submodule.sh b/git-submodule.sh
index 850d423..e557aca 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -17,6 +17,9 @@ OPTIONS_SPEC=3D
 . git-parse-remote
 require_work_tree
=20
+# Make sure we're in full control when calling grep in this script.
+unset GREP_OPTIONS
+
 command=3D
 branch=3D
 reference=3D
--=20
1.6.5
