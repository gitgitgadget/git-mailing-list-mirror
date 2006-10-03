From: Martin Waitz <tali@admingilde.org>
Subject: [RFC] submodule prototype
Date: Tue, 3 Oct 2006 18:26:42 +0200
Message-ID: <20061003162642.GL2871@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EdRE1UL8d3mMOE6m"
X-From: git-owner@vger.kernel.org Tue Oct 03 18:27:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUn6W-0002Ae-MS
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 18:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWJCQ0o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 12:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWJCQ0o
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 12:26:44 -0400
Received: from agent.admingilde.org ([213.95.21.5]:45250 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S964800AbWJCQ0n
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 12:26:43 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GUn6Q-0002IN-Cd
	for git@vger.kernel.org; Tue, 03 Oct 2006 18:26:42 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28273>


--EdRE1UL8d3mMOE6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

so, now my little submodule prototype did it's first pull correctly
so I think I should share some ideas here.

http://git.admingilde.org/tali/git.git/module

A submodule here is implemented as a more-or-less normal GIT repository.
The object directory is shared with the parent and all refs are visible
in both the parent and all submodules (via refs/parent and refs/module)
so that fsck works.

On top of that is some special handling for commit and pull:
When commiting in the parent project then all submodule refs are
stored in the tree, too.
Fetching from a remote parent copies all submodule references into
the current repository, too.
After a successful merge the submodules are updated to reflect
the new state.

The code below is obviously not finished and very fragile,
it has only been tested with the litte test script so far,
but I think it's a nice basis for discussion.

What do you think?

Some specific questions:

User interface: like show here only one more command to set up
submodules and then using standard commands for parent and submodule
or does it make more sense to add special commands for updating
submodules (and not recursing into them by default)?

Does it really make sense to have one shared object directory?
This allows to fetch the whole project in one go, but it
might be more robust to set up individual object databases.

diff --git a/.gitignore b/.gitignore
index a3d9c7a..2ef60fc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -47,6 +47,7 @@ git-http-push
 git-imap-send
 git-index-pack
 git-init-db
+git-init-module
 git-instaweb
 git-local-fetch
 git-log
diff --git a/Makefile b/Makefile
index 8467447..4493973 100644
--- a/Makefile
+++ b/Makefile
@@ -154,7 +154,7 @@ ### --- END CONFIGURATION SECTION ---
 SCRIPT_SH =3D \
 	git-bisect.sh git-branch.sh git-checkout.sh \
 	git-cherry.sh git-clean.sh git-clone.sh git-commit.sh \
-	git-fetch.sh \
+	git-fetch.sh git-init-module.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh \
diff --git a/git-checkout.sh b/git-checkout.sh
index 580a9e8..a8764fd 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -211,3 +211,20 @@ if [ "$?" -eq 0 ]; then
 else
 	exit 1
 fi
+
+#
+# Now checkout all the submodules recursively
+# FIXME: handle branch updates
+#
+unset GIT_DIR
+parent_dir=3D`pwd`
+if test -r .gitmodules; then
+	while read module; do
+		cd "$parent_dir"
+		HEAD=3D$(git-symbolic-ref "../.gitmodule/$module/HEAD")
+		mkdir -p "$module"
+		cd "$module"
+		git-init-module >/dev/null
+		git-checkout $HEAD
+	done < .gitmodules
+fi
diff --git a/git-clone.sh b/git-clone.sh
index e1b3bf3..cce21e9 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -410,7 +410,7 @@ Pull: refs/heads/$head_points_at:$origin
=20
 	case "$no_checkout" in
 	'')
-		git-read-tree -m -u -v HEAD HEAD
+		git-checkout
 	esac
 fi
 rm -f "$GIT_DIR/CLONE_HEAD" "$GIT_DIR/REMOTE_HEAD"
diff --git a/git-commit.sh b/git-commit.sh
index 5a4c659..1b79182 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -342,6 +342,18 @@ then
 	TOP=3D./
 fi
