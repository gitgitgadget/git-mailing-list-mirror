From: david@lang.hm
Subject: Re: metastore
Date: Sun, 16 Sep 2007 14:45:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709161245490.24221@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm> <7vwsur590q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 23:46:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX1wL-0007U6-Cc
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 23:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbXIPVqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 17:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbXIPVqB
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 17:46:01 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:33495
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbXIPVqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 17:46:00 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l8GLjPLH025717;
	Sun, 16 Sep 2007 14:45:25 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7vwsur590q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58354>

some of this duplicates thoughts from other messages in this thread. 
apologies for the duplication, but I want to be clear the response to 
Junio's concerns here as well

On Sun, 16 Sep 2007, Junio C Hamano wrote:

> david@lang.hm writes:
>
>> git has pre-commit hooks that could be used to gather the permission
>> information and store it into a file.
>>
>> git now has the ability to define cusom merge strategies for specific
>> file types, which could be used to handle merges for the permission
>> files.
>> ...
>> There are some significant advantages of having the permission store
>> be just a text file.
>>
>> 1. it doesn't require a special API to a new datastore in git
>>
>> 2. when working in an environment that doesn't allow for implementing the
>>    permissions (either a filesystem that can't store the permissions or
>>    when not working as root so that you can't set the ownership) the file
>>    can just be written and then edited with normal tools.
>>
>> 3. normal merge tools do a reasonable job of merging them.
>>
>> however to do this git would need to gain the ability to say 'this
>> filename is special, it must be checked out before any other file is
>> checked out' (either on a per-directory or per-repository level)
>
> I'd rather not implement it at such a low level where a true
> "checkout" happens.  For one thing, I am afraid that the special
> casing will affect the normal codepath too much and would make
> it into a maintenance nightmare.

as I understand it, at this point you already choose between three 
options.

1. write to a file (and set the write bit if needed)
2. write to stdout
3. write to a pager program

I am suggesting adding

4. write to a .gitattributes defined program and pass it some parameters.
    (and only if the .gitattributes tell you to)

this should be a very small change to the codepath

or am I missing something major here?

if this program can get the contents of the permission file out of the 
index, then the requirement I listed before to make sure the permission 
file gets written before anything else goes away, and the only requirement 
left is the ability to specify a different write method

> But more importantly, if you
> are switching between commits (this includes switching branches,
> checking out a different commit to a detached HEAD, or
> pulling/merging updates your HEAD and updates your work tree),
> and the contents of a path does not change between the original
> commit and the switched-to commit, you may still have to
> "checkout" the external information for that path if your
> "permission information file" are different between these two
> commits.  To the underlying checkout aka "two tree merge"
> operation, that kind of change is invisible and it should stay
> so for performance reasons, not to harm the normal operation.

I had not thought of this condition.

however, I think this may be easier then you are thinking

we have two conditions.

1. the permission file hasn't changed.

Solution:  do nothing

2. the permission file has changed

Solution: set all the permissions to match the new file

this could be done by useing .gitattributes to specify a different program 
for checking out the permission file, and that program goes through the 
file and sets the permssions on everything. yes this is a bit inefficiant 
compared to diffing the two permission files and only touching the files 
that have changed, but is the efficiancy at this point that critical? if 
so then instead of feeding the program the contents of the new file you 
could feed it the diff between the old and the new file.

in theory you could do this for any file, and it would be a win for some 
files (a large file that has a few changes to it would possibly be more 
efficiant to modify in place then to re-write), but I'm not sure the 
results would be worth the complications. if .gitattributes gains the 
ability to specify the program to be used to write the file, it could also 
gain the ability to specify feeding that file the diff instead of the full 
contents.

the one drawback to just setting all the permissions is that this will 
overrule any local changes to files that weren't otherwise modified. how 
big of a problem is this?

> IOW, I do not want the core level to even know about the
> existence of "permission information file", even the code that
> implements it is well isolated, ifdefed out or made conditional
> based on some config variable.

nobody is suggesting anything that wouldn't be at least conditional based 
on some config variable.

> I however think your idea to have extra "permission information
> file" is very interesting.  What would be more palatable, than
> mucking with the core level git, would be to have an external
> command that takes two tree object names that tells it what the
> old and new trees our work tree is switching between, and have
> that command to:
>
> - inspect the diff-tree output to find out what were checked
>   out and might need their permission information tweaked;
>
> - inspect the differences between the "permission information
>   file" in these trees to find out what were _not_ checked out,
>   but still need their permission information tweaked.
>
> - tweak whatever external information you are interested in
>   expressing in your "permission information file" in the work
>   tree for the paths it discovered in the above two steps.
>   This step may involve actions specific to projects and call
>   hook scripts with <path, info from "permission information
>   file" for that path> tuples to carry out the actual tweaking.

this is an area I wasn't aware of, but it doesn't seem that difficult to 
do. the issue (as I address above) is if this needs to be done as a diff 
or if it can be done simply by setting all the permissions according to 
the new file.

> If we go that route, I am not deeply opposed to add code to
> Porcelains to call that new command after they "checkout" a new
> commit at the very end of their processing (namely, git-commit,
> git-merge, git-am, and git-rebase).

this is saying you want a wrapper around git instead of a hook in git.

> Yes, I am very well aware that somebody already mentioned "there
> is a window between the true checkout and permission tweaking".
> If you need to touch the core level in order to close that
> window, I am not interested.

no matter how small the change? (see the above comments) If so this 
converstion isn't worth continuing, if you are just concerned about 
maintainability and are willing to consider small changes that won't cause 
big maintinance problems then we can continue to discuss if the changes I 
am suggesting are small enough. the need to be able to close the 
vunerability window is a showstopper to many uses.

>> The ability to handle /etc comes up every few months. it's got to be
>> the most common unimplemented request git has seen.
>
> Asking a pony for many times does not necessary make it the
> right for you to have the pony.  The sane way to implement this
> is in your Makefile, as Randal and other people with more
> experience have already pointed out, and I happen to agree with
> them.

you don't always have a makefile. if other tools that you use make 
modifications to the files in the locations where they reside, having to 
pull those changes back before you can do a checking is a complication as 
well

> My gut feeling is that the approach to use an external hook that
> reads your "permission information file" could be done with
> negligible impact to the normal operation of git.  I suspect
> that the "new command" I suggested above that would run after
> "checkout" actions would perform what people need to do in their
> Makefiles' "install" rules (if they have the work tree vs target
> tree distinction), or "post-checkout" rules (if they want to use
> the work tree in-place), and not having to write/reinvent a
> Makefile target for this in every project would hopefully make
> it easier to use.  That is the only reason I am writing this
> message on this topic.

but you are not willing to allow the hook to be created, you are saying 
that there would need to be an external wrapper instead.

at this point it appears that having a hook to be able to specify external 
programs at a point where you are already deciding between different 
options would be sufficiant.

>> so would changes like this be acceptable?
>
> That is a different question.  Is having an extention to help
> people who want to manage perm bits a worthy goal?  Perhaps, but
> it depends.  Is it worthy enough goal to complicate the really
> core parts of the code and add huge maintenance burden?
> Absolutely not.  Can it be made in such a way that it does not
> have much impact to the core parts?  We need to see how it is
> done.

this is why I was asking about this approach. do changes like this seem 
small enough to be worth the effort of coding and submitting?

David Lang
