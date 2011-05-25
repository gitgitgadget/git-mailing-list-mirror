From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 5/6] i18n win32: add git-submodule eval_gettext variable prefix
Date: Wed, 25 May 2011 23:19:53 +0000
Message-ID: <1306365594-22061-6-git-send-email-avarab@gmail.com>
References: <1306365594-22061-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 01:20:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPNNY-00086c-S9
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 01:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186Ab1EYXUW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 19:20:22 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64480 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab1EYXUH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 19:20:07 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so106217eyx.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 16:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=PSJWtZ/Y/08OI15KfkmWy/fW+YcadWWQAxr4Tfw6x0c=;
        b=OTBsHQx5HFQfY8+NdUPv+m2Ma+RPX+651Bz2grnlb+eUqgwZE/PYctJIFV46yuhTIx
         //nP2rsidpvTzuSvXmG7Hfw9cvSBVcwRUAw6PURjMS/uG1JjQKDxRPZyF8bFvbrY7HMv
         DOJlegbEkBeJjeNvqQtKtl8RkacGgD9rjJzGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cz7aRnCcqfezqvSuROOtpRnSW7n1KhxxUHqQ+fP6wf+INfefT+gws3UUJ6tT7WsGt8
         j5mQywfRUpWvCH3B8eUcn9eYfXi/uuMIx7wcdTtxGnYcy/CfUrt3QrZmCh0vB0sK4ovc
         dOkxiaTIbNiY2b5cD55ldByHPJofyVz4CuM5Y=
Received: by 10.14.2.76 with SMTP id 52mr64656eee.11.1306365606697;
        Wed, 25 May 2011 16:20:06 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b1sm102972eeg.19.2011.05.25.16.20.05
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 16:20:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306365594-22061-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174480>

Change the eval_gettext() invocations to use the GIT_I18N_VARIABLE_
prefix for variables used in eval_gettext. On Windows environment
variables are case insensitive, so e.g. $PATH clashes with $path. By
using a sufficiently unique prefix we work around that issue.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |  151 ++++++++++++++++++++++++++++++++++++----------=
-------
 1 files changed, 102 insertions(+), 49 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c1d3a5e..dea4f63 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -34,8 +34,10 @@ prefix=3D
 resolve_relative_url ()
 {
 	remote=3D$(get_default_remote)
-	remoteurl=3D$(git config "remote.$remote.url") ||
-		die "$(eval_gettext "remote (\$remote) does not have a url defined i=
n .git/config")"
+	remoteurl=3D$(git config "remote.$remote.url") || {
+		GIT_I18N_VARIABLE_remote=3D$(get_default_remote)
+		die "$(eval_gettext "remote (\$GIT_I18N_VARIABLE_remote) does not ha=
ve a url defined in .git/config")"
+	}
 	url=3D"$1"
 	remoteurl=3D${remoteurl%/}
 	sep=3D/
@@ -53,7 +55,8 @@ resolve_relative_url ()
 				sep=3D:
 				;;
 			*)
-				die "$(eval_gettext "cannot strip one component off url '\$remoteu=
rl'")"
+				GIT_I18N_VARIABLE_remoteurl=3D$remoteurl
+				die "$(eval_gettext "cannot strip one component off url '\$GIT_I18=
N_VARIABLE_remoteurl'")"
 				;;
 			esac
 			;;
@@ -104,9 +107,12 @@ module_name()
 	re=3D$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
 	name=3D$( git config -f .gitmodules --get-regexp '^submodule\..*\.pat=
h$' |
 		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
-       test -z "$name" &&
-       die "$(eval_gettext "No submodule mapping found in .gitmodules =
for path '\$path'")"
-       echo "$name"
+	if test -z "$name"
+	then
+		GIT_I18N_VARIABLE_path=3D$path
+		die "$(eval_gettext "No submodule mapping found in .gitmodules for p=
ath '\$GIT_I18N_VARIABLE_path'")"
+	fi
+	echo "$name"
 }
=20
 #
@@ -128,8 +134,11 @@ module_clone()
 		git-clone "$reference" -n "$url" "$path"
 	else
 		git-clone -n "$url" "$path"
-	fi ||
-	die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' fa=
iled")"
+	fi || {
+		GIT_I18N_VARIABLE_url=3D$url
+		GIT_I18N_VARIABLE_path=3D$path
+		die "$(eval_gettext "Clone of '\$GIT_I18N_VARIABLE_url' into submodu=
le path '\$GIT_I18N_VARIABLE_path' failed")"
+	}
 }
=20
 #
@@ -202,7 +211,8 @@ cmd_add()
 		realrepo=3D$repo
 		;;
 	*)
