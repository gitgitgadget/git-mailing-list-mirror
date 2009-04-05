From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] mergetool--lib: add new merge tool TortoiseMerge
Date: Sat,  4 Apr 2009 21:00:24 -0700
Message-ID: <1238904024-11238-1-git-send-email-davvid@gmail.com>
Cc: markus.heidelberg@web.de, charles@hashpling.org,
	git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 05 06:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqJYj-0007VY-Fm
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 06:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbZDEEAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 00:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbZDEEAm
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 00:00:42 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:28639 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbZDEEAm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 00:00:42 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1311861wah.21
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 21:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Bkv82goRXi3+bqum0/+aWLPvoipOsfUKN9FGazmlBC8=;
        b=Qxl6rktJbYQ5hB9bugO084dypDhdGi9yjZaNdo3EEnc5gn16DeBqv0Qf/2Sa/o5aFy
         lAdnIbec2bDnB2O96BBd28BGeXyS8deDBC0h4cbTpQSMGb3nTIZTSD0yIFpXj8BrBPrJ
         GEmm7059BoGmWjeNmBn0BxJvOsWD978e04KJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=st2pF2rfUnFSm4NjWfhRj1JvDQbaRFMIXzeudsrbHmS6FOngB6JpoIkUlD14N7YoAa
         TzProwTLTfHMryFzrvu03tmHtwsjZhc5VXKBvxzDFUy7NcdsrDXvAz9WiXmpKHTdiCRH
         ew0BJbDgRLw4mwD7oo9M2YXfd6gqzhOozDJZs=
Received: by 10.115.75.14 with SMTP id c14mr1505890wal.86.1238904039924;
        Sat, 04 Apr 2009 21:00:39 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j28sm3905128waf.39.2009.04.04.21.00.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 21:00:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.469.gdffc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115631>

From: Markus Heidelberg <markus.heidelberg@web.de>

TortoiseMerge comes with TortoiseSVN or TortoiseGit for Windows. It can
only be used as a merge tool with an existing base file. It cannot be
used without a base nor as a diff tool.

The documentation only mentions the slash '/' as command line option
prefix, which refused to work, but the parser also accepts the dash '-'

See http://code.google.com/p/msysgit/issues/detail?id=226

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

This is Markus' patch rebased on top of my latest refactoring
patch.  It didn't apply cleanly so I figured I'd resolve the
merge myself.

 git-mergetool--lib.sh |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index dcd4516..268485a 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -46,10 +46,13 @@ check_unchanged () {
 
 valid_tool () {
 	case "$1" in
-	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge | diffuse)
+	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge | diffuse | tortoisemerge)
 		if test "$1" = "kompare" && ! diff_mode; then
 			return 1
 		fi
+		if test "$1" = "tortoisemerge" && ! merge_mode; then
+			return 1
+		fi
 		;; # happy
 	*)
 		if test -z "$(get_merge_tool_cmd "$1")"; then
@@ -220,6 +223,16 @@ run_merge_tool () {
 		fi
 		status=$?
 		;;
+	tortoisemerge)
+		if $base_present; then
+			touch "$BACKUP"
+			"$merge_tool_path" -base:"$BASE" -mine:"$LOCAL" -theirs:"$REMOTE" -merged:"$MERGED"
+			check_unchanged
+		else
+			echo "TortoiseMerge cannot be used without a base" 1>&2
+			status=1
+		fi
+		;;
 	*)
 		if test -n "$merge_tool_cmd"; then
 			if merge_mode &&
-- 
1.6.2.1.469.gdffc1
