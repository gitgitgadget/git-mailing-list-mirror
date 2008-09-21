From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH (GIT-GUI,GITK) 6/8] gitk: Port new encoding logic from git-gui.
Date: Sun, 21 Sep 2008 22:52:35 +0400
Organization: HOME
Message-ID: <200809212252.35769.angavrilov@gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com> <bb6f213e0809190538m5bbfeb38o5510d06fa6757dd1@mail.gmail.com> <48D3A376.30905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Sep 21 20:55:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhU5R-0006zq-Bp
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 20:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbYIUSyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 14:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbYIUSyE
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 14:54:04 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:47760 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbYIUSyC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 14:54:02 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1215479fkq.5
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1qqdIoA2ka5iu+KRjNF/mktiLBNYx81vNRDHZuJAAHI=;
        b=T3jV9bhX4mQK9kzb9wwRAVNUOHaAOJsuZjHBHq5KJ3OEZwXeXLVDkNvRnTTmDSiCIg
         81mRMY3ZJmg2ds4lQWm0xCDXUGNWna8NO8Q/Q/fm+GiojFZrXMCA7zKgZOM6f3sqD6mY
         uiIEqw6HMlJitnzMq5GnypDTlc8VF/j+OuYLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=e5mzkk+5ePs3+sKXD46CyRFb1hDNsA/+antlJEs0TeG3ZLPEl1Dml3M0GCeMpvwWju
         CcCHgFHa8+yR2HGI15+hpEiUhTuqMAWmEJZeIMG2v+2IyxEpgmg1flWucYoKrrjT1Qlb
         uHmzhnyYPPJnzFV20Lje8MpOWYrcTNrFnMh2I=
Received: by 10.180.221.13 with SMTP id t13mr1853863bkg.19.1222023239324;
        Sun, 21 Sep 2008 11:53:59 -0700 (PDT)
Received: from keydesk.localnet ( [92.255.85.78])
        by mx.google.com with ESMTPS id e17sm3770732fke.10.2008.09.21.11.53.57
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 11:53:58 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26.3-29.fc9.i686; KDE/4.1.0; i686; ; )
In-Reply-To: <48D3A376.30905@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96421>

On Friday 19 September 2008 17:04:54 Johannes Sixt wrote:
> Alexander Gavrilov schrieb:
> > Also, it should work in the patch mode as well: it reads the patch as
> > binary, and decodes each line separately, based on the encoding
> > determined for the current file.
> 
> This is great. But we'll have to see how this works on a multi-file diff
> on Windows. (I sense slowness.)
> 

Yes, yesterday I noticed that when the patch is very big, like when the
index has got out of sync, and gitk claims local changes in all of the git-gui
repository (>1000 files), first view is slow even on Linux.

I made a patch to optimize attribute lookup. I'm afraid that further optimization
is impossible without interface changes in git-check-attr, or reimplementing
the attribute parser in Tcl.

--- >8 ---
From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH] gitk: Implement batch lookup and caching of encoding attrs.

When the diff contains thousands of files, calling git-check-attr
once per file is very slow. With this patch gitk does attribute
lookup in batches of 30 files while reading the diff file list,
which leads to a very noticeable speedup.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 1355aa2..6fc1e90 100755
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
@@ -9839,18 +9842,47 @@ proc tcl_encoding {enc} {
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
