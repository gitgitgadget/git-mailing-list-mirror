From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 10:12:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610220926170.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> 
 <vpqwt6wsmb5.fsf@ecrins.imag.fr>  <72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com>
  <45379A02.1010105@utoronto.ca>  <72877ab10610192014o3a7f66c6v79f94f48615e08f4@mail.gmail.com>
  <45384B0F.4040901@utoronto.ca>  <20061021123027.GB29843@artax.karlin.mff.cuni.cz>
  <ehd5u7$c5g$1@sea.gmane.org> <453A513B.1070006@utoronto.ca> 
 <Pine.LNX.4.64.0610211007320.3962@g5.osdl.org>
 <72877ab10610220049i602ab936m11181f1a2daf2aee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 19:12:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbgs0-0006a7-54
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 19:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWJVRMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 13:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWJVRMQ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 13:12:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751307AbWJVRMP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 13:12:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9MHC3aX014398
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 Oct 2006 10:12:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9MHC2Y2027954;
	Sun, 22 Oct 2006 10:12:02 -0700
To: Tim Webster <tdwebste@gmail.com>
In-Reply-To: <72877ab10610220049i602ab936m11181f1a2daf2aee@mail.gmail.com>
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29765>



On Sun, 22 Oct 2006, Tim Webster wrote:

> On 10/22/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > > project/file-1
> > > project/file-2
> > > project/.git-1
> > > project/.git-2
> > 
> > Ok, that's just insane.
> [snip]
> > Anyway. Git certainly allows you to do some really insane things. The
> > above is just the beginning - it's not even talking about alternate object
> > directories where you can share databases _partially_ between two
> > otherwise totally independent repositories etc.
> 
> 
> Perhaps this is insane, but it does not make sense to track all config
> files in etc as though they belong in a single repo.

Oh, ok, now I see what you're going after.

Right - if you track system directories in a repo, you'd quite possibly 
end up with multiple repositories. Although even then, I'd actually 
suggest that as a git user, you would only have one actual repository, and 
just multiple branches that have a disjoint set of files (again, it's 
certainly possible to have file overlap too, of course).

But the usage I would seriously suggest is to _not_ do development "inside 
/etc" itself. You'd have those git repositories somewhere else, say in 
"/usr/src/etc-repo" or similar, and then you'd have a few extra wrappers 
to help your particular usage. I have a few reasons for this:

 - I think being in /etc and doing development is just fundamentally scary 
   in itself, because if you do something wrong in the current directory, 
   you're just pretty badly off. It's better to have a "buffer zone" that 
   you do development in, and when you're happy, you do a "install" 
   command or something.

 - I think developing as "root" is totally broken, and some of the files 
   you are tracking may not even be _readable_ to normal users in their 
   real form, so you can't even do trivial things like "diff" as a normal 
   user otherwise. So again, the solution to this would be to do 
   development somewhere else, and have specific wrappers (with "sudo" as 
   appropriate, and your developer ID obviously specially in the sudo 
   files) to do those special "realdiff" and "install" commands.

 - finally: when you work with almost any SCM designed for source control, 
   you're almost inevitably going to have to have some "special" way to 
   track the things that source control usually does _not_ track because 
   it makes no sense for source code. So you'd have to have some special 
   file that tracks ownership/group/full permissions information, and 
   perhaps special devices (if you're tracking things like /dev).

   Again, the way to solve this would tend to be to have a few helper 
   scripts that use regular file-contents that _describe_ these things to 
   do "realdiff" and "install".

In other words, for at least three _totally_ different reasons, you really 
don't want to do tracking/development directly in /etc, but you want to 
have a buffer zone to do it. And once you have that, you might as well do 
_that_ as the repository, and just add a few specialty commands (let's 
call them "plugins" to make everybody happy) to do the special things.

And once you have that kind of setup, you're really better off with 
more of a "several branches for different kinds of files" or even totally 
different repositories. That's a detail, and I don't think anybody really 
cares.

Anyway, to make this slightly more grounded in examples, let me give a 
quick overview of what I'd do if I did this with git. Not a "real" setup 
at all, but kind of a "maybe something like this" - so don't get _too_ 
hung up about the details, ok? It's just a rough draft kind of thing.

First off, let's just say that I want to track /etc/group, /etc/passwd and 
/etc/shadow as one "thing". Whether that thing is a repository of its own 
or a branch in a bigger repository doesn't matter (right now I'm only 
doing those three), and quite frankly, I'm not going to even go into 
whether it _really_ makes sense to track "groups" and the passwd files 
together, but it's just an example, ok?

What I'd do is roughly:

	# set up the new repo (or branch, or..)
	mkdir identity-repo
	cd identity-repo
	git init-db

	# copy the data, set up a PERMISSIONS file to track extra info
	sudo cp /etc/group /etc/passwd /etc/shadow .
	sudo chown user:user *
	cat <<EOF > PERMISSIONS
	group root:root 0644
	passwd root:root 0644
	shadow root:root 0400
	EOF
	git add .
	git commit -m "Initial setup"

and now I have the initial setup, together with permissions and user/group 
information on the things, all ready to track. I can do development in 
this as if it was a normal source-code repository.

So now I can do "work work work commit commit commit" as if these files 
were nothign special. What else do I need? I need the "plugins" to 
actually expose (install) my work, and perhaps to check that /etc matches 
what I expect (and nobody else did anything behind my back that I'd need 
to merge).

Let's call them "install" and "realdiff" as I did above, ok?

And again, I'm not going to even claim that the above two "plugins" are 
the right ones (maybe you want other operations too to interact with the 
"real" installed files), and I'm not going to really get all the details 
right, but here's kind of how you _might_ do it.

To create the script (let's make it shell, because that's what I'm used 
to, but it could be anything) "git-install" in your git binary directory, 
and make it do something like this:

	#!/bin/sh
	while read name chown chmod
	do
		cp $name $name.tmp &&
		sudo chown $chown $name.tmp &&
		sudo chmod $chmod $name.tmp &&
		sudo mv $name.tmp /etc/$name
	done < PERMISSIONS

and make it executable.

Now, you can work in your git directory, and when you're happy, you can do

	git install

to actually copy it into the _real_ directory in /etc.

See? You can do something similar for "realdiff", that would compare the 
contents in /etc with what you have now in your development tree (where 
you want to script the thing to compare the PERMISSIONS file too).

And note: if you do the "plugin scripts" properly, they can work for _all_ 
your repositories that track different files in /etc. So you can work in 
many different repos, and track different files in each, and "git install" 
will do the right thing for each, regardless of the actual files you're 
tracking.

Doesn't this sound like a workable situation? You get all the normal SCM 
tools (looking at history etc), and there's only a few special things you 
need to do when you actually want to install a specific version.

Btw: none of this is really "git-specific". The above tells you how to do 
local "git plugins", and it's obviously fairly trivial, but I suspect any 
SCM can be used in this manner.

		Linus
