From: "W. Trevor King" <wking@tremily.us>
Subject: [RFC] git-submodule update: Add --commit option
Date: Thu, 29 Nov 2012 11:12:17 -0500
Message-ID: <20121129161216.GB23580@odin.tremily.us>
References: <20121127185142.GB4185@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=wq9mPyueHGvFACwf
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 17:13:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te6jY-0004D1-5X
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 17:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059Ab2K2QMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 11:12:47 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:27992 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab2K2QMq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 11:12:46 -0500
Received: from odin.tremily.us ([unknown] [72.68.105.242])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME900IXOBOH8550@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 29 Nov 2012 10:12:19 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 46D0B6E234E; Thu,
 29 Nov 2012 11:12:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354205537; bh=FjUvRFDLBnViRwDmjeYY5vpGqQ64guiE9uKG5BOB5+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=J0lbxB5cGm0uNo+W3AcjSBKp/OZaVPP6UDVyNwABnfEO7A+1JGlEbsrMvzmrUcDKU
 E60KzoNkPQyPe/3Qx/h+lkAckdWatiHSRsc8Ol3TF/ZSz2gcnzY0oDx6c5purN5PGm
 Ta0R//MLB8LE1SpyYwxjoXNk8g7A7e0g0BEDMv6U=
Content-disposition: inline
In-reply-to: <20121127185142.GB4185@book.hvoigt.net>
 <cover.1354130656.git.wking@tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210839>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This option triggers automatic commits when `submodule update` changes
any gitlinked submodule SHA-1s.  The commit message contains a
`shortlog` summary of the changes for each changed submodule.
---

On Tue, Nov 27, 2012 at 07:51:42PM +0100, Heiko Voigt wrote:
> BTW, I am more and more convinced that an automatically manufactured
> commit on update with --branch should be the default. What do other
> think? Sascha raised a concern that he would not want this, but as far as
> I understood he let the CI-server do that so I see no downside to
> natively adding that to git. People who want to manually craft those
> commits can still amend the generated commit. Since this is all about
> helping people keeping their submodules updated why not go the full way?

Here's a first pass (without documentation) for automatic commits on
submodule updates.  There have been a number of requests for
automatically-committed submodule updates due to submodule upstreams.
This patch shows how you can do that (if applied with my `submodule
update --remote` series), and reuse the same logic to automatically
commit changes due to local submodule changes (as shown here in the
new test).

I think the logic is pretty good, but the implementation is pretty
ugly due to POSIX shell variable limitations.  I'm basically trying to
pass an array of [(name, sm_path, sha1, subsha1), ...] into
commit_changes().  I though about perling-out in commit_changes(), but
I lack sufficient perl-fu to know how to tie clear_local_git_env, cd,
and shortlog up in a single open2 call.  If anyone can give me some
implementation pointers, that would be very helpful.

This is against v1.8.0 (without my --remote series).  To apply on top
of the --remote series, you'd have to save the original gitlinked
$sha1 and use that original value when constructing changed_modules.
I can attach this to the end of the --remote series if desired, but I
think this patch could also stand on its own.

Obviously this still needs documentation, etc., but I wanted feedback
on the implementation before I started digging into that.

Cheers,
Trevor

---
 git-submodule.sh            | 67 +++++++++++++++++++++++++++++++++++++++++=
+++-
 t/t7406-submodule-update.sh | 19 +++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..d9a59af 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,7 +8,7 @@ dashless=3D$(basename "$0" | sed -e 's/-/ /')
 USAGE=3D"[--quiet] add [-b branch] [-f|--force] [--reference <repository>]=
 [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [-=
-rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [-=
-commit] [--rebase] [--reference <repository>] [--merge] [--recursive] [--]=
 [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>=
] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--] [<path>...]"
@@ -21,6 +21,7 @@ require_work_tree
 command=3D
 branch=3D
 force=3D
+commit=3D
 reference=3D
 cached=3D
 recursive=3D
@@ -240,6 +241,52 @@ module_clone()
 }
=20
 #
+# Commit changed submodule gitlinks
+#
+# $1 =3D name-a;sha1-a;subsha1-a\n[name-b;sha1-b;subsha1-b\n...]
+#
+commit_changes()
+{
+	echo "commiting $1"
+	OIFS=3D"$IFS"
+	IFS=3D";"
+	paths=3D$(echo "$1" |
+		while read name sm_path sha1 subsha1
+		do
+			echo "$sm_path"
+		done
+		)
+	names=3D$(echo "$1" |
+		while read name sm_path sha1 subsha1
+		do
+			printf ' %s' "$name"
+		done
+		)
+	summary=3D"$(eval_gettext "Updated submodules:")$names"
+	body=3D$(echo "$1" |
+		while read name sm_path sha1 subsha1
+		do
+			if test "$name" =3D "$sm_path"
+			then
+				printf 'Changes to %s:\n\n' "$name"
+			else
+				printf 'Changes to %s (%s):\n\n' "$name" "$sm_path"
+			fi
+			(
+				clear_local_git_env
+				cd "$sm_path" &&
+				git shortlog "${sha1}..${subsha1}" ||
+				die "$(eval_gettext "Unable to generate shortlog in submodule path '\$=
sm_path'")"
+			)
+		done
+		)
+	IFS=3D"$OIFS"
+	message=3D"$(printf '%s\n\n%s\n' "$summary" "$body")"
+	echo "message: [$message]"
+	git commit -m "$message" $paths
+}
+
+#
 # Add a new submodule to the working tree, .gitmodules and the index
 #
 # $@ =3D repo path
