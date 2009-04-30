From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 1/2] Add 'git subtree' command for tracking history of 
	subtrees separately.
Date: Wed, 29 Apr 2009 22:27:44 -0400
Message-ID: <32541b130904291927m33908bacg2dbafcf64877b88f@mail.gmail.com>
References: <1240784983-1477-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 04:28:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzM0R-0007Ry-Ll
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 04:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbZD3C1r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 22:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbZD3C1q
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 22:27:46 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:45105 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbZD3C1p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 22:27:45 -0400
Received: by yx-out-2324.google.com with SMTP id 3so914060yxj.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 19:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=W3+8cV0N5Vx6d18lz34NseNk+esNqZeq4kC1Oe3KBNw=;
        b=Jle51Maq8dgyqEY5wIU4HMoIpt0zOPxzAiEEo37+Pwfgmx2LfOCh9D1Kur+sJAqewM
         NMyZvpVtDc4mhtccs1a0Fva5zdspqtDG19W2rER/NjTEH0ej8SUAWG9B13udZ1niO07Z
         SkvMtmrR4sbyUlD9yHgtStMIYuTTZjYkMDTO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=hgvCM3POZFnJqbzd5ZNpwQUZrBLekjN+iFarZXz4frUutqNXmwj0BZOImowCkDB+IV
         /1yfjtzTQSdP5xaivBQe1WwWDebLFYHZoN79BZ6cEUEYUJMAnC8e4dkFKzIDx0UqO6R8
         Ga32l34Y7HuDAWduAXJ6FmgUqhElZ3MJ5Ohkk=
Received: by 10.150.190.18 with SMTP id n18mr2599461ybf.110.1241058464093; 
	Wed, 29 Apr 2009 19:27:44 -0700 (PDT)
In-Reply-To: <1240784983-1477-1-git-send-email-apenwarr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117985>

Many projects are made of a combination of several subprojects/librarie=
s and
some application-specific code. =A0In some cases, particularly when the
subprojects are all maintained independently, 'git submodule' is the be=
st
way to deal with this situation. =A0But if you frequently change the
subprojects as part of developing your application, use multiple branch=
es,
and sometimes want to push your subproject changes upstream, the overhe=
ad of
manually managing submodules can be excessive.

'git subtree' provides an alternative mechanism, based around the
'git merge -s subtree' merge strategy. =A0Instead of tracking a submodu=
le
separately, you merge its history into your main project, and occasiona=
lly
extract a new "virtual history" from your mainline that can be easily m=
erged
back into the upstream project. =A0The virtual history can be increment=
ally
expanded as you make more changes to the superproject.

You would normally then merge the virtual history back into your mainli=
ne
(the --rejoin option). This results in extra commits in your applicatio=
n
that appear to change the same files, but these extra commits will tend=
 to
be ignored by git's merge simplification algorithm anyway.

=46or example, gitweb (commit 1130ef3) was merged into git as of commit
0a8f4f0, after which it was no longer maintained separately. =A0But ima=
gine it
had been maintained separately, and we wanted to extract git's changes =
to
gitweb since that time, to share with the upstream. =A0You could do thi=
s:

git subtree split --prefix=3Dgitweb --annotate=3D'(split) ' \
=A0 =A0 =A0 =A00a8f4f0^.. --onto=3D1130ef3 --rejoin

If gitweb had originally been merged using 'git subtree add' (or a prev=
ious
split had been done with --rejoin specified), then you could incrementa=
lly
produce the list of new changes without needing to remember any commit =
ids:

git subtree split --prefix=3Dgitweb --annotate=3D'(split) ' --rejoin
---

Resending just in case it got lost.

Don't suppose anyone has any comments on this?  It's just a first
draft, so please let loose.  I'm in desperate need of *some* kind of
solution like this, however.

- Avery


=A0Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
=A0command-list.txt | =A0 =A01 +
=A0git-subtree.sh =A0 | =A0435 ++++++++++++++++++++++++++++++++++++++++=
++++++++++++++
=A03 files changed, 437 insertions(+), 0 deletions(-)
=A0create mode 100755 git-subtree.sh

diff --git a/Makefile b/Makefile
index 5c8e83a..f14e11c 100644
--- a/Makefile
+++ b/Makefile
@@ -305,6 +305,7 @@ SCRIPT_SH +=3D git-request-pull.sh
=A0SCRIPT_SH +=3D git-sh-setup.sh
=A0SCRIPT_SH +=3D git-stash.sh
=A0SCRIPT_SH +=3D git-submodule.sh
+SCRIPT_SH +=3D git-subtree.sh
=A0SCRIPT_SH +=3D git-web--browse.sh

