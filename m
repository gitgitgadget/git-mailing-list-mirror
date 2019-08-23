Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9AC11F461
	for <e@80x24.org>; Fri, 23 Aug 2019 16:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391731AbfHWQv1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 12:51:27 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:57307 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfHWQv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 12:51:27 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 03EC01BF206;
        Fri, 23 Aug 2019 16:51:23 +0000 (UTC)
Date:   Fri, 23 Aug 2019 22:21:21 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 3/4] git-gui: Add the ability to revert selected lines
Message-ID: <20190823165121.2gklr4lz6mksdfc6@localhost.localdomain>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190822220107.4153-1-me@yadavpratyush.com>
 <20190822220107.4153-4-me@yadavpratyush.com>
 <CAKPyHN2GMV2n7rPO7NU7=wayNo3tYPNUhhwSuXK6EqAUbWEgng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPyHN2GMV2n7rPO7NU7=wayNo3tYPNUhhwSuXK6EqAUbWEgng@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/08/19 08:29AM, Bert Wesarg wrote:
> On Fri, Aug 23, 2019 at 12:01 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> >
> > Just like the user can select lines to stage or unstage, add the
> > ability to revert selected lines.
> >
> > Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> > ---
> >  git-gui.sh   | 25 ++++++++++++++++++++++++-
> >  lib/diff.tcl | 31 ++++++++++++++++++++++++++-----
> >  2 files changed, 50 insertions(+), 6 deletions(-)
> >
> > diff --git a/git-gui.sh b/git-gui.sh
> > index b7811d8..9d84ba9 100755
> > --- a/git-gui.sh
> > +++ b/git-gui.sh
> > @@ -3588,9 +3588,15 @@ set ui_diff_applyhunk [$ctxm index last]
> >  lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
> >  $ctxm add command \
> >         -label [mc "Apply/Reverse Line"] \
> > -       -command {apply_range_or_line $cursorX $cursorY; do_rescan}
> > +       -command {apply_or_revert_range_or_line $cursorX $cursorY 0; do_rescan}
> >  set ui_diff_applyline [$ctxm index last]
> >  lappend diff_actions [list $ctxm entryconf $ui_diff_applyline -state]
> > +$ctxm add command \
> > +       -label [mc "Revert Line"] \
> > +       -command {apply_or_revert_range_or_line $cursorX $cursorY 1; do_rescan}
> > +set ui_diff_revertline [$ctxm index last]
> > +lappend diff_actions [list $ctxm entryconf $ui_diff_revertline -state]
> > +set ui_diff_revertline [$ctxm index last]
> >  $ctxm add separator
> >  $ctxm add command \
> >         -label [mc "Show Less Context"] \
> > @@ -3688,15 +3694,19 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
> >                         set l [mc "Unstage Hunk From Commit"]
> >                         if {$has_range} {
> >                                 set t [mc "Unstage Lines From Commit"]
> > +                               set r [mc "Revert Lines"]
> >                         } else {
> >                                 set t [mc "Unstage Line From Commit"]
> > +                               set r [mc "Revert Line"]
> >                         }
> >                 } else {
> >                         set l [mc "Stage Hunk For Commit"]
> >                         if {$has_range} {
> >                                 set t [mc "Stage Lines For Commit"]
> > +                               set r [mc "Revert Lines"]
> >                         } else {
> >                                 set t [mc "Stage Line For Commit"]
> > +                               set r [mc "Revert Line"]
> >                         }
> >                 }
> >                 if {$::is_3way_diff
> > @@ -3707,11 +3717,24 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
> >                         || [string match {T?} $state]
> >                         || [has_textconv $current_diff_path]} {
> >                         set s disabled
> > +                       set revert_state disabled
> >                 } else {
> >                         set s normal
> > +
> > +                       # Only allow reverting changes in the working tree. If
> > +                       # the user wants to revert changes in the index, they
> > +                       # need to unstage those first.
> > +                       if {$::ui_workdir eq $::current_diff_side} {
> > +                               set revert_state normal
> > +                       } else {
> > +                               set revert_state disabled
> > +                       }
> >                 }
> > +
> >                 $ctxm entryconf $::ui_diff_applyhunk -state $s -label $l
> >                 $ctxm entryconf $::ui_diff_applyline -state $s -label $t
> > +               $ctxm entryconf $::ui_diff_revertline -state $revert_state \
> > +                       -label $r
> 
> so you have the 'Revert Line(s)'  menu entry always in the context
> menu, also when the context menu was opened for an staged file (than
> the menu entry is only disabled)? I think this is a step backwards
> from my original patch (which isn't mentioned/referenced at all in
> this patch anyway).
 
