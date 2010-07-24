From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: RFC: Between git-subtree and git-submodules
Date: Sat, 24 Jul 2010 02:13:19 +0200
Message-ID: <AANLkTi=tDRfgzzcbp0jV=+hQ+Cs2fhNF0vK8JL1COoFu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6d622cef983eb048c170595
To: Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 02:13:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcSNJ-0003t2-H3
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 02:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758766Ab0GXANl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 20:13:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46931 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757827Ab0GXANk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 20:13:40 -0400
Received: by fxm14 with SMTP id 14so5294716fxm.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 17:13:39 -0700 (PDT)
Received: by 10.103.217.14 with SMTP id u14mr923658muq.2.1279930419216; Fri, 
	23 Jul 2010 17:13:39 -0700 (PDT)
Received: by 10.102.58.11 with HTTP; Fri, 23 Jul 2010 17:13:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151585>

--0016e6d622cef983eb048c170595
Content-Type: text/plain; charset=ISO-8859-1

Hi *,

  now that there is a lot of traffic about git-subtree and git-submodules I
  would like to show you why *I* don't use neither of them, but something in
  between.

  First my requirements:

1) Everything[1] must be available from the same repository/branch (so I'm not
   worried about repository size)
2) The history must be as clean as possible
3) The directory content must be equal to the external module, at least when
   you add/update it[2]
4) The external module should be able to switch back and forth between
   different versions.

[1] Everything means all that you need to checkout all the commits in the
superproject not in the submodule.
[2] A consequence of 3) is that I lose all
change I've made in the subdirectory, if they are important I have to extract
them, apply them and add the module back.

git-submodule is rule out because of 1) but accomplish 2), 3) and
4). git-subtree is rule out because of 2) (even with --squash) 3) and 4)
without --squash but accomplish 1) and 4) with --squash. So I need something
in between or a mixture of both.

At the end I've done what I called originally git-subtree, but now I've written
the prune mode of git-subtree.

The idea is that you want to add the content of a module in a subdirectory and
that's all! I think that this simplicity is also very powerful as it
is very clear how it
behaves. You just get a commit each time you add a subtree (normal commit
not a merge) without the history of the subtree.

You get something like this:

$ git log --graph
* ee225bd Subtree 'a/': 895916a Commit message 1
* aa345dg Modification to a/Makefile
* ddcd676 Subtree 'a/': 9a053f2 Commit message 2
* ea35faf Indent, whitespaces,...

Later you can extract/split all the modifications to a/ with "git-subtree
split" (not yet implemented).

If you merge two branches with different content in the subtree you just merge
them the normal way as with any other file.

It works quite well in my use case.

Below you can find the patch to git-subtree to add this prune mode (also
attatched because of whitespace corruption). Only slightly tested as I
normally use
my git-subtree command (completely different) and I've just patch git-subtree
but you can get the idea of what it does.

HTH,
Santi

diff --git i/git-subtree.sh w/git-subtree.sh
index 781eef3..7706d72 100755
--- i/git-subtree.sh
+++ w/git-subtree.sh
@@ -27,6 +27,7 @@ onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
  options for 'add', 'merge', 'pull' and 'push'
 squash        merge subtree changes as a single commit
+prune         prune history
 "
 eval $(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)

@@ -44,6 +45,7 @@ rejoin=
 ignore_joins=
 annotate=
 squash=
+prune=
 message=

 debug()
@@ -92,6 +94,8 @@ while [ $# -gt 0 ]; do
 		--no-ignore-joins) ignore_joins= ;;
 		--squash) squash=1 ;;
 		--no-squash) squash= ;;
+		--prune) prune=1;;
+		--no-prune) prune=;;
 		--) break ;;
 		*) die "Unexpected option: $opt" ;;
 	esac
@@ -110,7 +114,7 @@ if [ -z "$prefix" ]; then
 fi

 case "$command" in
-	add) [ -e "$prefix" ] &&
+	add) [ -e "$prefix" -a -z "$prune" ] &&
 		die "prefix '$prefix' already exists." ;;
 	*)   [ -e "$prefix" ] ||
 		die "'$prefix' does not exist; use 'git subtree add'" ;;
@@ -359,6 +363,17 @@ squash_msg()
 	echo "git-subtree-split: $newsub"
 }

