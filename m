From: Toby Corkindale <toby.corkindale@rea-group.com>
Subject: [BUG?] git-archive ignores remote .gitattributes (was: .git/info/attributes
 not cloned)
Date: Fri, 28 Mar 2008 16:10:41 +1100
Organization: REA Group
Message-ID: <47EC7DD1.3060102@rea-group.com>
References: <47EB0FAE.5000102@rea-group.com> <20080327033341.GB5417@coredump.intra.peff.net> <47EB213F.1020503@rea-group.com> <20080327042925.GA6426@coredump.intra.peff.net> <47EB271F.1050307@rea-group.com> <20080327045342.GC6426@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 06:03:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf6kX-0002Ft-TN
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 06:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbYC1FCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 01:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbYC1FCm
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 01:02:42 -0400
Received: from mel-nat68.realestate.com.au ([210.50.192.68]:1403 "EHLO
	mel-nat68.realestate.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751037AbYC1FCl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Mar 2008 01:02:41 -0400
Received: from [192.168.53.6] ([192.168.53.6]) by mel-nat68.realestate.com.au with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 28 Mar 2008 16:02:18 +1100
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <20080327045342.GC6426@coredump.intra.peff.net>
X-OriginalArrivalTime: 28 Mar 2008 05:02:18.0730 (UTC) FILETIME=[E5ED8CA0:01C89090]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78383>

Jeff King wrote:
> On Thu, Mar 27, 2008 at 03:48:31PM +1100, Toby Corkindale wrote:
> 
>>> I vaguely recall some discussion of this in the past, so maybe it isn't
>>> a good idea. But I would think changing git-archive to respect
>>> .gitattributes might be worth doing (presumably the version of
>>> .gitattributes from the tree that is being exported).
>> Respecting the repo's .gitattributes would feel right. It seems unusual  
>> (to me) that it bypasses $REMOTE/.gitattributes, but DOES check  
>> $REMOTE/info/attributes.
> 
> I agree that it seems like a bug. You might search the list archives for
> discussion around the export_subst attribute to see if it was discussed
> then or if it is simply an omission.

My searches haven't turned anything up that seems relevant.
I submit that this is a bug, or at least undesirable behaviour:

"git-archive --remote=/some/repo" will ignore /some/repo/.gitattributes, 
but check /some/repo/info/attributes.

I think the problem is in the loop that looks for .gitattributes, which 
seems to do so by taking the current path and iterating down through it?
In the case of remote archives, shouldn't that start by taking the path 
of the repo, not current dir?

Or should it go one step further, and check the .gitattributes for every 
file it extracts? That is the behaviour you get if you run git-archive 
from within a repo, rather than remotely - and don't we want that to be 
consistent with using --remote?

ie. I'm thinking of structures like:
/myModule/testfile.pm
/myModule/subdir/testfile.pm
/myModule/subdir/.gitattributes

if I do "cd /myModule; git-archive HEAD" then shouldn't I get the same 
output as if I did "cd /tmp; git-archive --remote=/myModule HEAD" ?