=A0SCRIPT_PERL +=3D git-add--interactive.perl
diff --git a/command-list.txt b/command-list.txt
index fb03a2e..9be4774 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -113,6 +113,7 @@ git-stash =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 mainporcelain
=A0git-status =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
mainporcelain common
=A0git-stripspace =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pu=
rehelpers
=A0git-submodule =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ma=
inporcelain
+git-subtree =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ma=
inporcelain
=A0git-svn =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 foreignscminterface
=A0git-symbolic-ref =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0plum=
bingmanipulators
=A0git-tag =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 mainporcelain common
diff --git a/git-subtree.sh b/git-subtree.sh
new file mode 100755
index 0000000..39c377c
--- /dev/null
+++ b/git-subtree.sh
@@ -0,0 +1,435 @@
+#!/bin/bash
+#
+# git-subtree.sh: split/join git repositories in subdirectories of thi=
s one
+#
+# Copyright (C) 2009 Avery Pennarun <apenwarr@gmail.com>
+#
+if [ $# -eq 0 ]; then
+ =A0 =A0set -- -h
+fi
+OPTS_SPEC=3D"\
+git subtree add --prefix=3D<prefix> <commit>
+git subtree split [options...] --prefix=3D<prefix> <commit...>
+git subtree merge --prefix=3D<prefix> <commit>
+git subtree pull =A0--prefix=3D<prefix> <repository> <refspec...>
+--
+h,help =A0 =A0 =A0 =A0show the help
+q =A0 =A0 =A0 =A0 =A0 =A0 quiet
+d =A0 =A0 =A0 =A0 =A0 =A0 show debug messages
+prefix=3D =A0 =A0 =A0 the name of the subdir to split out
+ options for 'split'
+annotate=3D =A0 =A0 add a prefix to commit message of new commits
+onto=3D =A0 =A0 =A0 =A0 try connecting new tree to an existing one
+rejoin =A0 =A0 =A0 =A0merge the new branch back into HEAD
+ignore-joins =A0ignore prior --rejoin commits
+"
+eval $(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo ex=
it $?)
+. git-sh-setup
+require_work_tree
+
+quiet=3D
+debug=3D
+command=3D
+onto=3D
+rejoin=3D
+ignore_joins=3D
+annotate=3D
+
+debug()
+{
+ =A0 =A0 =A0 if [ -n "$debug" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "$@" >&2
+ =A0 =A0 =A0 fi
+}
+
+say()
+{
+ =A0 =A0 =A0 if [ -z "$quiet" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "$@" >&2
+ =A0 =A0 =A0 fi
+}
+
+assert()
+{
+ =A0 =A0 =A0 if "$@"; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 :
+ =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "assertion failed: " "$@"
+ =A0 =A0 =A0 fi
+}
+
+
+#echo "Options: $*"
+
+while [ $# -gt 0 ]; do
+ =A0 =A0 =A0 opt=3D"$1"
+ =A0 =A0 =A0 shift
+ =A0 =A0 =A0 case "$opt" in
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 -q) quiet=3D1 ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 -d) debug=3D1 ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 --annotate) annotate=3D"$1"; shift ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 --no-annotate) annotate=3D ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 --prefix) prefix=3D"$1"; shift ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 --no-prefix) prefix=3D ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 --onto) onto=3D"$1"; shift ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 --no-onto) onto=3D ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 --rejoin) rejoin=3D1 ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 --no-rejoin) rejoin=3D ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 --ignore-joins) ignore_joins=3D1 ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 --no-ignore-joins) ignore_joins=3D ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 --) break ;;
+ =A0 =A0 =A0 esac
+done
+
+command=3D"$1"
+shift
+case "$command" in
+ =A0 =A0 =A0 add|merge|pull) default=3D ;;
+ =A0 =A0 =A0 split) default=3D"--default HEAD" ;;
+ =A0 =A0 =A0 *) die "Unknown command '$command'" ;;
+esac
+
+if [ -z "$prefix" ]; then
+ =A0 =A0 =A0 die "You must provide the --prefix option."
+fi
+dir=3D"$prefix"
+
+if [ "$command" !=3D "pull" ]; then
+ =A0 =A0 =A0 revs=3D$(git rev-parse $default --revs-only "$@") || exit=
 $?