=20
+# update the .gitmodule/ contents
+# FIXME: don't overwrite, test if submodule is ancestor of current value
+if test -r .gitmodules; then
+	while read module; do
+		rm -rf ".gitmodule/$module"
+		mkdir -p ".gitmodule/$module/refs"
+		cp -a "$module/.git/refs/heads" ".gitmodule/$module/refs/"
+		cp -a "$module/.git/refs/tags" ".gitmodule/$module/refs/"
+		cp -a "$module/.git/HEAD" ".gitmodule/$module/"
+	done < .gitmodules
+fi
+
 case "$all,$also" in
 t,)
 	save_index &&
diff --git a/git-init-module.sh b/git-init-module.sh
new file mode 100644
index 0000000..b64f630
--- /dev/null
+++ b/git-init-module.sh
@@ -0,0 +1,65 @@
+#!/bin/sh -e
+
+USAGE=3D""
+LONG_USAGE=3D"Sets up a GIT sub module in the current directory"
+SUBDIRECTORY_OK=3Dyes
+
+# get directory of parent GIT repository
+GIT_MODULE_DIR=3D`pwd`
+cd ..
+. git-sh-setup
+GIT_PARENT_DIR=3D`cd "$GIT_DIR" && pwd`
+GIT_PARENT_DIR=3D"${GIT_PARENT_DIR%.git}"
+
+# make relative path
+GIT_MODULE_REL_DIR=3D"${GIT_MODULE_DIR#$GIT_PARENT_DIR}"
+GIT_PARENT_REL_DIR=3D"$GIT_PARENT_DIR" # FIXME should be made relative
+
+populate_dirs() {
+	(cd "$1" && find . -type d) | (cd "$2" && xargs mkdir -p)
+}
+
+# a mv which can merge directory trees
+move() {
+	populate_dirs "$@"
+	(cd "$1" && find . ! -type d) | xargs -n 1 -i mv "{}" "$2"
+	find "$1" -depth | xargs rmdir
+}
+
+
+# create a basic repository here
+cd "$GIT_MODULE_DIR"
+git-init-db
+
+# use parents object directory instead
+if test ! -L .git/objects; then
+	move .git/objects "$GIT_PARENT_DIR/.git/objects/"
+	ln -s "$GIT_PARENT_REL_DIR/.git/objects" .git/objects
+fi
+
+# make all references known everywhere, so that git-fsck-objects works.
+mkdir -p "$GIT_PARENT_DIR/.git/refs/module/$GIT_MODULE_REL_DIR"
+ln -s -f -n "$GIT_PARENT_REL_DIR/.git/refs" .git/refs/parent
+for dir in heads tags remotes; do
+	ln -s -f -n "$GIT_MODULE_DIR/.git/refs/$dir" "$GIT_PARENT_DIR/.git/refs/m=
odule/$GIT_MODULE_REL_DIR/$dir"
+done
+
+
+# copy heads from parent, but without overwriting anything
+GIT_PARENT_REFS=3D"$GIT_PARENT_DIR/.gitmodule/$GIT_MODULE_REL_DIR"
+mkdir -p "$GIT_PARENT_REFS"
+populate_dirs "$GIT_PARENT_REFS" .git
+(cd "$GIT_PARENT_REFS" && find ! -type d) | while read path; do
+	if test ! -e ".git/$path"; then
+		cp "$GIT_PARENT_REFS/$path" ".git/$path"
+	fi
+done
+
+# register the module in the parent
+(cat "$GIT_PARENT_DIR/.gitmodules" 2>/dev/null || true;
+ echo "$GIT_MODULE_REL_DIR") |
+	sort -u > "$GIT_PARENT_DIR/.gitmodules.new"
+mv "$GIT_PARENT_DIR/.gitmodules.new" "$GIT_PARENT_DIR/.gitmodules"
+
+grep "^/$GIT_MODULE_REL_DIR$" "$GIT_PARENT_DIR/.gitignore" >/dev/null 2>&1=
 ||
+echo "/$GIT_MODULE_REL_DIR" >> "$GIT_PARENT_DIR/.gitignore"
diff --git a/git-merge.sh b/git-merge.sh
index d049e16..273d864 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -97,8 +97,33 @@ finish () {
 		esac
 		;;
 	esac
+
+	# now take a look at changes in submodules
+	if test -e .gitmodules; then
+		while read module; do
+			merge_module "$module"
+		done < .gitmodules
+	fi
 }
