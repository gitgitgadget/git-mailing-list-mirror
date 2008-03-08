From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] gitk: Add horizontal scrollbar to the diff view
Date: Fri, 7 Mar 2008 20:53:57 -0500
Message-ID: <20080308015357.GU8410@spearce.org>
References: <20080305225123.GA8485@localdomain> <7vy78wgyu1.fsf@gitster.siamese.dyndns.org> <18383.51154.695501.543720@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, kaitanie@cc.helsinki.fi,
	newsletter@dirk.my1.cc, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 02:54:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXoGx-0006B3-S1
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 02:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbYCHByM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 20:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbYCHByL
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 20:54:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34625 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587AbYCHByJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 20:54:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JXoFw-0003Y8-Bz; Fri, 07 Mar 2008 20:53:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2CB7920FBAE; Fri,  7 Mar 2008 20:53:57 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <18383.51154.695501.543720@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76539>

Paul Mackerras <paulus@samba.org> wrote:
> Junio C Hamano writes:
> > An obvious solution is to show the scrollbar on-demand (i.e. when the
> > lines are overlong), but I do not talk Tcl/Tk and do not know if you can
> > do that easily.
> 
> I don't know of any extremely easy way to do it; it's certainly
> possible, but I think I would have to calculate the length of each
> line as it is put in, so as to get the maximum, and then have a
> handler for when the pane is resized, and pack and unpack the
> scrollbar as necessary.
> 
> I think it's reasonable to have the scroll bar there always.  I think
> that pane could look better using the grid geometry manager (instead
> of pack), but that can be a separate patch.

git-gui does this scrollbar on-demand thing in its revision list meta-widget,
which is lib/choose_rev.tcl.  The procedure in question is this, and it gets
installed as:

      listbox $w_list \
        -font font_diff \
        -width 50 \
        -height 10 \
        -selectmode browse \
        -exportselection false \
        -xscrollcommand [cb _sb_set $w.list.sbx h] \
        -yscrollcommand [cb _sb_set $w.list.sby v]


method _sb_set {sb orient first last} {
    set old_focus [focus -lastfor $w]
       
    if {$first == 0 && $last == 1} {
        if {[winfo exists $sb]} {
            destroy $sb
            if {$old_focus ne {}} {
                update
                focus $old_focus
            }
        }
        return
    }
       
    if {![winfo exists $sb]} {
        if {$orient eq {h}} {
            scrollbar $sb -orient h -command [list $w_list xview]
            pack $sb -fill x -side bottom -before $w_list
        } else {
            scrollbar $sb -orient v -command [list $w_list yview]
            pack $sb -fill y -side right -before $w_list
        }
        if {$old_focus ne {}} {
            update
            focus $old_focus
        }
    }
       
    catch {$sb set $first $last}
}


-- 
Shawn.
