From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Dealing with many many git repos in a /home directory
Date: Thu, 04 Feb 2010 12:35:11 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002041207330.1681@xanadu.home>
References: <9b18b3111002040029x1c7de0afw4a5ef883588f7a18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 18:35:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd5cG-00029f-C1
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 18:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933509Ab0BDRfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 12:35:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31040 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933506Ab0BDRfN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 12:35:13 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXB0010QVIN7Y30@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 04 Feb 2010 12:35:12 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9b18b3111002040029x1c7de0afw4a5ef883588f7a18@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138988>

On Thu, 4 Feb 2010, demerphq wrote:

> At $work we have a host where we have about 50-100 users each with
> their own private copies of the same repos. These are cloned froma
> remote via git/ssh and are not thus automatically hardlinking their
> object stores.
> 
> This is starting to take a lot of space.

You should keep a pristine copy of that common repository on that host 
and make it readable to everyone, and then ask your users to use the 
--reference argument with 'git clone' to borrow as much as possible from 
that common repository.

For those who already cloned the repository in full i.e. without the 
--reference switch, then it is possible to fix the situation simply by 
adding the full path to the common repository's .git/objects directory 
in their own .git/objects/info/alternates (create it if it doesn't 
exist) and then run 'git gc'.  That's what the --reference argument to 
the clone command does: setting up that .git/objects/info/alternates 
file.

> I was thinking it should be possible to hardlink all of the objects in
> the different repos to a canonical single copy.
> 
> Would i be correct in thinking that if i have to repos with an
> equivalent  .git/objects/../..... file in them that the files are
> necessarily identical and one can be replaced by a hardlink to the
> other?

Yes, you could do that.  However you'll save very little by doing that 
as the bulk of a repository content is normally stored into pack files, 
and those may differ from one repository to another depending on what 
exactly the pack contains.  The alternates mechanism is more powerful as 
it lets Git fetch objects from the canonical repository packed or not, 
and more importantly it avoids creating local copy of new objects if 
they already exists in that canonical copy meaning that you don't have 
to constantly search in every user's repository for potential new 
objects to hardlink.

> If this is correct then is there some tool known to the list that
> already does this?  I whipped this together:

The "tool" exists in Git already and is what I describe above.  The 
actual tool you might need is probably a script to populate that 
.git/objects/info/alternates file in all your users' repositoryes and 
maybe run ,git gc' on their behalf.


Nicolas
