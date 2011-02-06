From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: Updating a submodule with a compatible version from
	another submodule version using the parent meta-repository
Date: Sun, 6 Feb 2011 19:51:41 +0100
Message-ID: <20110206185140.GA61833@book.hvoigt.net>
References: <4D407099.4010805@web.de> <AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com> <4D407875.7080607@web.de> <AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com> <7v7hdrl7nw.fsf@alter.siamese.dyndns.org> <AANLkTik8VrhbBSLwRq9gd39hofnmifk15zSqXVTsSzAp@mail.gmail.com> <7v1v3zjp6w.fsf@alter.siamese.dyndns.org> <20110129110807.GA21864@book.hvoigt.net> <AANLkTimBCeSnR270eWMcrgCVj6rmiRkJizOxQPAPOAnn@mail.gmail.com> <AANLkTim2G0kF+omPZ1_fk0P6oGDaKDWd79XNR5GXUkWG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Julian Ibarz <julian.ibarz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 19:51:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9i8-0007uX-Rq
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab1BFSvn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Feb 2011 13:51:43 -0500
Received: from darksea.de ([83.133.111.250]:56662 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753303Ab1BFSvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:51:43 -0500
Received: (qmail 8260 invoked from network); 6 Feb 2011 19:51:41 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Feb 2011 19:51:41 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTim2G0kF+omPZ1_fk0P6oGDaKDWd79XNR5GXUkWG@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166193>

Hi Julian,

interesting work so far.

One thing regarding the mailing list: Please do not top post and try to=
 cut non
relevant text (the one you are not replying to) from your replies.

On Wed, Feb 02, 2011 at 11:31:40PM -0500, Julian Ibarz wrote:
> After a couple of hours, I have finally succeeded to go through the
> entire history of a repository and I can detect the submodules in a
> tree of a commit. For those interested here is the source code:
>=20
> http://gitorious.org/julian_ibarz_git/julian_ibarz_git/blobs/submodul=
e_checkout/builtin/submodulecheckout.c
>=20
> Next time I will build the list of commits of a submodule in the
> entire history.

Sounds great. That will be one tool you need. Here is a small script
snippet which already does that as an example for the msysgit repositor=
y
(git://repo.or.cz/msysgit.git):

export sub=3Dgit
git log --pretty=3D"%h" -- $sub | \
    while read i; do git ls-tree $i -- $sub; done | \
        cut -f3 -d" " | cut -f1

It outputs all the hashes that have been registered for the git
submodule. Maybe thats a good starting point to find example code in C.
You can use it for other submodules also just change the name in the va=
riable
sub.

> Then I will need to find the distance of each commit
> in the list compared to the current  commit of a submodule and keep
> the closest one (which has to be a parent so an algebric distance
> would be good to have).

Have a look at the codepath that is used for

  git branch --contains <sha1>

It essentially does the thing you want (find all refs that contain a
commit). An approach could be to extend this mechanism not to iterate
through all refs but e.g. take a list of sha1's for iteration.

> So now my two questions that could save me some time are:
> - is there a function that gives the distance between two commits? I'=
m
> sure there is something like this coded somewhere but I didn't find i=
t
> yet
> - is the struct decorate a hash map and if yes could someone explain
> me how to use it or point me to a location where it is used?

Please see the tips above.

> Except from that I think I have all the information I need.

There are a few points I would like to mention:

 * Citing my drawing:
> >> =A0 superproject A:
> >>
> >> =A0 =A0 =A0O---O---X''---O
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> >> =A0 submodule B: \
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> >> =A0 =A0 =A0O---X---O---X'---O---O

   There can be multiple X' which contain X. These are all valid
   candidates. The same applies to X'' where there can be multiple
   candidates that record a specific X'. IMO, all of them need to be
   considered. If in the end they all reduce to one commit in submodule=
 C
   you can check that out. If not printing a list of all candidates is
   probably the best option.

 * If we want your code to go upstream it probably needs to be
   integrated as a subcommand into the current submodule script. I can
   offer to help you on the bash scripting side. I think once the tools
   to find the appropriate commits are ready that will not be a big
   issue.

 * I think for protoyping the tools you can later use in the submodule
   script its fine to implement your own command. Keep in mind that you
   later on you should probably integrate your code into the appropriat=
e
   existing commands. Here some suggestions.

   To support proper bash scripting two parts come into my mind:

   1. A tool to output all of the submodules commits which are
      candidates for X'' like the script snippet above.

   2. A tool that takes the list from 1. and then reduces that list to
      a list of commits that actually register the possible commits X'.
      If that is one commit X'' we can directly checkout. If not we
      print the list in a nice format and let the user choose.

Looking forward to your work.

Cheers Heiko
