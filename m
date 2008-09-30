From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v2 1/4] gitk: Port new encoding logic from git-gui.
Date: Tue, 30 Sep 2008 15:00:19 +0400
Message-ID: <1222772422-28020-2-git-send-email-angavrilov@gmail.com>
References: <1222772422-28020-1-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 13:03:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkd0j-0000DF-P0
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 13:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbYI3LCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 07:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752442AbYI3LCD
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 07:02:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:58900 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbYI3LCB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 07:02:01 -0400
Received: by nf-out-0910.google.com with SMTP id d3so838180nfc.21
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 04:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=b79x2jlNJ1U4/4ZTsCcdFBbsY54I/wCwiUROI/maMsU=;
        b=eu+fyVhJjnpEZzOsCeo4QTqv2wNImYLzeSCQheQJFc9Wh7RVcvcGwPXulYk/EIU0LS
         BStQqTUtWZLP/uSfTI3N9N7FMlf19R8lK/DpO//DlPob+kUyzak8bN0/lkz0ICiOLKIW
         FzNIeqAkN53lH75bJ+IcG36y38DC8zMTM7myo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kQj0f/NVGkYmCT3PGZ6BGk/B0B9sGob0Bcx9E7ohW0MAV0dqtdO8PmuLUP2/DZe/I1
         tKyM6hhG99CBd2+1Xw/474sgQVkG36aXjOYPYFoHwN9rMnbGiy8FlCojXWfNrrFArUN2
         UANSipTqBgOlfBDc5/dYcRPrThc+QSaHpvrBw=
Received: by 10.102.247.4 with SMTP id u4mr4688017muh.94.1222772519212;
        Tue, 30 Sep 2008 04:01:59 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id y6sm7517378mug.7.2008.09.30.04.01.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 04:01:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1222772422-28020-1-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97097>

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
 gitk |   50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 546627f..b210f79 100755
--- a/gitk
+++ b/gitk
@@ -9726,7 +9726,7 @@ set encoding_aliases {
     { ISO-8859-16 iso-ir-226 ISO_8859-16:2001 ISO_8859-16 latin10 l10 }
     { GBK CP936 MS936 windows-936 }
     { JIS_Encoding csJISEncoding }
-    { Shift_JIS MS_Kanji csShiftJIS }
+    { Shift_JIS MS_Kanji csShiftJIS ShiftJIS Shift-JIS }
     { Extended_UNIX_Code_Packed_Format_for_Japanese csEUCPkdFmtJapanese
       EUC-JP }
     { Extended_UNIX_Code_Fixed_Width_for_Japanese csEUCFixWidJapanese }
@@ -9768,7 +9768,7 @@ proc tcl_encoding {enc} {
     set i [lsearch -exact $lcnames $enc]
     if {$i < 0} {
 	# look for "isonnn" instead of "iso-nnn" or "iso_nnn"
-	if {[regsub {^iso[-_]} $enc iso encx]} {
+	if {[regsub {^(iso|cp|ibm|jis)[-_]} $enc {\1} encx]} {
 	    set i [lsearch -exact $lcnames $encx]
 	}
     }
@@ -9780,7 +9780,7 @@ proc tcl_encoding {enc} {
 	    foreach e $ll {
 		set i [lsearch -exact $lcnames $e]
 		if {$i < 0} {
-		    if {[regsub {^iso[-_]} $e iso ex]} {
+		    if {[regsub {^(iso|cp|ibm|jis)[-_]} $e {\1} ex]} {
 			set i [lsearch -exact $lcnames $ex]
 		    }
 		}
@@ -9795,6 +9795,45 @@ proc tcl_encoding {enc} {
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
+proc get_cached_encoding {path} {
+	global path_encoding_cache
+	if {[info exists path_encoding_cache($path)]} {
+		return $path_encoding_cache($path)
+	} else {
+		set enc [get_path_encoding $path]
+		set path_encoding_cache($path) $enc
+		return $enc
+	}
+}
+
 # First check that Tcl/Tk is recent enough
 if {[catch {package require Tk 8.4} err]} {
     show_error {} . [mc "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
@@ -9817,6 +9856,11 @@ if {$tclencoding == {}} {
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
