Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94412853F8
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756940; cv=none; b=uCT4Kz4TNAcEppmgvZtPhoxSnqtMKcJS6Q/k08Pc7McHDjewEOzFz2KNL+0jnmGgXqYfZAt+cFAMOhl/104/QYR9HjolcO+1WDsIwrBRy1/SmrKNpKJabG6JU6Zd8Rmfz5kKPlmAsrG4AQYB597VV1E3KOvwySveGyslP166tVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756940; c=relaxed/simple;
	bh=XN2rnlQIapAHTlomqTYak0xx3u/Y2RLeJN87V/DgaTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Ur6GL+p/+cUclVp+0PIg6lEVOCtvqDPdW4T8Y7vx2C1h9SXWIGr52mrM1mogpJBmXHe3iWwvpyWO6bvAb9OdtjwJXS4y8O4Hu9dTPc50fYhy3oAjyVeA7hFz8Eczf8PEz3UNR5UonILdURUqhWgwWwZYaNYMFVhJ/gYKyuALEVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4dLtnG1CCMz7RX54
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 11:15:30 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4dLtn442lpzRpL2;
	Wed,  3 Dec 2025 11:15:20 +0100 (CET)
Message-ID: <9a9441d5-fb64-4718-8765-852e66458598@kdbg.org>
Date: Wed, 3 Dec 2025 11:15:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: fix history window panes position
To: "tobias.boesch@miele.com" <tobias.boesch@miele.com>
References: <AM0PR08MB5426BC141388A69BB5087732E1D8A@AM0PR08MB5426.eurprd08.prod.outlook.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <AM0PR08MB5426BC141388A69BB5087732E1D8A@AM0PR08MB5426.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 02.12.25 um 14:08 schrieb tobias.boesch@miele.com:
> From: Tobias Boesch <tobias.boesch@miele.com>
> Date: Thu, 27 Nov 2025 11:27:16 +0100
> Subject: [PATCH] gitk: fix history window panes position
> 
> When the history window panes in are resized
> by moving either of the two sashes and then
> the gitk window is vertically resized,
> the sashes fall back into their previous
> position without respecting the users wish
> for resizing.

You say "the Gitk windows is resized vertically". Did you mean "resized
horizontally"? If I change only the height of the Gitk window, the
widths of the top panel (history, author, date) aren't changed at all.
However, if I change only the width, the symptoms do occur.

Also, the error is not limited to the upper half of the window. The
lower panel (patch text, file list) also forgets the last used position
when the window size is changed. Can we fix this, too?

> Save the sash position when the sashes are
> moved to make them keep their position when
> the window is resized afterwards.
> 
> When the gitk window is opened and maximized
> on a screen, then closed and opened on a
> screen smaller than the previously used one,
> the author pane and time pane of the history
> window only are a few pixels wide and their
> contents are barely visible.
> Widen the two panes on start of gitk to a
> reasonable fixed size that shows a good amount
> of text of authors and time.

I did this test:

0. Make Gitk significantly less than the screen size.
1. Adjust pane size to 1/2 history, 1/3 author, 1/6 date.
2. Maximize window via "Maximize" button.
3. Restore window via "Maximize" button.

After 2., the pane widths are scaled with the window width and retain
their proportions (or so it seems).

But after 3., the pane widths are completely scrambled. The date pane is
far too wide (wider than in the maximized window), the history pane
steals a lot of the remaining width, and the author pane is squished to
a minimal size.

The behavior without the patch was better in this regard, because the
proportions of the memoized panel widths were retained.

