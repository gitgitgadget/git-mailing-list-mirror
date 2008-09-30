From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v2 4/4] gitk: Implement batch lookup and caching of encoding attrs.
Date: Tue, 30 Sep 2008 15:00:22 +0400
Message-ID: <1222772422-28020-5-git-send-email-angavrilov@gmail.com>
References: <1222772422-28020-1-git-send-email-angavrilov@gmail.com>
 <1222772422-28020-2-git-send-email-angavrilov@gmail.com>
 <1222772422-28020-3-git-send-email-angavrilov@gmail.com>
 <1222772422-28020-4-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 13:03:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkd0m-0000DF-1E
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 13:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbYI3LCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 07:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbYI3LCM
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 07:02:12 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:13407 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbYI3LCF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 07:02:05 -0400
Received: by ey-out-2122.google.com with SMTP id 6so717965eyi.37
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 04:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=G2QcFNVoYH1pewQ5ITjSz7iPKtRAtm5I4PcsyVoD4bo=;
        b=UuVUizeaETERMmDsgEmSC0w9+Dm7LhLlvfuRaWvTh+PCCKqbJpIcyVtMwp1SlGixbq
         BtG2hyW6W4DBstB/rH1xKsqcBuKXWcyPcVHmstG+v2Tkx8/tI3Kw2/+YgucN3S1KmWXA
         36NKK9L+bhgKVXYm8tcBmOpEblWdUntcqtgb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iSdnBw99LZ7NkcwCwUWvI7cFxHgTIBH9Ix1EgeQpVy8G34IxIcjrhNHpE/9nOajgDM
         FRrHpJ6m8sK/+A+ojPH51j3uXU7wXPMz2qS561o6co+NoVZn9TmYahmyXSTZDTw1SWnh
         tLd1s5PYeW6SY8W4pqwxNnXSg08RUOoqR2Q40=
Received: by 10.103.52.13 with SMTP id e13mr4698800muk.80.1222772524297;
        Tue, 30 Sep 2008 04:02:04 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id y6sm7517378mug.7.2008.09.30.04.02.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 04:02:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1222772422-28020-4-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97100>

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
index 1355aa2..cf557c3 100755
--- a/gitk
+++ b/gitk
@@ -6530,6 +6530,7 @@ proc gettreediffline {gdtf ids} {
     global cmitmode vfilelimit curview limitdiffs
 
     set nr 0
+    set sublist {}
     while {[incr nr] <= 1000 && [gets $gdtf line] >= 0} {
 	set i [string first "\t" $line]
 	if {$i >= 0} {
@@ -6539,8 +6540,10 @@ proc gettreediffline {gdtf ids} {
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
@@ -9839,18 +9842,48 @@ proc tcl_encoding {enc} {
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
