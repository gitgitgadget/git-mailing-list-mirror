From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 5/7] pull: add warning on non-ff merges
Date: Sat, 12 Oct 2013 02:01:58 -0500
Message-ID: <1381561322-20059-4-git-send-email-felipe.contreras@gmail.com>
References: <1381561322-20059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:08:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtJD-0002E2-SQ
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab3JLHIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:08:14 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:48056 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab3JLHIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:08:12 -0400
Received: by mail-oa0-f48.google.com with SMTP id m6so3077913oag.21
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T47t6qCSZBpgmttcDK9GAha2cM5y5Kau7cxThpOP3BQ=;
        b=LIIujXzos8OuK6fCCKE2gSXwgzEexsP7Sf56yXdElOMmLnqWHxNmwO554P8X2lMlHG
         7AHt3EJbcDFa76KIbFBCgkq6ZkkaZj6o9gBXisB9H4ODPybJmuKZlwGSZtQqXDoijj4S
         /ZJB0KLRUgSeSndgRcfhfkQ3W/ewlsRHucruqT2X5JP5c2LjycmzH8Sc1AiDetZreRzZ
         YsgOkT5+G/18mJWNo+NxWgrdxUBKiGucCG9J7Wboz4Eb5N0lanlKHzyRfeyxSTG1fKQx
         9c3moaX49lmELJUKCTTAKoid+IG4uXgkSbQApr0702lPvg8YB9s8UJbHnUBnzKJ/pPK2
         AT4A==
X-Received: by 10.182.142.229 with SMTP id rz5mr17578365obb.12.1381561691951;
        Sat, 12 Oct 2013 00:08:11 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id nw5sm28628111obc.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:08:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561322-20059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235951>

To prepare our uses for the upcoming changes we should warn them and let
them know that they will need to specify a merge or a rebase in the
future (when a non-fast-forward situation arises). Also, let them know
we fallback to 'git pull --merge', so when the obsoletion of this mode
comes, they know what to type without interrupting or changing their
workflow.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-pull.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 6e6b887..d1b07d8 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -62,7 +62,7 @@ then
 		echo "Please use pull.mode and branch.<name>.pullmode instead."
 	fi
 fi
-test -z "$mode" && mode=merge
+test -z "$mode" && mode=default
 dry_run=
 while :
 do
@@ -286,13 +286,22 @@ case "$merge_head" in
 *)
 	# check if a non-fast-foward merge would be needed
 	merge_head=${merge_head% }
-	if test "$mode" = merge-ff-only -a -z "$no_ff$ff_only${squash#--no-squash}" &&
+	if test -z "$no_ff$ff_only${squash#--no-squash}" &&
 		test -n "$orig_head" &&
 		! git merge-base --is-ancestor "$orig_head" "$merge_head" &&
 		! git merge-base --is-ancestor "$merge_head" "$orig_head"
 	then
-		die "$(gettext "The pull was not fast-forward, please either merge or rebase.
+		case "$mode" in
+		merge-ff-only)
+			die "$(gettext "The pull was not fast-forward, please either merge or rebase.
 If unsure, run 'git pull --merge'.")"
+			;;
+		default)
+			echo "$(gettext "warning: the pull was not fast-forward, in the future you would have to choose
+a merge or a rebase, falling back to old style for now (git pull --merge).
+Read 'git pull --help' for more information.")" >&2
+			;;
+		esac
 	fi
 	;;
 esac
-- 
1.8.4-fc