+ =A0 =A0 =A0 dirs=3D"$(git rev-parse --no-revs --no-flags "$@")" || ex=
it $?
+ =A0 =A0 =A0 if [ -n "$dirs" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "Error: Use --prefix instead of bare =
filenames."
+ =A0 =A0 =A0 fi
+fi
+
+debug "command: {$command}"
+debug "quiet: {$quiet}"
+debug "revs: {$revs}"
+debug "dir: {$dir}"
+debug "opts: {$*}"
+debug
+
+cache_setup()
+{
+ =A0 =A0 =A0 cachedir=3D"$GIT_DIR/subtree-cache/$$"
+ =A0 =A0 =A0 rm -rf "$cachedir" || die "Can't delete old cachedir: $ca=
chedir"
+ =A0 =A0 =A0 mkdir -p "$cachedir" || die "Can't create new cachedir: $=
cachedir"
+ =A0 =A0 =A0 debug "Using cachedir: $cachedir" >&2
+}
+
+cache_get()
+{
+ =A0 =A0 =A0 for oldrev in $*; do
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ -r "$cachedir/$oldrev" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read newrev <"$cachedir/$=
oldrev"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo $newrev
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
+ =A0 =A0 =A0 done
+}
+
+cache_set()
+{
+ =A0 =A0 =A0 oldrev=3D"$1"
+ =A0 =A0 =A0 newrev=3D"$2"
+ =A0 =A0 =A0 if [ "$oldrev" !=3D "latest_old" \
+ =A0 =A0 =A0 =A0 =A0 =A0-a "$oldrev" !=3D "latest_new" \
+ =A0 =A0 =A0 =A0 =A0 =A0-a -e "$cachedir/$oldrev" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "cache for $oldrev already exists!"
+ =A0 =A0 =A0 fi
+ =A0 =A0 =A0 echo "$newrev" >"$cachedir/$oldrev"
+}
+
+# if a commit doesn't have a parent, this might not work. =A0But we on=
ly want
+# to remove the parent from the rev-list, and since it doesn't exist, =
it won't
+# be there anyway, so do nothing in that case.
+try_remove_previous()
+{
+ =A0 =A0 =A0 if git rev-parse "$1^" >/dev/null 2>&1; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "^$1^"
+ =A0 =A0 =A0 fi
+}
+
+find_existing_splits()
+{
+ =A0 =A0 =A0 debug "Looking for prior splits..."
+ =A0 =A0 =A0 dir=3D"$1"
+ =A0 =A0 =A0 revs=3D"$2"
+ =A0 =A0 =A0 git log --grep=3D"^git-subtree-dir: $dir\$" \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 --pretty=3Dformat:'%s%n%n%b%nEND' $revs |
+ =A0 =A0 =A0 while read a b junk; do
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 case "$a" in
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git-subtree-mainline:) ma=
in=3D"$b" ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git-subtree-split:) sub=3D=
"$b" ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ -n "=
$main" -a -n "$sub" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 debug " =A0Prior: $main -> $sub"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 cache_set $main $sub
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 try_remove_previous "$main"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 try_remove_previous "$sub"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 main=3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 sub=3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 esac
+ =A0 =A0 =A0 done
+}
+
+copy_commit()
+{
+ =A0 =A0 =A0 # We're doing to set some environment vars here, so
+ =A0 =A0 =A0 # do it in a subshell to get rid of them safely later
+ =A0 =A0 =A0 debug copy_commit "{$1}" "{$2}" "{$3}"
+ =A0 =A0 =A0 git log -1
--pretty=3Dformat:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b' "$1" |
+ =A0 =A0 =A0 (
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 read GIT_AUTHOR_NAME
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 read GIT_AUTHOR_EMAIL
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 read GIT_AUTHOR_DATE
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 read GIT_COMMITTER_NAME
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 read GIT_COMMITTER_EMAIL
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 read GIT_COMMITTER_DATE
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 export =A0GIT_AUTHOR_NAME \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GIT_AUTHOR_EMAIL \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GIT_AUTHOR_DATE \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GIT_COMMITTER_NAME \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GIT_COMMITTER_EMAIL \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GIT_COMMITTER_DATE
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 (echo -n "$annotate"; cat ) |
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 git commit-tree "$2" $3 =A0# reads the re=
st of stdin
+ =A0 =A0 =A0 ) || die "Can't copy commit $1"
+}
+
+add_msg()
+{
+ =A0 =A0 =A0 dir=3D"$1"
+ =A0 =A0 =A0 latest_old=3D"$2"
+ =A0 =A0 =A0 latest_new=3D"$3"
+ =A0 =A0 =A0 cat <<-EOF
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 Add '$dir/' from commit '$latest_new'
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 git-subtree-dir: $dir
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 git-subtree-mainline: $latest_old
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 git-subtree-split: $latest_new
+ =A0 =A0 =A0 EOF
+}
+
+merge_msg()
+{
+ =A0 =A0 =A0 dir=3D"$1"
+ =A0 =A0 =A0 latest_old=3D"$2"
+ =A0 =A0 =A0 latest_new=3D"$3"
+ =A0 =A0 =A0 cat <<-EOF
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 Split '$dir/' into commit '$latest_new'
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 git-subtree-dir: $dir
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 git-subtree-mainline: $latest_old
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 git-subtree-split: $latest_new
+ =A0 =A0 =A0 EOF
+}
+
+toptree_for_commit()
+{
+ =A0 =A0 =A0 commit=3D"$1"
+ =A0 =A0 =A0 git log -1 --pretty=3Dformat:'%T' "$commit" -- || exit $?
+}
+
+subtree_for_commit()
+{
+ =A0 =A0 =A0 commit=3D"$1"
+ =A0 =A0 =A0 dir=3D"$2"
+ =A0 =A0 =A0 git ls-tree "$commit" -- "$dir" |
+ =A0 =A0 =A0 while read mode type tree name; do
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 assert [ "$name" =3D "$dir" ]
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo $tree
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break
+ =A0 =A0 =A0 done
+}
+
+tree_changed()
+{
+ =A0 =A0 =A0 tree=3D$1
+ =A0 =A0 =A0 shift
+ =A0 =A0 =A0 if [ $# -ne 1 ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0 =A0 # weird parents, consider it=
 changed
+ =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptree=3D$(toptree_for_commit $1)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ "$ptree" !=3D "$tree" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0 =A0 # changed
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1 =A0 # not change=
d
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
+ =A0 =A0 =A0 fi
+}
+
+copy_or_skip()
+{
+ =A0 =A0 =A0 rev=3D"$1"
+ =A0 =A0 =A0 tree=3D"$2"
+ =A0 =A0 =A0 newparents=3D"$3"
+ =A0 =A0 =A0 assert [ -n "$tree" ]
+
+ =A0 =A0 =A0 identical=3D
+ =A0 =A0 =A0 nonidentical=3D
+ =A0 =A0 =A0 p=3D
+ =A0 =A0 =A0 gotparents=3D
+ =A0 =A0 =A0 for parent in $newparents; do
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptree=3D$(toptree_for_commit $parent) || =
exit $?
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ -z "$ptree" ] && continue
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ "$ptree" =3D "$tree" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # an identical parent cou=
ld be used in place
of this rev.
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 identical=3D"$parent"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nonidentical=3D"$parent"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 # sometimes both old parents map to the s=
ame newparent;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 # eliminate duplicates
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_new=3D1
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 for gp in $gotparents; do
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ "$gp" =3D "$parent" =
]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_new=3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 done
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ -n "$is_new" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gotparents=3D"$gotparents=
 $parent"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p=3D"$p -p $parent"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
