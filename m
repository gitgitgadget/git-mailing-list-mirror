From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v3 4/4] gitk: Optimize encoding name resolution using a lookup table.
Date: Mon, 13 Oct 2008 12:12:34 +0400
Message-ID: <1223885554-27718-5-git-send-email-angavrilov@gmail.com>
References: <1223885554-27718-1-git-send-email-angavrilov@gmail.com>
 <1223885554-27718-2-git-send-email-angavrilov@gmail.com>
 <1223885554-27718-3-git-send-email-angavrilov@gmail.com>
 <1223885554-27718-4-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 10:16:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpIbO-0003kw-Bx
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 10:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbYJMIOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 04:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755221AbYJMIO2
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 04:14:28 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:15752 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756591AbYJMIOY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 04:14:24 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1550954fkq.5
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 01:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZPaQdb0fgdiZ4+x+Yyj6EKTbh1BppcuiY/VaoIPeaP0=;
        b=k0aP9bH8ZANFHFW+CGbscEgABtttwz901L1IN4THqKKff5Em1WBNw8/xBm7iP9/9pG
         hfFqCjHcLgnxqgEqrA03VRrEZ5QHDL7x7EtHDOSeLhv7EydMv+ImV2Oz4JAdNBQU59WB
         8CxLQXXgg1ojnCsO0MhG+FR+qEWDNP2EhnJVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DI/JbgaON/NDCpAE38RTmSGtNTX5ph0oKj2DkOJp4CBcQrDOAaGSO66RuSDDGY/4/N
         30wji5OzMqTpo9ZhlIdmNA6cl7lopaegabsjHy5DrG9EeggdvBXhDyv3svnqkGmesicv
         h62/Qf4mpQRWxbt6AflbBng8YOOyiedqr/fwk=
Received: by 10.181.137.17 with SMTP id p17mr4215317bkn.40.1223885662302;
        Mon, 13 Oct 2008 01:14:22 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm6128723fks.6.2008.10.13.01.14.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 01:14:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1223885554-27718-4-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98091>

Current implementation of tcl_encoding uses linear search,
and is rather slow when called hundreds of times. This commit
reimplements it using a lookup table, which is efficiently
calculated on the first run. After that, resolution costs two
calls to [info exists], and one actual fetch from the table.

This is a port of git-gui commit a1c3feb7fac7.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   84 ++++++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/gitk b/gitk
index 8cd3171..134df00 100755
--- a/gitk
+++ b/gitk
@@ -9783,39 +9783,63 @@ set encoding_aliases {
     { Big5 csBig5 }
 }
 
-proc tcl_encoding {enc} {
-    global encoding_aliases
-    set names [encoding names]
-    set lcnames [string tolower $names]
-    set enc [string tolower $enc]
-    set i [lsearch -exact $lcnames $enc]
-    if {$i < 0} {
-	# look for "isonnn" instead of "iso-nnn" or "iso_nnn"
-	if {[regsub {^(iso|cp|ibm|jis)[-_]} $enc {\1} encx]} {
-	    set i [lsearch -exact $lcnames $encx]
+proc build_encoding_table {} {
+	global encoding_aliases encoding_lookup_table
+
+	# Prepare the lookup list; cannot use lsort -nocase because
+	# of compatibility issues with older Tcl (e.g. in msysgit)
+	set names [list]
+	foreach item [encoding names] {
+		lappend names [list [string tolower $item] $item]
+	}
+	set names [lsort -ascii -index 0 $names]
+	# neither can we use lsearch -index
+	set lnames [list]
+	foreach item $names {
+		lappend lnames [lindex $item 0]
+	}
+
+	foreach grp $encoding_aliases {
+		set target {}
+		foreach item $grp {
+			set i [lsearch -sorted -ascii $lnames \
+					[string tolower $item]]
+			if {$i >= 0} {
+				set target [lindex $names $i 1]
+				break
+			}
+		}
+		if {$target eq {}} continue
+		foreach item $grp {
+			set encoding_lookup_table([string tolower $item]) $target
+		}
 	}
-    }
-    if {$i < 0} {
-	foreach l $encoding_aliases {
-	    set ll [string tolower $l]
-	    if {[lsearch -exact $ll $enc] < 0} continue
-	    # look through the aliases for one that tcl knows about
-	    foreach e $ll {
-		set i [lsearch -exact $lcnames $e]
-		if {$i < 0} {
-		    if {[regsub {^(iso|cp|ibm|jis)[-_]} $e {\1} ex]} {
-			set i [lsearch -exact $lcnames $ex]
-		    }
+
+	foreach item $names {
+		set encoding_lookup_table([lindex $item 0]) [lindex $item 1]
+	}
+}
+
+proc tcl_encoding {enc} {
+	global encoding_lookup_table
+	if {$enc eq {}} {
+		return {}
+	}
+	if {![info exists encoding_lookup_table]} {
+		build_encoding_table
+	}
+	set enc [string tolower $enc]
+	if {![info exists encoding_lookup_table($enc)]} {
+		# look for "isonnn" instead of "iso-nnn" or "iso_nnn"
+		if {[regsub {^(iso|cp|ibm|jis)[-_]} $enc {\1} encx]} {
+			set enc $encx
 		}
-		if {$i >= 0} break
-	    }
-	    break
 	}
-    }
-    if {$i >= 0} {
-	return [lindex $names $i]
-    }
-    return {}
+	if {[info exists encoding_lookup_table($enc)]} {
+		return $encoding_lookup_table($enc)
+	} else {
+		return {}
+	}
 }
 
 proc gitattr {path attr default} {
-- 
1.6.0.20.g6148bc
