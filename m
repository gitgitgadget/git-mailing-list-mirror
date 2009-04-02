From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/3] mergetool-lib: specialize xxdiff options when in diff mode
Date: Thu,  2 Apr 2009 03:30:45 -0700
Message-ID: <1238668246-762-2-git-send-email-davvid@gmail.com>
References: <1238668246-762-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 02 12:33:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpKEU-0000C6-Fk
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 12:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbZDBKbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 06:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760680AbZDBKa6
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 06:30:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:6140 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759150AbZDBKa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 06:30:57 -0400
Received: by rv-out-0506.google.com with SMTP id f9so557034rvb.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 03:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ulj368hoSHes+abwBY+0vdoei8dgcj6ryoxpe3TLxJY=;
        b=FDKg7BafrMYfpzzdSxnS5hDzS8Phe7B3DYKQ5gpsiI02nWx1766vFo5bZgLmxhc0ZA
         P/HT3anM7eOrDBIZt5n0xAg1LzntDrF/uFMa3gCFZz9/4cy8CTyJvCWAKjQoQO50dcE/
         PDprY5mw8so8GDtDl9kYlGrGhUnU1NBXic5XA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pkFgDWWnEdDMYJbU1jihAOXUl+QD0IXnUVw476UQrf3nDCseVLgB4FxNBJfzUlYDXy
         EjUjqNUuf+bjlzrWLBAtM4P943d3G173+wfByxAqT7LFovi/8hLNJuZDzGU7WYhf74Cd
         b2N93KZw/l+S+O92y2CTN15uG3KF7S+azoxbc=
Received: by 10.114.211.17 with SMTP id j17mr5835015wag.61.1238668255068;
        Thu, 02 Apr 2009 03:30:55 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j26sm997686waf.24.2009.04.02.03.30.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 03:30:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.469.gdffc1
In-Reply-To: <1238668246-762-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115453>

We don't need '-merged-file', 'save as', and the merge-status exit
code when in diff mode

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool-lib.sh |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/git-mergetool-lib.sh b/git-mergetool-lib.sh
index e2d074d..3ba332b 100644
--- a/git-mergetool-lib.sh
+++ b/git-mergetool-lib.sh
@@ -127,7 +127,9 @@ run_mergetool () {
 		fi
 		;;
 	xxdiff)
-		merge_mode && touch "$BACKUP"
+		if merge_mode; then
+			touch "$BACKUP"
+		fi
 		if $base_present; then
 			"$merge_tool_path" -X --show-merged-pane \
 			    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
@@ -135,12 +137,18 @@ run_mergetool () {
 			    -R 'Accel.SearchForward: "Ctrl-G"' \
 			    --merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
 		else
-			merge_mode && extra=--show-merged-pane
-			"$merge_tool_path" -X $extra \
-				-R 'Accel.SaveAsMerged: "Ctrl-S"' \
-				-R 'Accel.Search: "Ctrl+F"' \
-				-R 'Accel.SearchForward: "Ctrl-G"' \
-				--merged-file "$MERGED" "$LOCAL" "$REMOTE"
+			if merge_mode; then
+				"$merge_tool_path" -X $extra \
+					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+					-R 'Accel.Search: "Ctrl+F"' \
+					-R 'Accel.SearchForward: "Ctrl-G"' \
+					--merged-file "$MERGED" "$LOCAL" "$REMOTE"
+			else
+				"$merge_tool_path" \
+					-R 'Accel.Search: "Ctrl+F"' \
+					-R 'Accel.SearchForward: "Ctrl-G"' \
+					"$LOCAL" "$REMOTE"
+			fi
 		fi
 		check_unchanged
 		;;
-- 
1.6.2.1.303.g63699
