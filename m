From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified
 submodules.
Date: Mon, 12 Nov 2007 09:40:39 +0100
Message-ID: <200711120940.40271.johan@herland.net>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
 <46dff0320711102218h259199e3g2b4a4d3b73202cdb@mail.gmail.com>
 <7vhcjscyhu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Yin Ping <pkufranky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 09:41:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrUr9-0001r9-HH
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 09:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbXKLIlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 03:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbXKLIlA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 03:41:00 -0500
Received: from smtp.getmail.no ([84.208.20.33]:36389 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbXKLIk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 03:40:59 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JRD00007XFXLE00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 12 Nov 2007 09:40:45 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JRD00MWAXFTUZA0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 12 Nov 2007 09:40:41 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JRD007A5XFS4J90@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 12 Nov 2007 09:40:41 +0100 (CET)
In-reply-to: <7vhcjscyhu.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64576>

On Sunday 11 November 2007, Junio C Hamano wrote:
> "Yin Ping" <pkufranky@gmail.com> writes:
> 
> > I think it's this kind of case in most open-source project. However,
> > in a company environment, superprojects may be not so super.
> 
> Let's not say "most open-source" nor "company", because I think
> nobody said anything that substantiates that the commit density
> characteristics I described is typical for most open-source, nor
> what you said is typical for corporate development projects, in
> this thread so far.
> 
> If "superprojects is not so super", why are you using submodule
> to bind these, instead of using a single project that tracks
> developments of such closely tied parts?
> 
> I am not saying that it is wrong to use submodule to track such
> groups of source trees whose versions are very closely tied
> together.  At least not yet.
> 
> I am just trying to find out what benefit you are getting out of
> the submodule support, after rejecting one of the most visible
> and advertised benefit of submodule support, which is to enable
> binding "related but not that closely tied together" projects.

At $dayjob, we are working on a codebase roughly the same size as current 
linux-kernel with about 8 years of history in CVS. I'm currently looking at 
how suitable git would be for our revision control purposes (and so far I'm 
lovin' it).

The codebase is divided into CVS modules; most modules (aka. "core" modules) 
each have their own in-house maintainer and have internal releases with 
variable frequency. The other modules (aka. "platform/product" modules) 
each pull together a carefully chosen set of "core" modules as submodules, 
and add platform code to create - in the end - a complete product (with its 
own release frequency). Specifically:

- All the modules required by the product must be present in the checkout 
before a build can be made

- All the modules are independently developed, with different 
development/release timelines

- The "core" people only focus on 1-2 modules at a time, but 
the "platform/product" people might make changes in _many_ modules during a 
workday.

When investigating how to mesh this workflow with git, I naturally ended up 
with converting each CVS module to a git repository, and making 
the "platform/product" repos include the required "core" repos as 
submodules. This decision has the following effect from git's POV:

- "superproject is not so super" in that _all_ required modules must be 
checked out before a build can be made. In other words: all the submodules 
in a repo are "interesting"

- The modules are "related but not that closely tied together" since they 
follow separate development schedules, with separate releases, etc.

- The "platform/product" people will most certainly want to have commands 
like "git diff", "git status", and maybe even "git log" and "git-commit" 
recurse into submodules.

- The "core" people will probably not want "recurse-into-submodules" 
behaviour, although I can see places where it could be useful for them as 
well.


A possible solution to the above problem is to add 
a '--recurse-into-submodules' option to all relevant git commands. At the 
same time, the actual implementation of submodule recursion should probably 
be kept in the vicinity of "git-submodule" (instead of spreading it across 
the other git commands).

Probably unrealistic: Maybe we could solve the problem by adding
"--recurse-into-submodules" to the toplevel 'git' command itself, and make 
it re-invoke itself recursively in each submodule.


Hope this gives you insight into how _some_ people would like to use git's 
submodule support.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
