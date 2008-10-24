From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH 3/7] gitk: Allow starting gui blame for a specific line.
Date: Fri, 24 Oct 2008 12:13:01 +0400
Organization: HOME
Message-ID: <200810241213.01337.angavrilov@gmail.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com> <1223449540-20457-4-git-send-email-angavrilov@gmail.com> <18688.26370.467724.404768@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Oct 24 10:16:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtHqC-00033r-KY
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 10:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbYJXIPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 04:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbYJXIPE
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 04:15:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:26660 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbYJXIO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 04:14:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so886021fgg.17
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=MZZhYuFcAVfM4AS/ijyBHtsRmy1NvJaqNMGIUxo+EBk=;
        b=I2uXozyGtfhOub8V2Eq8JrJWlwiXG6c3DdjQcFbogUkb6/E/N1R2K1WMah8jaO0Jts
         A4+ubtUW2KTFjw6gCWphFgV7vSSc1owEclxs55RNFzm08mansYstnQ5LDwHB8or2/Snf
         Vd7ZYTp3o66gFfZhnRSaQFZJ9iE9K/PIzbgBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=yDd9kdwney06TAVJqC0LciOnm9seaAYKlpQ/E6L5Gkfu0j3BVu/B/pE4wiF8WulHyu
         hPEdsXu/asG8jJ9CJDL0kKUXWKs5VcABL7KP8hGWwSOrZVk8Xh+yv4RZLSVHvR3PMybG
         KMvMXp4+dWLil1FDpKiutPuxDOIYHHhVxtJuA=
Received: by 10.181.234.5 with SMTP id l5mr605757bkr.124.1224836096847;
        Fri, 24 Oct 2008 01:14:56 -0700 (PDT)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id k29sm21811623fkk.2.2008.10.24.01.14.54
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Oct 2008 01:14:55 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26.5-45.fc9.i686; KDE/4.1.1; i686; ; )
In-Reply-To: <18688.26370.467724.404768@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99020>

On Thursday 23 October 2008 15:58:58 Paul Mackerras wrote:
> > +    # Now scan the lines to determine offset within the hunk
> > +    set parent {}
> > +    set dline 0
> > +    set s_lno [lindex [split $s_lix "."] 0]
> > +
> > +    for {set i $line} {$i > $s_lno} {incr i -1} {
> > +	set c_line [$ctext get $i.0 "$i.0 + 1 lines"]
> > +	if {$parent eq {}} {
> > +	    # find first preceeding line that belongs to some parent
> > +	    for {set j 0} {$j < [llength $old_lines]} {incr j} {
> > +		set code [string index $c_line $j]
> > +		if {$code ne {-} && $code ne { }} continue
> > +		if {$code eq { } && $parent ne {}} continue
> > +		set parent $j
> > +		if {$code eq {-}} break
> > +	    }
> > +	}
> 
> This part worries me a bit.  If the user clicks on a line where all
> the $code values are "+" then I think we should blame the current
> commit.  Either that, or we disable the context menu item before
> posting it if the user clicks on a line that starts with all "+"
> characters (as many "+" as there are parents).

Good point. How about this variant? I renamed the menu item, and
changed the code to blame the current commit if:

- The display is in the tree mode, or
- The line is added relative to all parents, or
- Diff analysis failed

I also fixed a bug in processing of deleted lines in combined diffs,
and made the parent selection code more readable (hopefully).

--- >8 ---
From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH] gitk: Allow starting gui blame for a specific line.

Adds a context menu item to the diff viewer pane that
calls blame, focusing it on the clicked line. In case
of combined diffs, it also automatically deduces which
parent is to be blamed. Lines added by the diff are
blamed on the current commit itself.

The context menu itself is added by this patch. It is
possible to populate it with commands from the flist
menu.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |  148 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index f6a3e10..6fbd6bb 100755
--- a/gitk
+++ b/gitk
@@ -2249,6 +2249,7 @@ proc makewindow {} {
     bind $cflist <ButtonRelease-1> {treeclick %W %x %y}
     global ctxbut
     bind $cflist $ctxbut {pop_flist_menu %W %X %Y %x %y}
+    bind $ctext $ctxbut {pop_diff_menu %W %X %Y %x %y}
 
     set maincursor [. cget -cursor]
     set textcursor [$ctext cget -cursor]
@@ -2291,6 +2292,13 @@ proc makewindow {} {
 	{mc "Blame parent commit" command {external_blame 1}}
     }
     $flist_menu configure -tearoff 0
+
+    global diff_menu
+    set diff_menu .diffctxmenu
+    makemenu $diff_menu {
+	{mc "Blame this line" command {external_blame_diff}}
+    }
+    $diff_menu configure -tearoff 0
 }
 
 # Windows sends all mouse wheel events to the current focused window, not
