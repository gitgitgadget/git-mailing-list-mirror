From: david@lang.hm
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sat, 15 Sep 2007 18:30:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 16 03:31:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWiyo-0001Yw-7G
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 03:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbXIPBbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 21:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbXIPBbP
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 21:31:15 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:35810
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbXIPBbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 21:31:14 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l8G1Urur021443;
	Sat, 15 Sep 2007 18:30:53 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <Pine.LNX.4.64.0709152310380.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58288>

On Sat, 15 Sep 2007, Johannes Schindelin wrote:

> On Sat, 15 Sep 2007, Daniel Barkalow wrote:
>
>> Git doesn't have any way to represent owners or groups, and they would
>> need to be represented carefully in order to make sense across multiple
>> computers.
>
> [speaking mostly to the proponents of git-as-a-backup-tool]
>
> While at it, you should invent a fallback what to do when the owner is not
> present on the system you check out on.  And a fallback when checking out
> on a filesystem that does not support owners.
>
> And a fallback when a non-root user uses it.
>
> Oh, and while you're at it (you said that it would be nice not to restrict
> git in any way: "it is a content tracker") support the Windows style
> "Group-or-User-or-something:[FRW]" ACLs.

git has pre-commit hooks that could be used to gather the permission 
information and store it into a file.

git now has the ability to define cusom merge strategies for specific file 
types, which could be used to handle merges for the permission files.

what git lacks the ability to do is to deal with special cases on 
checkout.

the handling of gitattributes came really close, but there are two 
problems remaining.

1. whatever is trying to write the files with the correct permissions
    needs to be able to query the permission store before files are
    written. This needs to either be an API call into git to retreive the
    information for any file when it's written, or the ability to define a
    specific file to be checked out first so that it can be used for
    everything else.

2. the ability to specify a custom routine/program to write the file out
    (assuming that it's being written to a filesystem not a pipe). this
    routine would be responsible for querying the permission store and
    doing 'the right thing' when the file is written during a checkout

there are some significant advantages of having the permission store be 
just a text file.

1. it doesn't require a special API to a new datastore in git

2. when working in an environment that doesn't allow for implementing the
    permissions (either a filesystem that can't store the permissions or
    when not working as root so that you can't set the ownership) the file
    can just be written and then edited with normal tools.

3. normal merge tools do a reasonable job of merging them.

however to do this git would need to gain the ability to say 'this 
filename is special, it must be checked out before any other file is 
checked out' (either on a per-directory or per-repository level)

if this is acceptable then altering the routines that write the files to 
have the additional option of calling a different routine based on the 
settings in .gitattributes seems relativly simple. there should already be 
logic to decect if it's writing to a pipe or a filesystem (it needs to 
know if it should set the write bit if nothing else), and there's the 
existing passthrough or custom routine logic for the crlf translation from 
.gitattributes. combining the logic of the two should handle the output 
issues.

the ability to handle /etc comes up every few months. it's got to be the 
most common unimplemented request git has seen. Adding the nessasary hooks 
for it to be done could end up being less effort then repeatedly telling 
people that they shouldn't use git for that task (or should wrap git in 
their own scripts and use the result instead of useing git directly)


so would changes like this be acceptable?

David Lang
