From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/2] git-gui: fix applying line/ranges when the selection ends at the begin of a line
Date: Mon,  9 Jan 2012 14:43:18 +0100
Message-ID: <37339be035746797fcec7634e3560ffcd5b26cf3.1326116492.git.bert.wesarg@googlemail.com>
References: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Jan 09 14:43:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkFVc-0001th-As
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 14:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691Ab2AINn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 08:43:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57007 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab2AINnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 08:43:25 -0500
Received: by eaad14 with SMTP id d14so2018070eaa.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 05:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=Lggo4SZAvgUQQg31HfMTnNKnfzLlh0R3Tne5zk0sDPg=;
        b=j1maVJYm+5jCdWfW/XW+S+yWMcYGrNYTJ8J+rQH5hmlCqufxK9frp7EuTZDgvdNw8C
         JMGmKjkFW+8Mb17wkK/qWYzGd9mXsRt4dKXGjvsGjBVQHdr/9jWlFL2G/YX7d57EpYgp
         eYYx/doeq2jsEzLFzA67PBywAdXTBucLNzM3Q=
Received: by 10.205.129.3 with SMTP id hg3mr7223469bkc.20.1326116603795;
        Mon, 09 Jan 2012 05:43:23 -0800 (PST)
Received: from localhost ([141.76.90.220])
        by mx.google.com with ESMTPS id ci12sm143505726bkb.13.2012.01.09.05.43.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 Jan 2012 05:43:23 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.873.gfea665
In-Reply-To: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com>
In-Reply-To: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com>
References: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188169>

Selecting also the trailing newline of a line for staging/unstaging would
have resulted in also staging/unstaging of the next line.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/diff.tcl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 63f8742..a750ea7 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -632,7 +632,13 @@ proc apply_range_or_line {x y} {
 	}
 
 	set first_l [$ui_diff index "$first linestart"]
-	set last_l [$ui_diff index "$last lineend"]
+	# don't include the next line if $last points to the start of a line
+	# ie. <lno>.0
+	if {[lindex [split $last .] 1] == 0} {
+		set last_l [$ui_diff index "$last -1 line lineend"]
+	} else {
+		set last_l [$ui_diff index "$last lineend"]
+	}
 
 	if {$current_diff_path eq {} || $current_diff_header eq {}} return
 	if {![lock_index apply_hunk]} return
-- 
1.7.8.1.873.gfea665
