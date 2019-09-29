Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31AE31F463
	for <e@80x24.org>; Sun, 29 Sep 2019 17:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfI2RLf (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 13:11:35 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:60105 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfI2RLf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 13:11:35 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id CAA6CC0002;
        Sun, 29 Sep 2019 17:11:31 +0000 (UTC)
Date:   Sun, 29 Sep 2019 22:41:29 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Heiko Voigt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 1/4] git-gui: provide question helper for retry fallback
 on Windows
Message-ID: <20190929171129.u5kvx5ggyjxjkzdu@yadavpratyush.com>
References: <pull.358.git.gitgitgadget@gmail.com>
 <58972068a230c996951e26d795e26cf66459c497.1569511793.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58972068a230c996951e26d795e26cf66459c497.1569511793.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/19 08:29AM, Heiko Voigt via GitGitGadget wrote:
> From: Heiko Voigt <hvoigt@hvoigt.net>
> 
> Make use of the new environment variable GIT_ASK_YESNO to support the
> recently implemented fallback in case unlink, rename or rmdir fail for
> files in use on Windows. The added dialog will present a yes/no question
> to the the user which will currently be used by the windows compat layer
> to let the user retry a failed file operation.

I can't find any documentation related to this environment variable. A 
Google search does not yield any promising results. I don't see this 
mentioned in the git man page either, though that is to be expected 
because it seems to be a Windows-only variable.

My point is, it would be nice if the commit message pointed to some sort 
of documentation for the environment variable. It would also help me in 
reviewing the patch if I know more about the variable.

Either way, some minor comments down below.

> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Makefile          |  2 ++
>  git-gui--askyesno | 51 +++++++++++++++++++++++++++++++++++++++++++++++
>  git-gui.sh        |  3 +++
>  3 files changed, 56 insertions(+)
>  create mode 100755 git-gui--askyesno
> 
> diff --git a/Makefile b/Makefile
> index fe30be38dc..85633b73df 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -291,6 +291,7 @@ install: all
>  	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
>  	$(QUIET)$(INSTALL_X0)git-gui $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
>  	$(QUIET)$(INSTALL_X0)git-gui--askpass $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> +	$(QUIET)$(INSTALL_X0)git-gui--askyesno $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
>  	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(INSTALL_L0)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L1)'$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' $(INSTALL_L2)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L3) &&) true
>  ifdef GITGUI_WINDOWS_WRAPPER
>  	$(QUIET)$(INSTALL_R0)git-gui.tcl $(INSTALL_R1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> @@ -309,6 +310,7 @@ uninstall:
>  	$(QUIET)$(CLEAN_DST) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
>  	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui $(REMOVE_F1)
>  	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui--askpass $(REMOVE_F1)
> +	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui--askyesno $(REMOVE_F1)
>  	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/$p $(REMOVE_F1) &&) true
>  ifdef GITGUI_WINDOWS_WRAPPER
>  	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui.tcl $(REMOVE_F1)

I'm not too slick with Makefiles, but these changes look good.

> diff --git a/git-gui--askyesno b/git-gui--askyesno
> new file mode 100755
> index 0000000000..cf9c990d09
> --- /dev/null
> +++ b/git-gui--askyesno
> @@ -0,0 +1,51 @@
> +#!/bin/sh
> +# Tcl ignores the next line -*- tcl -*- \
> +exec wish "$0" -- "$@"
> +
> +# This is an implementation of a simple yes no dialog
> +# which is injected into the git commandline by git gui
> +# in case a yesno question needs to be answered.
> +
> +set NS {}
> +set use_ttk [package vsatisfies [package provide Tk] 8.5]
> +if {$use_ttk} {
> +	set NS ttk
> +}
> +
> +if {$argc < 1} {
> +	puts stderr "Usage: $argv0 <question>"
> +	exit 1
> +} else {
> +	set prompt [join $argv " "]
> +}
> +
> +${NS}::frame .t
> +${NS}::label .t.m -text $prompt -justify center -width 400px
> +.t.m configure -wraplength 400px
> +pack .t.m -side top -fill x -padx 20 -pady 20 -expand 1
> +pack .t -side top -fill x -ipadx 20 -ipady 20 -expand 1
> +
> +${NS}::frame .b
> +${NS}::frame .b.left -width 200
> +${NS}::button .b.yes -text Yes -command yes
> +${NS}::button .b.no  -text No  -command no

Do you really need separate functions for yes/no? I think something like

  -command {exit 1}

and

  -command {exit 0}

would do just fine.

Either way...

> +
> +

Nitpick: Drop one of the two blank lines.

> +pack .b.left -side left -expand 1 -fill x
> +pack .b.yes -side left -expand 1
> +pack .b.no -side right -expand 1 -ipadx 5
> +pack .b -side bottom -fill x -ipadx 20 -ipady 15
> +
> +bind . <Key-Return> {exit 0}
> +bind . <Key-Escape> {exit 1}

... do the same thing here. Call yes and no here too if you are using 
them above.

I have no preference for either way, but I would like uniformity in 
these two spots.

> +
> +proc no {} {
> +	exit 1
> +}
> +
> +proc yes {} {
> +	exit 0
> +}
> +
> +wm title . "Question?"
> +tk::PlaceWindow .
> diff --git a/git-gui.sh b/git-gui.sh
> index f9b323abff..76d8139b8d 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1248,6 +1248,9 @@ set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
>  if {![info exists env(SSH_ASKPASS)]} {
>  	set env(SSH_ASKPASS) [gitexec git-gui--askpass]
>  }
> +if {![info exists env(GIT_ASK_YESNO)]} {
> +	set env(GIT_ASK_YESNO) [gitexec git-gui--askyesno]
> +}

Since this seems to be a Windows-only variable, you might want to enable 
it only on Windows. Are there workflows on other platforms that would 
use this environment variable?

-- 
Regards,
Pratyush Yadav
