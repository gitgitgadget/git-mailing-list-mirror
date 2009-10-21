From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: ident hash usage question
Date: Wed, 21 Oct 2009 01:35:16 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910210059090.14365@iabervon.org>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>  <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>  <81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>  <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
  <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>  <76c5b8580910201330r45cf625k3a41b5b9e24b3e01@mail.gmail.com>  <7veioxn6ee.fsf@alter.siamese.dyndns.org>  <76c5b8580910201514sc44f1cag222cf8a3710c875@mail.gmail.com>  <7vbpk1lmvl.fsf@alter.siamese.dyndns.org>
 <76c5b8580910201649i76d14f8bod9a84afa6ea6bbb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-590039195-1256103316=:14365"
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 07:35:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Tr3-00080i-QV
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 07:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbZJUFfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 01:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbZJUFfN
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 01:35:13 -0400
Received: from iabervon.org ([66.92.72.58]:55939 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbZJUFfM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 01:35:12 -0400
Received: (qmail 12098 invoked by uid 1000); 21 Oct 2009 05:35:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Oct 2009 05:35:16 -0000
In-Reply-To: <76c5b8580910201649i76d14f8bod9a84afa6ea6bbb0@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130884>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-590039195-1256103316=:14365
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 20 Oct 2009, Eugene Sajine wrote:

> > I am not sure what you mean by "static linking" anymore.  Usually the word
> > means that everything you tell the linker to link to the executable is
> > linked, together with objects from libraries.  The resulting executable is
> > usable on its own and it does not change behaviour regardless of which
> > version of dynamic libraries you depend on happen to be installed on the
> > target system (because by definition a statically linked executable does
> > not depend on dynamic libraries---that is the whole point of static
> > linking).
> >
> 
> There seems to be no misunderstanding in the static linking - i meant
> the same thing. But let me put an example:
> 
> I have a program.exe
> 
> This program.exe is built basing on two statically linked libraries
> lib1.lib and lib2.lib
> 
> I'm not developing any of those libraries, but only my own code of the
> program.exe
> 
> Now, somebody changed 2 files in lib1.lib and 5 files in lib2.lib. But
> i don't know that they are changed because it is different CVS module
> or because I'm building against latest released libs or for whatever
> reason...
> 
> When i rebuild my program the build supposed to pick up changes from
> the libraries I'm using and relink, that will include 7 changed obj
> files.
> 
> How can i say which exactly files are changed in my new version of
> executable comparing to the previous version?

As Nanako points out, you want a version string from each library, 
probably with the name of the library in the symbol. So:

static char *lib1_version = "" VERSION_STRING

in lib1/version.cc.

> Currently they can take a look at the revision number of every
> particular file included into the executable, which is put there by
> CVS and compare it with the production. If the version is different,
> then you know which files are changed and you can get diffs on them...
> They also have file path and date and other stuff expanded...

Once you've got the version strings from each of the components, and 
you've got the repository for each library, you can compare the version in 
the string with other versions, and that one hash expands to the hashes 
for all of the files, including things like the Makefile that don't 
actually become object files but affect them.

You can also do things like: when you build an executable, write it as a 
blob to the repository and make a tag (actually, a note will be 
better, but that's newer than I've done this) pointing to it that lists 
everything used to build it. If you encounter the executable again later, 
it'll have the same hash, and git can find the tag with the other 
information.

I've actually done something where I tagged the main tree and a few 
libraries with matching tags, built the executable with a 20-byte 
sequence of zeros, put it into the repository, then wrote its sha1 to 
those 20 bytes, and tagged the executable with a tag based on the source 
tag. Then I put it on a microcontroller, sealed it in epoxy, mixed it with 
other devices with different firmware revisions, and sent it out. When a 
device had a problem, I could ask it for those 20 bytes, ask git for the 
tag that pointed to those 20 bytes, and check out exactly the source used 
to build it.

> Please note, my personal goal is *to prove that git can do that
> better*, with less intrusion into the code sources, not other way
> around.So, while keeping the info they want to have they might get
> some benefits of git. Although, i understand that there might be no
> cure for this state already, you can tell me that and I will close the
> topic, but I just keep hoping;)

You're not going to be able to avoid having different tracking things in 
the source, but git does give you the major advantage that you can have 
the build system produce one hash that identifies every single file in the 
project, rather than having to have each file identify itself (and 
probably overlook files that don't directly produce object code). It's a 
big help the day you're trying to figure out if an executable came from 
before or after someone's commit to change the compiler options, and it's 
fewer strings than you need with CVS.

	-Daniel
*This .sig left intentionally blank*
--1547844168-590039195-1256103316=:14365--
