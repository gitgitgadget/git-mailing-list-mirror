From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v3 3/4] gitk: Implement batch lookup and caching of encoding attrs.
Date: Mon, 13 Oct 2008 12:12:33 +0400
Message-ID: <1223885554-27718-4-git-send-email-angavrilov@gmail.com>
References: <1223885554-27718-1-git-send-email-angavrilov@gmail.com>
 <1223885554-27718-2-git-send-email-angavrilov@gmail.com>
 <1223885554-27718-3-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 10:16:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpIbN-0003kw-J5
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 10:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019AbYJMIO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 04:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755134AbYJMIO1
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 04:14:27 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:21158 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976AbYJMIOW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 04:14:22 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1550920fkq.5
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 01:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7rE2XLqYng5O3bbRPEW+pmbYjf1rfAqzW6lL01AFiYE=;
        b=T+kBHCOaoKloUesb86EXv1qq7fEXnVcmSJxEWR30ATNhok8MiUBDScSTsMkhmtkDBM
         Y+oeY00l8CZ2VP3IjINDLYbyXSnC2gVT2IS0x4wZpFlbFeeJ3HpdAm1Dr9mbdxo/EBbJ
         hhAzTHxWa+z03lGFzbGf4/LuwXk+84gujIsIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AhCOCZfzf6DHnoanr9hlhCAWtpamQWDFoYZTST+30ZfWPPv/gBIsYWFV7Qom1CAysq
         BYf09DF7sEU9pEZT9r36lwMXjEUjMB3A/8ut8BWsqDs6O8q/jOqdE1sy2k+707puPsHd
         kUClxkGD8DPgfMnjT1LAMf657WwYb5Ljzny8M=
Received: by 10.181.58.17 with SMTP id l17mr4213535bkk.12.1223885660816;
        Mon, 13 Oct 2008 01:14:20 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm6128723fks.6.2008.10.13.01.14.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 01:14:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1223885554-27718-3-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98092>

When the diff contains thousands of files, calling git-check-attr
once per file is very slow. With this patch gitk does attribute
lookup in batches of 30 files while reading the diff file list,
which leads to a very noticeable speedup.

It may be possible to reimplement this even more efficiently,
if git-check-attr is modified to support a --stdin-paths option.
Additionally, it should quote the ':' character in file paths,
or provide a more robust way of column separation.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
Tested-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 gitk |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 5f35f61..8cd3171 100755
--- a/gitk
+++ b/gitk
@@ -6531,6 +6531,7 @@ proc gettreediffline {gdtf ids} {
     global cmitmode vfilelimit curview limitdiffs
 
     set nr 0
+    set sublist {}
     while {[incr nr] <= 1000 && [gets $gdtf line] >= 0} {
 	set i [string first "\t" $line]
 	if {$i >= 0} {
@@ -6540,8 +6541,10 @@ proc gettreediffline {gdtf ids} {
 	    }
 	    set file [encoding convertfrom $file]
 	    lappend treediff $file
+	    lappend sublist $file
 	}
     }
+    cache_gitattr encoding $sublist
     if {![eof $gdtf]} {
 	return [expr {$nr >= 1000? 2: 1}]
     }
@@ -9816,18 +9819,48 @@ proc tcl_encoding {enc} {
 }
 
 proc gitattr {path attr default} {
-	if {[catch {set r [exec git check-attr $attr -- $path]}]} {
+	global path_attr_cache
+	if {[info exists path_attr_cache($attr,$path)]} {
+		set r $path_attr_cache($attr,$path)
+	} elseif {[catch {set r [exec git check-attr $attr -- $path]}]} {
 		set r unspecified
 	} else {
 		set r [join [lrange [split $r :] 2 end] :]
 		regsub {^ } $r {} r
 	}
+	set path_attr_cache($attr,$path) $r
 	if {$r eq {unspecified}} {
 		return $default
 	}
 	return $r
 }
 
+proc cache_gitattr {attr pathlist} {
+	global path_attr_cache
+	set newlist {}
+	foreach path $pathlist {
+		if {[info exists path_attr_cache($attr,$path)]} continue
+		lappend newlist $path
+	}
+	while {$newlist ne {}} {
+		set head [lrange $newlist 0 29]
+		set newlist [lrange $newlist 30 end]
+		if {![catch {set rlist [eval exec git check-attr $attr -- $head]}]} {
+			foreach row [split $rlist "\n"] {
+				set cols [split $row :]
+				set path [lindex $cols 0]
+				set value [join [lrange $cols 2 end] :]
+				if {[string index $path 0] eq "\""} {
+					set path [encoding convertfrom [lindex $path 0]]
+				}
+				regsub {^ } $value {} value
+				set path_attr_cache($attr,$path) $value
+			}
+		}
+		update
+	}
+}
+
 proc get_path_encoding {path} {
 	global gui_encoding
 	set tcl_enc [tcl_encoding $gui_encoding]
-- 
1.6.0.20.g6148bc
