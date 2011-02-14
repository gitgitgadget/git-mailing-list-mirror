From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: Re: Re: Updating a submodule with a compatible version
	from another submodule version using the parent meta-repository
Date: Mon, 14 Feb 2011 22:13:18 +0100
Message-ID: <20110214211317.GA50815@book.hvoigt.net>
References: <7v7hdrl7nw.fsf@alter.siamese.dyndns.org> <AANLkTik8VrhbBSLwRq9gd39hofnmifk15zSqXVTsSzAp@mail.gmail.com> <7v1v3zjp6w.fsf@alter.siamese.dyndns.org> <20110129110807.GA21864@book.hvoigt.net> <AANLkTimBCeSnR270eWMcrgCVj6rmiRkJizOxQPAPOAnn@mail.gmail.com> <AANLkTim2G0kF+omPZ1_fk0P6oGDaKDWd79XNR5GXUkWG@mail.gmail.com> <20110209193610.GA67890@book.hvoigt.net> <AANLkTimist_GXgRGdUW1PpxpRO=poYgD4HkDC5CsyLra@mail.gmail.com> <20110213133019.GB31986@book.hvoigt.net> <AANLkTikHS95BVV4FUjR6TjZxHOGXsje2iDxEwbt9zckh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Julian Ibarz <julian.ibarz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 22:13:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp5jZ-0001fC-T5
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 22:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab1BNVNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 16:13:21 -0500
Received: from darksea.de ([83.133.111.250]:45906 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752692Ab1BNVNU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 16:13:20 -0500
Received: (qmail 18160 invoked from network); 14 Feb 2011 22:13:18 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Feb 2011 22:13:18 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTikHS95BVV4FUjR6TjZxHOGXsje2iDxEwbt9zckh@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166768>

Hi,

On Sun, Feb 13, 2011 at 01:59:09PM -0500, Julian Ibarz wrote:
> On Sun, Feb 13, 2011 at 8:30 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > Ok lets not be so hard:
> >
> > git checkout v1.7.2.3.msysgit.0
> > cd ..
> > git submodulecheckout --find-versions git > git-versions.txt
> > cd git
> > git submodulecheckout --find-closest < ../git-versions.txt
> >> 820fd48475eb72cdd4f2
> >
> > Close but not quite the right commit. See the output of git log:
> > 820fd48 Chomp CRLF before feeding to tar when building netinstaller.
> > 83e164c Avoid quoting environment variable values.
> > daafc61 (tag: Git-1.7.2.3-preview20100911) Updated git and git documents and ReleaseNotes to v1.7.2.3
> >
> > Whats strange is that this commit did not even change the submodule.
> 
> Well because it is _exactly_ the commit that point to the current
> submodule version you have checked out :) So it _is_ the good version.
> Which version were you thinking was good?

Well I think the interface was/is still confusing me. Once you change to
one where I can specify the hash I want to search for I will give it
another try.

> > I think currently it does not make sense to implement the scripting
> > since the interface is not yet cleaned up enough. It should be possible
> > to specify a commit as parameter and the path should probably go after
> > that like the other commands do as well.
> >
> > The other issue is that we need to change the working directory. IMO,
> > everything should be possible to do from superproject. Have a look at
> > add_submodule_odb() in submodule.c it lets you load the database of a
> > submodule. This way you can run the --find-closest from the superproject.
> 
> I don't think we want to do that. The usual scenario is:
> 
> * you are in a submodule
> * you checkout a specific version
> * you want the meta-repo and side submodules to be updated accordingly
> 
> And in this scenario at the beginning you are at the submodule
> directory, not the meta repository so... What do you think? Also even
> if in these low-level commands you need to change directory, if it is
> hided in an integration in the sh submodule script, it doesn't matter
> right?

Well I think the interface should be useable by hand also. Lots of tools
in git were invented by plugging the tools together differently than the
original developer even had in his mind. So a nice "do only one thing
but that very good" kind of interface makes sense.

I think a nice thing would be if you could stay in one directory and it
should not be too hard since we have add_submodule_odb(). Implementation
would be easier if we started this command from the supermodule since
searching for a supermodule from a submodule is still missing.

> > So what I would be looking for is something like this:
> >
> > # This looks up all commits of <submodule> ever registered in this
> > # project
> > git submodulecheckout --find-versions <submodule> > out.tmp
> >
> > # This reads the previous list and outputs a list of of all the commits
> > # that contain <treeish>. Function in_merge_bases(treeish, i&commit, 1)
> > # can be of help here. Afterwards you have to prune all later commits
> > # that contain earlier ones. I did this in find_first_merges(). I
> > # suggest to refactor that code into a function so that you can use it.
> > git submodulecheckout --find-closest <treeish> -- <submodule> < out.tmp > out2.tmp
> >
> > # And now we can search for the commit in the other submodule C
> > git submodulecheckout --list-commits <other submodule> < out2.tmp > out3.tmp
> >
> > And if out3.tmp just contained one line we could checkout that one. I am
> > still not sure in which command these options could go. Junio do you
> > maybe have a suggestion? Since its all about submodules it would make
> > sense to put it in 'git submodule' but thats already the script.
> >
> > Maybe a new 'git-submodule-tool' ?
> 
> Before I wanted to name it submodule-checkout but I think I hade a
> naming conflict issue with submodule... not sure if submodule-tool
> will work...

Since the submodule script might be obsoleted partly and get rewritten
in C at some point I was thinking of this as a kind of intermediate
internal submodule helper tool.

Cheers Heiko
