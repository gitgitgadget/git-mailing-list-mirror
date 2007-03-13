From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 2/3] git-fetch: Support the local remote "."
Date: Tue, 13 Mar 2007 17:28:24 +0100
Message-ID: <87bqixf6qf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C. Hamano" <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>,
	Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 13 17:28:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR9rE-0000gd-6X
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 17:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030775AbXCMQ2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Mar 2007 12:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030754AbXCMQ2N
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 12:28:13 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:38062 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030778AbXCMQ2M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 12:28:12 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l2DGS4q15269;
	Tue, 13 Mar 2007 17:28:04 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42131>


To this end, git-parse-remote is grown with a new kind of remote,
`builtin'. This returns all the local branches in
get_remote_default_refs_for_fetch. This is equivalent to having a
fake remote as:

[remote "local"]
url =3D .
fetch =3D refs/*

Based on a patch from Paolo Bonzini.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/config.txt     |    4 ++++
 git-parse-remote.sh          |   12 +++++++++++-
 t/t5515-fetch-merge-logic.sh |    2 ++
 t/t5515/fetch.br-.           |    6 ++++++
 t/t5515/fetch.br-.-merge     |    6 ++++++
 t/t5515/fetch.br-.-merge_.   |    6 ++++++
 t/t5515/fetch.br-.-octopus   |    6 ++++++
 t/t5515/fetch.br-.-octopus_. |    6 ++++++
 t/t5515/fetch.br-._.         |    6 ++++++
 t/t5515/fetch.br-unconfig_.  |    5 +++++
 t/t5515/fetch.master_.       |    5 +++++
 t/t5520-pull.sh              |   13 +++++++++++++
 12 files changed, 76 insertions(+), 1 deletions(-)
 create mode 100644 t/t5515/fetch.br-.
 create mode 100644 t/t5515/fetch.br-.-merge
 create mode 100644 t/t5515/fetch.br-.-merge_.
 create mode 100644 t/t5515/fetch.br-.-octopus
 create mode 100644 t/t5515/fetch.br-.-octopus_.
 create mode 100644 t/t5515/fetch.br-._.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5408dd6..28899d9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -272,6 +272,10 @@ branch.<name>.merge::
 	`git fetch`) to lookup the default branch for merging. Without
 	this option, `git pull` defaults to merge the first refspec fetched.
 	Specify multiple values to get an octopus merge.
+	If you wish to setup `git pull` so that it merges into <name> from
+	another branch in the local repository, you can point
+	branch.<name>.merge to the desired branch, and use the special settin=
g
+	`.` (a period) for branch.<name>.remote.
=20
 color.branch::
 	A boolean to enable/disable color in the output of
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 99e7184..84c2c89 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -9,6 +9,9 @@ get_data_source () {
 	*/*)
 		echo ''
 		;;
+	.)
+		echo builtin
+		;;
 	*)
 		if test "$(git-config --get "remote.$1.url")"
 		then
@@ -31,6 +34,9 @@ get_remote_url () {
 	'')
 		echo "$1"
 		;;
+	builtin)
+		echo "$1"
+		;;
 	config)
 		git-config --get "remote.$1.url"
 		;;
@@ -57,7 +63,7 @@ get_default_remote () {
 get_remote_default_refs_for_push () {
 	data_source=3D$(get_data_source "$1")
 	case "$data_source" in
-	'' | branches)
+	'' | branches | builtin)
 		;; # no default push mapping, just send matching refs.
 	config)
 		git-config --get-all "remote.$1.push" ;;
@@ -128,6 +134,10 @@ get_remote_default_refs_for_fetch () {
 	case "$data_source" in
 	'')
 		set explicit "HEAD:" ;;
+	builtin)
+		set glob $(for name in $(git-show-ref |
+			sed -n 's,.*[      ]refs/,refs/,p')
+		    do echo "$name:" ; done);;
 	config)
 		set $(expand_refs_wildcard "$1" \
 			$(git-config --get-all "remote.$1.fetch")) ;;
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.s=
h
index 9759959..e840fe0 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -78,6 +78,8 @@ test_expect_success setup '
 	echo "../.git#one" > .git/branches/branches-one &&
 	remotes=3D"$remotes branches-one" &&
=20
+	remotes=3D"$remotes ." &&
+
 	for remote in $remotes ; do
 		git config branch.br-$remote.remote $remote &&
 		git config branch.br-$remote-merge.remote $remote &&
diff --git a/t/t5515/fetch.br-. b/t/t5515/fetch.br-.
new file mode 100644
index 0000000..8878a73
--- /dev/null
+++ b/t/t5515/fetch.br-.
@@ -0,0 +1,6 @@
+# br-.
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/HEAD' of .
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	remote branch '=
origin/master' of .
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	remote branch '=
origin/one' of .
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/three' of .
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	remote branch '=
origin/two' of .
diff --git a/t/t5515/fetch.br-.-merge b/t/t5515/fetch.br-.-merge
new file mode 100644
index 0000000..b851578
--- /dev/null
+++ b/t/t5515/fetch.br-.-merge
@@ -0,0 +1,6 @@
+# br-.-merge
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/HEAD' of .
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	remote branch '=
origin/master' of .
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	remote branch '=
origin/one' of .
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/three' of .
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	remote branch '=
origin/two' of .
diff --git a/t/t5515/fetch.br-.-merge_. b/t/t5515/fetch.br-.-merge_.
new file mode 100644
index 0000000..2484570
--- /dev/null
+++ b/t/t5515/fetch.br-.-merge_.
@@ -0,0 +1,6 @@
+# br-.-merge .
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/HEAD' of .
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	remote branch '=
origin/master' of .
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	remote branch '=
origin/one' of .
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/three' of .
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	remote branch '=
origin/two' of .
diff --git a/t/t5515/fetch.br-.-octopus b/t/t5515/fetch.br-.-octopus
new file mode 100644
index 0000000..3f440b1
--- /dev/null
+++ b/t/t5515/fetch.br-.-octopus
@@ -0,0 +1,6 @@
+# br-.-octopus
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/HEAD' of .
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	remote branch '=
origin/master' of .
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	remote branch '=
origin/one' of .
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/three' of .
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	remote branch '=
origin/two' of .
diff --git a/t/t5515/fetch.br-.-octopus_. b/t/t5515/fetch.br-.-octopus_=
=2E
new file mode 100644
index 0000000..938e9ed
--- /dev/null
+++ b/t/t5515/fetch.br-.-octopus_.
@@ -0,0 +1,6 @@
+# br-.-octopus .
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/HEAD' of .
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	remote branch '=
origin/master' of .
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	remote branch '=
origin/one' of .
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/three' of .
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	remote branch '=
origin/two' of .
diff --git a/t/t5515/fetch.br-._. b/t/t5515/fetch.br-._.
new file mode 100644
index 0000000..9d43858
--- /dev/null
+++ b/t/t5515/fetch.br-._.
@@ -0,0 +1,6 @@
+# br-. .
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/HEAD' of .
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	remote branch '=
origin/master' of .
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	remote branch '=
origin/one' of .
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/three' of .
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	remote branch '=
origin/two' of .
diff --git a/t/t5515/fetch.br-unconfig_. b/t/t5515/fetch.br-unconfig_.
index 73c937d..455a0ce 100644
--- a/t/t5515/fetch.br-unconfig_.
+++ b/t/t5515/fetch.br-unconfig_.
@@ -1 +1,6 @@
 # br-unconfig .
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/HEAD' of .
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	remote branch '=
origin/master' of .
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	remote branch '=
origin/one' of .
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/three' of .
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	remote branch '=
origin/two' of .
diff --git a/t/t5515/fetch.master_. b/t/t5515/fetch.master_.
index ad16cdc..967d057 100644
--- a/t/t5515/fetch.master_.
+++ b/t/t5515/fetch.master_.
@@ -1 +1,6 @@
 # master .
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/HEAD' of .
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	remote branch '=
origin/master' of .
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	remote branch '=
origin/one' of .
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	remote branch '=
origin/three' of .
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	remote branch '=
origin/two' of .
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 7eb3783..c424e5b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -29,5 +29,18 @@ test_expect_success 'checking the results' '
 	diff file cloned/file
 '
=20
+test_expect_success 'test . as a remote' '
+
+	git branch copy master &&
+	git config branch.copy.remote . &&
+	git config branch.copy.merge refs/heads/master &&
+	echo updated >file &&
+	git commit -a -m updated &&
+	git checkout copy &&
+	test `cat file` =3D file &&
+	git pull &&
+	test `cat file` =3D updated
+'
+
 test_done
=20
--=20
1.5.0.3.1021.g5897
