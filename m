From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-http-fetch segfault, curl 7.18.0
Date: Sun, 2 Mar 2008 15:20:17 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803021508340.19665@iabervon.org>
References: <20080302190857.11027.qmail@28c5bbafb32cb2.315fe32.mid.smarden.org> <20080302192355.GA625@glandium.org> <20080302200309.GA2070@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 21:21:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVugG-0005cj-IP
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 21:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbYCBUU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 15:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753760AbYCBUU3
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 15:20:29 -0500
Received: from iabervon.org ([66.92.72.58]:44114 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601AbYCBUU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 15:20:29 -0500
Received: (qmail 23699 invoked by uid 1000); 2 Mar 2008 20:20:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Mar 2008 20:20:17 -0000
In-Reply-To: <20080302200309.GA2070@glandium.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75834>

On Sun, 2 Mar 2008, Mike Hommey wrote:

> On Sun, Mar 02, 2008 at 08:23:55PM +0100, Mike Hommey wrote:
> > On Sun, Mar 02, 2008 at 07:08:57PM +0000, Gerrit Pape wrote:
> > > Hi, as reported through http://bugs.debian.org/468836, I can reproduce
> > > with current maint branch on Debian/unstable, but I don't know whether
> > > it's a problem in curl, or in git.  Maybe anyone with some experience
> > > in curl can help on this?
> > > 
> > > gdb gives this
> > (...)
> > 
> > valgrind gives better insight:
> > ==862== Invalid read of size 4
> > ==862==    at 0x493B32: fill_active_slots (http.c:441)
> > ==862==    by 0x493CF9: step_active_slots (http.c:459)
> > ==862==    by 0x493D6E: run_active_slot (http.c:479)
> > ==862==    by 0x493F8B: http_cleanup (http.c:296)
> > ==862==    by 0x494CA8: cleanup (http-walker.c:900)
> > ==862==    by 0x4911D6: walker_free (walker.c:315)
> > ==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
> > ==862==    by 0x404247: handle_internal_command (git.c:248)
> > ==862==    by 0x4049D4: main (git.c:412)
> > ==862==  Address 0x7c7c558 is 16 bytes inside a block of size 72 free'd
> > ==862==    at 0x4C20B2E: free (vg_replace_malloc.c:323)
> > ==862==    by 0x493F47: http_cleanup (http.c:301)
> > ==862==    by 0x494CA8: cleanup (http-walker.c:900)
> > ==862==    by 0x4911D6: walker_free (walker.c:315)
> > ==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
> > ==862==    by 0x404247: handle_internal_command (git.c:248)
> > ==862==    by 0x4049D4: main (git.c:412)
> (...)
> > 
> > It seems there is something wrong going on with slots...
> 
> And the problem lies in the fact we run_active_slot() during cleanup,
> which can end up going through all the slots starting at
> active_queue_head, while we have freed the first slots...
> 
> Now, why do we need to run slots when cleaning up ?

AFAICT, it's always been that way. I assume there was code that set up all 
of the remaining transfers and then just called http_cleanup, relying on 
the callbacks to handle the receipt of the remaining data, but I'm not 
sure if that's still the case. On the other hand, I think that code is 
supposed to remove slots from the active queue as they get processed, so 
that run_active_slot() is always safe to call and just won't do anything 
if it's not needed in cleanup.

So I'm guessing that we have list corruption due to code getting careless 
in error cases, in addition to cleanup code that possibly cares too much 
about finishing everything it can.

(I don't really know the http.c code all that well, BTW; I've only 
interacted with it peripherally in reorganizing http-fetch into 
http-walker last summer)

	-Daniel
*This .sig left intentionally blank*
