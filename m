From: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>
Subject: Re: Efficient cloning from svn (with multiple branches/tags subdirs)
Date: Thu, 15 Oct 2009 18:23:31 +0100
Message-ID: <4AD75A93.9050106@manchester.ac.uk>
References: <hb2fvu$8qi$1@ger.gmane.org> <20091014060307.GA17178@dcvr.yhbt.net> 	<32541b130910140928jdac0187x754423e8d5c64e53@mail.gmail.com> 	<20091014180013.GA24741@dcvr.yhbt.net> <32541b130910141126u4df7f439i3d2926c2e1db9497@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 19:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyU7N-0002cU-CT
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 19:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933471AbZJORYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 13:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759632AbZJORYm
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 13:24:42 -0400
Received: from lo.gmane.org ([80.91.229.12]:34006 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758630AbZJORYl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 13:24:41 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MyU3Q-0000Cr-4Y
	for git@vger.kernel.org; Thu, 15 Oct 2009 19:23:56 +0200
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 19:23:56 +0200
Received: from Bruno.Harbulot by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 19:23:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: rain.gmane.org
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <32541b130910141126u4df7f439i3d2926c2e1db9497@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130404>

Hello,

Avery Pennarun wrote:
> On Wed, Oct 14, 2009 at 2:00 PM, Eric Wong <normalperson@yhbt.net> wrote:
>> Avery Pennarun <apenwarr@gmail.com> wrote:
>>> I've been thinking about this myself for some time.  One option that
>>> might be "interesting" would be to just grab the *entire* svn tree
>>> (from the root), and then use git-subtree[1] to slice and dice it into
>>> branches using your local copy of git (which is fast and uses no
>>> bandwidth) instead of during the svn fetch (which is slow and uses
>>> lots of bandwidth).  I think it would also simplify the git-svn code
>>> quite a lot, at least for fetching, since there would always be a
>>> global view of the tree and SVN things like "copy branch A to tag B"
>>> would just be exactly that.
>> This was actually the original use case of git svn back when I started.
>>
>>  git svn clone SVNREPO_ROOT   (without --stdlayout)
>>
>> It's still an option if you have the disk space for the working copies,
>> but I had to create the branches/tags support since the working copies
>> would be become prohibitively large.  If git-subtree could be
>> taught to work on a bare repo (git svn has a --no-checkout option)
>> it might be an option, too.

Thank you for your suggestions. Unfortunately, I'm not really familiar 
with git-subtree and how it could work with git-svn, sorry.

I've tried another workaround: using svnsync to pull the repository only 
once, and only then using git-svn fetch, locally, so as to avoid too 
much network traffic (I don't mind too much if it loops locally). I was 
hoping to be able to change the URL of the repository to the original 
one afterwards, but it doesn't seem to work so easily, because of the 
commit IDs. I'm assuming not having the same will cause problems for 
further fetches (this time directly from the original SVN repository) 
and for potential dcommits.

When I do this:
   git init
   git svn init -s --prefix=svn/ file:///path/to/local/restlet-svnroot
   git svn fetch -r 1:2

I get this ID, for example:
   r2 = c69a0b98d288a6e4e8779b50962b7fc65c4622e8

If I do this using the original http://restlet.tigris.org/svn/restlet, I 
get this:
   r2 = ce3b82915e92fe1ccf6ddedacd9d74b30bd4de86


I've even tried to install a Apache-based subversion server locally and 
make it believe it was restlet.tigris.org (by editing /etc/hosts and 
creating the appropriate VirtualHost), but this generates another SHA1 
ID. (That's of course not a solution that would be generalisable.)

I've had a quick look at the git-svn code to see how this ID was 
generated, but couldn't find anything obvious.
I realise this isn't the cleanest approach possible, but any suggestion 
would be appreciated.


Best wishes,

Bruno.
