From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Look for gitk in $PATH, not $LIBEXEC/git-core
Date: Tue, 29 Jul 2008 09:48:56 -0700
Message-ID: <20080729164856.GB1730@spearce.org>
References: <80915B5E107BED488500050294C6F48712136B@ex2k.bankofamerica.com> <20080724132853.GA25313@toroid.org> <20080725220544.GD23202@spearce.org> <80915B5E107BED488500050294C6F48712137A@ex2k.bankofamerica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Abhijit Menon-Sen <ams@toroid.org>, git@vger.kernel.org
To: "Murphy, John" <john.murphy@bankofamerica.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 18:50:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNsOe-00043O-Il
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 18:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbYG2Qs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 12:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755288AbYG2Qs5
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 12:48:57 -0400
Received: from george.spearce.org ([209.20.77.23]:48345 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644AbYG2Qs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 12:48:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 73D08383A4; Tue, 29 Jul 2008 16:48:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <80915B5E107BED488500050294C6F48712137A@ex2k.bankofamerica.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90656>

"Murphy, John" <john.murphy@bankofamerica.com> wrote:
> I have rebuilt git-gui with version 0.10.2.18.gc629 it is still not finding gitk.
> I have done some debugging in proc _which
> I have found the issue is with the following line:
> 
> set p [file join $p $what$_search_exe]
> 
> The variable $p = gitk.exe
> 
> And there is no such animal
> 
> When I copy gitk to gitk.exe in /usr/local/git/bin, it works fine.
> 
> So, not sure if this is a git issue or a git-gui issue.

Since you are new to the list, I will politely point out we do
not top-post.  (http://www.html-faq.com/etiquette/?toppost) and
much prefer inline posting.  (Yea, I know, its Outlook.  Switch to
text only message format and then edit inline in the reply.)

This is definately a git-gui bug.  _which should search not just
.exe extensions, but also the base name itself in case it is a
shell script or perl script.  git-gui already has special cases
to handle executing those through their interpreters even on a
pure Win32 Tcl/Tk process.

Its wrong to install gitk as gitk.exe, it is not a Win32 executable
process and the Windows kernel cannot load it into memory on its own.

 
> From: spearce@spearce.org [mailto:spearce@spearce.org] 
> Abhijit Menon-Sen <ams@toroid.org> wrote:
> > At 2008-07-24 09:01:48 -0400, john.murphy@bankofamerica.com wrote:
> > >
> > > I presume this was just an oversight when git- commands were removed
> > > from the bin directory.
> > 
> > Looks like it. The following patch fixes it for me. Does it work for
> > you on Windows?
> 
> Thanks.
> 
> This patch is obviously correct on any platform except Mac OS X.
> On Mac OS X it gets confusing because [info nameofexecutable] is
> a wrapper .app which loads its own main script.  That main script
> needs to use the gitk location it receives from git-gui, and not
> the location it computes from gitexecdir.  So I'm following up
> your patch with this:
> 
> diff --git a/macosx/AppMain.tcl b/macosx/AppMain.tcl
> index 41ca08e..ddbe633 100644
> --- a/macosx/AppMain.tcl
> +++ b/macosx/AppMain.tcl
> @@ -7,7 +7,7 @@ if {[string first -psn [lindex $argv 0]] == 0} {
>  }
>  
>  if {[file tail [lindex $argv 0]] eq {gitk}} {
> -	set argv0 [file join $gitexecdir gitk]
> +	set argv0 [lindex $argv 0]
>  	set AppMain_source $argv0
>  } else {
>  	set argv0 [file join $gitexecdir [file tail [lindex $argv 0]]]

-- 
Shawn.