+prune_msg()
+{
+	dir="$1"
+	newsub="$2"
+	
+	git show -s --pretty="tformat:Subtree '$dir/': %h %s" $newsub
+	echo
+	echo "git-subtree-dir: $dir"
+	echo "git-subtree-split: $newsub"
+}
+
 toptree_for_commit()
 {
 	commit="$1"
@@ -464,7 +479,7 @@ ensure_clean()

 cmd_add()
 {
-	if [ -e "$dir" ]; then
+	if [ -e "$dir" -a -z "$prune" ]; then
 		die "'$dir' already exists.  Cannot add."
 	fi

@@ -498,6 +513,10 @@ cmd_add_commit()
 	rev="$1"
 	
 	debug "Adding $dir as '$rev'..."
+	if [ -d "$dir" ]; then
+	    #TODO: write it with plumbing commands
+	    git rm -r -q $dir
+	fi
 	git read-tree --prefix="$dir" $rev || exit $?
 	git checkout -- "$dir" || exit $?
 	tree=$(git write-tree) || exit $?
@@ -513,6 +532,9 @@ cmd_add_commit()
 		rev=$(new_squash_commit "" "" "$rev") || exit $?
 		commit=$(add_squashed_msg "$rev" "$dir" |
 			 git commit-tree $tree $headp -p "$rev") || exit $?
+	elif [ -n "$prune" ]; then
+		commit=$(prune_msg "$dir" "$rev" |
+			 git commit-tree $tree -p $headrev) || exit $?
 	else
 		commit=$(add_msg "$dir" "$headrev" "$rev" |
 			 git commit-tree $tree $headp -p "$rev") || exit $?

--0016e6d622cef983eb048c170595
Content-Type: text/x-diff; charset=US-ASCII; name="git-subtree-prune-mode.patch"
Content-Disposition: attachment; filename="git-subtree-prune-mode.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gbzpeq0q0

ZGlmZiAtLWdpdCBpL2dpdC1zdWJ0cmVlLnNoIHcvZ2l0LXN1YnRyZWUuc2gKaW5kZXggNzgxZWVm
My4uNzcwNmQ3MiAxMDA3NTUKLS0tIGkvZ2l0LXN1YnRyZWUuc2gKKysrIHcvZ2l0LXN1YnRyZWUu
c2gKQEAgLTI3LDYgKzI3LDcgQEAgb250bz0gICAgICAgICB0cnkgY29ubmVjdGluZyBuZXcgdHJl
ZSB0byBhbiBleGlzdGluZyBvbmUKIHJlam9pbiAgICAgICAgbWVyZ2UgdGhlIG5ldyBicmFuY2gg
YmFjayBpbnRvIEhFQUQKICBvcHRpb25zIGZvciAnYWRkJywgJ21lcmdlJywgJ3B1bGwnIGFuZCAn
cHVzaCcKIHNxdWFzaCAgICAgICAgbWVyZ2Ugc3VidHJlZSBjaGFuZ2VzIGFzIGEgc2luZ2xlIGNv
bW1pdAorcHJ1bmUgICAgICAgICBwcnVuZSBoaXN0b3J5CiAiCiBldmFsICQoZWNobyAiJE9QVFNf
U1BFQyIgfCBnaXQgcmV2LXBhcnNlIC0tcGFyc2VvcHQgLS0gIiRAIiB8fCBlY2hvIGV4aXQgJD8p
CiAKQEAgLTQ0LDYgKzQ1LDcgQEAgcmVqb2luPQogaWdub3JlX2pvaW5zPQogYW5ub3RhdGU9CiBz
cXVhc2g9CitwcnVuZT0KIG1lc3NhZ2U9CiAKIGRlYnVnKCkKQEAgLTkyLDYgKzk0LDggQEAgd2hp
bGUgWyAkIyAtZ3QgMCBdOyBkbwogCQktLW5vLWlnbm9yZS1qb2lucykgaWdub3JlX2pvaW5zPSA7
OwogCQktLXNxdWFzaCkgc3F1YXNoPTEgOzsKIAkJLS1uby1zcXVhc2gpIHNxdWFzaD0gOzsKKwkJ
LS1wcnVuZSkgcHJ1bmU9MTs7CisJCS0tbm8tcHJ1bmUpIHBydW5lPTs7CiAJCS0tKSBicmVhayA7
OwogCQkqKSBkaWUgIlVuZXhwZWN0ZWQgb3B0aW9uOiAkb3B0IiA7OwogCWVzYWMKQEAgLTExMCw3
ICsxMTQsNyBAQCBpZiBbIC16ICIkcHJlZml4IiBdOyB0aGVuCiBmaQogCiBjYXNlICIkY29tbWFu
ZCIgaW4KLQlhZGQpIFsgLWUgIiRwcmVmaXgiIF0gJiYgCisJYWRkKSBbIC1lICIkcHJlZml4IiAt
YSAteiAiJHBydW5lIiBdICYmCiAJCWRpZSAicHJlZml4ICckcHJlZml4JyBhbHJlYWR5IGV4aXN0
cy4iIDs7CiAJKikgICBbIC1lICIkcHJlZml4IiBdIHx8IAogCQlkaWUgIickcHJlZml4JyBkb2Vz
IG5vdCBleGlzdDsgdXNlICdnaXQgc3VidHJlZSBhZGQnIiA7OwpAQCAtMzU5LDYgKzM2MywxNyBA
QCBzcXVhc2hfbXNnKCkKIAllY2hvICJnaXQtc3VidHJlZS1zcGxpdDogJG5ld3N1YiIKIH0KIAor
cHJ1bmVfbXNnKCkKK3sKKwlkaXI9IiQxIgorCW5ld3N1Yj0iJDIiCisJCisJZ2l0IHNob3cgLXMg
LS1wcmV0dHk9InRmb3JtYXQ6U3VidHJlZSAnJGRpci8nOiAlaCAlcyIgJG5ld3N1YgorCWVjaG8K
KwllY2hvICJnaXQtc3VidHJlZS1kaXI6ICRkaXIiCisJZWNobyAiZ2l0LXN1YnRyZWUtc3BsaXQ6
ICRuZXdzdWIiCit9CisKIHRvcHRyZWVfZm9yX2NvbW1pdCgpCiB7CiAJY29tbWl0PSIkMSIKQEAg
LTQ2NCw3ICs0NzksNyBAQCBlbnN1cmVfY2xlYW4oKQogCiBjbWRfYWRkKCkKIHsKLQlpZiBbIC1l
ICIkZGlyIiBdOyB0aGVuCisJaWYgWyAtZSAiJGRpciIgLWEgLXogIiRwcnVuZSIgXTsgdGhlbgog
CQlkaWUgIickZGlyJyBhbHJlYWR5IGV4aXN0cy4gIENhbm5vdCBhZGQuIgogCWZpCiAKQEAgLTQ5
OCw2ICs1MTMsMTAgQEAgY21kX2FkZF9jb21taXQoKQogCXJldj0iJDEiCiAJCiAJZGVidWcgIkFk
ZGluZyAkZGlyIGFzICckcmV2Jy4uLiIKKwlpZiBbIC1kICIkZGlyIiBdOyB0aGVuCisJICAgICNU
T0RPOiB3cml0ZSBpdCB3aXRoIHBsdW1iaW5nIGNvbW1hbmRzCisJICAgIGdpdCBybSAtciAtcSAk
ZGlyCisJZmkKIAlnaXQgcmVhZC10cmVlIC0tcHJlZml4PSIkZGlyIiAkcmV2IHx8IGV4aXQgJD8K
IAlnaXQgY2hlY2tvdXQgLS0gIiRkaXIiIHx8IGV4aXQgJD8KIAl0cmVlPSQoZ2l0IHdyaXRlLXRy
ZWUpIHx8IGV4aXQgJD8KQEAgLTUxMyw2ICs1MzIsOSBAQCBjbWRfYWRkX2NvbW1pdCgpCiAJCXJl
dj0kKG5ld19zcXVhc2hfY29tbWl0ICIiICIiICIkcmV2IikgfHwgZXhpdCAkPwogCQljb21taXQ9
JChhZGRfc3F1YXNoZWRfbXNnICIkcmV2IiAiJGRpciIgfAogCQkJIGdpdCBjb21taXQtdHJlZSAk
dHJlZSAkaGVhZHAgLXAgIiRyZXYiKSB8fCBleGl0ICQ/CisJZWxpZiBbIC1uICIkcHJ1bmUiIF07
IHRoZW4KKwkJY29tbWl0PSQocHJ1bmVfbXNnICIkZGlyIiAiJHJldiIgfAorCQkJIGdpdCBjb21t
aXQtdHJlZSAkdHJlZSAtcCAkaGVhZHJldikgfHwgZXhpdCAkPwogCWVsc2UKIAkJY29tbWl0PSQo
YWRkX21zZyAiJGRpciIgIiRoZWFkcmV2IiAiJHJldiIgfAogCQkJIGdpdCBjb21taXQtdHJlZSAk
dHJlZSAkaGVhZHAgLXAgIiRyZXYiKSB8fCBleGl0ICQ/Cg==
--0016e6d622cef983eb048c170595--
