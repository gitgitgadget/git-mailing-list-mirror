From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 4/8] git-gui: Support more merge tools.
Date: Sun, 31 Aug 2008 00:59:47 +0400
Organization: TEPKOM
Message-ID: <200808310059.47327.angavrilov@gmail.com>
References: <200808310052.21595.angavrilov@gmail.com> <200808310055.45679.angavrilov@gmail.com> <200808310056.51324.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 23:16:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXo5-00089f-37
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997AbYH3VOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 17:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755757AbYH3VOc
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 17:14:32 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:58555 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702AbYH3VO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 17:14:28 -0400
Received: by fk-out-0910.google.com with SMTP id 18so883439fkq.5
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 14:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZCWvH31NiD6QsNDVIcx9/eswI7kkhUwdqmr5CPFOA0k=;
        b=RPwprqAUGOL0ztBZt0JZlx9zsuXzUBrGczF3C3mE4F/r26TzBC7xn3dIZPSrE7hcFg
         7CyZ1yLM84ebJVml0rkjeIXCIEnuwn0qR1V+gPct9KeLykZyRuREUHCdGr24Snn/+QSq
         QjE7sE6HpqDYIZhWE0DTEHqYypISTV51PI5cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ixxHeoVL13b80WmqevUM9mVY9fSRQdWk+cU6iyiSxNgmUp8aBnB+naIDgDnriBYvdU
         +J4fuarPC9l53/QTTp2Tc4IsKYuXLXo9Sy4DQLeVH7sN+L0tSyOg8B+4UGAtZgs2R39O
         GwM0tuqdc30C81hNTI8/Tc5Cv7E8lE6BnPQrU=
Received: by 10.181.21.6 with SMTP id y6mr4102912bki.50.1220130867990;
        Sat, 30 Aug 2008 14:14:27 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id d13sm4092560fka.3.2008.08.30.14.14.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 14:14:27 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808310056.51324.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94427>

Add native support for Araxis Merge, WinMerge and Perforce merge.

Custom merge tools are not implemented by mergetool.tcl; besides,
native support allows constructing the command lines in a more
intelligent way.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/mergetool.tcl |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
index ba9e8ce..5f3da1f 100644
--- a/lib/mergetool.tcl
+++ b/lib/mergetool.tcl
@@ -131,6 +131,7 @@ proc merge_resolve_tool2 {} {
 	if {$merge_tool_path eq {}} {
 		switch -- $tool {
 		emerge { set merge_tool_path "emacs" }
+		araxis { set merge_tool_path "compare" }
 		default { set merge_tool_path $tool }
 		}
 	}
@@ -210,6 +211,31 @@ proc merge_resolve_tool2 {} {
 					"$LOCAL" "$REMOTE" "$basename"]
 		}
 	}
+	winmerge {
+		if {$base_stage ne {}} {
+			# This tool does not support 3-way merges.
+			# Use the 'conflict file' resolution feature instead.
+			set cmdline [list "$merge_tool_path" -e -ub "$MERGED"]
+		} else {
+			set cmdline [list "$merge_tool_path" -e -ub -wl \
+				-dl "Theirs File" -dr "Mine File" "$REMOTE" "$LOCAL" "$MERGED"]
+		}
+	}
+	araxis {
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" -wait -merge -3 -a1 \
+				-title1:"'$MERGED (Base)'" -title2:"'$MERGED (Local)'" \
+				-title3:"'$MERGED (Remote)'" \
+				"$BASE" "$LOCAL" "$REMOTE" "$MERGED"]
+		} else {
+			set cmdline [list "$merge_tool_path" -wait -2 \
+				 -title1:"'$MERGED (Local)'" -title2:"'$MERGED (Remote)'" \
+				 "$LOCAL" "$REMOTE" "$MERGED"]
+		}
+	}
+	p4merge {
+		set cmdline [list "$merge_tool_path" "$BASE" "$REMOTE" "$LOCAL" "$MERGED"]
+	}
 	vimdiff {
 		error_popup [mc "Not a GUI merge tool: '%s'" $tool]
 		return
@@ -236,6 +262,7 @@ proc merge_tool_get_stages {target stages} {
 	foreach fname $stages {
 		if {$merge_stages($i) eq {}} {
 			file delete $fname
+			catch { close [open $fname w] }
 		} else {
 			# A hack to support autocrlf properly
 			git checkout-index -f --stage=$i -- $target
-- 
1.6.0.20.g6148bc