> 
> Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
> ---
> 
> Notes:
>     Debug print statements are left in the code for easier
>     testing by maintainers.
>     They will be removed when the review is finished.
> 
>  gitk-git/gitk | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 7f62c8041d..6fbc2588fb 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2471,6 +2471,23 @@ proc makewindow {} {
>          -xscrollincr $linespc \
>          -yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll"
>      .tf.histframe.pwclist add $canv
> +    bind .tf.histframe.pwclist.canv <Configure> {
> +        global oldsash
> +        set parent [regsub {\.[A-Za-z]+$} %W ""]
> +        puts "Canvas (pwclist) configuration changed saving sash \
> +                position if parent panedwindow $parent is initialised \
> +                (oldsash exist)"
> +        if {[info exists oldsash($parent)]} {
> +            set s0 [$parent sashpos 0]
> +            set s1 [$parent sashpos 1]
> +            puts "   Sash0 is $s0"
> +            puts "   Sash1 is $s1"
> +            set oldsash($parent) [list $s0 $s1]
> +            puts "   oldsash saved for $parent"
> +        } else {
> +            puts "   oldsash not yet existing so oldsash is not saved for $parent"
> +        }
> +    }

I wonder why this handler is only installed for one of the three panes.

Does panedwindow not have any features that can notify us to store the
current sash positions? Can we perhaps bind to its <Motion> or
<ButtonRelease> instead?

At any rate, a callback like this is large enough (even without
debugging code) to be moved to its own function. Is there a reason that
proc resizeclistpanes cannot be reused in some way?

>      set canv2 .tf.histframe.pwclist.canv2
>      canvas $canv2 \
>          -selectbackground $selectbgcolor \
> @@ -3116,30 +3133,53 @@ proc savestuff {w} {
> 
>  proc resizeclistpanes {win w} {
>      global oldwidth oldsash
> +    puts "Starting resizeclistpanes..."
>      if {[info exists oldwidth($win)]} {
>          if {[info exists oldsash($win)]} {
> +            puts "   Using oldsash from window"
>              set s0 [lindex $oldsash($win) 0]
>              set s1 [lindex $oldsash($win) 1]
> +            puts "   Sash0 is $s0"
> +            puts "   Sash1 is $s1"
>          } else {
> +            puts "   New window creation detected"
> +            puts "   Width is $w"
> +            puts "   Using sash from window sashpos directly"
>              set s0 [$win sashpos 0]
>              set s1 [$win sashpos 1]
> +            puts "   Sash0 is $s0"
> +            puts "   Sash1 is $s1"
> +            if {$s1 > $w - 140} {
> +                puts "      Sash1 greater than width - 140, setting max size"
> +                set s1 [expr {$w - 140}]
> +                if {$s0 > $s1 - 300} {> +                    puts "
      Sash0 greater than sash1 - 300, setting max size"
> +                    set s0 [expr {$s1 - 300}]

So, these aren't "max size", but actually "minimal width".

It is strange that the minimal width of the author pane is only
corrected if the date pane is too small as well.

I have an issue with this. If the user makes the panes small, the wider
versions are forced on them. The user's wish should have priority.

I understand that you want to restore the widths to a sane size after
the "maximize-restore" operation has caused the degenerated widths. But
doesn't this solution just paper over the real bug that the window
resize operation doesn't heed the pane width proportions?

> +                }
> +            }
>          }
>          if {$w < 60} {
> +            puts "   Narrow window ($w), scaling sash in dependency to window width"
>              set sash0 [expr {int($w/2 - 2)}]
>              set sash1 [expr {int($w*5/6 - 2)}]
>          } else {
> +            puts "   Wide window ($w), scaling sash in dependency to old width, oldsash and window width"
>              set factor [expr {1.0 * $w / $oldwidth($win)}]
>              set sash0 [expr {int($factor * [lindex $s0 0])}]
>              set sash1 [expr {int($factor * [lindex $s1 0])}]

Not a problem of this patch, but I wonder why we have [lindex] here.

>              if {$sash0 < 30} {
> +                puts "      Sash0 too small, setting min size"
>                  set sash0 30
>              }
>              if {$sash1 < $sash0 + 20} {
> +                puts "      Sash1 smaller than sash0 + 20, setting min size"
>                  set sash1 [expr {$sash0 + 20}]
>              }
>              if {$sash1 > $w - 10} {
> +                puts "      Sash1 greater than width - 140, setting max size"
>                  set sash1 [expr {$w - 10}]
>                  if {$sash0 > $sash1 - 20} {
> +                    puts "         Sash0 greater than sash1 - 300, setting max size"
>                      set sash0 [expr {$sash1 - 20}]
>                  }
>              }
> @@ -3149,6 +3189,7 @@ proc resizeclistpanes {win w} {
>          set oldsash($win) [list $sash0 $sash1]
>      }
>      set oldwidth($win) $w
> +    puts "Finished resizeclistpanes..."
>  }
> 
>  proc resizecdetpanes {win w} {
-- Hannes

