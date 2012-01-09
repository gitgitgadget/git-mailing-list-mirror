From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/1] git-gui: fix hunk parsing for corner case changes
Date: Mon,  9 Jan 2012 14:43:17 +0100
Message-ID: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Jan 09 14:43:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkFVb-0001th-PO
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 14:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab2AINnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 08:43:24 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51872 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab2AINnY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 08:43:24 -0500
Received: by bkcjm19 with SMTP id jm19so1466451bkc.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 05:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=tb++aFXXXlOhl/OsZ/BBmVMLeTB4SdiQa75oTT0ygXI=;
        b=JUdbGchhTC913jx55ioCujxRKxxZvVQnszhcw5vM5Mq1duZkvet5oTMiv3iX9flrTD
         zWgtvlmdRZxrFb38RH3zndx64oDFkmhD9STALm7jwH57eGIKT5JuVTblpeUOYIq6Rom8
         6rmPZL5vUgdz4dtSqny3D2u5uYnuAiiNXlAsQ=
Received: by 10.205.138.136 with SMTP id is8mr7025689bkc.35.1326116602604;
        Mon, 09 Jan 2012 05:43:22 -0800 (PST)
Received: from localhost ([141.76.90.220])
        by mx.google.com with ESMTPS id l20sm27705175bkv.5.2012.01.09.05.43.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 Jan 2012 05:43:21 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.873.gfea665
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188170>

The simple hunk parsing code did not recognize hunks when there is no
second number after the comma. Like in these cases:

  @@ -1 +0,0 @@
  -1

Which resulted in this hunk header:

  @@ -1 +0,1 +1 +0,0 @@

Or:

  @@ -1 +1 @@
  -1
  +2

Resulted in:

  @@ -1 +1 @@
  ,1 +1 +1 @@
  ,0 @@

While trying to stage only the '-1' line.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/diff.tcl |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index ec44055..63f8742 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -672,9 +672,11 @@ proc apply_range_or_line {x y} {
 		# $i_l is now at the beginning of a line
 
 		# pick start line number from hunk header
-		set hh [$ui_diff get $i_l "$i_l + 1 lines"]
-		set hh [lindex [split $hh ,] 0]
-		set hln [lindex [split $hh -] 1]
+		if {![regexp {^@@ -(\d+)(?:,\d+)? \+(?:\d+)(?:,\d+)? @@(?:\s|$)} \
+			[$ui_diff get $i_l "$i_l + 1 lines"] hh hln]} {
+			unlock_index
+			return
+		}
 
 		# There is a special situation to take care of. Consider this
 		# hunk:
-- 
1.7.8.1.873.gfea665
