From: Ciaran <ciaranj@gmail.com>
Subject: Re: [RFC PATCH] Pass empty file to p4merge where no base is suitable.
Date: Sun, 1 May 2011 23:16:02 +0100
Message-ID: <BANLkTimD_S3ik7-0j0gMCiEo3aoRwCy92Q@mail.gmail.com>
References: <BANLkTimXBayYAScPfk2j9spxcYrmtMJKxg@mail.gmail.com>
	<7vwriq3p0t.fsf@alter.siamese.dyndns.org>
	<BANLkTimf1q8JM46J-X1BCwQ+GaeWAgv75Q@mail.gmail.com>
	<7v7haarsrd.fsf@alter.siamese.dyndns.org>
	<BANLkTikv0YmB-u74sOrQUQZGQvYJNmBx_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 00:16:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGevy-0008V8-Cp
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 00:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666Ab1EAWQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 18:16:05 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61970 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab1EAWQD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 18:16:03 -0400
Received: by pvg12 with SMTP id 12so2955964pvg.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 15:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=N0UjA1DP19UggDyLIPU3SDgo//OCNnUgZZrtQAevO0k=;
        b=S/mTafWK4Uo2VHr0swHi/gGiuu94zGBYv41gDgCHAKr+Z/cKjUInwQEvvNJkNexvPy
         trwQf5yTqBpcySmWNb/5e7sAb4fUMACcbM+ykyPYPjRrTUiNIpl7Ve1KPghqLRLlFAog
         fpU6C2uyzg2IZR7VTWSCCJQ2k6y4m20uXsKnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=RsRcrskUEsUsgkJNe/tYnmnH10pEUxmBfjfta+FDEPsG1HwokRwI18rzbotDv6ma2D
         YeuTgt1YTG0ZoLTcEXfZdxS4lb8I6QSFJ7qb1qh44jU81dWu0gZVEU5NKLxMEVWQEFeK
         EFAom3x85ouuNqsvkkU9O2ZvnUdDPhOXBTfLc=
Received: by 10.68.38.33 with SMTP id d1mr6377524pbk.389.1304288162512; Sun,
 01 May 2011 15:16:02 -0700 (PDT)
Received: by 10.68.62.6 with HTTP; Sun, 1 May 2011 15:16:02 -0700 (PDT)
In-Reply-To: <BANLkTikv0YmB-u74sOrQUQZGQvYJNmBx_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172549>

Modify the p4merge client command to pass a reference to an empty file
instead of the local file when no base revision available.

In the situation where a merge tries to add a file from one branch
into a branch that already contains that file (by name), p4merge
currently seems to have successfully automatically resolved the
'conflict' when it is opened (correctly if the files differed by
just whitespace for example) but leaves the save button disabled. This
means the user of the p4merge client cannot commit the resolved
changes back to disk and merely exits, leaving the original
(merge-conflicted) file intact on the disk.

Provide an empty base file to p4merge so that it leaves the save
button enabled.  This will allow saving of the auto-resolution to
disk.

Signed-off-by: Ciaran Jessup <ciaranj@gmail.com>
---
A hopefully final stab at the patch, which effectively backs out my
version, and implements the suggestions of
Junio C Hamano.

 git-mergetool--lib.sh |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index fb3f52b..4db9212 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -258,12 +258,9 @@ run_merge_tool () {
 		;;
 	p4merge)
 		if merge_mode; then
-		    touch "$BACKUP"
-			if $base_present; then
-				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
-			else
-				"$merge_tool_path" "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"
-			fi
+			touch "$BACKUP"
+			$base_present || >"$BASE"
+			"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
 			check_unchanged
 		else
 			"$merge_tool_path" "$LOCAL" "$REMOTE"
-- 
1.7.4.1
