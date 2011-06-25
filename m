From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodule add: always initialize .git/config entry
Date: Sun, 26 Jun 2011 01:26:02 +0200
Message-ID: <4E066E8A.7060209@web.de>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com> <7v7h8c4nv3.fsf@alter.siamese.dyndns.org> <4E0390A7.8040505@web.de> <7vboxo2ne9.fsf@alter.siamese.dyndns.org> <7vy60r27et.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <hordp@cisco.com>, Maarten Billemont <lhunath@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Andreas_K=F6hler?= <andi5.py@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 26 01:27:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QacG6-0001JG-Dh
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 01:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab1FYX0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jun 2011 19:26:30 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40839 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab1FYX03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2011 19:26:29 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 4B8E81920EA5D;
	Sun, 26 Jun 2011 01:26:03 +0200 (CEST)
Received: from [93.246.44.86] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QacEk-0003mT-00; Sun, 26 Jun 2011 01:26:02 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vy60r27et.fsf_-_@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19OoVxvlTBPmqwJtsKM9kaQ6bMbTLonAmdXvYcC
	N99uTxX0gFot3gDbkgqD+QYauVRDXrgf1ppHX86F9rZmBT7A1w
	73MSUg3FVo8NfzqTAz6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176320>

When "git submodule add $path" is run to add a subdirectory $path to the
superproject, and $path is already the top of the working tree of the
submodule repository, the command created submodule.$path.url entry in the
configuration file in the superproject. However, when adding a repository
$URL that is outside the respository of the superproject to $path that
does not exist (yet) with "git submodule add $URL $path", the command
forgot to set it up.

The user is expressing the interest in the submodule and wants to keep a
checkout, the "submodule add" command should consistently set up the
submodule.$path.url entry in either case.

As a result "git submodule init" can't simply skip the initialization of
those submodules for which it finds an url entry in the git./config
anymore. That lead to problems when adding a submodule (which now sets the
url), add the "update" setting to .gitmodules and expect init to copy that
into .git/config like it is done in t7406. So change init to only then
copy the "url" and "update" entries when they don't exist yet in the
.git/config and do nothing otherwise.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 24.06.2011 06:13, schrieb Junio C Hamano:
> Shouldn't "submodule add" add an entry for .git/config even when it cloned
> from elsewhere?

Yes, we should be consistent here.

> I suspect this fix will cascade to breakage elsewhere, but I've run out of
> energy and inclination to look at the submodule code tonight, so I'll let
> the list to take it further from here.

Ok, t7406 expected "git submodule init" to copy the new update setting
into .git/config for a newly added submodule, which it didn't do anymore
because it already found the url set. I solved that by teaching init to
only then copy the url and update settings if they aren't present yet.
Now all tests are running fine and your change to the test I added in
jl/submodule-add-relurl-wo-upstream isn't necessary anymore.

When I cherry pick that onto cbd0a3c6bc in your current pu branch and
resolve the conflicts all tests run fine (if you want me to resend this
patch based on that commit to avoid the conflicts with i18n and the
"submodule add: clean up duplicated code" patch please just say so).


 git-submodule.sh |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 543f1d0..7e39c97 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -246,7 +246,6 @@ cmd_add()
 			url="$repo"
 			;;
 		esac
-		git config submodule."$path".url "$url"
 	else

 		module_clone "$path" "$realrepo" "$reference" || exit
@@ -260,6 +259,7 @@ cmd_add()
 			esac
 		) || die "Unable to checkout submodule '$path'"
 	fi
+	git config submodule."$path".url "$url"

 	git add $force "$path" ||
 	die "Failed to add submodule '$path'"
@@ -355,25 +355,26 @@ cmd_init()
 	do
 		# Skip already registered paths
 		name=$(module_name "$path") || exit
-		url=$(git config submodule."$name".url)
-		test -z "$url" || continue
-
-		url=$(git config -f .gitmodules submodule."$name".url)
-		test -z "$url" &&
-		die "No url found for submodule path '$path' in .gitmodules"
-
-		# Possibly a url relative to parent
-		case "$url" in
-		./*|../*)
-			url=$(resolve_relative_url "$url") || exit
-			;;
-		esac
-
-		git config submodule."$name".url "$url" ||
-		die "Failed to register url for submodule path '$path'"
+		if test -z "$(git config "submodule.$name.url")"
+		then
+			url=$(git config -f .gitmodules submodule."$name".url)
+			test -z "$url" &&
+			die "No url found for submodule path '$path' in .gitmodules"
+
+			# Possibly a url relative to parent
+			case "$url" in
+			./*|../*)
+				url=$(resolve_relative_url "$url") || exit
+				;;
+			esac
+			git config submodule."$name".url "$url" ||
+			die "Failed to register url for submodule path '$path'"
+		fi

+		# Copy "update" setting when it is not set yet
 		upd="$(git config -f .gitmodules submodule."$name".update)"
 		test -z "$upd" ||
+		test -n "$(git config submodule."$name".update)" ||
 		git config submodule."$name".update "$upd" ||
 		die "Failed to register update mode for submodule path '$path'"

-- 
1.7.6.rc3.2.gcfa18
