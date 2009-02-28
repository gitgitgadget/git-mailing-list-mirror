From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: put all startup code into a proc to enable re-sourcing
Date: 28 Feb 2009 00:17:13 +0000
Message-ID: <87prh3e7p2.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 03:02:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdEXJ-0001VE-Cd
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 03:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762266AbZB1CBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 21:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762275AbZB1CBG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 21:01:06 -0500
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:60700 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762229AbZB1CBA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 21:01:00 -0500
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1LdCtM-0000sD-99; Sat, 28 Feb 2009 00:17:20 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1LdCtG-00080l-Gn; Sat, 28 Feb 2009 00:17:19 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 0354851836; Sat, 28 Feb 2009 00:17:13 +0000 (GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111738>


    All the startup code is moved into a procedure. All the variables
    get initialized using 'variable' to ensure they are in the global
    namespace.  This makes it possible to re-source the script during
    development from the Tk console or a tkcon interactive session.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |  578 +++++++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 309 insertions(+), 269 deletions(-)

diff --git a/gitk b/gitk
index dc2a439..f8c3c73 100755
--- a/gitk
+++ b/gitk
@@ -7,6 +7,8 @@ exec wish "$0" -- "$@"
 # and distributed under the terms of the GNU General Public Licence,
 # either version 2, or (at your option) any later version.
 
+package require Tk
+
 proc gitdir {} {
     global env
     if {[info exists env(GIT_DIR)]} {
@@ -1794,39 +1796,48 @@ proc show_error {w top msg} {
 }
 
 proc error_popup {msg {owner .}} {
-    set w .error
-    toplevel $w
-    make_transient $w $owner
-    show_error $w $w $msg
+    if {[tk windowingsystem] eq "win32"} {
+        tk_messageBox -icon error -type ok -title [wm title .] \
+            -parent $owner -message $msg
+    } else {
+        set w .error
+        toplevel $w
+        make_transient $w $owner
+        show_error $w $w $msg
+    }
 }
 
 proc confirm_popup {msg {owner .}} {
-    global confirm_ok
+    global confirm_ok use_ttk
+    set ttk [expr {$use_ttk ? "ttk" : ""}]
     set confirm_ok 0
     set w .confirm
     toplevel $w
     make_transient $w $owner
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
-    button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
+    ${ttk}::button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
     pack $w.ok -side left -fill x
-    button $w.cancel -text [mc Cancel] -command "destroy $w"
+    ${ttk}::button $w.cancel -text [mc Cancel] -command "destroy $w"
     pack $w.cancel -side right -fill x
     bind $w <Visibility> "grab $w; focus $w"
-    bind $w <Key-Return> "set confirm_ok 1; destroy $w"
+    bind $w <Key-Return> [list $w.ok invoke]
     bind $w <Key-space>  "set confirm_ok 1; destroy $w"
-    bind $w <Key-Escape> "destroy $w"
+    bind $w <Key-Escape> [list $w.cancel invoke]
+    tk::PlaceWindow $w widget $owner
     tkwait window $w
     return $confirm_ok
 }
 
 proc setoptions {} {
-    option add *Panedwindow.showHandle 1 startupFile
-    option add *Panedwindow.sashRelief raised startupFile
+    if {[tk windowingsystem] ne "win32"} {
+        option add *Panedwindow.showHandle 1 startupFile
+        option add *Panedwindow.sashRelief raised startupFile
+        option add *Menu.font uifont startupFile
+    }
     option add *Button.font uifont startupFile
     option add *Checkbutton.font uifont startupFile
     option add *Radiobutton.font uifont startupFile
-    option add *Menu.font uifont startupFile
     option add *Menubutton.font uifont startupFile
     option add *Label.font uifont startupFile
     option add *Message.font uifont startupFile
@@ -10649,274 +10660,303 @@ proc get_path_encoding {path} {
     return $tcl_enc
 }
 
-# First check that Tcl/Tk is recent enough
-if {[catch {package require Tk 8.4} err]} {
-    show_error {} . [mc "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
+proc init {args} {
+    global env argv0
+
+    ## For msgcat loading, first locate the installation location.
+    if { [info exists ::env(GITK_MSGSDIR)] } {
+        ## Msgsdir was manually set in the environment.
+        variable gitk_msgsdir $::env(GITK_MSGSDIR)
+    } else {
+        ## Let's guess the prefix from argv0.
+        set gitk_prefix [file dirname [file dirname [file normalize $argv0]]]
+        variable gitk_libdir [file join $gitk_prefix share gitk lib]
+        variable gitk_msgsdir [file join $gitk_libdir msgs]
+        unset gitk_prefix
+    }
+
+    ## Internationalization (i18n) through msgcat and gettext. See
+    ## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
+    package require msgcat
+    namespace import ::msgcat::mc
+    ## And eventually load the actual message catalog
+    ::msgcat::mcload $gitk_msgsdir
+    
+
+    # First check that Tcl/Tk is recent enough
+    if {[catch {package require Tk 8.4} err]} {
+        tk_messageBox -icon error -type ok \
+            -title "[file tail $argv0]: [file tail [pwd]]"\
+            -message [mc "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
 		     Gitk requires at least Tcl/Tk 8.4."]
-    exit 1
-}
+        exit 1
+    }
 
-# defaults...
-set wrcomcmd "git diff-tree --stdin -p --pretty"
+    # Hide the main window until everything is ready.
+    wm withdraw .
 
-set gitencoding {}
-catch {
-    set gitencoding [exec git config --get i18n.commitencoding]
-}
-catch {
-    set gitencoding [exec git config --get i18n.logoutputencoding]
-}
-if {$gitencoding == ""} {
-    set gitencoding "utf-8"
-}
-set tclencoding [tcl_encoding $gitencoding]
-if {$tclencoding == {}} {
-    puts stderr "Warning: encoding $gitencoding is not supported by Tcl/Tk"
-}
+    # defaults...
+    variable wrcomcmd "git diff-tree --stdin -p --pretty"
 
-set gui_encoding [encoding system]
-catch {
-    set enc [exec git config --get gui.encoding]
-    if {$enc ne {}} {
-	set tclenc [tcl_encoding $enc]
-	if {$tclenc ne {}} {
-	    set gui_encoding $tclenc
-	} else {
-	    puts stderr "Warning: encoding $enc is not supported by Tcl/Tk"
-	}
-    }
-}
-
-set mainfont {Helvetica 9}
-set textfont {Courier 9}
-set uifont {Helvetica 9 bold}
-set tabstop 8
-set findmergefiles 0
-set maxgraphpct 50
-set maxwidth 16
-set revlistorder 0
-set fastdate 0
-set uparrowlen 5
-set downarrowlen 5
-set mingaplen 100
-set cmitmode "patch"
-set wrapcomment "none"
-set showneartags 1
-set maxrefs 20
-set maxlinelen 200
-set showlocalchanges 1
-set limitdiffs 1
-set datetimeformat "%Y-%m-%d %H:%M:%S"
-set autoselect 1
-set perfile_attrs 0
-
-set extdifftool "meld"
-
-set colors {green red blue magenta darkgrey brown orange}
-set bgcolor white
-set fgcolor black
-set diffcolors {red "#00a000" blue}
-set diffcontext 3
-set ignorespace 0
-set selectbgcolor gray85
-set markbgcolor "#e0e0ff"
-
-set circlecolors {white blue gray blue blue}
-
-# button for popping up context menus
-if {[tk windowingsystem] eq "aqua"} {
-    set ctxbut <Button-2>
-} else {
-    set ctxbut <Button-3>
-}
-
-## For msgcat loading, first locate the installation location.
-if { [info exists ::env(GITK_MSGSDIR)] } {
-    ## Msgsdir was manually set in the environment.
-    set gitk_msgsdir $::env(GITK_MSGSDIR)
-} else {
-    ## Let's guess the prefix from argv0.
-    set gitk_prefix [file dirname [file dirname [file normalize $argv0]]]
-    set gitk_libdir [file join $gitk_prefix share gitk lib]
-    set gitk_msgsdir [file join $gitk_libdir msgs]
-    unset gitk_prefix
-}
-
-## Internationalization (i18n) through msgcat and gettext. See
-## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
-package require msgcat
-namespace import ::msgcat::mc
-## And eventually load the actual message catalog
-::msgcat::mcload $gitk_msgsdir
-
-catch {source ~/.gitk}
-
-font create optionfont -family sans-serif -size -12
-
-parsefont mainfont $mainfont
-eval font create mainfont [fontflags mainfont]
-eval font create mainfontbold [fontflags mainfont 1]
-
-parsefont textfont $textfont
-eval font create textfont [fontflags textfont]
-eval font create textfontbold [fontflags textfont 1]
-
-parsefont uifont $uifont
-eval font create uifont [fontflags uifont]
-
-setoptions
-
-# check that we can find a .git directory somewhere...
-if {[catch {set gitdir [gitdir]}]} {
-    show_error {} . [mc "Cannot find a git repository here."]
-    exit 1
-}
-if {![file isdirectory $gitdir]} {
-    show_error {} . [mc "Cannot find the git directory \"%s\"." $gitdir]
-    exit 1
-}
-
-set selecthead {}
-set selectheadid {}
-
-set revtreeargs {}
-set cmdline_files {}
-set i 0
-set revtreeargscmd {}
-foreach arg $argv {
-    switch -glob -- $arg {
-	"" { }
-	"--" {
-	    set cmdline_files [lrange $argv [expr {$i + 1}] end]
-	    break
-	}
-	"--select-commit=*" {
-	    set selecthead [string range $arg 16 end]
-	}
-	"--argscmd=*" {
-	    set revtreeargscmd [string range $arg 10 end]
-	}
-	default {
-	    lappend revtreeargs $arg
-	}
+    set gitencoding {}
+    catch {
+        set gitencoding [exec git config --get i18n.commitencoding]
+    }
+    catch {
+        set gitencoding [exec git config --get i18n.logoutputencoding]
+    }
+    if {$gitencoding == ""} {
+        set gitencoding "utf-8"
+    }
+    variable tclencoding [tcl_encoding $gitencoding]
+    if {$tclencoding == {}} {
+        puts stderr "Warning: encoding $gitencoding is not supported by Tcl/Tk"
     }
-    incr i
-}
 
-if {$selecthead eq "HEAD"} {
-    set selecthead {}
-}
+    variable gui_encoding [encoding system]
+    catch {
+        set enc [exec git config --get gui.encoding]
+        if {$enc ne {}} {
+            set tclenc [tcl_encoding $enc]
+            if {$tclenc ne {}} {
+                set gui_encoding $tclenc
+            } else {
+                puts stderr "Warning: encoding $enc is not supported by Tcl/Tk"
+            }
+        }
+    }
+    
+    variable have_tk85 [package vsatisfies [package provide Tk] 8.5]
+    variable use_ttk [llength [info commands ::ttk::style]]
+    variable mainfont {Helvetica 9}
+    variable textfont {Courier 9}
+    variable uifont {Helvetica 9 bold}
+    variable tabstop 8
+    variable findmergefiles 0
+    variable maxgraphpct 50
+    variable maxwidth 16
+    variable revlistorder 0
+    variable fastdate 0
+    variable uparrowlen 5
+    variable downarrowlen 5
+    variable mingaplen 100
+    variable cmitmode "patch"
+    variable wrapcomment "none"
+    variable showneartags 1
+    variable maxrefs 20
+    variable maxlinelen 200
+    variable showlocalchanges 1
+    variable limitdiffs 1
+    variable datetimeformat "%Y-%m-%d %H:%M:%S"
+    variable autoselect 1
+    variable perfile_attrs 0
+
+    variable extdifftool "meld"
+
+    variable colors {green red blue magenta darkgrey brown orange}
+    variable bgcolor white
+    variable fgcolor black
+    variable diffcolors {red "#00a000" blue}
+    variable diffcontext 3
+    variable ignorespace 0
+    variable selectbgcolor gray85
+    variable markbgcolor "#e0e0ff"
+
+    variable circlecolors {white blue gray blue blue}
+
+    # button for popping up context menus
+    if {[tk windowingsystem] eq "aqua"} {
+        variable ctxbut <Button-2>
+    } else {
+        variable ctxbut <Button-3>
+    }
 
-if {$i >= [llength $argv] && $revtreeargs ne {}} {
-    # no -- on command line, but some arguments (other than --argscmd)
-    if {[catch {
-	set f [eval exec git rev-parse --no-revs --no-flags $revtreeargs]
-	set cmdline_files [split $f "\n"]
-	set n [llength $cmdline_files]
-	set revtreeargs [lrange $revtreeargs 0 end-$n]
-	# Unfortunately git rev-parse doesn't produce an error when
-	# something is both a revision and a filename.  To be consistent
-	# with git log and git rev-list, check revtreeargs for filenames.
-	foreach arg $revtreeargs {
-	    if {[file exists $arg]} {
-		show_error {} . [mc "Ambiguous argument '%s': both revision\
+
+    catch {source ~/.gitk}
+
+    font create optionfont -family sans-serif -size -12
+
+    parsefont mainfont $mainfont
+    eval font create mainfont [fontflags mainfont]
+    eval font create mainfontbold [fontflags mainfont 1]
+
+    parsefont textfont $textfont
+    eval font create textfont [fontflags textfont]
+    eval font create textfontbold [fontflags textfont 1]
+    
+    parsefont uifont $uifont
+    eval font create uifont [fontflags uifont]
+
+    setoptions
+
+    # check that we can find a .git directory somewhere...
+    if {[catch {set gitdir [gitdir]}]} {
+        show_error {} . [mc "Cannot find a git repository here."]
+        exit 1
+    }
+    if {![file isdirectory $gitdir]} {
+        show_error {} . [mc "Cannot find the git directory \"%s\"." $gitdir]
+        exit 1
+    }
+
+    variable selecthead {}
+    variable selectheadid {}
+    
+    variable revtreeargs {}
+    set cmdline_files {}
+    set i 0
+    set revtreeargscmd {}
+    foreach arg $args {
+        switch -glob -- $arg {
+            "" { }
+            "--" {
+                set cmdline_files [lrange $args [expr {$i + 1}] end]
+                break
+            }
+            "--select-commit=*" {
+                set selecthead [string range $arg 16 end]
+            }
+            "--argscmd=*" {
+                set revtreeargscmd [string range $arg 10 end]
+            }
+            default {
+                lappend revtreeargs $arg
+            }
+        }
+        incr i
+    }
+    
+    if {$selecthead eq "HEAD"} {
+        set selecthead {}
+    }
+    
+    if {$i >= [llength $args] && $revtreeargs ne {}} {
+        # no -- on command line, but some arguments (other than --argscmd)
+        if {[catch {
+            set f [eval exec git rev-parse --no-revs --no-flags $revtreeargs]
+            set cmdline_files [split $f "\n"]
+            set n [llength $cmdline_files]
+            set revtreeargs [lrange $revtreeargs 0 end-$n]
+            # Unfortunately git rev-parse doesn't produce an error when
+            # something is both a revision and a filename.  To be consistent
+            # with git log and git rev-list, check revtreeargs for filenames.
+            foreach arg $revtreeargs {
+                if {[file exists $arg]} {
+                    show_error {} . [mc "Ambiguous argument '%s': both revision\
 				 and filename" $arg]
-		exit 1
-	    }
-	}
-    } err]} {
-	# unfortunately we get both stdout and stderr in $err,
-	# so look for "fatal:".
-	set i [string first "fatal:" $err]
-	if {$i > 0} {
-	    set err [string range $err [expr {$i + 6}] end]
-	}
-	show_error {} . "[mc "Bad arguments to gitk:"]\n$err"
-	exit 1
+                    exit 1
+                }
+            }
+        } err]} {
+            # unfortunately we get both stdout and stderr in $err,
+            # so look for "fatal:".
+            set i [string first "fatal:" $err]
+            if {$i > 0} {
+                set err [string range $err [expr {$i + 6}] end]
+            }
+            show_error {} . "[mc "Bad arguments to gitk:"]\n$err"
+            exit 1
+        }
     }
-}
 
-set nullid "0000000000000000000000000000000000000000"
-set nullid2 "0000000000000000000000000000000000000001"
-set nullfile "/dev/null"
-
-set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
-
-set runq {}
-set history {}
-set historyindex 0
-set fh_serial 0
-set nhl_names {}
-set highlight_paths {}
-set findpattern {}
-set searchdirn -forwards
-set boldids {}
-set boldnameids {}
-set diffelide {0 0}
-set markingmatches 0
-set linkentercount 0
-set need_redisplay 0
-set nrows_drawn 0
-set firsttabstop 0
-
-set nextviewnum 1
-set curview 0
-set selectedview 0
-set selectedhlview [mc "None"]
-set highlight_related [mc "None"]
-set highlight_files {}
-set viewfiles(0) {}
-set viewperm(0) 0
-set viewargs(0) {}
-set viewargscmd(0) {}
-
-set selectedline {}
-set numcommits 0
-set loginstance 0
-set cmdlineok 0
-set stopped 0
-set stuffsaved 0
-set patchnum 0
-set lserial 0
-set isworktree [expr {[exec git rev-parse --is-inside-work-tree] == "true"}]
-setcoords
-makewindow
-# wait for the window to become visible
-tkwait visibility .
-wm title . "[file tail $argv0]: [file tail [pwd]]"
-readrefs
-
-if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
-    # create a view for the files/dirs specified on the command line
-    set curview 1
-    set selectedview 1
-    set nextviewnum 2
-    set viewname(1) [mc "Command line"]
-    set viewfiles(1) $cmdline_files
-    set viewargs(1) $revtreeargs
-    set viewargscmd(1) $revtreeargscmd
-    set viewperm(1) 0
-    set vdatemode(1) 0
-    addviewmenu 1
-    .bar.view entryconf [mca "Edit view..."] -state normal
-    .bar.view entryconf [mca "Delete view"] -state normal
-}
-
-if {[info exists permviews]} {
-    foreach v $permviews {
-	set n $nextviewnum
-	incr nextviewnum
-	set viewname($n) [lindex $v 0]
-	set viewfiles($n) [lindex $v 1]
-	set viewargs($n) [lindex $v 2]
-	set viewargscmd($n) [lindex $v 3]
-	set viewperm($n) 1
-	addviewmenu $n
+    variable nullid "0000000000000000000000000000000000000000"
+    variable nullid2 "0000000000000000000000000000000000000001"
+    variable nullfile "/dev/null"
+    
+    variable runq {}
+    variable history {}
+    variable historyindex 0
+    variable fh_serial 0
+    variable nhl_names {}
+    variable highlight_paths {}
+    variable findpattern {}
+    variable searchdirn -forwards
+    variable boldids {}
+    variable boldnameids {}
+    variable diffelide {0 0}
+    variable markingmatches 0
+    variable linkentercount 0
+    variable need_redisplay 0
+    variable nrows_drawn 0
+    variable firsttabstop 0
+
+    global nextviewnum curview selectedview selectedhlview
+    global highlight_related highlight_files
+    global viewcomplete viewactive viewname viewinstances
+    global viewfiles viewargs viewargscmd viewperm nextviewnum
+
+    set nextviewnum 1
+    set curview 0
+    set selectedview 0
+    set selectedhlview [mc "None"]
+    set highlight_related [mc "None"]
+    set highlight_files {}
+    set viewfiles(0) {}
+    set viewperm(0) 0
+    set viewargs(0) {}
+    set viewargscmd(0) {}
+
+    variable selectedline {}
+    variable numcommits 0
+    variable loginstance 0
+    variable cmdlineok 0
+    variable stopped 0
+    variable stuffsaved 0
+    variable patchnum 0
+    variable lserial 0
+    variable isworktree [expr {[exec git rev-parse --is-inside-work-tree] == "true"}]
+    setcoords
+    makewindow
+    # wait for the window to become visible
+    wm deiconify .
+    tkwait visibility .
+    wm title . "[file tail $argv0]: [file tail [pwd]]"
+    readrefs
+
+    if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
+        # create a view for the files/dirs specified on the command line
+        set curview 1
+        set selectedview 1
+        set nextviewnum 2
+        set viewname(1) [mc "Command line"]
+        set viewfiles(1) $cmdline_files
+        set viewargs(1) $revtreeargs
+        set viewargscmd(1) $revtreeargscmd
+        set viewperm(1) 0
+        set vdatemode(1) 0
+        addviewmenu 1
+        .bar.view entryconf [mca "Edit view..."] -state normal
+        .bar.view entryconf [mca "Delete view"] -state normal
+    }
+
+    if {[info exists permviews]} {
+        foreach v $permviews {
+            set n $nextviewnum
+            incr nextviewnum
+            set viewname($n) [lindex $v 0]
+            set viewfiles($n) [lindex $v 1]
+            set viewargs($n) [lindex $v 2]
+            set viewargscmd($n) [lindex $v 3]
+            set viewperm($n) 1
+            addviewmenu $n
+        }
     }
-}
 
-if {[tk windowingsystem] eq "win32"} {
-    focus -force .
+    if {[tk windowingsystem] eq "win32"} {
+        focus -force .
+        bind . <Control-F2> {console show}
+    }
+
+    getcommits {}
 }
 
-getcommits {}
+if {!$tcl_interactive} {
+    if {![info exists initialized]} {
+        set initialized 1
+        set r [catch [linsert $argv 0 init] err]
+        if {$r} {
+            tk_messageBox -icon error -title "Gitk error" \
+                -message $errorInfo
+        }
+    }
+}
-- 
1.6.0.2.1172.ga5ed0
