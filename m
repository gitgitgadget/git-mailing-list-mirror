From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: New features in gitk
Date: Fri, 2 Nov 2007 08:42:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org> 
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org> 
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org> 
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:45:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inyhb-0006Fo-BB
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759100AbXKBPng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 11:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758199AbXKBPng
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:43:36 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41948 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756239AbXKBPnd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 11:43:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2FgxQL029696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Nov 2007 08:43:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2Fgwts029017;
	Fri, 2 Nov 2007 08:42:59 -0700
In-Reply-To: <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
X-Spam-Status: No, hits=-2.693 required=5 tests=AWL,BAYES_00,TW_QG
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63136>



On Fri, 2 Nov 2007, Marco Costalba wrote:
> 
> I have tried to overcome --topo-order in qgit but I found it very
> difficult, too much for me.
> 
> Lazily drawing the layout it doesn't mean that you lazy load the data
> from git, indeed you load all the git-log output as soon as it
> arrives.

Would it be more palatable if I tried to write some visualization-specific 
front-end that acted kind of like "git rev-list", but would have some way 
of "resetting" its output?

The thing is, I'm pretty sure I can feed you commits really quickly if I 
don't sort them, and if I don't do the full and careful "oops, this commit 
was reachable from a commit that was marked uninteresting", but while the 
fast-and-stupid approach will work well enough for most things, it will 
occasionally get the wrong answer.

But it will *notice* when it gets the wrong answer, though, and can reset 
and start over!

IOW, I might be able to do something that

 - prints out the commit info per line

 - prepends each line with a line number

 - goes back to an earlier line 'n' when it notices that it needs to 
   output a commit before a previous commit (or when it notices that a 
   commit that it had already output was actually not supposed to show up)

and with something like that, I could make git give you incremental 
output.

The thing is, any revision information that requires "global knowledge" 
simply cannot scale. And "git rev-list --topo-order" may be fast as hell, 
and I can do it in one second on the kernel archive on my machine, but 
that's really only true when it's all cached. 

If it's not cached, it will inevitably have to read in every single commit 
if you want a "final and unchanging ordering". Which inevitably gets you a 
really irritating startup latency. That's just fundamental.

On the other hand, if there is some way to say "oops, restart", I can 
optimistically give you a list that is always properly sorted on a *local* 
scale, but then based on later data I might notice that it wasn't right 
globally and that I need to re-do all or part of it.

But as mentioned, that requires that side-band data of "uhhuh, I screwed 
up, let me go back and fix it".

			Linus