+ =A0 =A0 =A0 done
+
+ =A0 =A0 =A0 if [ -n "$identical" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo $identical
+ =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 copy_commit $rev $tree "$p" || exit $?
+ =A0 =A0 =A0 fi
+}
+
+ensure_clean()
+{
+ =A0 =A0 =A0 if ! git diff-index HEAD --exit-code --quiet; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "Working tree has modifications. =A0C=
annot add."
+ =A0 =A0 =A0 fi
+ =A0 =A0 =A0 if ! git diff-index --cached HEAD --exit-code --quiet; th=
en
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "Index has modifications. =A0Cannot a=
dd."
+ =A0 =A0 =A0 fi
+}
+
+cmd_add()
+{
+ =A0 =A0 =A0 if [ -e "$dir" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "'$dir' already exists. =A0Cannot add=
=2E"
+ =A0 =A0 =A0 fi
+ =A0 =A0 =A0 ensure_clean
+
+ =A0 =A0 =A0 set -- $revs
+ =A0 =A0 =A0 if [ $# -ne 1 ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "You must provide exactly one revisio=
n. =A0Got: '$revs'"
+ =A0 =A0 =A0 fi
+ =A0 =A0 =A0 rev=3D"$1"
+
+ =A0 =A0 =A0 debug "Adding $dir as '$rev'..."
+ =A0 =A0 =A0 git read-tree --prefix=3D"$dir" $rev || exit $?
+ =A0 =A0 =A0 git checkout "$dir" || exit $?
+ =A0 =A0 =A0 tree=3D$(git write-tree) || exit $?
+
+ =A0 =A0 =A0 headrev=3D$(git rev-parse HEAD) || exit $?
+ =A0 =A0 =A0 if [ -n "$headrev" -a "$headrev" !=3D "$rev" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 headp=3D"-p $headrev"
+ =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 headp=3D
+ =A0 =A0 =A0 fi
+ =A0 =A0 =A0 commit=3D$(add_msg "$dir" "$headrev" "$rev" |
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git commit-tree $tree $headp -p "$rev"=
) || exit $?
+ =A0 =A0 =A0 git reset "$commit" || exit $?
+}
+
+cmd_split()
+{
+ =A0 =A0 =A0 debug "Splitting $dir..."
+ =A0 =A0 =A0 cache_setup || exit $?
+
+ =A0 =A0 =A0 if [ -n "$onto" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 debug "Reading history for --onto=3D$onto=
=2E.."
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 git rev-list $onto |
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 while read rev; do
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # the 'onto' history is a=
lready just the subdir, so
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # any parent we find ther=
e can be used verbatim
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 debug " =A0cache: $rev"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cache_set $rev $rev
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 done
+ =A0 =A0 =A0 fi
+
+ =A0 =A0 =A0 if [ -n "$ignore_joins" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 unrevs=3D
+ =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 unrevs=3D"$(find_existing_splits "$dir" "=
$revs")"
+ =A0 =A0 =A0 fi
+
+ =A0 =A0 =A0 # We can't restrict rev-list to only $dir here, because s=
ome of our
+ =A0 =A0 =A0 # parents have the $dir contents the root, and those won'=
t match.
+ =A0 =A0 =A0 # (and rev-list --follow doesn't seem to solve this)
+ =A0 =A0 =A0 grl=3D'git rev-list --reverse --parents $revs $unrevs'
+ =A0 =A0 =A0 revmax=3D$(eval "$grl" | wc -l)
+ =A0 =A0 =A0 revcount=3D0
+ =A0 =A0 =A0 createcount=3D0
+ =A0 =A0 =A0 eval "$grl" |
+ =A0 =A0 =A0 while read rev parents; do
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 revcount=3D$(($revcount + 1))
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 say -n "$revcount/$revmax ($createcount)
"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 debug "Processing commit: $rev"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 exists=3D$(cache_get $rev)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ -n "$exists" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 debug " =A0prior: $exists=
"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 createcount=3D$(($createcount + 1))
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 debug " =A0parents: $parents"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 newparents=3D$(cache_get $parents)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 debug " =A0newparents: $newparents"
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tree=3D$(subtree_for_commit $rev "$dir")
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 debug " =A0tree is: $tree"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ -z $tree ] && continue
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 newrev=3D$(copy_or_skip "$rev" "$tree" "$=
newparents") || exit $?
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 debug " =A0newrev is: $newrev"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cache_set $rev $newrev
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cache_set latest_new $newrev
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cache_set latest_old $rev
+ =A0 =A0 =A0 done || exit $?
+ =A0 =A0 =A0 latest_new=3D$(cache_get latest_new)
+ =A0 =A0 =A0 if [ -z "$latest_new" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "No new revisions were found"
+ =A0 =A0 =A0 fi
+
+ =A0 =A0 =A0 if [ -n "$rejoin" ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 debug "Merging split branch into HEAD..."
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 latest_old=3D$(cache_get latest_old)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 git merge -s ours \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -m "$(merge_msg $dir $lat=
est_old $latest_new)" \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $latest_new >&2
+ =A0 =A0 =A0 fi
+ =A0 =A0 =A0 echo $latest_new
+ =A0 =A0 =A0 exit 0
+}
+
+cmd_merge()
+{
+ =A0 =A0 =A0 ensure_clean
+
+ =A0 =A0 =A0 set -- $revs
+ =A0 =A0 =A0 if [ $# -ne 1 ]; then
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "You must provide exactly one revisio=
n. =A0Got: '$revs'"
+ =A0 =A0 =A0 fi
+ =A0 =A0 =A0 rev=3D"$1"
+
+ =A0 =A0 =A0 git merge -s subtree $rev
+}
+
+cmd_pull()
+{
+ =A0 =A0 =A0 ensure_clean
+ =A0 =A0 =A0 set -x
+ =A0 =A0 =A0 git pull -s subtree "$@"
+}
+
+"cmd_$command" "$@"
--
1.6.3.rc2.8.gbe66.dirty
