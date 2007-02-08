From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: [PATCH] Make gitk save and restore the user set window position.
Date: Wed, 7 Feb 2007 21:43:31 -0800 (PST)
Message-ID: <491753.81112.qm@web38915.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 06:50:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF2Al-0003pH-VC
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 06:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161535AbXBHFuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 00:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161538AbXBHFuQ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 00:50:16 -0500
Received: from web38915.mail.mud.yahoo.com ([209.191.125.121]:26180 "HELO
	web38915.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161535AbXBHFuO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Feb 2007 00:50:14 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Feb 2007 00:50:14 EST
Received: (qmail 81810 invoked by uid 60001); 8 Feb 2007 05:43:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Mq+Cv7hgIpzQiquk+Gtig0QRBCZbtAherHFqnY3t/VvgWqgA35IMtJ3HM33i1bgPdE0pbEq8AAxyvIL8gKkJN7qpv7X7pWLYWRSfTzc94NA2JiX/bUDPR3Ie11tais8e7gnVVfBbwELdzULT/FoaXl1Us1iI4l+VKxETbGGR4E0=;
X-YMail-OSG: eKwePFcVM1kDWKR9vDY0sPpo5u5LfDU3IL_PG4CV6Ixu9ry2ZiTDT5T.f8RRvaTIMw--
Received: from [198.205.32.93] by web38915.mail.mud.yahoo.com via HTTP; Wed, 07 Feb 2007 21:43:31 PST
X-Mailer: YahooMailRC/368.7 YahooMailWebService/0.6.132.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39031>

>----- Original Message ----
>From: Mark Levedahl <mdl123@verizon.net>
>To: Shawn O. Pearce <spearce@spearce.org>
>Cc: Junio C Hamano <junkio@cox.net>; git@vger.kernel.org
>Sent: Wednesday, February 7, 2007 4:30:38 PM
>Subject: Re: [PATCH] Make gitk save and restore the user set window position.
>
>Shawn O. Pearce wrote:
>> Junio C Hamano <junkio@cox.net> wrote:
>>  
>>>    After seeing what this patch has to do, I feel dirty, but
>>>    that is not Mark's fault -- rather it is Tk's.
>>>
>>>    I am tempted to suggest adding an explicit "Save window
>>>    configuration" action on the menubar and forget about
>>>    resurrecting the window configuration immediately before the
>>>    end of the last session.
>>>    
>>
>> Maybe take a look at what git-gui does here, because its slightly
>> saner and still saves the geometry on exit:
>>
>>     set is_quitting 0
>>     proc do_quit {} {
>>         global is_quitting
>>         if {$is_quitting} return
>>         set is_quitting 1
>>         # save wm geometry
>>     }
>>     bind . <Destroy> do_quit
>>
>> OK, its not that much saner.  But it does bypass needing to setup
>> some ugly bindings on every object in the UI.  Though I recently
>> took a slightly different approach in a dialog:
>>
>>     proc do_quit {} {
>>         bind . <Destroy> {}
>>         # do cleanup
>>     }
>>     bind . <Destroy> do_quit
>>
>> Yes the binding is firing in both cases for some arbitrary child
>> widget in the window, but it doesn't matter.  In the latter version
>> setting the binding to the empty string removes the do_quit binding,
>> allowing the other widgets to destroy without reinvoking do_quit
>> and whacking whatever geometry data you may have saved before the
>> widgets started to get deleted.
>>
>>
>> The only problem I seem to have in git-gui is the window position
>> opens about 10 pixels lower and 2 pixels to the right than the last
>> time it opened.  I think there's a bug in Tk on Windows where the
>> window position on the desktop doesn't include the titlebar when I
>> get it, but expects to include it when I attempt to set it on the
>> next start.
>>
>> I should note I also see the same behavior with my day-time-job's
>> Java apps on Windows however, so I don't think its a specific Tk
>> or git-gui issue.
>>
>>  
> What you suggest is essentially what gitk does before my patch. In
> git-gui, routine do_quit is invoked when Tk is ready to destroy the top
> level window: this is _after_ Tk has destroyed everything in the window,
> and thus the problem. I still haven't isolated which object(s) being
> destroyed from gitk cause the geometry reported from wm info to change,
> clearly my patch is binding widgets that do not need to be bound, but I
> haven't found which specific one needs to be bound.
> 
> With my patch, the correct position is saved and restored on both Linux
> and Cygwin. I think that should be the goal. A more elegant solution
> accomplishing that end is of course desirable, but there remains the
> issue of finding it. I think the objections to my patch are more
> theoretical than practical: I seriously doubt you can find any
> practically observable side effect of binding all the widgets other than
> that the window geometry _is_ correctly saved and restored.
> 
> As to being specific to Tk, I have many windows applications that
> successfully save and restore window state, this geometry issue is not
> endemic to Windows and I have never encountered it except with Tk.
> 
> Mark
> 

I've only been half following this thread, so I apologize if this was already talked about.

Have you tried [wm protocol] command. You would use it like this:

    wm protocol . WM_DELETE_WINDOW do_quit

This basically traps the signal from the windowmanager, and [do_quit] gets executed *before* the gui is torn down. The only bad thing about this, is if you explicitly destroy a widget inside your code (i.e. [destroy .]), then this will *not* get invoked. You also need to make sure you catch any possible errors in do_quit, otherwise the gui will hang.

HTH,
    --brett


-
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html





 
____________________________________________________________________________________
Be a PS3 game guru.
Get your game face on with the latest PS3 news and previews at Yahoo! Games.
http://videogames.yahoo.com/platform?platform=120121