@@ -2993,6 +3001,34 @@ proc pop_flist_menu {w X Y x y} {
     tk_popup $flist_menu $X $Y
 }
 
+proc find_ctext_fileinfo {line} {
+    global ctext_file_names ctext_file_lines
+
+    set ok [bsearch $ctext_file_lines $line]
+    set tline [lindex $ctext_file_lines $ok]
+
+    if {$ok >= [llength $ctext_file_lines] || $line < $tline} {
+        return {}
+    } else {
+        return [list [lindex $ctext_file_names $ok] $tline]
+    }
+}
+
+proc pop_diff_menu {w X Y x y} {
+    global ctext diff_menu flist_menu_file
+    global diff_menu_txtpos diff_menu_line
+    global diff_menu_filebase
+
+    stopfinding
+    set diff_menu_txtpos [split [$w index "@$x,$y"] "."]
+    set diff_menu_line [lindex $diff_menu_txtpos 0]
+    set f [find_ctext_fileinfo $diff_menu_line]
+    if {$f eq {}} return
+    set flist_menu_file [lindex $f 0]
+    set diff_menu_filebase [lindex $f 1]
+    tk_popup $diff_menu $X $Y
+}
+
 proc flist_hl {only} {
     global flist_menu_file findstring gdttype
 
@@ -3099,7 +3135,96 @@ proc external_diff {} {
     }
 }
 
