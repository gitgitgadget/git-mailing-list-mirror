From: Zachary Turner <zturner@chromium.org>
Subject: Re: Make the git codebase thread-safe
Date: Thu, 13 Feb 2014 18:38:00 +0000 (UTC)
Message-ID: <loom.20140213T193220-631@post.gmane.org>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com> <CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com> <CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com> <CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com> <CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com> <CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com> <52FBC9E5.6010609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 13 19:45:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE1Hc-0003yM-L3
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 19:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbaBMSpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 13:45:06 -0500
Received: from plane.gmane.org ([80.91.229.3]:49408 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbaBMSpE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 13:45:04 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WE1HS-0003nm-NB
	for git@vger.kernel.org; Thu, 13 Feb 2014 19:45:02 +0100
Received: from 216.239.45.74 ([216.239.45.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 19:45:02 +0100
Received: from zturner by 216.239.45.74 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 19:45:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 216.239.45.74 (Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1836.3 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242072>

Karsten Blees <karsten.blees <at> gmail.com> writes:

> 
> Am 12.02.2014 19:37, schrieb Erik Faye-Lund:
> > On Wed, Feb 12, 2014 at 7:34 PM, Stefan Zager <szager <at> google.com> 
wrote:
> >> On Wed, Feb 12, 2014 at 10:27 AM, Erik Faye-Lund <kusmabite <at> 
gmail.com> wrote:
> >>> On Wed, Feb 12, 2014 at 7:20 PM, Stefan Zager <szager <at> google.com> 
wrote:
> >>>>
> >>>> I don't want to steal the thunder of my coworker, who wrote the
> >>>> implementation.  He plans to submit it upstream soon-ish.  It relies
> >>>> on using the lpOverlapped argument to ReadFile(), with some 
additional
> >>>> tomfoolery to make sure that the implicit position pointer for the
> >>>> file descriptor doesn't get modified.
> >>>
> >>> Is the code available somewhere? I'm especially interested in the
> >>> "additional tomfoolery to make sure that the implicit position pointer
> >>> for the file descriptor doesn't get modified"-part, as this was what I
> >>> ended up butting my head into when trying to do this myself.
> >>
> >> https://chromium-review.googlesource.com/#/c/186104/
> > 
> > ReOpenFile, that's fantastic. Thanks a lot!
> 
> ...but should be loaded dynamically via GetProcAddress, or are we ready to 
drop XP support?
> 
> 

Original patch author here.  In trying to prepare this patch to use 
GetProcAddress to load dynamically, I've run into a bit of a snag.  
NO_THREAD_SAFE_PREAD is a compile-time flag, which will be incompatible with 
any attempt to make this a runtime decision a la LoadLibrary / 
GetProcAddress.  On XP, we would need to fallback to the single-threaded 
path, and on Vista+ we would use the thread-able path, and obviously this 
decision could not be made until runtime.

If MinGW were the only configuration using NO_THREAD_SAFE_PREAD, I would 
just remove it entirely, but it appears Cygwin configuration uses it also.

Suggestions?  

One possibility is to disallow (by convention, perhaps), the use of pread() 
and read() against the same fd.  The only reason ReOpenFile is necessary at 
all is because some code somewhere is mixing read-styles against the same 
fd.
