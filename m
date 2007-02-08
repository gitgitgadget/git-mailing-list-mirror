From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] Make gitk save and restore the user set window position.
Date: Wed, 07 Feb 2007 19:30:38 -0500
Message-ID: <45CA6F2E.7010707@verizon.net>
References: <7v3b5ifyam.fsf@assigned-by-dhcp.cox.net>
 <20070207054010.GB7047@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 01:34:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HExEh-0004Ai-3e
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422856AbXBHAbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422848AbXBHAbE
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:31:04 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:11724 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422844AbXBHAas (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:30:48 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JD400HESC30SX5M@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 07 Feb 2007 18:30:38 -0600 (CST)
In-reply-to: <20070207054010.GB7047@spearce.org>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39020>

Shawn O. Pearce wrote:
> Junio C Hamano <junkio@cox.net> wrote:
>   
>>    After seeing what this patch has to do, I feel dirty, but
>>    that is not Mark's fault -- rather it is Tk's.
>>
>>    I am tempted to suggest adding an explicit "Save window
>>    configuration" action on the menubar and forget about
>>    resurrecting the window configuration immediately before the
>>    end of the last session.
>>     
>
> Maybe take a look at what git-gui does here, because its slightly
> saner and still saves the geometry on exit:
>
> 	set is_quitting 0
> 	proc do_quit {} {
> 		global is_quitting
> 		if {$is_quitting} return
> 		set is_quitting 1
> 		# save wm geometry
> 	}
> 	bind . <Destroy> do_quit
>
> OK, its not that much saner.  But it does bypass needing to setup
> some ugly bindings on every object in the UI.  Though I recently
> took a slightly different approach in a dialog:
>
> 	proc do_quit {} {
> 		bind . <Destroy> {}
> 		# do cleanup
> 	}
> 	bind . <Destroy> do_quit
>
> Yes the binding is firing in both cases for some arbitrary child
> widget in the window, but it doesn't matter.  In the latter version
> setting the binding to the empty string removes the do_quit binding,
> allowing the other widgets to destroy without reinvoking do_quit
> and whacking whatever geometry data you may have saved before the
> widgets started to get deleted.
>
>
> The only problem I seem to have in git-gui is the window position
> opens about 10 pixels lower and 2 pixels to the right than the last
> time it opened.  I think there's a bug in Tk on Windows where the
> window position on the desktop doesn't include the titlebar when I
> get it, but expects to include it when I attempt to set it on the
> next start.
>
> I should note I also see the same behavior with my day-time-job's
> Java apps on Windows however, so I don't think its a specific Tk
> or git-gui issue.
>
>   
What you suggest is essentially what gitk does before my patch. In 
git-gui, routine do_quit is invoked when Tk is ready to destroy the top 
level window: this is _after_ Tk has destroyed everything in the window, 
and thus the problem. I still haven't isolated which object(s) being 
destroyed from gitk cause the geometry reported from wm info to change, 
clearly my patch is binding widgets that do not need to be bound, but I 
haven't found which specific one needs to be bound.

With my patch, the correct position is saved and restored on both Linux 
and Cygwin. I think that should be the goal. A more elegant solution 
accomplishing that end is of course desirable, but there remains the 
issue of finding it. I think the objections to my patch are more 
theoretical than practical: I seriously doubt you can find any 
practically observable side effect of binding all the widgets other than 
that the window geometry _is_ correctly saved and restored.

As to being specific to Tk, I have many windows applications that 
successfully save and restore window state, this geometry issue is not 
endemic to Windows and I have never encountered it except with Tk.

Mark
