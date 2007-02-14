From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: git-gui Error
Date: Wed, 14 Feb 2007 18:46:35 +0100
Message-ID: <20070214174635.GA21612@auto.tuwien.ac.at>
References: <20070213065616.GA4195@auto.tuwien.ac.at> <20070213074519.GA32687@spearce.org> <20070213215303.GA26716@auto.tuwien.ac.at> <20070214022200.GB30884@spearce.org> <20070214060041.GA31871@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:46:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHODP-0003Fu-Je
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbXBNRql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 14 Feb 2007 12:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbXBNRql
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:46:41 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:38014 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbXBNRqk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:46:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 1D61F6869BC3;
	Wed, 14 Feb 2007 18:46:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xL8y9g391mgm; Wed, 14 Feb 2007 18:46:35 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 365D9680065F; Wed, 14 Feb 2007 18:46:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070214060041.GA31871@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39703>

On Wed, Feb 14, 2007 at 01:00:41AM -0500, Shawn O. Pearce wrote:
> "Shawn O. Pearce" <spearce@spearce.org> wrote:
> This is now pushed to repo.or.cz.  It probably won't show up in
> git.git for at least a few weeks.  I want to push through some
> more features (especially around the blame UI) in git-gui before
> I bother Junio with another git-gui merge.  Besides, Git 1.5.0
> (including git-gui 0.6.0.1) just shipped.  :)
>=20
> It turned out to be slightly more difficult than just adding
> refs/tags, as %(objectname) would be the name of the annotated tag,
> and we need the commit name to match against rev-list output.  So I
> had to extend the for-each-ref call to also include %(*objectname).
>=20

I'm missing the possibility to base a new branch on a tag.
The following adds a tag drop down to the new branch dialog:

--- git-gui.sh  2007-02-14 08:51:38.025781229 +0000
+++ git-gui     2007-02-14 10:50:13.618870598 +0000
@@ -1916,11 +1916,25 @@
        return [lsort -unique $all_trackings]
 }

+proc load_all_tags {} {
+       set all_tags [list]
+       set fd [open "| git for-each-ref --format=3D%(refname) refs/tag=
s" r]
+       while {[gets $fd line] > 0} {
+               if {![regsub ^refs/tags/ $line {} name]} continue
+               lappend all_tags $name
+       }
+       close $fd
+
+       return [lsort $all_tags]
+}
+
+
 proc do_create_branch_action {w} {
        global all_heads null_sha1 repo_config
        global create_branch_checkout create_branch_revtype
        global create_branch_head create_branch_trackinghead
        global create_branch_name create_branch_revexp
+        global create_branch_tag

        set newbranch $create_branch_name
        if {$newbranch eq {}
@@ -1959,6 +1973,7 @@
        switch -- $create_branch_revtype {
        head {set rev $create_branch_head}
        tracking {set rev $create_branch_trackinghead}
+       tag {set rev $create_branch_tag}
        expression {set rev $create_branch_revexp}
        }
        if {[catch {set cmt [git rev-parse --verify "${rev}^0"]}]} {
@@ -2015,6 +2030,7 @@
        global create_branch_checkout create_branch_revtype
        global create_branch_head create_branch_trackinghead
        global create_branch_name create_branch_revexp
+        global create_branch_tag

        set w .branch_editor
        toplevel $w
@@ -2078,6 +2094,19 @@
                        $all_trackings
                grid $w.from.tracking_r $w.from.tracking_m -sticky w
        }
+       set all_tags [load_all_tags]
+       if {$all_tags ne {}} {
+               set create_branch_tag [lindex $all_tags 0]
+               radiobutton $w.from.tag_r \
+                       -text {Tag:} \
+                       -value tag \
+                       -variable create_branch_revtype \
+                       -font font_ui
+               eval tk_optionMenu $w.from.tag_m \
+                       create_branch_tag \
+                       $all_tags
+               grid $w.from.tag_r $w.from.tag_m -sticky w
+       }
        radiobutton $w.from.exp_r \
                -text {Revision Expression:} \
                -value expression \

mfg Martin K=F6gler
