From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] filter-branch.sh: support nearly proper tag name filtering
Date: Mon, 24 Mar 2008 17:09:01 -0500
Message-ID: <47E8267D.5000405@nrlssc.navy.mil>
References: <47E7FACD.7020409@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:10:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdurh-0005Ff-MN
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbYCXWJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 18:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbYCXWJU
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:09:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43787 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbYCXWJT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 18:09:19 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2OM92A5001075;
	Mon, 24 Mar 2008 17:09:02 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Mar 2008 17:09:02 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47E7FACD.7020409@nrlssc.navy.mil>
X-OriginalArrivalTime: 24 Mar 2008 22:09:02.0146 (UTC) FILETIME=[AAC5DA20:01C88DFB]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--13.283900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwNDQyMS03MDQ0?=
	=?us-ascii?B?MjUtNzExNjEyLTcwMDQ3Ni03MDM5NjktNzAzNzg4LTcwMDYzMC03?=
	=?us-ascii?B?MDEyMjAtNzAxMjM2LTcwMDE2MC03MDQwNDgtNzA3NDUxLTcwMDcw?=
	=?us-ascii?B?MS03MTA0NDItMTA1NzAwLTcwOTEzNy03MDE2MTgtNzAwNDgxLTE4?=
	=?us-ascii?B?ODAxOS03MDc3NTAtMTIxNjI0LTcwODI1Ny03MDA5NzEtODM0NjY4?=
	=?us-ascii?B?LTcwNDQxMC03MDIzNTgtNzAyMTQzLTcwMzcxMi03MDE0NTUtNzA0?=
	=?us-ascii?B?OTMwLTcwNjI0OS03MDk1ODQtNzA0OTI3LTcwMDEzMy03MDA5NDkt?=
	=?us-ascii?B?MTIxNjI4LTEwNjM5MC03MDY0NTQtNzAzNjU3LTEwNjQyMC03MDE5?=
	=?us-ascii?B?NDAtNzA1OTAxLTcwMjU1MS0xMjEzMzgtNzAwMzI0LTcwMDk3MC03?=
	=?us-ascii?B?MDMxODctNzAyNTk4LTEzOTYyOS03MDAwNzMtNzAwNjQ4LTE4ODE5?=
	=?us-ascii?B?OS03MDU0NTAtMTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78107>

Add support for creating a new tag object and retaining the tag message,
author, and date when rewriting tags. The gpg signature, if one exists,
will be stripped.

This adds nearly proper tag name filtering to filter-branch. Proper tag
name filtering would include the ability to change the tagger, tag date,
tag message, and _not_ strip a gpg signature if the tag did not change.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


I learned that the 'Q' command to sed is not portable, and most versions
of sed require a newline after 'c\' like commands.

Here is an updated patch which should be portable. Nothing else has been
changed.

Here's the diff from the previous patch...

  --- a/git-filter-branch.sh
  +++ b/git-filter-branch.sh
  @@ -406,11 +406,16 @@ if [ "$filter_tag_name" ]; then
                  echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
 
                  if [ "$type" = "tag" ]; then
  -                       new_sha1=$(git cat-file tag "$ref" | \
  -                               sed -e "1c\object $new_sha1" \
  -                                   -e '2c\type commit'      \
  -                                   -e "3c\tag $new_ref"     \
  -                                   -e '/^-----BEGIN PGP SIGNATURE-----/Q' | \
  +                       new_sha1=$(git cat-file tag "$ref" |
  +                               sed -n \
  +                                   -e "1c\
  +                                       object $new_sha1" \
  +                                   -e "2c\
  +                                       type commit" \
  +                                   -e "3c\
  +                                       tag $new_ref" \
  +                                   -e '/^-----BEGIN PGP SIGNATURE-----/q' \
  +                                   -e 'p' |
                                  git mktag) ||
                                  die "Could not create new tag object for $ref"
                          if git cat-file tag "$ref" | \


-brandon


 Documentation/git-filter-branch.txt |   14 ++++++++++----
 git-filter-branch.sh                |   19 +++++++++++++++++--
 t/t7003-filter-branch.sh            |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 6 deletions(-)

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
index 22b6ed4..3da3ccd 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -406,8 +406,23 @@ if [ "$filter_tag_name" ]; then
 		echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
 
 		if [ "$type" = "tag" ]; then
-			# Warn that we are not rewriting the tag object itself.
-			warn "unreferencing tag object $sha1t"
+			new_sha1=$(git cat-file tag "$ref" |
+				sed -n \
+				    -e "1c\
+					object $new_sha1" \
+				    -e "2c\
+					type commit" \
+				    -e "3c\
+					tag $new_ref" \
+				    -e '/^-----BEGIN PGP SIGNATURE-----/q' \
+				    -e 'p' |
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
