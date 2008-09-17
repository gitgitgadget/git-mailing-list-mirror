From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI,GITK) 4/8] git-gui: Optimize encoding name resolution using a lookup table.
Date: Thu, 18 Sep 2008 01:07:35 +0400
Message-ID: <1221685659-476-5-git-send-email-angavrilov@gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
 <1221685659-476-2-git-send-email-angavrilov@gmail.com>
 <1221685659-476-3-git-send-email-angavrilov@gmail.com>
 <1221685659-476-4-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 23:12:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg4IU-0003an-DU
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 23:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbYIQVJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 17:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbYIQVJM
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 17:09:12 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:50839 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbYIQVJC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 17:09:02 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3045913fkq.5
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 14:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=34m2cvI45H01fpog0msoo0JqJXIMhOmN9yDrtAdl+Tg=;
        b=DERi3gyEeP/BHHa+o/Jj7KW3LVHEnweL1Tq52/Cz3VaqBDVgETxiAVYFeIhnGIKSTr
         hcD2VgP5DoHV8BZB/0r0+VsJxqynJzlS/X/8Srw56cS6MbsEyX9EQuDuqyxOFD9r3wOO
         IKyL08z99QlucKxo6JfYCYISgOhqRUddmvSDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FzKSj2H4s7krwrMJ67NW0I1hYTHSUciZPIZ9urnhVsoc5ZuSFVdfBvAflHzEIqeF0F
         OD5TZz+wrXdkeCMG6KKvlMrQZIPqSYP6i8kr4RguorXmgUpfpTcB8s2YQdW3H2RyEP4X
         acTsxaITI8xQpszHS8XRuBAZugOy1dfnLpNPs=
Received: by 10.180.231.20 with SMTP id d20mr2323859bkh.68.1221685739718;
        Wed, 17 Sep 2008 14:08:59 -0700 (PDT)
Received: from localhost.localdomain ( [92.255.85.78])
        by mx.google.com with ESMTPS id z10sm17426586fka.15.2008.09.17.14.08.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 14:08:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1221685659-476-4-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96143>

Encoding menu construction does almost a hundred of encoding
resolutions, which with the old implementation led to a
small but noticeable delay.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/encoding.tcl |   82 +++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/lib/encoding.tcl b/lib/encoding.tcl
index b2ee38c..32668fc 100644
--- a/lib/encoding.tcl
+++ b/lib/encoding.tcl
@@ -286,39 +286,63 @@ set encoding_groups {
 	{"Symbol" Symbol Dingbats MacDingbats MacCentEuro}}
 }
 
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
+	}
+
+	foreach item $names {
+		set encoding_lookup_table([lindex $item 0]) [lindex $item 1]
+	}
+}
+
 proc tcl_encoding {enc} {
-    global encoding_aliases
-    set names [encoding names]
-    set lcnames [string tolower $names]
-    set enc [string tolower $enc]
-    set i [lsearch -exact $lcnames $enc]
-    if {$i < 0} {
-	# look for "isonnn" instead of "iso-nnn" or "iso_nnn"
-	if {[regsub {^(iso|cp|ibm|jis)[-_]} $enc {\1} encx]} {
-	    set i [lsearch -exact $lcnames $encx]
+	global encoding_lookup_table
+	if {$enc eq {}} {
+		return {}
+	}
+	if {![info exists encoding_lookup_table]} {
+		build_encoding_table
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
 
 proc force_path_encoding {path enc} {
-- 
1.6.0.20.g6148bc
