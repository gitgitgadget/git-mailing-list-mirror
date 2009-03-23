From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: make use of themed widgets where available
Date: Mon, 23 Mar 2009 16:34:56 +1100
Message-ID: <18887.8064.114036.850741@drongo.ozlabs.ibm.com>
References: <87ljrre7nr.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 06:36:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llcq0-0002Hr-0g
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 06:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbZCWFfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 01:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbZCWFfJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 01:35:09 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:33658 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852AbZCWFfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 01:35:08 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 8A8FFB7066; Mon, 23 Mar 2009 16:35:05 +1100 (EST)
In-Reply-To: <87ljrre7nr.fsf@users.sourceforge.net>
X-Mailer: VM 8.0.12 under 22.2.1 (powerpc-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114242>

Pat Thoyts writes:

>     This patch improves the appearence of gitk on Windows XP and Vista
>     by making use of the themed widgets that are provided in Tk 8.5
>     and above. For good Vista support 8.6 will be needed.
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

Thanks for the patch.  It does seem to do a bit more than the commit
description says, though:

- It adds a toggle-fullscreen function.  I'd prefer that was done in a
  separate patch.

- It makes various changes to the layout in the non-ttk case - in
  particular various message widgets get turned into label widgets.
  Are label widgets entirely equivalent to message widgets?

Also, the patch has been corrupted by your mailer: on lines containing
only a "+", the "+" has been deleted.

I have a few questions about specific things you've done in the patch:

> +proc ttk_toplevel {w args} {
> +    variable use_ttk
> +    eval [linsert $args 0 ::toplevel $w]
> +    if {$use_ttk} {
> +        place [ttk::frame $w._toplevel_background] -x 0 -y 0 -relwidth 1 -relheight 1

What is the effect of this line, or what would happen if it wasn't
there?

>  proc show_error {w top msg} {
> +    variable use_ttk
> +    set ttk [expr {$use_ttk ? "ttk" : ""}]

Is there a strong reason for using variable here rather than global,
or is it just habit?

It looks to me as though $ttk might as well be a global variable,
rather than computing it from $use_ttk everywhere that we need it.

> @@ -1945,8 +1975,10 @@ proc makewindow {} {
>      }
>      . configure -menu .bar
>  
> +    place [${ttk}::frame ._main_background] -x 0 -y 0 -relwidth 1 -relheight 1

Once again, what's the reason for using place and the extra frame?

> +    if {$use_ttk} {
> +        #set p1 [expr {[winfo screenwidth .] - (40 * $charspc)}]
> +        #set p0 [expr {[winfo screenwidth .] - (100 * $charspc)}]
> +        #.tf.histframe.pwclist sashpos 0 585
> +        #.tf.histframe.pwclist sashpos 1 868
> +     } else {
> +        eval .tf.histframe.pwclist sash place 0 $geometry(pwsash0)
> +        eval .tf.histframe.pwclist sash place 1 $geometry(pwsash1)
> +    }

Looks like that could be cleaned up a bit.

> -    set gm [tk_optionMenu .tf.lbar.gdttype gdttype \
> -		[mc "containing:"] \
> -		[mc "touching paths:"] \
> -		[mc "adding/removing string:"]]
> +    if {$use_ttk} {
> +        set values [list [mc "containing:"] [mc "touching paths:"] \
> +                        [mc "adding/removing string:"]]
> +        set gm [ttk::combobox .tf.lbar.gdttype -width 10\
> +                    -values $values -textvariable gdtype]
> +    } else {
> +        set gm [tk_optionMenu .tf.lbar.gdttype gdttype \
> +                    [mc "containing:"] \
> +                    [mc "touching paths:"] \
> +                    [mc "adding/removing string:"]]
> +    }

We could profitably use a helper function here that would take the
list of alternatives and make the combobox/optionMenu.

> -    $top.tohead conf -state readonly
> +    $top.tohead configure -state readonly

Do all the other instances of conf need to be changed to configure,
and if so, why?

> -    checkbutton $top.showlocal -text [mc "Show local changes"] \
> -	-font optionfont -variable showlocalchanges
> +    ${ttk}::checkbutton $top.showlocal -text [mc "Show local changes"] \
> +	-variable showlocalchanges

Why do we lose the -font optionfont?

Thanks,
Paul.
