Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08393C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 07:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E04E961262
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 07:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhKEHi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 03:38:26 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:51051 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhKEHiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 03:38:25 -0400
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
        id 4Hlsk875kdz4xdM; Fri,  5 Nov 2021 18:35:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1636097745;
        bh=Wri33NgL7RtyY8Qg1Vo8CiG9pwhOLi8ABqoDLPPgP70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaDYrekrl5unb19PMg1n4ykDwcLLjWCQzf8F3nuvWZ/nTRdpdqAmwS8EieNaLVH7A
         ZPqGt+Fk2GBGiTJVxg+5Lf9oUBXSxUTjGTfkItJZAcWoIeZXWg875FRAzqUC4iHexM
         Me2HodQND3c1d90Ve/bwrPn4WKpMBLEi/52GXkPhPdKPuAZ4gPq4kZ+BBJjJoUbq5x
         9eopxPW4K3FW7QI7kGFdw8vfSTZv3uN1FHV/U/hGzeAtUE1pe4kPNWwUgMTw7jvG/I
         tB43d9I/RHj8jnuhxT4njABw3LWfEdnqZKZqRAHPv9GLYmrnrskN7pbDXfev5RERkM
         F3VhLWsayKR7g==
Date:   Fri, 5 Nov 2021 18:35:39 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Vladimir Chigarev <chiga17@gmail.com>
Cc:     Vladimir Chigarev via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Vladimir Chigarev <chiga17@mail.ru>
Subject: Re: [PATCH] gitk: add option to perform 'git fetch' command
Message-ID: <YYTey3B8Bw7vJo+u@thinks.paulus.ozlabs.org>
References: <pull.872.git.git.1611328595003.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2104072142001.54@tvgsbejvaqbjf.bet>
 <CAGyQznWL_X+-2jyfJCOkTGsp5Ucd3aomQ0Rf5W4nSo8sEz9d5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyQznWL_X+-2jyfJCOkTGsp5Ucd3aomQ0Rf5W4nSo8sEz9d5Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 03, 2021 at 01:01:14PM +0300, Vladimir Chigarev wrote:
> Hello Paul,
> 
> Just a gentle reminder.
> May I ask you to review my changes in gitk?

Thanks for the reminder.  See comments below.

> > > +proc fetch {} {
> > > +    global bgcolor NS fetch_output
> > > +
> > > +    set fetch_output {}
> > > +    if {[catch {exec sh -c "git fetch -v 2>&1"} fetch_output]} {

This "exec" call is synchronous, meaning that the gitk process won't
do anything else until the exec call returns.  Since git fetch is a
network operation, that could be quite a long time, during which the
GUI will be unresponsive.  It would be better to use open rather than
exec, which will return a file descriptor.  You would then use filerun
to set up a procedure to be called when the file descriptor is
readable.  That way you can arrange for the GUI to continue to respond
while the git fetch is happening.

Also, it may be more useful to do "git fetch --all" rather than just
"git fetch", though I'm not going to insist on that.

> > > +    }
> > > +
> > > +    set w .about

Why are you reusing the "About gitk" window here?  That doesn't seem
right.  Don't you mean "set w .fetch" or similar?

> > > +    if {[winfo exists $w]} {
> > > +     raise $w
> > > +     return
> > > +    }
> > > +    ttk_toplevel $w
> > > +    wm title $w [mc "Fetch"]
> > > +    make_transient $w .
> > > +    message $w.m -text [mc " $fetch_output "] \
> > > +         -justify left -aspect 600 -border 2 -bg $bgcolor -relief groove

How long can the git fetch output be?  If it can be say ten or more
lines you might need to use a text widget and a scrollbar rather than
a message widget.

> > > +    pack $w.m -side top -fill x -padx 2 -pady 2
> > > +    ${NS}::button $w.ok -text [mc "Close"] -command "destroy $w"
> > -default active
> > > +    pack $w.ok -side bottom
> > > +    bind $w <Visibility> "focus $w.ok"
> > > +    bind $w <Key-Escape> "destroy $w"
> > > +    bind $w <Key-Return> "destroy $w"
> > > +    tk::PlaceWindow $w widget .
> > > +
> > > +    reloadcommits
> > > +}
> > > +
> > >  proc updatecommits {} {
> > >      global curview vcanopt vorigargs vfilelimit viewinstances
> > >      global viewactive viewcomplete tclencoding
> > > @@ -2089,6 +2117,7 @@ proc makewindow {} {
> > >          mc "&File" cascade {
> > >              {mc "&Update" command updatecommits -accelerator F5}
> > >              {mc "&Reload" command reloadcommits -accelerator Shift-F5}
> > > +            {mc "&Fetch" command fetch -accelerator F7}
> > >              {mc "Reread re&ferences" command rereadrefs}
> > >              {mc "&List references" command showrefs -accelerator F2}
> > >              {xx "" separator}
> > > @@ -2609,6 +2638,7 @@ proc makewindow {} {
> > >      bindkey f nextfile
> > >      bind . <F5> updatecommits
> > >      bindmodfunctionkey Shift 5 reloadcommits
> > > +    bind . <F7> fetch
> > >      bind . <F2> showrefs
> > >      bindmodfunctionkey Shift 4 {newview 0}
> > >      bind . <F4> edit_or_newview
> > > @@ -3125,6 +3155,7 @@ proc keys {} {
> > >  [mc "<%s-KP->        Decrease font size" $M1T]
> > >  [mc "<%s-minus>      Decrease font size" $M1T]
> > >  [mc "<F5>            Update"]
> > > +[mc "<F7>            Fetch"]
> > >  " \
> > >              -justify left -bg $bgcolor -border 2 -relief groove
> > >      pack $w.m -side top -fill both -padx 2 -pady 2

Paul.
