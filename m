From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/8] git-gui: rework handling of diff header
Date: Thu,  9 Dec 2010 21:47:52 +0100
Message-ID: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 21:48:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnPp-0003RY-3O
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 21:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757206Ab0LIUsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 15:48:16 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:50756 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117Ab0LIUsP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 15:48:15 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so2916089fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 12:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ZWxsvIsknmQdI2JYoV2yMSlS8teIvzhNLGHr3Eqy4/s=;
        b=vwEEv7GcJdQ02a/W05RD8SaF0v/lNJXTC+y3GrFkBGSbaEZlhBY5wuBtFEqsa+CZJd
         ucHlUfKTzigVO2V0vozpApYS2xu5z4JwAxguIFv2h4C0DWauV5t/DKfUWiqfB4ot87/e
         epXfoKhCXj+gngiYinPEQ2gaOPE7uGWrG+y60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QG+WJUFlqGWKpd+sKBXKZjLiJHqZnMPwBECuydY5EdE4x342pREnPxgJ2YMCo8TeVe
         1ZWOyIlLN7GH7VAUL6g4WOxyFb3MiSOwmZA/f7NRDs0ICyNqiK3Dtyk2caEl6VbiaJoK
         rL4zgEXahsJYIxx4Y9KtuvGaf0Y2UI+x3mPSU=
Received: by 10.223.74.141 with SMTP id u13mr20166faj.62.1291927684047;
        Thu, 09 Dec 2010 12:48:04 -0800 (PST)
Received: from localhost (p3E990761.dip.t-dialin.net [62.153.7.97])
        by mx.google.com with ESMTPS id 5sm705873fak.23.2010.12.09.12.48.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 12:48:02 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163319>

The fix in ca53c3f (Fix diff parsing for lines starting with "--" or "++",
2008-09-05) got a bug report from Johannes Sixt, that new files in the
index now looks like:

new file mode 100644
--- /dev/null
+++ b/foo
@@ -0,0 +1 @@
+foo

The introduced problem was that the 'in-diff-header'-flag was unconditially
disabled. Now it is only disabled when a hunk line is detected. And also
re-enabled when we encounter a new diff header.

The second part solves also the issue reported by me for diffs with file
type changes (i.e. the ''error: Unhandled 2 way diff marker: {d}"', which
comes from the second 'diff --git' line).

Reported-by: Johannes Sixt <j.sixt@viscovery.net>
Reported-by: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

Cc: Johannes Sixt <j.sixt@viscovery.net>
---
 foo          |    1 +
 lib/diff.tcl |   18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)
 create mode 100644 foo

diff --git a/foo b/foo
new file mode 100644
index 0000000..257cc56
--- /dev/null
+++ b/foo
@@ -0,0 +1 @@
+foo
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 9d0dc07..dae6ca6 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -382,23 +382,35 @@ proc read_diff {fd conflict_size cont_info} {
 		foreach {line markup} [parse_color_line $line] break
 		set line [string map {\033 ^} $line]
 
-		# -- Cleanup uninteresting diff header lines.
+		# -- Check for start of diff header.
+		if {   [string match {diff --git *}      $line]
+		    || [string match {diff --cc *}       $line]
+		    || [string match {diff --combined *} $line]} {
+			set ::current_diff_inheader 1
+		}
+
+		# -- Check for end of diff header (any hunk line will do this).
 		#
+		if {[regexp {^@@+ } $line]} {set ::current_diff_inheader 0}
+
 		if {$::current_diff_inheader} {
+			append current_diff_header $line "\n"
+
+			# -- Cleanup uninteresting diff header lines.
+			#
 			if {   [string match {diff --git *}      $line]
 			    || [string match {diff --cc *}       $line]
 			    || [string match {diff --combined *} $line]
 			    || [string match {--- *}             $line]
 			    || [string match {+++ *}             $line]} {
-				append current_diff_header $line "\n"
 				continue
 			}
 		}
+
 		if {[string match {index *} $line]} continue
 		if {$line eq {deleted file mode 120000}} {
 			set line "deleted symlink"
 		}
-		set ::current_diff_inheader 0
 
 		# -- Automatically detect if this is a 3 way diff.
 		#
-- 
1.7.3.2.1200.ge4bf6