I intentionally did this because I thought keeping the menu layout the 
same at all times will help a bit with muscle memory. I don't mind your 
way either though. If you feel very strongly about this, I'll do it your 
way.

> My orignal patch also had this hunk in lib/diff.tcl:
> 
> @@ -614,6 +619,8 @@ proc apply_hunk {x y} {
> 
>      if {$current_diff_side eq $ui_index} {
>          set mi ${o}M
> +    } elseif {$revert} {
> +        set mi "[string index $mi 0]$o"
>      } elseif {[string index $mi 0] eq {_}} {
>          set mi M$o
>      } else {
> 
> which is missing here. I cannot remember why I added this here. But
> maybe you can?
 
You are looking at the wrong patch. This patch is for reverting lines, 
not hunks. Since the current "Stage selected line(s)" function relies on 
a rescan to update file states, I went with that convention. The 
-command parameter for the menu entry triggers a rescan after the revert 
is done.

The next patch deals with hunks, and it contains this if statement.

> Best,
> Bert
> 
> >                 tk_popup $ctxm $X $Y
> >         }
> >  }
> > diff --git a/lib/diff.tcl b/lib/diff.tcl
> > index 4cae10a..00b15f5 100644
> > --- a/lib/diff.tcl
> > +++ b/lib/diff.tcl
> > @@ -640,7 +640,7 @@ proc apply_hunk {x y} {
> >         }
> >  }
> >
> > -proc apply_range_or_line {x y} {
> > +proc apply_or_revert_range_or_line {x y revert} {
> >         global current_diff_path current_diff_header current_diff_side
> >         global ui_diff ui_index file_states
> >
> > @@ -660,25 +660,46 @@ proc apply_range_or_line {x y} {
> >         if {$current_diff_path eq {} || $current_diff_header eq {}} return
> >         if {![lock_index apply_hunk]} return
> >
> > -       set apply_cmd {apply --cached --whitespace=nowarn}
> > +       set apply_cmd {apply --whitespace=nowarn}
> >         set mi [lindex $file_states($current_diff_path) 0]
> >         if {$current_diff_side eq $ui_index} {
> >                 set failed_msg [mc "Failed to unstage selected line."]
> >                 set to_context {+}
> > -               lappend apply_cmd --reverse
> > +               lappend apply_cmd --reverse --cached
> >                 if {[string index $mi 0] ne {M}} {
> >                         unlock_index
> >                         return
> >                 }
> >         } else {
> > -               set failed_msg [mc "Failed to stage selected line."]
> > -               set to_context {-}
> > +               if {$revert} {
> > +                       set failed_msg [mc "Failed to revert selected line."]
> > +                       set to_context {+}
> > +                       lappend apply_cmd --reverse
> > +               } else {
> > +                       set failed_msg [mc "Failed to stage selected line."]
> > +                       set to_context {-}
> > +                       lappend apply_cmd --cached
> > +               }
> > +
> >                 if {[string index $mi 1] ne {M}} {
> >                         unlock_index
> >                         return
> >                 }
> >         }
> >
> > +       if {$revert} {
> > +               set query "[mc "Revert changes in file %s?" \
> > +                       [short_path $current_diff_path]]
> > +
> > +[mc "The selected lines will be permanently lost by the revert."]"
> > +
> > +               set reply [revert_dialog $query]
> > +               if {$reply ne 1} {
> > +                       unlock_index
> > +                       return
> > +               }
> > +       }
> > +
> >         set wholepatch {}
> >
> >         while {$first_l < $last_l} {
> > --
> > 2.21.0
> >

-- 
Regards,
Pratyush Yadav