@@ -515,6 +562,9 @@ cmd_update()
 		-f|--force)
 			force=3D$1
 			;;
+		--commit)
+			commit=3D1
+			;;
 		-r|--rebase)
 			update=3D"rebase"
 			;;
@@ -557,6 +607,7 @@ cmd_update()
 	fi
=20
 	cloned_modules=3D
+	changed_modules=3D
 	module_list "$@" | {
 	err=3D
 	while read mode sha1 stage sm_path
@@ -660,6 +711,15 @@ Maybe you want to use 'update --init'?")"
 				err=3D"${err};$die_msg"
 				continue
 			fi
+
+			subsha1=3D$(clear_local_git_env; cd "$sm_path" &&
+				git rev-parse --verify HEAD) ||
+			die "$(eval_gettext "Unable to find new revision in submodule path '\$s=
m_path'")"
+
+			if test "$subsha1" !=3D "$sha1"
+			then
+				changed_modules=3D$(printf '%s%s\n' "$changed_modules" "$name;$sm_path=
;$sha1;$subsha1")
+			fi
 		fi
=20
 		if test -n "$recursive"
@@ -680,6 +740,11 @@ Maybe you want to use 'update --init'?")"
 		fi
 	done
=20
+	if test -z "$err" -a -n "$commit" -a -n "$changed_modules"
+	then
+		commit_changes "$changed_modules"
+	fi
+
 	if test -n "$err"
 	then
 		OIFS=3D$IFS
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 1542653..4c8bb5d 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -163,6 +163,25 @@ test_expect_success 'submodule update --merge staying =
on master' '
 	)
 '
=20
+test_expect_success 'submodule update --commit --rebase should commit gitl=
ink changes' '
+	(cd super/submodule &&
+	 git reset --hard HEAD~1 &&
+	 echo "local change" > local-file &&
+	 git add local-file &&
+	 test_tick &&
+	 git commit -m "local change"
+	) &&
+	(cd super &&
+	 git submodule update --commit --rebase submodule &&
+	 test "$(git log -1 --oneline)" =3D "bbdbe2d Updated submodules: submodul=
e"
+	) &&
+	(cd submodule &&
+	 git remote add super-submodule ../super/submodule &&
+	 git pull super-submodule master
+	) &&
+  test "a" =3D "b"
+'
+
 test_expect_success 'submodule update - rebase in .git/config' '
 	(cd super &&
 	 git config submodule.submodule.update rebase
--=20
1.8.0.1.gaaf2ac7.dirty

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQt4leAAoJEEUbTsx0l5OMG/IP/RROCTFpSIvllcelYhTmgISz
QSktqJCKQD8t0NGZedXf4euPl0PYT5duXKZqYpO2pkjvyETMJcapNwFpbdPRxcFC
1MdjZeiZ1FkUhs1oFOxOIPIVRHXiVUhly51kaXBZKdpPN3dTnLZm0yhpG/05hqkR
YPCP0gAS3aV0z1n3aCDuiutmcyzJjveI9pi6KsQIApT71+yPmKCV6HpunYzWKFI6
yScmwouDllmj03Pc2CAole0ybpepvPMhBdV+nglYbfw4PrJsUfEjvEKeXbXwfeWG
lwRVbGgHSgp9qP+WwhK0UQy4W0tbg7Gao4O+toaxdYLCvLsJmGYekiGncC23JjBr
E1GZWAOjo2vCCYFViy6tE9HKxu1EfbbOkRa1n3YN4TJXKga5FjZ5r8JhovB975gn
zmvxQAMhGjYYc0XVwoXY4IFFiVKSyaQlcv9vE6QBQBbjoqQQsizuH90kR9e94EM4
nlSJvHHfn4441LIQiBfotASoViuD1zb1MSe+qAiNDNX6kJuOeoPE2NXFZkizIR4A
jZZi4MYnq6OiMwNzvtPvoRHD5GK1Opz7ANWqjGb8pwlE3Q3zPPvacBAbbblMkPv0
HtDGj+4Riap/GMeirB1jM4qmZ/PldBRp6H9GyLkL2+Ojq66GNjOnFSFIvuD1X1OE
WRDP3nS0EmZ4FNp3G9au
=yEPx
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