-		die "$(eval_gettext "repo URL: '\$repo' must be absolute or begin wi=
th ./|../")"
+		GIT_I18N_VARIABLE_repo=3D$repo
+		die "$(eval_gettext "repo URL: '\$GIT_I18N_VARIABLE_repo' must be ab=
solute or begin with ./|../")"
 	;;
 	esac
=20
@@ -218,14 +228,18 @@ cmd_add()
 			tstart
 			s|/*$||
 		')
-	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
-	die "$(eval_gettext "'\$path' already exists in the index")"
+	if git ls-files --error-unmatch "$path" > /dev/null 2>&1
+	then
+		GIT_I18N_VARIABLE_path=3D$path
+		die "$(eval_gettext "'\$GIT_I18N_VARIABLE_path' already exists in th=
e index")"
+	fi
=20
 	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" >=
 /dev/null 2>&1
 	then
 		(
+			GIT_I18N_VARIABLE_path=3D$path
 			eval_gettext "The following path is ignored by one of your .gitigno=
re files:
-\$path
+\$GIT_I18N_VARIABLE_path
 Use -f if you really want to add it." &&
 			echo
 		) >&2
@@ -237,9 +251,11 @@ Use -f if you really want to add it." &&
 	then
 		if test -d "$path"/.git -o -f "$path"/.git
 		then
-			eval_gettext "Adding existing repo at '\$path' to the index"; echo
+			GIT_I18N_VARIABLE_path=3D$path
+			eval_gettext "Adding existing repo at '\$GIT_I18N_VARIABLE_path' to=
 the index"; echo
 		else
-			die "$(eval_gettext "'\$path' already exists and is not a valid git=
 repo")"
+			GIT_I18N_VARIABLE_path=3D$path		=09
+			die "$(eval_gettext "'\$GIT_I18N_VARIABLE_path' already exists and =
is not a valid git repo")"
 		fi
=20
 		case "$repo" in
@@ -262,16 +278,22 @@ Use -f if you really want to add it." &&
 			'') git checkout -f -q ;;
 			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
 			esac
-		) || die "$(eval_gettext "Unable to checkout submodule '\$path'")"
+		) || {
+			GIT_I18N_VARIABLE_path=3D$path
+			die "$(eval_gettext "Unable to checkout submodule '\$GIT_I18N_VARIA=
BLE_path'")"
+		}
 	fi
=20
-	git add $force "$path" ||
-	die "$(eval_gettext "Failed to add submodule '\$path'")"
+	git add $force "$path" || {
+		die "$(eval_gettext "Failed to add submodule '\$GIT_I18N_VARIABLE_pa=
th'")"
+	}
=20
 	git config -f .gitmodules submodule."$path".path "$path" &&
 	git config -f .gitmodules submodule."$path".url "$repo" &&
-	git add --force .gitmodules ||
-	die "$(eval_gettext "Failed to register submodule '\$path'")"
+	git add --force .gitmodules || {
+		GIT_I18N_VARIABLE_path=3D$path
+		die "$(eval_gettext "Failed to register submodule '\$GIT_I18N_VARIAB=
LE_path'")"
+	}
 }
=20
 #
@@ -309,7 +331,9 @@ cmd_foreach()
 	do
 		if test -e "$path"/.git
 		then
-			say "$(eval_gettext "Entering '\$prefix\$path'")"
+			GIT_I18N_VARIABLE_prefix=3D$prefix
+			GIT_I18N_VARIABLE_path=3D$path
+			say "$(eval_gettext "Entering '\$GIT_I18N_VARIABLE_prefix\$GIT_I18N=
_VARIABLE_path'")"
 			name=3D$(module_name "$path")
 			(
 				prefix=3D"$prefix$path/"
@@ -321,7 +345,7 @@ cmd_foreach()
 					cmd_foreach "--recursive" "$@"
 				fi
 			) ||
-			die "$(eval_gettext "Stopping at '\$path'; script returned non-zero=
 status.")"
+			die "$(eval_gettext "Stopping at '\$GIT_I18N_VARIABLE_path'; script=
 returned non-zero status.")"
 		fi
 	done
 }
@@ -363,8 +387,11 @@ cmd_init()
 		test -z "$url" || continue
=20
 		url=3D$(git config -f .gitmodules submodule."$name".url)
-		test -z "$url" &&
-		die "$(eval_gettext "No url found for submodule path '\$path' in .gi=
tmodules")"
+		if test -z "$url"
+		then
+			GIT_I18N_VARIABLE_path=3D$path
+			die "$(eval_gettext "No url found for submodule path '\$GIT_I18N_VA=
RIABLE_path' in .gitmodules")"
+		fi
=20
 		# Possibly a url relative to parent
 		case "$url" in
@@ -373,15 +400,24 @@ cmd_init()
 			;;
 		esac
=20
-		git config submodule."$name".url "$url" ||
-		die "$(eval_gettext "Failed to register url for submodule path '\$pa=
th'")"
+		if ! git config submodule."$name".url "$url"
+		then
+			GIT_I18N_VARIABLE_path=3D$path
+			die "$(eval_gettext "Failed to register url for submodule path '\$G=
IT_I18N_VARIABLE_path'")"
+		fi
=20
 		upd=3D"$(git config -f .gitmodules submodule."$name".update)"
 		test -z "$upd" ||
-		git config submodule."$name".update "$upd" ||
-		die "$(eval_gettext "Failed to register update mode for submodule pa=
th '\$path'")"
+		if ! git config submodule."$name".update "$upd"
+		then
+			GIT_I18N_VARIABLE_path=3D$path
+			die "$(eval_gettext "Failed to register update mode for submodule p=
ath '\$GIT_I18N_VARIABLE_path'")"
+		fi
=20
-		say "$(eval_gettext "Submodule '\$name' (\$url) registered for path =
'\$path'")"
+		GIT_I18N_VARIABLE_name=3D$name
+		GIT_I18N_VARIABLE_url=3D$url
+		GIT_I18N_VARIABLE_path=3D$path
+		say "$(eval_gettext "Submodule '\$GIT_I18N_VARIABLE_name' (\$GIT_I18=
N_VARIABLE_url) registered for path '\$GIT_I18N_VARIABLE_path'")"
 	done
 }
=20
@@ -463,9 +499,11 @@ cmd_update()
 		then
 			# Only mention uninitialized submodules when its
 			# path have been specified
-			test "$#" !=3D "0" &&
-			say "$(eval_gettext "Submodule path '\$path' not initialized
+			if test "$#" !=3D "0"
+			then
+				say "$(eval_gettext "Submodule path '\$GIT_I18N_VARIABLE_path' not=
 initialized
 Maybe you want to use 'update --init'?")"
+			fi
 			continue
 		fi
=20
@@ -476,8 +514,10 @@ Maybe you want to use 'update --init'?")"
 			subsha1=3D
 		else
 			subsha1=3D$(clear_local_git_env; cd "$path" &&
-				git rev-parse --verify HEAD) ||
-			die "$(eval_gettext "Unable to find current revision in submodule p=
ath '\$path'")"
+				git rev-parse --verify HEAD) || {
+				GIT_I18N_VARIABLE_path=3D$path
+				die "$(eval_gettext "Unable to find current revision in submodule =
path '\$GIT_I18N_VARIABLE_path'")"
+			}
 		fi
=20
 		if ! test -z "$update"
@@ -500,8 +540,10 @@ Maybe you want to use 'update --init'?")"
 				# is not reachable from a ref.
 				(clear_local_git_env; cd "$path" &&
 					((rev=3D$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
-					 test -z "$rev") || git-fetch)) ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$path'")"
+					 test -z "$rev") || git-fetch)) || {
+					GIT_I18N_VARIABLE_path=3D$path
+					die "$(eval_gettext "Unable to fetch in submodule path '\$GIT_I18=
N_VARIABLE_path'")"
+				}
 			fi
=20
 			# Is this something we just cloned?
@@ -511,21 +553,23 @@ Maybe you want to use 'update --init'?")"
 				update_module=3D ;;
 			esac
=20
+			GIT_I18N_VARIABLE_path=3D$path
+			GIT_I18N_VARIABLE_sha1=3D$sha1
 			case "$update_module" in
 			rebase)
 				command=3D"git rebase"
-				die_msg=3D"$(eval_gettext "Unable to rebase '\$sha1' in submodule =
path '\$path'")"
-				say_msg=3D"$(eval_gettext "Submodule path '\$path': rebased into '=
\$sha1'")"
+				die_msg=3D"$(eval_gettext "Unable to rebase '\$GIT_I18N_VARIABLE_s=
ha1' in submodule path '\$GIT_I18N_VARIABLE_path'")"
+				say_msg=3D"$(eval_gettext "Submodule path '\$GIT_I18N_VARIABLE_pat=
h': rebased into '\$GIT_I18N_VARIABLE_sha1'")"
 				;;
 			merge)
 				command=3D"git merge"
-				die_msg=3D"$(eval_gettext "Unable to merge '\$sha1' in submodule p=
ath '\$path'")"
-				say_msg=3D"$(eval_gettext "Submodule path '\$path': merged in '\$s=
ha1'")"
+				die_msg=3D"$(eval_gettext "Unable to merge '\$GIT_I18N_VARIABLE_sh=
a1' in submodule path '\$GIT_I18N_VARIABLE_path'")"
+				say_msg=3D"$(eval_gettext "Submodule path '\$GIT_I18N_VARIABLE_pat=
h': merged in '\$GIT_I18N_VARIABLE_sha1'")"
 				;;
 			*)
 				command=3D"git checkout $subforce -q"
-				die_msg=3D"$(eval_gettext "Unable to checkout '\$sha1' in submodul=
e path '\$path'")"
-				say_msg=3D"$(eval_gettext "Submodule path '\$path': checked out '\=
$sha1'")"
+				die_msg=3D"$(eval_gettext "Unable to checkout '\$GIT_I18N_VARIABLE=
_sha1' in submodule path '\$GIT_I18N_VARIABLE_path'")"
+				say_msg=3D"$(eval_gettext "Submodule path '\$GIT_I18N_VARIABLE_pat=
h': checked out '\$GIT_I18N_VARIABLE_sha1'")"
 				;;
 			esac
=20
@@ -535,8 +579,10 @@ Maybe you want to use 'update --init'?")"
=20
 		if test -n "$recursive"
 		then
-			(clear_local_git_env; cd "$path" && eval cmd_update "$orig_flags") =
||
-			die "$(eval_gettext "Failed to recurse into submodule path '\$path'=
")"
+			(clear_local_git_env; cd "$path" && eval cmd_update "$orig_flags") =
|| {
+				GIT_I18N_VARIABLE_path=3D$path
+				die "$(eval_gettext "Failed to recurse into submodule path '\$GIT_=
I18N_VARIABLE_path'")"
+			}
 		fi
 	done
 }
@@ -661,7 +707,8 @@ cmd_summary() {
 			*)
 				# unexpected type
 				(
-					eval_gettext "unexpected mode \$mod_dst" &&
+					GIT_I18N_VARIABLE_mod_dst=3D$mod_dst
+					eval_gettext "unexpected mode \$GIT_I18N_VARIABLE_mod_dst" &&
 					echo
 				) >&2
 				continue ;;
@@ -679,15 +726,18 @@ cmd_summary() {
 		missing_dst=3Dt
=20
 		total_commits=3D
+		GIT_I18N_VARIABLE_name=3D$name
+		GIT_I18N_VARIABLE_sha1_src=3D$sha1_src
+		GIT_I18N_VARIABLE_sha1_dst=3D$sha1_dst
 		case "$missing_src,$missing_dst" in
 		t,)
-			errmsg=3D"$(eval_gettext "  Warn: \$name doesn't contain commit \$s=
ha1_src")"
+			errmsg=3D"$(eval_gettext "  Warn: \$GIT_I18N_VARIABLE_name doesn't =
contain commit \$GIT_I18N_VARIABLE_sha1_src")"
 			;;
 		,t)
-			errmsg=3D"$(eval_gettext "  Warn: \$name doesn't contain commit \$s=
ha1_dst")"
+			errmsg=3D"$(eval_gettext "  Warn: \$GIT_I18N_VARIABLE_name doesn't =
contain commit \$GIT_I18N_VARIABLE_sha1_dst")"
 			;;
 		t,t)
-			errmsg=3D"$(eval_gettext "  Warn: \$name doesn't contain commits \$=
sha1_src and \$sha1_dst")"
+			errmsg=3D"$(eval_gettext "  Warn: \$GIT_I18N_VARIABLE_name doesn't =
contain commits \$GIT_I18N_VARIABLE_sha1_src and \$sha1_dst")"
 			;;
 		*)
 			errmsg=3D
@@ -837,8 +887,10 @@ cmd_status()
 				clear_local_git_env
 				cd "$path" &&
 				eval cmd_status "$orig_args"
-			) ||
-			die "$(eval_gettext "Failed to recurse into submodule path '\$path'=
")"
+			) || {
+				GIT_I18N_VARIABLE_path=3D$path
+				die "$(eval_gettext "Failed to recurse into submodule path '\$GIT_=
I18N_VARIABLE_path'")"
+			}
 		fi
 	done
 }
@@ -882,7 +934,8 @@ cmd_sync()
 			;;
 		esac
=20
-		say "$(eval_gettext "Synchronizing submodule url for '\$name'")"
+		GIT_I18N_VARIABLE_name=3D$name
+		say "$(eval_gettext "Synchronizing submodule url for '\$GIT_I18N_VAR=
IABLE_name'")"
 		git config submodule."$name".url "$url"
=20
 		if test -e "$path"/.git
--=20
1.7.5.1
