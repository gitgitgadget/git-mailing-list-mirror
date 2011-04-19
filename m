From: Ciaran <ciaranj@gmail.com>
Subject: [RFC PATCH] Pass empty file to p4merge where no base is suitable.
Date: Tue, 19 Apr 2011 20:46:11 +0100
Message-ID: <BANLkTimXBayYAScPfk2j9spxcYrmtMJKxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 21:46:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCGsL-0003QI-K3
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 21:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700Ab1DSTqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 15:46:12 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63910 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab1DSTqM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 15:46:12 -0400
Received: by pwi15 with SMTP id 15so33861pwi.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=eaQlS0x9H15tE4DkLzqaAM7Ue1AU8fAhFSPEwsLC9xY=;
        b=IociRunJKJuu2LK0PMJBcvNzZ4UCI5W1aB3fe7X3mwXvYKgGiM1RQvK0rEZ1eTrPw8
         5Gwxnr1Hrbq9kNu0T0VtQRIC8lBTbaMLI7o+SvKUo+985iZhgCQGqX+Zz/tV7FTZ5tn0
         cKkXqlKBR/pdS/YGCW8nDsBVBfduuIV2EUfBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=nGQTmw3iWWjlFKFeK2kAylvp4SgcZNog29tq/laZyBIfOOwQlQr7MDQ8IVkpJ645IN
         ZzDe33rgqXY4JesJOCmHaKDmyQ6qYO2+i9G5fzuSGiOvM2QLCwqHHZNF9W5/dceTRazJ
         oTdjCtJjcbTG7pKZ9Iv/Bzm35bkePK4p8zADQ=
Received: by 10.68.63.2 with SMTP id c2mr10100618pbs.54.1303242371210; Tue, 19
 Apr 2011 12:46:11 -0700 (PDT)
Received: by 10.68.62.6 with HTTP; Tue, 19 Apr 2011 12:46:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171812>

Modify the p4merge client command to pass a reference to an empty file
instead of the local file when no base revision available.

In the situation where a merge tries to add a file from one branch
into a branch that already contains that file (by name), p4merge
currently seems to have successfully automatically resolved the
'conflict' when it is opened (correctly if the files differed by
just whitespace for example) but leaves the save button disabled. This
means the user of the p4merge client cannot commit the resolved
changes back to disk and merely exits, leaving the original
(merge-conflicted) file in-tact on the disk.

Provide an empty base file to p4merge so that it leaves the save
button enabled.  This will allow saving of the auto-resolution to
disk.

Please note that the empty file is temporarily stored in the location
specified as GIT_DIR/.no_base

Signed-off-by: Ciaran Jessup <ciaranj@gmail.com>
---
Thank you to David Aguilar for his feedback previously on this patch,
hopefully I've followed the submission guidelines correctly this time.
 This patch is to improve the interaction of p4merge and git in the
case where merge conflicts have no common ancestor.  For more detailed
discussion please see: http://marc.info/?l=git&m=130190735601527&w=2
(I was unsure if it was ok to repost inline, sorry)

 git-mergetool--lib.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index fb3f52b..3e007e9 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -262,7 +262,9 @@ run_merge_tool () {
 			if $base_present; then
 				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
 			else
-				"$merge_tool_path" "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"
+				touch "$GIT_DIR/.no_base"
+				"$merge_tool_path" "$GIT_DIR/.no_base" "$LOCAL" "$REMOTE" "$MERGED"
+				rm "$GIT_DIR/.no_base"
 			fi
 			check_unchanged
 		else
-- 
1.7.4.1
