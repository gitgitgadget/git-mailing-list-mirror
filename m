From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-quiltimport and non-existent patches
Date: Thu, 27 Sep 2007 12:41:14 -0700
Message-ID: <7vps03uc9x.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.62.0709271154440.10467@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Geoff Levand <geoffrey.levand@am.sony.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:41:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IazEr-00059s-RN
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758432AbXI0TlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 15:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758411AbXI0TlW
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:41:22 -0400
Received: from rune.pobox.com ([208.210.124.79]:54993 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758383AbXI0TlV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 15:41:21 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 49A0413D32A;
	Thu, 27 Sep 2007 15:41:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8621413D314;
	Thu, 27 Sep 2007 15:41:38 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.62.0709271154440.10467@pademelon.sonytel.be> (Geert
	Uytterhoeven's message of "Thu, 27 Sep 2007 11:59:51 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59323>

Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> writes:

> It would be nice if git-quiltimport would just warn about
> non-existent patches, just like quilt.  This will make it work
> with `markers' we put in our quilt series files. Commenting
> out the markers is no solution as `quilt series' doesn't show
> commented-out patches.

I cannot decide if this should be the default (that's up to
heavy users of git-quiltimport script), but something along this
line should do.  Care to test it and ack?

---

 git-quiltimport.sh |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 74a54d5..3c38959 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -4,6 +4,7 @@ SUBDIRECTORY_ON=Yes
 . git-sh-setup
 
 dry_run=""
+error_empty=t
 quilt_author=""
 while test $# != 0
 do
@@ -25,6 +26,11 @@ do
 		dry_run=1
 		;;
 
+	--expect-marker)
+		shift
+		error_empty=
+		;;
+
 	--pa=*|--pat=*|--patc=*|--patch=*|--patche=*|--patches=*)
 		QUILT_PATCHES=$(expr "z$1" : 'z-[^=]*\(.*\)')
 		shift
@@ -74,10 +80,17 @@ for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
 	echo $patch_name
 	git mailinfo "$tmp_msg" "$tmp_patch" \
 		<"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
-	test -s "$tmp_patch" || {
-		echo "Patch is empty.  Was it split wrong?"
-		exit 1
-	}
+	if test ! -s "$tmp_patch"
+	then
+		if test -z "$error_empty"
+		then
+			echo "Patch is empty.  Was it split wrong?"
+			exit 1
+		else
+			echo "Marker seen."
+			continue
+		fi
+	fi
 
 	# Parse the author information
 	export GIT_AUTHOR_NAME=$(sed -ne 's/Author: //p' "$tmp_info")