=20
+merge_module () {
+	module=3D"$1"
+	HEAD=3D$(git-symbolic-ref "../.gitmodule/$module/HEAD")
+	new_head=3D$(cat ".gitmodule/$module/$HEAD")
+	# FIXME: first step: merge HEAD only
+	(set -e
+		cd "$module"
+		unset GIT_DIR
+		# FIXME: sure there is a nicer way to do this...
+		echo "Updateing $module"
+		git-branch "refs/update/$HEAD" "$new_head"
+		git-merge "updated by parent" "$HEAD" "refs/update/$HEAD"
+		git-branch -d "refs/update/$HEAD"
+		git-checkout "$HEAD"
+	)
+}
+
+
 rloga=3D
 while case "$#" in 0) break ;; esac
 do
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 187f088..230eb4d 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -149,6 +149,17 @@ get_remote_default_refs_for_fetch () {
 	*)
 		die "internal error: get-remote-default-ref-for-push $1" ;;
 	esac
+	# also fetch all submodule data
+	if test -e .gitmodules; then
+		while read module; do
+			(cd .gitmodule/$module/refs && find * ! -type d) |
+			while read ref; do
+				# only fetch the ref, don't store it
+				# as it gets stored in the repository directly
+				echo ".refs/module/$module/$ref:"
+			done
+		done < .gitmodules
+	fi
 }
=20
 get_remote_refs_for_push () {
diff --git a/t/t7500-submodule.sh b/t/t7500-submodule.sh
new file mode 100755
index 0000000..cb57fef
--- /dev/null
+++ b/t/t7500-submodule.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+test_description=3D"Test submodule support."
+
+. ./test-lib.sh
+
+
+test_expect_success "Create parent" \
+    'mkdir p &&
+     cd p &&
+     git-init-db &&
+     echo "Parent repository" > README &&
+     git-add README &&
+     git-commit -a -m "init parent" &&
+     cd ..'
+
+test_expect_success "Create submodule" \
+    'mkdir p/sub &&
+     cd p/sub &&
+     git-init-module &&
+     echo "Submodule repository" > README &&
+     git-add README &&
+     git-commit -a -m "init submodule" &&
+     cd ../..'
+
+test_expect_success "Add submodule to parent" \
+    'cd p &&
+     git-add .gitmodules .gitignore &&
+     git-status >/dev/null &&
+     git-add .gitmodule &&
+     git-commit -a -m "add submodule" &&
+     cd ..'
+
+check_repos() {
+     ( git-status > ../actual || true ) &&
+     git-fsck-objects --full 2>&1 >> ../actual 2>&1 &&
+     cd sub &&
+     ( git-status >> ../../actual 2>&1 || true ) &&
+     git-fsck-objects --full >> ../../actual 2>&1 &&
+     cd ../.. &&
+     echo "nothing to commit" > expected &&
+     echo "nothing to commit" >> expected &&
+     diff -u expected actual
+}
+
+test_expect_success "Check repositories" \
+    'cd p && check_repos'
+
+test_expect_success "Cloning parent" \
+    'git-clone p p2'
+
+test_expect_success "Check cloned repositories" \
+    'cd p2 && check_repos'
+
+test_expect_success "Commit to submodule" \
+    'cd p/sub &&
+     echo foo > bar &&
+     git-add bar &&
+     git-commit -a -m "add bar" &&
+     cd ../..'
+
+test_expect_success "Commit to parent" \
+    'cd p &&
+     git-commit -a -m "update sub" &&
+     cd ..'
+
+test_expect_success "Pull changes into clone" \
+    'cd p2 &&
+     git-pull ../p &&
+     test -f sub/bar &&
+     cd ..'
+
+test_expect_success "Check updated repositories" \
+    'cd p2 && check_repos'
+
+test_done

--=20
Martin Waitz

--EdRE1UL8d3mMOE6m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFIo9Cj/Eaxd/oD7IRAsUaAJ4sANE23HIfI6kvo17CI8VpIkOQPQCfd20h
1YUQMB0QBuo+pJA962legT4=
=hSMa
-----END PGP SIGNATURE-----

--EdRE1UL8d3mMOE6m--
