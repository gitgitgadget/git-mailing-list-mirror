From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI,GITK) 6/8] gitk: Port new encoding logic from git-gui.
Date: Thu, 18 Sep 2008 01:07:37 +0400
Message-ID: <1221685659-476-7-git-send-email-angavrilov@gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
 <1221685659-476-2-git-send-email-angavrilov@gmail.com>
 <1221685659-476-3-git-send-email-angavrilov@gmail.com>
 <1221685659-476-4-git-send-email-angavrilov@gmail.com>
 <1221685659-476-5-git-send-email-angavrilov@gmail.com>
 <1221685659-476-6-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 23:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg4IW-0003an-0D
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 23:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbYIQVJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 17:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbYIQVJQ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 17:09:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:53356 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbYIQVJC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 17:09:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2125237fgg.17
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0ps7gUjiDCWWWR5dczYUIjbauimywh1M/ybgkOtVUNM=;
        b=vqlwZpXEjWjkmawscuA6irikDmzb8Y0kBKRiQO+Kq0lLBDbYuKRR0mmv8rwn4zTpX4
         WrUo7TifJujFnE8+2oDPjJDMqhKjKas4prx7I1KWnyfgj7AfmS+gdkuZ1MTnHrCHQ2kF
         bMPZPkGmXe0m0uboM8uyiD/UUHm5tT65rlyZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=C0Hy331ZpCszIC/ihhPnQYUd4WU82LPB74lqoAOQYrS5+8fzuqSq5m+dx3G5xcQ5pk
         Xgxtykv2EGxFagSmp8PaRVpQRSiA+oPlNiIJ9cPeh1d1uZ96VJ6rhzNZ7/DvLeQvmmqQ
         faLSWnrK69Qp26x0jupnn4TCLLotfpwn9o7/0=
Received: by 10.180.244.19 with SMTP id r19mr2314263bkh.94.1221685741771;
        Wed, 17 Sep 2008 14:09:01 -0700 (PDT)
Received: from localhost.localdomain ( [92.255.85.78])
        by mx.google.com with ESMTPS id z10sm17426586fka.15.2008.09.17.14.09.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 14:09:01 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1221685659-476-6-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96140>

Add functions that implement the same logic for file
contents encoding as git-gui uses:

- Defaults to the system encoding.
- Overridden by setting the gui.encoding option.
- Further overridden on per-file basis by gitattributes.

Also extends the range of supported encoding names.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
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
