Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A952A2ED842
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522901; cv=none; b=owGzpDLlnT+DH3FSDBNele6Gw9TvRyjN5SVfx0SrWmtORNxC7o9q/DAa4OqeeZ7eGpJlr/Rg177AXdUg26uk6XCdLaWkz3MMyZ+7Ap8BFpbTlWLgFgMGydnTPQSDZHO+Px0kFdqJioeSNgrXXhJwFviA3u+PWDV+WTKUQ1Xk0Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522901; c=relaxed/simple;
	bh=0M0UbzjFGn3bmKZUxUSbFfFFPmCdFPPatvIb0DYQ42E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L7FSb5U95gkJesjo/J0V1VB8UKIijySOdJG1gCLI3f5ORqjhnvNAbFpWd53mpaPMLChQqNdhWSbzEydZyu4AKhqGmKZ1F3OL3h/vL7B4csLGXH1GZkklRoVhTX0086S/aCZW+bc2oMtRvq7Hbtr+YNV34yo4gFCvJgfQSMfIOFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4cVYJ05WmHz7Qv0P
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 08:34:56 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4cVYHr0xvYzRq1q;
	Mon, 22 Sep 2025 08:34:48 +0200 (CEST)
Message-ID: <c6a33014-5d87-4750-b6ce-234e944131b4@kdbg.org>
Date: Mon, 22 Sep 2025 08:34:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] gitk: make Tags and Heads window geometry sticky
Content-Language: en-US
To: Michael Rappazzo <rappazzo@gmail.com>, git@vger.kernel.org
References: <20250920184007.26183-1-rappazzo@gmail.com>
 <20250920184007.26183-3-rappazzo@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250920184007.26183-3-rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.09.25 um 20:40 schrieb Michael Rappazzo:
> Currently, the Tags and Heads window always opens at a default position
> and size, requiring users to reposition it each time. This patch makes
> the window remember its geometry between sessions.
> 
> This change saves and restores the Tags and Heads window size and position
> relative to the main gitk window. The geometry is stored in the config file

The "relative to the main Gitk window" is not true anymore.

> as `geometry(showrefs)` and persists between gitk sessions. The window
> position is stored relative to the main window, so it maintains the same
> spatial relationship when the main window is moved or when gitk is restarted
> on different monitors.
> 
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  gitk | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 95469a8fae..0393241c85 100755
> --- a/gitk
> +++ b/gitk
> @@ -3116,6 +3116,11 @@ proc savestuff {w} {
>          puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sashpos 1] 1\""
>          puts $f "set geometry(botwidth) [winfo width .bleft]"
>          puts $f "set geometry(botheight) [winfo height .bleft]"
> +        if {[winfo exists .showrefs]} {
> +            puts $f "set geometry(showrefs) \"[wm geometry .showrefs]\""
> +        } elseif {[info exists geometry(showrefs)]} {
> +            puts $f "set geometry(showrefs) \"$geometry(showrefs)\""
> +        }
>  
>          array set view_save {}
>          array set views {}
> @@ -10209,11 +10214,13 @@ proc showrefs {} {
>      if {[winfo exists $top]} {
>          raise $top
>          refill_reflist
> +        wm protocol $top WM_DELETE_WINDOW [list destroy_showrefs $top]
>          return
>      }
>      ttk_toplevel $top
>      wm title $top [mc "Tags and heads: %s" [file tail [pwd]]]
>      make_transient $top .
> +    wm protocol $top WM_DELETE_WINDOW [list destroy_showrefs $top]
>      text $top.list -background $bgcolor -foreground $fgcolor \
>          -selectbackground $selectbgcolor -font mainfont \
>          -xscrollcommand "$top.xsb set" -yscrollcommand "$top.ysb set" \
> @@ -10239,8 +10246,8 @@ proc showrefs {} {
>      ttk::checkbutton $top.sort -text [mc "Sort refs by type"] \
>          -variable sortrefsbytype -command {refill_reflist}
>      grid $top.sort - -sticky w -pady 2
> -    ttk::button $top.close -command [list destroy $top] -text [mc "Close"]
> -    bind $top <Key-Escape> [list destroy $top]
> +    ttk::button $top.close -command [list destroy_showrefs $top] -text [mc "Close"]
> +    bind $top <Key-Escape> [list destroy_showrefs $top]
>      grid $top.close -
>      grid columnconfigure $top 0 -weight 1
>      grid rowconfigure $top 0 -weight 1
> @@ -10249,6 +10256,8 @@ proc showrefs {} {
>      bind $top.list <ButtonRelease-1> {sel_reflist %W %x %y; break}
>      set reflist {}
>      refill_reflist
> +    after idle [list manage_showrefs_geometry $top restore]

My thinking without having debugged it is:

 1. A Configure event happens with the default geometry when the window
becomes visible. This records the default geometry in geometry(showrefs)
by the handler that is bound in the next line below.

 2. "After idle" the geometry is set to the then-current value of
geometry(showrefs), which would then be the default geometry and not the
one restored from the settings.

Why is it not necessary to encode the now-current value of
geometry(showrefs) (the restored value) in this after-idle handler? IOW,
why does this work?

> +    bind $top <Configure> [list manage_showrefs_geometry $top save]

With this binding, all size and position changes are immediately
recorded in the global geometry(showrefs) variable. Why do we still have
to bind to so many other close events? Why is it necessary to check for
`winfo exists .showrefs` and handle that in a separate branch in proc
savestuff above?

>  }
>  
>  proc sel_reflist {w x y} {
> @@ -10281,6 +10290,28 @@ proc reflistfilter_change {n1 n2 op} {
>      after 200 refill_reflist
>  }
>  
> +proc manage_showrefs_geometry {top action} {
> +    global geometry
> +    switch $action {
> +        save {
> +            if {[winfo exists $top]} {
> +                set geometry(showrefs) [wm geometry $top]
> +            }
> +        }
> +        restore {
> +            if {[info exists geometry(showrefs)] && [winfo exists $top]} {
> +                after 1 [list wm geometry $top $geometry(showrefs)]
> +            }
> +        }
> +    }
> +}

The two branches have no common code path. What is the rationale to have
a single function with sub-commands instead of two distinct functions?

> +
> +proc destroy_showrefs {top} {
> +    manage_showrefs_geometry $top save
> +    savestuff .
> +    destroy $top
> +}
> +
>  proc refill_reflist {} {
>      global reflist reflistfilter showrefstop headids tagids otherrefids sortrefsbytype
>      global curview upstreamofref

-- Hannes

