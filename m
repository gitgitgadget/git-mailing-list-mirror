From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH 2/4] FindToolbar port to the new history page.
Date: Tue, 01 Apr 2008 00:44:06 -0300
Message-ID: <47F1AF86.3030503@intelinet.com.br>
References: <1206890325-3732-1-git-send-email-rogersoares@intelinet.com.br> <20080331061914.GK10274@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 05:48:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgXUU-0000aV-9I
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 05:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbYDADsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 23:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbYDADsL
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 23:48:11 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1502 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750872AbYDADsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 23:48:09 -0400
Received: (qmail 26753 invoked by uid 0); 1 Apr 2008 00:49:57 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.451367 secs); 01 Apr 2008 03:49:57 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 1 Apr 2008 03:49:57 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20080213)
In-Reply-To: <20080331061914.GK10274@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78621>


Shawn O. Pearce escreveu:
> Hmm.  So what functionality did the highlight flag + RevFilter
> not get you?  It supports both regex as well as non-regex matches,
> is quick, and can be joined together with other filters.  A lot of
> the code in the FindToolbarThread should drop out.
>   
Ok, so, my motivation first. I don't have too much time to work on egit 
but I'm interested in using your work in my build. So, I'm pushing the 
features I need. This patch was intended as a simple port of the 
existing FindToolbar to the new history page so I can use it.

I tried the applyFlags you described but it doesn't have a monitor 
approach to give feedback to the toolbar so it knows when to refresh the 
table and to select the first match, or to go red when nothing was 
found. I also couldn't find from the highlight flag + RevFilter solution 
how to get the total rows encountered and the index of a match so the 
toolbar can show that the selected match is number 2 from 10.

So, this patch was intented as a port. I'm not sure everything related 
to search should go inside jgit, but I agree that RevFilters should be 
reused. I was thinking about it as an improvement after the port, it's 
not my priority right now but someone else can do it? ;)


> This field isn't necessary.  "table.getTable()" will get you the
> same widget.
>   
Ok.


> So this is doing basically the same thing as the highlight RevFlag
> (give a boolean about match status for a given RevCommit) but needs
> to consult a HashMap by creating a temporary boxed Integer, and this
> is deep down inside of the painting code for the table.  Urrgh.
>   
The map is used to give the x from total information. When using a 
VIRTUAL table it doesn't have a noticable performance impact because 
only a small set is required at a time.

Robin sent a patch some time ago to change those new Integer() to 
Integer.valueOf(), I guess he didn't push it yet.


> These strings should be in UIText, and UIText.properties, so they
> can be translated strings.
>   
Ok.


> Would it make sense to abstract out and reuse the BooleanPrefAction
> class I added to GitHistoryPage in ea3f1e7a7684b8?  
>   
Probably, I'll get a look on it.


> Shouldn't this maybe be a Job instead, and scheduled on the History
> site so the History title bar goes italics and the user can see
> the progress meter in the status bar of the workspace and in their
> Progress view?
>   
Maybe. When I wrote this I wasn't aware about the existence of the Job 
interface. Then when I met it I thought about replacing it, but havent't 
done it yet.


> I'm not an SWT expert, but I think hanging onto a Display reference
> from a class static isn't a good idea.
>   
You're right.


> Shouldn't this be a volatile, or an AtomicInteger, or protected by
> a synchronized block?
>   
Yep.


> Wow.  That's black magic.  You are blocking the threads from
> doing multiple searches at once by synchonizing on the static
> method, but since you are in an instance method you had to pass
> everything through as arguments.  :-|
>
> It would be a lot easier to follow if this was an instance member,
> and thus had access to the instance fields, and if you used an
> explicit lock, e.g.:
>
> 	private static final Object EXEC_LOCK = new Object();
>
> 	public void run() {
> 		synchronized (EXEC_LOCK) {
> 			execFind();
> 		}
> 	}
>
> 	private void execFind() { ... }
>   
Yep, looks better.

[]s,
Roger.
