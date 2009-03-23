From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] gitk: make use of themed widgets where available
Date: Tue, 24 Mar 2009 00:28:25 +0100
Message-ID: <49C81B19.2000706@users.sourceforge.net>
References: <87ljrre7nr.fsf@users.sourceforge.net> <18887.8064.114036.850741@drongo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 00:30:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lltav-00044r-8o
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 00:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbZCWX2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 19:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbZCWX2n
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 19:28:43 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:49213 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750906AbZCWX2m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 19:28:42 -0400
Received: from [172.23.170.145] (helo=anti-virus03-08)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1LltZO-0007CJ-UR; Mon, 23 Mar 2009 23:28:38 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1LltZJ-0007m3-Kk; Mon, 23 Mar 2009 23:28:38 +0000
Received: from [192.168.0.25] (pc025.patthoyts.tk [192.168.0.25])
	by badger.patthoyts.tk (Postfix) with ESMTP id F085C5182B;
	Mon, 23 Mar 2009 23:28:32 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <18887.8064.114036.850741@drongo.ozlabs.ibm.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114361>

Paul Mackerras wrote:
> Pat Thoyts writes:
> 
>>     This patch improves the appearence of gitk on Windows XP and Vista
>>     by making use of the themed widgets that are provided in Tk 8.5
>>     and above. For good Vista support 8.6 will be needed.
>>
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> 
> Thanks for the patch.  It does seem to do a bit more than the commit
> description says, though:
> 
> - It adds a toggle-fullscreen function.  I'd prefer that was done in a
>   separate patch.

Sure. This seems to be a recurring issue that I need to take care of.

> - It makes various changes to the layout in the non-ttk case - in
>   particular various message widgets get turned into label widgets.
>   Are label widgets entirely equivalent to message widgets?

It depends on how the message widget is being used - but for simple cases
they are equivalent. The message widget has some more options for placing
the text within but is no themed equivalent for message.

> Also, the patch has been corrupted by your mailer: on lines containing
> only a "+", the "+" has been deleted.

Damn - I'm surprised Gnus mashed anything in a patch file.

> I have a few questions about specific things you've done in the patch:
> 
>> +proc ttk_toplevel {w args} {
>> +    variable use_ttk
>> +    eval [linsert $args 0 ::toplevel $w]
>> +    if {$use_ttk} {
>> +        place [ttk::frame $w._toplevel_background] -x 0 -y 0 -relwidth 1 -relheight 1
> 
> What is the effect of this line, or what would happen if it wasn't
> there?

A 'toplevel' widget is not themed so it picks up the default Tk options
for the current platform. Where the theme background colour for a frame
is significantly different to the Tk background colour this becomes
obvious. For instance:
 package require Tk 8.5
 ttk::style theme use clam
 pack [ttk::frame .f -height 100 -width 100] -padx 10 -pady 10
will show a different 10 pixel border around the frame in the Tk default
colour. On some themes the difference is not too noticable, on others
its significant.

>>  proc show_error {w top msg} {
>> +    variable use_ttk
>> +    set ttk [expr {$use_ttk ? "ttk" : ""}]
> 
> Is there a strong reason for using variable here rather than global,
> or is it just habit?

habit.

> It looks to me as though $ttk might as well be a global variable,
> rather than computing it from $use_ttk everywhere that we need it.

Agreed

>> @@ -1945,8 +1975,10 @@ proc makewindow {} {
>>      }
>>      . configure -menu .bar
>>  
>> +    place [${ttk}::frame ._main_background] -x 0 -y 0 -relwidth 1 -relheight 1
> 
> Once again, what's the reason for using place and the extra frame?

As above. The other alternative would be to pack or grid a ttk::frame
and then make all the other widgets children of this and pack/grid them
inside. This is a simpler option.

> 
>> +    if {$use_ttk} {
>> +        #set p1 [expr {[winfo screenwidth .] - (40 * $charspc)}]
>> +        #set p0 [expr {[winfo screenwidth .] - (100 * $charspc)}]
>> +        #.tf.histframe.pwclist sashpos 0 585
>> +        #.tf.histframe.pwclist sashpos 1 868
>> +     } else {
>> +        eval .tf.histframe.pwclist sash place 0 $geometry(pwsash0)
>> +        eval .tf.histframe.pwclist sash place 1 $geometry(pwsash1)
>> +    }
>
> Looks like that could be cleaned up a bit.

Doh. I have this fixed properly locally (I'll comment at the end).

>> -    set gm [tk_optionMenu .tf.lbar.gdttype gdttype \
>> -		[mc "containing:"] \
>> -		[mc "touching paths:"] \
>> -		[mc "adding/removing string:"]]
>> +    if {$use_ttk} {
>> +        set values [list [mc "containing:"] [mc "touching paths:"] \
>> +                        [mc "adding/removing string:"]]
>> +        set gm [ttk::combobox .tf.lbar.gdttype -width 10\
>> +                    -values $values -textvariable gdtype]
>> +    } else {
>> +        set gm [tk_optionMenu .tf.lbar.gdttype gdttype \
>> +                    [mc "containing:"] \
>> +                    [mc "touching paths:"] \
>> +                    [mc "adding/removing string:"]]
>> +    }
> 
> We could profitably use a helper function here that would take the
> list of alternatives and make the combobox/optionMenu.
> 
>> -    $top.tohead conf -state readonly
>> +    $top.tohead configure -state readonly
> 
> Do all the other instances of conf need to be changed to configure,
> and if so, why?

Using abbreviated subcommand or option names should really be restricted
to interactive code. In script files its better to write it out in full
as you never know in some future version Tk might get more subcommands
added and the abbreviation may no longer be unique.
However, such changes should be put in a separate style patch.

> 
>> -    checkbutton $top.showlocal -text [mc "Show local changes"] \
>> -	-font optionfont -variable showlocalchanges
>> +    ${ttk}::checkbutton $top.showlocal -text [mc "Show local changes"] \
>> +	-variable showlocalchanges
> 
> Why do we lose the -font optionfont?

The point to the ttk widgets is that the visual style of the widget
becomes dictated by the theme and it should no longer be necessary to
specify lots of options on each widget to get it looking reasonable.
When running on Windows, the graphical elements should be drawn using
the system configured fonts and in Tk 8.5+ this is read from the system
parameters info. So if a user configures her system to use large fonts
via the system display properties control panel, then large fonts is
what she will now get.

In fact the ttk::checkbutton doesn't accept a -font option to discourage
people from overriding the users chosen system settings. If you really
need to set the font for a checkbutton then you create a new style and
set the font for that style. Or cheat and use a tk::checkbutton which
provides all the same options it has always done.

For instance:
 ttk::style configure Fat.Checkbutton -font {Arial 12 bold}
 pack [ttk::checkbutton .check -text Emboldened -style Fat.Checkbutton]


I will redo the ttk patch on top of the new commits and take better care
to isolate them into descrete chunks of work. I have noticed since
posting the patch that it broke the preferences dialog on Linux and the
positions of the panedwindow splitters stopped being saved so these need
rolling into a new patch as well.

Pat Thoyts
