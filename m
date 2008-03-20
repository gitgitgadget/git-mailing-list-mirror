From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] filter-branch.sh: support nearly proper tag name filtering
Date: Thu, 20 Mar 2008 12:02:29 -0500
Message-ID: <47E298A5.6050508@nrlssc.navy.mil>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 18:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcOAu-0000cq-Ux
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 18:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757528AbYCTRCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 13:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757427AbYCTRCs
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 13:02:48 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54846 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757381AbYCTRCr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 13:02:47 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2KH2T3o015764;
	Thu, 20 Mar 2008 12:02:31 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 20 Mar 2008 12:02:29 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil>
X-OriginalArrivalTime: 20 Mar 2008 17:02:29.0635 (UTC) FILETIME=[2E546530:01C88AAC]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15792001
X-TM-AS-Result: : Yes--15.441900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwNDQyMS03MDQ0?=
	=?us-ascii?B?MjUtNzExNjEyLTcwMDQ3Ni03MDM5NjktNzAzNzg4LTcwMDYzMC03?=
	=?us-ascii?B?MDEyMjAtNzAxMjM2LTcwMDE2MC03MDIxOTAtMTEzMjI4LTcwNjEx?=
	=?us-ascii?B?NC03MDcxMzctMTIxNjI0LTcwNDQxMC0xODgwMTktNzAyMzU4LTcw?=
	=?us-ascii?B?ODI1Ny03MDIxNDMtNzAzNzEyLTcwMTQ1NS03MDQ5MzAtNzA2MjQ5?=
	=?us-ascii?B?LTcwOTU4NC03MDQ5MjctNzAwMTMzLTcwMDk0OS0xMjE2MjgtMTA2?=
	=?us-ascii?B?MzkwLTcwNjQ1NC03MDM2NTctMTA2NDIwLTcwMTk0MC03MDU5MDEt?=
	=?us-ascii?B?NzAyNTUxLTcwNzc1MC03MDA5NzEtNzAwNzAxLTgzNDY2OC0xMjEz?=
	=?us-ascii?B?MzgtNzAwMzI0LTcwMDk3MC03MDMxODctNzAyNTk4LTEzOTYyOS03?=
	=?us-ascii?B?MDAwNzMtNzAwNjQ4LTE4ODE5OS03MDU0NTAtMTQ4MDM5LTE0ODA1?=
	=?us-ascii?B?MS0xMDAwMw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77675>

Add support for creating a new tag object and retaining the tag message,
author, and date when rewriting tags. The gpg signature, if one exists,
will be stripped.

This adds nearly proper tag name filtering to filter-branch. Proper tag
name filtering would include the ability to change the tagger, tag date,
tag message, and _not_ strip a gpg signature if the tag did not change.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


I went back and forth over stripping the gpg signature or just leaving
it intact and creating a new tag with the invalid signature. I ended
up stripping it, and printing a message saying it was stripped along
with the original tag object's sha1.

Portability comments?

-brandon


 Documentation/git-filter-branch.txt |   14 ++++++++++----
 git-filter-branch.sh                |   14 ++++++++++++--
 t/t7003-filter-branch.sh            |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 543a1cf..9364919 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -132,10 +132,16 @@ use "--tag-name-filter cat" to simply update the tags.  In this
 case, be very careful and make sure you have the old tags
 backed up in case the conversion has run afoul.
 +
-Note that there is currently no support for proper rewriting of
-tag objects; in layman terms, if the tag has a message or signature
-attached, the rewritten tag won't have it.  Sorry.  (It is by
-definition impossible to preserve signatures at any rate.)
+Nearly proper rewriting of tag objects is supported. If the tag has
+a message attached, a new tag object will be created with the same message,
+author, and timestamp. If the tag has a signature attached, the
+signature will be stripped. It is by definition impossible to preserve
+signatures. The reason this is "nearly" proper, is because ideally if
+the tag did not change (points to the same object, has the same name, etc.)
+it should retain any signature. That is not the case, signatures will always
+be removed, buyer beware. There is also no support for changing the
+author or timestamp (or the tag message for that matter). Tags which point
+to other tags will be rewritten to point to the underlying commit.
 
 --subdirectory-filter <directory>::
 	Only look at the history which touches the given subdirectory.
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 22b6ed4..12d5a25 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -406,8 +406,18 @@ if [ "$filter_tag_name" ]; then
 		echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
 
 		if [ "$type" = "tag" ]; then
-			# Warn that we are not rewriting the tag object itself.
-			warn "unreferencing tag object $sha1t"
+			new_sha1=$(git cat-file tag "$ref" | \
+				sed -e "1c\object $new_sha1" \
+				    -e '2c\type commit'      \
+				    -e "3c\tag $new_ref"     \
+				    -e '/^-----BEGIN PGP SIGNATURE-----/Q' | \
+				git mktag) ||
+				die "Could not create new tag object for $ref"
+			if git cat-file tag "$ref" | \
+			   grep '^-----BEGIN PGP SIGNATURE-----' >/dev/null 2>&1
+			then
+				warn "gpg signature stripped from tag object $sha1t"
+			fi
 		fi
 
 		git update-ref "refs/tags/$new_ref" "$new_sha1" ||
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 6827249..1daaf54 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -203,4 +203,36 @@ test_expect_success 'Subdirectory filter with disappearing trees' '
 	test $(git rev-list master | wc -l) = 3
 '
 
+test_expect_success 'Tag name filtering retains tag message' '
+	git tag -m atag T &&
+	git cat-file tag T > expect &&
+	git filter-branch -f --tag-name-filter cat &&
+	git cat-file tag T > actual &&
+	git diff expect actual
+'
+
+faux_gpg_tag='object XXXXXX
+type commit
+tag S
+tagger T A Gger <tagger@example.com> 1206026339 -0500
+
+This is a faux gpg signed tag.
+-----BEGIN PGP SIGNATURE-----
+Version: FauxGPG v0.0.0 (FAUX/Linux)
+
+gdsfoewhxu/6l06f1kxyxhKdZkrcbaiOMtkJUA9ITAc1mlamh0ooasxkH1XwMbYQ
+acmwXaWET20H0GeAGP+7vow=
+=agpO
+-----END PGP SIGNATURE-----
+'
+test_expect_success 'Tag name filtering strips gpg signature' '
+	sha1=$(git rev-parse HEAD) &&
+	sha1t=$(echo "$faux_gpg_tag" | sed -e s/XXXXXX/$sha1/ | git mktag) &&
+	git update-ref "refs/tags/S" "$sha1t" &&
+	echo "$faux_gpg_tag" | sed -e s/XXXXXX/$sha1/ | head -n 6 > expect &&
+	git filter-branch -f --tag-name-filter cat &&
+	git cat-file tag S > actual &&
+	git diff expect actual
+'
+
 test_done
-- 
1.5.4.4.481.g5075