-proc external_blame {parent_idx} {
+proc find_hunk_blamespec {base line} {
+    global ctext
+
+    # Find and parse the hunk header
+    set s_lix [$ctext search -backwards -regexp ^@@ "$line.0 lineend" $base.0]
+    if {$s_lix eq {}} return
+
+    set s_line [$ctext get $s_lix "$s_lix + 1 lines"]
+    if {![regexp {^@@@*(( -\d+(,\d+)?)+) \+(\d+)(,\d+)? @@} $s_line \
+	    s_line old_specs osz osz1 new_line nsz]} {
+	return
+    }
+
+    # base lines for the parents
+    set base_lines [list $new_line]
+    foreach old_spec [lrange [split $old_specs " "] 1 end] {
+	if {![regexp -- {-(\d+)(,\d+)?} $old_spec \
+	        old_spec old_line osz]} {
+	    return
+	}
+	lappend base_lines $old_line
+    }
+
+    # Now scan the lines to determine offset within the hunk
+    set parent {}
+    set dline 0
+    set s_lno [lindex [split $s_lix "."] 0]
+
+    for {set i $line} {$i > $s_lno} {incr i -1} {
+	set c_line [$ctext get $i.0 "$i.0 + 1 lines"]
+	# Determine if the line is removed
+	set chunk [string range $c_line 0 [llength $base_lines]-2]
+	set removed_idx [string first "-" $chunk]
+	# Choose a parent index
+	if {$parent eq {}} {
+	    if {$removed_idx >= 0} {
+		set parent $removed_idx
+		incr parent
+	    } else {
+		set unchanged_idx [string first " " $chunk]
+		if {$unchanged_idx >= 0} {
+		    set parent $unchanged_idx
+		    incr parent
+		} else {
+		    # blame the current commit
+		    set parent 0
+		}
+	    }
+	}
+	# then count other lines that belong to it
+	if {$parent > 0} {
+	    set code [string index $c_line $parent-1]
+	    if {$code eq "-" || ($removed_idx < 0 && $code ne "+")} {
+		incr dline
+	    }
+	} else {
+	    if {$removed_idx < 0} {
+		incr dline
+	    }
+	}
+    }
+
+    if {$parent eq {}} { set parent 0 }
+    incr dline [lindex $base_lines $parent]
+    return [list $parent $dline]
+}
+
+proc external_blame_diff {} {
+    global currentid diffmergeid cmitmode
+    global diff_menu_txtpos diff_menu_line
+    global diff_menu_filebase flist_menu_file
+
+    if {$cmitmode eq "tree"} {
+	set parent_idx 0
+	set line [expr {$diff_menu_line - $diff_menu_filebase - 1}]
+    } else {
+	set hinfo [find_hunk_blamespec $diff_menu_filebase $diff_menu_line]
+	if {$hinfo ne {}} {
+	    set parent_idx [lindex $hinfo 0]
+	    set line [lindex $hinfo 1]
+	} else {
+	    set parent_idx 0
+	    set line 0
+	}
+    }
+
+    external_blame $parent_idx $line
+}
+
+proc external_blame {parent_idx {line {}}} {
     global flist_menu_file
     global nullid nullid2
     global parentlist selectedline currentid
@@ -3115,7 +3240,12 @@ proc external_blame {parent_idx} {
 	return
     }
 
-    if {[catch {exec git gui blame $base_commit $flist_menu_file &} err]} {
+    set cmdline [list git gui blame]
+    if {$line ne {} && $line > 1} {
+	lappend cmdline "--line=$line"
+    }
+    lappend cmdline $base_commit $flist_menu_file
+    if {[catch {eval exec $cmdline &} err]} {
 	error_popup "[mc "git gui blame: command failed:"] $err"
     }
 }
@@ -6364,6 +6494,7 @@ proc gettreeline {gtf id} {
 
 proc showfile {f} {
     global treefilelist treeidlist diffids nullid nullid2
+    global ctext_file_names ctext_file_lines
     global ctext commentend
 
     set i [lsearch -exact $treefilelist($diffids) $f]
@@ -6387,6 +6518,8 @@ proc showfile {f} {
     filerun $bf [list getblobline $bf $diffids]
     $ctext config -state normal
     clear_ctext $commentend
+    lappend ctext_file_names $f
+    lappend ctext_file_lines [lindex [split $commentend "."] 0]
     $ctext insert end "\n"
     $ctext insert end "$f\n" filesep
     $ctext config -state disabled
@@ -6447,6 +6580,7 @@ proc mergediff {id} {
 proc getmergediffline {mdf id np} {
     global diffmergeid ctext cflist mergemax
     global difffilestart mdifffd treediffs
+    global ctext_file_names ctext_file_lines
     global diffencoding
 
     $ctext conf -state normal
@@ -6465,6 +6599,8 @@ proc getmergediffline {mdf id np} {
 	    lappend difffilestart $here
 	    lappend treediffs($id) $fname
 	    add_flist [list $fname]
+	    lappend ctext_file_names $fname
+	    lappend ctext_file_lines [lindex [split $here "."] 0]
 	    set diffencoding [get_path_encoding $fname]
 	    set l [expr {(78 - [string length $fname]) / 2}]
 	    set pad [string range "----------------------------------------" 1 $l]
@@ -6733,11 +6869,13 @@ proc setinlist {var i val} {
 
 proc makediffhdr {fname ids} {
     global ctext curdiffstart treediffs
+    global ctext_file_names
 
     set i [lsearch -exact $treediffs($ids) $fname]
     if {$i >= 0} {
 	setinlist difffilestart $i $curdiffstart
     }
+    set ctext_file_names [lreplace $ctext_file_names end end $fname]
     set l [expr {(78 - [string length $fname]) / 2}]
     set pad [string range "----------------------------------------" 1 $l]
     $ctext insert $curdiffstart "$pad $fname $pad" filesep
@@ -6746,6 +6884,7 @@ proc makediffhdr {fname ids} {
 proc getblobdiffline {bdf ids} {
     global diffids blobdifffd ctext curdiffstart
     global diffnexthead diffnextnote difffilestart
+    global ctext_file_names ctext_file_lines
     global diffinhdr treediffs
     global diffencoding
 
@@ -6763,6 +6902,8 @@ proc getblobdiffline {bdf ids} {
 	    # start of a new file
 	    $ctext insert end "\n"
 	    set curdiffstart [$ctext index "end - 1c"]
+	    lappend ctext_file_names ""
+	    lappend ctext_file_lines [lindex [split $curdiffstart "."] 0]
 	    $ctext insert end "\n" filesep
 	    # If the name hasn't changed the length will be odd,
 	    # the middle char will be a space, and the two bits either
@@ -6899,6 +7040,7 @@ proc nextfile {} {
 
 proc clear_ctext {{first 1.0}} {
     global ctext smarktop smarkbot
+    global ctext_file_names ctext_file_lines
     global pendinglinks
 
     set l [lindex [split $first .] 0]
@@ -6912,6 +7054,8 @@ proc clear_ctext {{first 1.0}} {
     if {$first eq "1.0"} {
 	catch {unset pendinglinks}
     }
+    set ctext_file_names {}
+    set ctext_file_lines {}
 }
 
 proc settabs {{firstab {}}} {
-- 
1.6.0.20.g6148bc
