From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v3 1/4] gitk: Port new encoding logic from git-gui.
Date: Mon, 13 Oct 2008 12:12:31 +0400
Message-ID: <1223885554-27718-2-git-send-email-angavrilov@gmail.com>
References: <1223885554-27718-1-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 10:15:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpIaR-0003Qq-OY
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 10:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586AbYJMIOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 04:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756579AbYJMIOV
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 04:14:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:48218 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976AbYJMIOU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 04:14:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1206955fgg.17
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 01:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0/aQSqTgsJjUQd2ewDbIKcCiCOOMdyBNA8b3Neo8G4M=;
        b=dCQiIPkLtE5k57g/dduA9Sp7iHUSDKjNc8Vul5VRhK3OgBXcVwl3vdy03uRKx3EfEN
         ZGCpJl+FBWwH706gL6N9A0tX0bJxbwZXo2mUiRWPoQAtmhKU0cfIVlcJKCCtBrE/cOKe
         LXL5pmn27ZjhOQmoPsKv0Vg+6UVonQQCu6p7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KB3AhtwuXToVOOrvqi/9Y8A8OoHrYJw84RRDIoK8DCvtSxOhCd1Gw8ubf7IQx7NDNo
         QtFEKwomCG3gJoxw2UHF1XlrdgWCcf8IKWRh3btYYzAUweWpP0TVaBd5o8OshCDDQxYF
         sqqEROo5kOzLTrj2B6NEJZpopYtVFZ0iJl0b0=
Received: by 10.181.58.9 with SMTP id l9mr4209454bkk.98.1223885657774;
        Mon, 13 Oct 2008 01:14:17 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm6128723fks.6.2008.10.13.01.14.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 01:14:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1223885554-27718-1-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98089>

Recently handling of file encodings in GIT-GUI has
been greatly enhanced. It now follows these rules:

- File encoding defaults to the system encoding.
- It can be overridden by setting the gui.encoding option.
- Finally, the 'encoding' attribute is checked on
  per-file basis; it has the last word.

This patch inserts copies of git-gui functions necessary
for supporting this into gitk. The following patch will
connect them to the rest of the code.

Note: Since git-check-attr does not provide support for
reading attributes from trees, attribute lookup is done
using files from the working directory.

It also extends the range of supported encoding
names, to match changes in git-gui.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
Tested-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 gitk |   39 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index dce17e9..8682838 100755
--- a/gitk
+++ b/gitk
@@ -9727,7 +9727,7 @@ set encoding_aliases {
     { ISO-8859-16 iso-ir-226 ISO_8859-16:2001 ISO_8859-16 latin10 l10 }
     { GBK CP936 MS936 windows-936 }
     { JIS_Encoding csJISEncoding }
-    { Shift_JIS MS_Kanji csShiftJIS }
+    { Shift_JIS MS_Kanji csShiftJIS ShiftJIS Shift-JIS }
     { Extended_UNIX_Code_Packed_Format_for_Japanese csEUCPkdFmtJapanese
       EUC-JP }
     { Extended_UNIX_Code_Fixed_Width_for_Japanese csEUCFixWidJapanese }
@@ -9769,7 +9769,7 @@ proc tcl_encoding {enc} {
     set i [lsearch -exact $lcnames $enc]
     if {$i < 0} {
 	# look for "isonnn" instead of "iso-nnn" or "iso_nnn"
-	if {[regsub {^iso[-_]} $enc iso encx]} {
+	if {[regsub {^(iso|cp|ibm|jis)[-_]} $enc {\1} encx]} {
 	    set i [lsearch -exact $lcnames $encx]
 	}
     }
@@ -9781,7 +9781,7 @@ proc tcl_encoding {enc} {
 	    foreach e $ll {
 		set i [lsearch -exact $lcnames $e]
 		if {$i < 0} {
-		    if {[regsub {^iso[-_]} $e iso ex]} {
+		    if {[regsub {^(iso|cp|ibm|jis)[-_]} $e {\1} ex]} {
 			set i [lsearch -exact $lcnames $ex]
 		    }
 		}
@@ -9796,6 +9796,34 @@ proc tcl_encoding {enc} {
     return {}
 }
 
+proc gitattr {path attr default} {
+	if {[catch {set r [exec git check-attr $attr -- $path]}]} {
+		set r unspecified
+	} else {
+		set r [join [lrange [split $r :] 2 end] :]
+		regsub {^ } $r {} r
+	}
+	if {$r eq {unspecified}} {
+		return $default
+	}
+	return $r
+}
+
+proc get_path_encoding {path} {
+	global gui_encoding
+	set tcl_enc [tcl_encoding $gui_encoding]
+	if {$tcl_enc eq {}} {
+		set tcl_enc [encoding system]
+	}
+	if {$path ne {}} {
+		set enc2 [tcl_encoding [gitattr $path encoding $tcl_enc]]
+		if {$enc2 ne {}} {
+			set tcl_enc $enc2
+		}
+	}
+	return $tcl_enc
+}
+
 # First check that Tcl/Tk is recent enough
 if {[catch {package require Tk 8.4} err]} {
     show_error {} . [mc "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
@@ -9818,6 +9846,11 @@ if {$tclencoding == {}} {
     puts stderr "Warning: encoding $gitencoding is not supported by Tcl/Tk"
 }
 
+set gui_encoding [encoding system]
+catch {
+	set gui_encoding [exec git config --get gui.encoding]
+}
+
 set mainfont {Helvetica 9}
 set textfont {Courier 9}
 set uifont {Helvetica 9 bold}
-- 
1.6.0.20.g6148bc
