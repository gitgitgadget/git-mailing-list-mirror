From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-quiltimport.sh: disallow fuzz
Date: Thu, 25 Sep 2014 15:59:49 -0700
Message-ID: <xmqq1tqz9uhm.fsf@gitster.dls.corp.google.com>
References: <20140924213512.GA7619@logfs.org>
	<xmqqwq8sb81e.fsf@gitster.dls.corp.google.com>
	<20140925220831.GA14433@logfs.org>
	<xmqq7g0r9v04.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?J=C3=B6rn?= Engel <joern@logfs.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 00:59:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXI0y-0007tI-57
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 00:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbaIYW7w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2014 18:59:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61420 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbaIYW7v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2014 18:59:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B43E3ECFC;
	Thu, 25 Sep 2014 18:59:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2m+38SOukDkv
	X6hF99orgC9nvmQ=; b=v3lidsexu0lU8d8LMuLtLxplVOZbBmdc+5LkoWx5YMXq
	DRQqj0P6PAYbJ8ZN9/Labqcld5ceDjpCCNQi31axhvXrrScv6WwVGg1ANt48NLx0
	C9JNBQeBspzKcYEpZXFWfUMqFxqoEnDH9ymOPTuSWvWoW2SLrv/NHZY0jQbd1Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mzcwjY
	340/F/JT9T2OJPIdPu4+EB1Us5hva3uT8Y+BrUP2yKDawRuvWOnfiGBLK4vWvUOV
	8RSYLNfdV2SAQzeRe/4cbPzDqcX3YqIqbHSG0NRLeSLvG+HTtVwrn7FV9jQTVXpt
	XvOE8y1aTptuBCdRo/6a6BFZjs5+z6+DGmf24=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22CE83ECFB;
	Thu, 25 Sep 2014 18:59:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9BAEF3ECFA;
	Thu, 25 Sep 2014 18:59:50 -0400 (EDT)
In-Reply-To: <xmqq7g0r9v04.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Sep 2014 15:48:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A792EB66-4507-11E4-9BC4-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257502>

Junio C Hamano <gitster@pobox.com> writes:

> Let's have it the other way around, keep the same behaviour for
> those who run the command without the new option, while allowing
> people who know better and are aligned with the spirit of git to
> pass the parameter, at least for now, with a note in the
> documentation to warn that the default may change in the future to
> allow no fuzz, or something.

Perhaps like this, with some documentation added (do we have/need
any test???).

-- >8 --
To: J=C3=B6rn Engel <joern@logfs.org>
Date: Thu, 25 Sep 2014 18:08:31 -0400
Subject: [PATCH] git-quiltimport.sh: allow declining fuzz with --exact =
option

git-quiltimport unconditionally passes "-C1" to "git apply",
supposedly to roughly match the quilt default of --fuzz 2.  Allow
users to pass --exact option to disable it, requiring the patch to
apply without any fuzz.

Also note that -C1 and fuzz=3D2 is not identical.  Most patches have
three lines of context, so fuzz=3D2 leaves one relevant line of
context.  But for any patches with more or less context this is not
true.  git-apply has no option for fuzz, so any emulation will
always be best-effort.

Signed-off-by: Joern Engel <joern@logfs.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-quiltimport.txt | 12 ++++++++++++
 git-quiltimport.sh                | 17 ++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quil=
timport.txt
index a356196..109918d 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -49,6 +49,18 @@ The default for the patch directory is patches
 or the value of the $QUILT_PATCHES environment
 variable.
=20
+-C <number>::
+	Pass `-C<number>` to underlying `git apply` when applying
+	the patch, to reduce number of context lines to be matched.
+	By default, `-C1` is passed to `git apply` to emulate the
+	`--fuzz=3D2` behaviour of quilt (assuming the standard 3
+	context lines).
+
+--exact::
+	Do not pass any `-C<number>` option to `git apply` when
+	applying the patch, to require context lines to fully match.
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 167d79f..2d2c377 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -6,6 +6,8 @@ git quiltimport [options]
 --
 n,dry-run     dry run
 author=3D       author name and email address for patches without any
+C=3D            minimum context (see git apply)
+exact         allow no-fuzz
 patches=3D      path to the quilt series and patches
 "
 SUBDIRECTORY_ON=3DYes
@@ -13,6 +15,7 @@ SUBDIRECTORY_ON=3DYes
=20
 dry_run=3D""
 quilt_author=3D""
+cflag=3D-C1
 while test $# !=3D 0
 do
 	case "$1" in
@@ -20,6 +23,18 @@ do
 		shift
 		quilt_author=3D"$1"
 		;;
+	-C)
+		shift
+		# ensure numerical parameter
+		case "$1" in
+		''|*[!0-9]*) usage;;
+		*) ;;
+		esac
+		cflag=3D"-C$1"
+		;;
+	--exact)
+		cflag=3D
+		;;
 	-n|--dry-run)
 		dry_run=3D1
 		;;
@@ -130,7 +145,7 @@ do
 	fi
=20
 	if [ -z "$dry_run" ] ; then
-		git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
+		git apply --index $cflag ${level:+"$level"} "$tmp_patch" &&
 		tree=3D$(git write-tree) &&
 		commit=3D$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tre=
e $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
--=20
2.1.1-394-g5293c25
