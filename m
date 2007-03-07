From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] git-fetch: Split fetch and merge logic
Date: Wed, 07 Mar 2007 13:25:28 +0100
Message-ID: <87fy8h5jgn.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 13:25:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOvD3-0005Bz-BQ
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 13:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbXCGMZa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Mar 2007 07:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXCGMZ3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 07:25:29 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:40292 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbXCGMZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 07:25:28 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l27CPGw30232
	for <git@vger.kernel.org>; Wed, 7 Mar 2007 13:25:18 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41666>


It makes git-parse-remote.sh, git-fetch--tool and almost all git-fetch
independent of the merge logic.

git-fetch fetches the branches from the remote and saves this
information in .git/FETCH_FETCHED (a temporary file), and at the end it
generates the file .git/FETCH_HEAD.

The current merge behaviour is unchanged.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
Hi *,

 this time the net effect is to add 10 lines :(

 This applies to next.

 Regards,

 Santi

 builtin-fetch--tool.c |   49 ++++++++++--------------------
 git-fetch.sh          |   78 +++++++++++++++++++++++++++++++++++++++++=
-------
 git-parse-remote.sh   |   65 ++++++++++++-----------------------------
 3 files changed, 101 insertions(+), 91 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index e9d6764..2cee058 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -138,8 +138,7 @@ static int update_local_ref(const char *name,
=20
 static int append_fetch_head(FILE *fp,
 			     const char *head, const char *remote,
-			     const char *remote_name, const char *remote_nick,
-			     const char *local_name, int not_for_merge,
+			     const char *remote_name, const char *local_name,
 			     int verbose, int force)
 {
 	struct commit *commit;
@@ -151,8 +150,6 @@ static int append_fetch_head(FILE *fp,
 	if (get_sha1(head, sha1))
 		return error("Not a valid object name: %s", head);
 	commit =3D lookup_commit_reference(sha1);
-	if (!commit)
-		not_for_merge =3D 1;
=20
 	if (!strcmp(remote_name, "HEAD")) {
 		kind =3D "";
@@ -189,9 +186,9 @@ static int append_fetch_head(FILE *fp,
 		note_len +=3D sprintf(note + note_len, "'%s' of ", what);
 	}
 	note_len +=3D sprintf(note + note_len, "%.*s", remote_len, remote);
-	fprintf(fp, "%s\t%s\t%s\n",
+	fprintf(fp, "%s\t%s:%s\t%s\n",
 		sha1_to_hex(commit ? commit->object.sha1 : sha1),
-		not_for_merge ? "not-for-merge" : "",
+		remote_name, local_name,
 		note);
 	return update_local_ref(local_name, head, note, verbose, force);
 }
@@ -211,14 +208,14 @@ static void remove_keep_on_signal(int signo)
 }
=20
 static char *find_local_name(const char *remote_name, const char *refs=
,
-			     int *force_p, int *not_for_merge_p)
+			     int *force_p)
 {
 	const char *ref =3D refs;
 	int len =3D strlen(remote_name);
=20
 	while (ref) {
 		const char *next;
-		int single_force, not_for_merge;
+		int single_force;
=20
 		while (*ref =3D=3D '\n')
 			ref++;
@@ -226,19 +223,11 @@ static char *find_local_name(const char *remote_n=
ame, const char *refs,
 			break;
 		next =3D strchr(ref, '\n');
=20
-		single_force =3D not_for_merge =3D 0;
+		single_force =3D 0;
 		if (*ref =3D=3D '+') {
 			single_force =3D 1;
 			ref++;
 		}
-		if (*ref =3D=3D '.') {
-			not_for_merge =3D 1;
-			ref++;
-			if (*ref =3D=3D '+') {
-				single_force =3D 1;
-				ref++;
-			}
-		}
 		if (!strncmp(remote_name, ref, len) && ref[len] =3D=3D ':') {
 			const char *local_part =3D ref + len + 1;
 			char *ret;
@@ -252,7 +241,6 @@ static char *find_local_name(const char *remote_nam=
e, const char *refs,
 			memcpy(ret, local_part, retlen);
 			ret[retlen] =3D 0;
 			*force_p =3D single_force;
-			*not_for_merge_p =3D not_for_merge;
 			return ret;
 		}
 		ref =3D next;
@@ -262,7 +250,6 @@ static char *find_local_name(const char *remote_nam=
e, const char *refs,
=20
 static int fetch_native_store(FILE *fp,
 			      const char *remote,
-			      const char *remote_nick,
 			      const char *refs,
 			      int verbose, int force)
 {
@@ -276,7 +263,7 @@ static int fetch_native_store(FILE *fp,
 		int len;
 		char *cp;
 		char *local_name;
-		int single_force, not_for_merge;
+		int single_force;
=20
 		for (cp =3D buffer; *cp && !isspace(*cp); cp++)
 			;
@@ -298,12 +285,11 @@ static int fetch_native_store(FILE *fp,
 		}
=20
 		local_name =3D find_local_name(cp, refs,
-					     &single_force, &not_for_merge);
+					     &single_force);
 		if (!local_name)
 			continue;
 		err |=3D append_fetch_head(fp,
-					 buffer, remote, cp, remote_nick,
-					 local_name, not_for_merge,
+					 buffer, remote, cp, local_name,
 					 verbose, force || single_force);
 	}
 	return err;
@@ -336,8 +322,6 @@ static int parse_reflist(const char *reflist)
 			break;
 		for (next =3D ref; *next && !isspace(*next); next++)
 			;
-		if (*ref =3D=3D '.')
-			ref++;
 		if (*ref =3D=3D '+')
 			ref++;
 		colon =3D strchr(ref, ':');
@@ -460,12 +444,11 @@ int cmd_fetch__tool(int argc, const char **argv, =
const char *prefix)
 		int result;
 		FILE *fp;
=20
-		if (argc !=3D 8)
-			return error("append-fetch-head takes 6 args");
-		fp =3D fopen(git_path("FETCH_HEAD"), "a");
+		if (argc !=3D 6)
+			return error("append-fetch-head takes 4 args");
+		fp =3D fopen(git_path("FETCH_FETCHED"), "a");
 		result =3D append_fetch_head(fp, argv[2], argv[3],
 					   argv[4], argv[5],
-					   argv[6], !!argv[7][0],
 					   verbose, force);
 		fclose(fp);
 		return result;
@@ -474,10 +457,10 @@ int cmd_fetch__tool(int argc, const char **argv, =
const char *prefix)
 		int result;
 		FILE *fp;
=20
-		if (argc !=3D 5)
-			return error("fetch-native-store takes 3 args");
-		fp =3D fopen(git_path("FETCH_HEAD"), "a");
-		result =3D fetch_native_store(fp, argv[2], argv[3], argv[4],
+		if (argc !=3D 4)
+			return error("fetch-native-store takes 2 args");
+		fp =3D fopen(git_path("FETCH_FETCHED"), "a");
+		result =3D fetch_native_store(fp, argv[2], argv[3],
 					    verbose, force);
 		fclose(fp);
 		return result;
diff --git a/git-fetch.sh b/git-fetch.sh
index 9d45dd2..58cbef1 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -79,9 +79,9 @@ do
 	shift
 done
=20
+origin=3D$(get_default_remote)
 case "$#" in
 0)
-	origin=3D$(get_default_remote)
 	test -n "$(get_remote_url ${origin})" ||
 		die "Where do you want to fetch from today?"
 	set x $origin ; shift ;;
@@ -103,6 +103,8 @@ if test "" =3D "$append"
 then
 	: >"$GIT_DIR/FETCH_HEAD"
 fi
+: >"$GIT_DIR/FETCH_FETCHED"
+trap 'rm -f "$GIT_DIR"/FETCH_FETCHED' 0 1 2 3 15
=20
 # Global that is reused later
 ls_remote_result=3D$(git ls-remote $exec "$remote") ||
@@ -145,7 +147,7 @@ then
 		  git-show-ref --exclude-existing=3Drefs/tags/ |
 	          while read sha1 name
 		  do
-			echo ".${name}:${name}"
+			echo "${name}:${name}"
 		  done` || exit
 	if test "$#" -gt 1
 	then
@@ -182,7 +184,7 @@ fetch_native () {
 	test -n "$force" && flags=3D"$flags -f"
 	GIT_REFLOG_ACTION=3D"$GIT_REFLOG_ACTION" \
 		git-fetch--tool $flags native-store \
-			"$remote" "$remote_nick" "$refs"
+			"$remote" "$refs"
       )
     ) || exit
=20
@@ -199,13 +201,6 @@ fetch_dumb () {
=20
       # These are relative path from $GIT_DIR, typically starting at r=
efs/
       # but may be HEAD
-      if expr "z$ref" : 'z\.' >/dev/null
-      then
-	  not_for_merge=3Dt
-	  ref=3D$(expr "z$ref" : 'z\.\(.*\)')
-      else
-	  not_for_merge=3D
-      fi
       if expr "z$ref" : 'z+' >/dev/null
       then
 	  single_force=3Dt
@@ -283,7 +278,7 @@ fetch_dumb () {
       esac
=20
       append_fetch_head "$head" "$remote" \
-	  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge" || exi=
t
+	  "$remote_name" "$remote_nick" "$local_name" || exit
=20
   done
=20
@@ -316,7 +311,7 @@ case "$no_tags$tags" in
 		do
 			git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
 			echo >&2 "Auto-following $name"
-			echo ".${name}:${name}"
+			echo "${name}:${name}"
 		done)
 	esac
 	case "$taglist" in
@@ -344,3 +339,62 @@ case "$orig_head" in
 	fi
 	;;
 esac
+# Generate $GIT_DIR/FETCH_HEAD
+case ",$#,$remote_nick," in
+,1,$origin,)
+	# Fetch default: merge the branches in branch.*.merge that match
+	#                the fetched ones or the first one
+	curr_branch=3D$(git-symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
+	merge_branches=3D$(git-config \
+		--get-all "branch.${curr_branch}.merge" | sort -u)
+	fetch_branches=3D$(get_remote_default_refs_for_fetch -n $remote_nick =
|
+		sed -e 's/:.*$//g' -e 's/^+//' | sort -u)
+	test -n "$merge_branches" && test -n "$fetch_branches" &&
+	merge_branches=3D$(printf '%s\n%s' "$merge_branches" "$fetch_branches=
" |
+		sort | uniq -d)
+
+	[ -z "$merge_branches" ] ||
+	test "$(get_data_source $remote_nick)" =3D branches && merge_first=3D=
yes;;
+,1,$remote,)
+	# Remote is a URL, merge the default branch HEAD
+	merge_branches=3DHEAD;;
+,1,*)
+	# Remote is a shorthand diferent from the default,
+	# merge the first fetched branch
+	merge_first=3Dyes ;;
+*)
+	# Merge the branches given in the command line
+	merge_branches=3D$(for ref in $(get_remote_refs_for_fetch "$@") ; do
+		expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
+		echo "$(expr "z$ref" : 'z\([^:]*\):')"; done);;
+esac
+
+if test "$merge_first" =3D "yes" ; then
+    merge_branches=3D
+    # Do not merge the first branch if it was specified with a glob
+    test "$(get_remote_default_refs_for_fetch -t $remote_nick)" !=3D "=
explicit" &&
+    merge_first=3D
+else
+    merge_branches=3D$(canon_refs_list_for_fetch $merge_branches | sed=
 's/:.*$//g')
+fi
+
+while IFS=3D'	' read hash ref note ; do
+	# 2.6.11-tree tag would not be happy to be fed to resolve.
+	if git-cat-file commit "$hash" >/dev/null 2>&1
+	then
+		hashc=3D$(git-rev-parse --verify "$hash^0") || exit
+		remote_branch=3D$(expr "z$ref" : 'z\([^:]*\):')
+		for merge_branch in $merge_branches ; do
+			[ "$merge_branch" =3D "$remote_branch" ] &&
+			echo "$hashc		$note" && continue 2
+		done
+	else
+		echo "$hash	not-for-merge	$note" && continue
+	fi
+	if ! test "$merge_first" || test "$merge_first" =3D "done" ; then
+		echo "$hash	not-for-merge	$note"
+	else
+		echo "$hash		$note"
+		merge_first=3Ddone
+	fi
+done < "$GIT_DIR"/FETCH_FETCHED >> "$GIT_DIR/FETCH_HEAD"
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index c46131f..99e7184 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -70,8 +70,7 @@ get_remote_default_refs_for_push () {
 	esac
 }
=20
-# Called from canon_refs_list_for_fetch -d "$remote", which
-# is called from get_remote_default_refs_for_fetch to grok
+# Called from get_remote_default_refs_for_fetch to grok
 # refspecs that are retrieved from the configuration, but not
 # from get_remote_refs_for_fetch when it deals with refspecs
 # supplied on the command line.  $ls_remote_result has the list
@@ -87,30 +86,6 @@ expand_refs_wildcard () {
=20
 # Subroutine to canonicalize remote:local notation.
 canon_refs_list_for_fetch () {
-	# If called from get_remote_default_refs_for_fetch
-	# leave the branches in branch.${curr_branch}.merge alone,
-	# or the first one otherwise; add prefix . to the rest
-	# to prevent the secondary branches to be merged by default.
-	merge_branches=3D
-	curr_branch=3D
-	if test "$1" =3D "-d"
-	then
-		shift ; remote=3D"$1" ; shift
-		set $(expand_refs_wildcard "$remote" "$@")
-		is_explicit=3D"$1"
-		shift
-		if test "$remote" =3D "$(get_default_remote)"
-		then
-			curr_branch=3D$(git-symbolic-ref -q HEAD | \
-			    sed -e 's|^refs/heads/||')
-			merge_branches=3D$(git-config \
-			    --get-all "branch.${curr_branch}.merge")
-		fi
-		if test -z "$merge_branches" && test $is_explicit !=3D explicit
-		then
-			merge_branches=3D..this.will.never.match.any.ref..
-		fi
-	fi
 	for ref
 	do
 		force=3D
@@ -123,18 +98,6 @@ canon_refs_list_for_fetch () {
 		expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
 		remote=3D$(expr "z$ref" : 'z\([^:]*\):')
 		local=3D$(expr "z$ref" : 'z[^:]*:\(.*\)')
-		dot_prefix=3D.
-		if test -z "$merge_branches"
-		then
-			merge_branches=3D$remote
-			dot_prefix=3D
-		else
-			for merge_branch in $merge_branches
-			do
-			    [ "$remote" =3D "$merge_branch" ] &&
-			    dot_prefix=3D && break
-			done
-		fi
 		case "$remote" in
 		'' | HEAD ) remote=3DHEAD ;;
 		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
@@ -153,32 +116,42 @@ canon_refs_list_for_fetch () {
 		   git-check-ref-format "$local_ref_name" ||
 		   die "* refusing to create funny ref '$local_ref_name' locally"
 		fi
-		echo "${dot_prefix}${force}${remote}:${local}"
+		echo "${force}${remote}:${local}"
 	done
 }
=20
 # Returns list of src: (no store), or src:dst (store)
 get_remote_default_refs_for_fetch () {
+	test "$1" =3D -t && type=3Dyes && shift
+	test "$1" =3D -n && canon=3Dno && shift
 	data_source=3D$(get_data_source "$1")
 	case "$data_source" in
 	'')
-		echo "HEAD:" ;;
+		set explicit "HEAD:" ;;
 	config)
-		canon_refs_list_for_fetch -d "$1" \
-			$(git-config --get-all "remote.$1.fetch") ;;
+		set $(expand_refs_wildcard "$1" \
+			$(git-config --get-all "remote.$1.fetch")) ;;
 	branches)
 		remote_branch=3D$(sed -ne '/#/s/.*#//p' "$GIT_DIR/branches/$1")
 		case "$remote_branch" in '') remote_branch=3Dmaster ;; esac
-		echo "refs/heads/${remote_branch}:refs/heads/$1"
+		set explicit "refs/heads/${remote_branch}:refs/heads/$1"
 		;;
 	remotes)
-		canon_refs_list_for_fetch -d "$1" $(sed -ne '/^Pull: */{
-						s///p
-					}' "$GIT_DIR/remotes/$1")
+		set $(expand_refs_wildcard "$1" $(sed -ne '/^Pull: */s///p'\
+					"$GIT_DIR/remotes/$1"))
 		;;
 	*)
 		die "internal error: get-remote-default-ref-for-push $1" ;;
 	esac
+	if test "$type" =3D yes ; then
+		echo $1
+	elif test "$canon" =3D no ; then
+		shift
+		for ref ; do echo "$ref" ; done
+	else
+		shift
+		canon_refs_list_for_fetch "$@"
+	fi
 }
=20
 get_remote_refs_for_push () {
--=20
1.5.0.3.897.g91a70-dirty
