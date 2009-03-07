From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGit] Push to new Amazon S3 does not work? ("funny refname")
Date: Sat, 7 Mar 2009 13:10:08 -0800
Message-ID: <20090307211008.GP16213@spearce.org>
References: <ff6a9c820903070805m34f792dard6b17d2029e41dfe@mail.gmail.com> <200903071850.38045.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Cheng <j16sdiz+freenet@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 22:11:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg3o4-0007IK-K6
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 22:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919AbZCGVKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 16:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755911AbZCGVKM
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 16:10:12 -0500
Received: from george.spearce.org ([209.20.77.23]:45127 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbZCGVKK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 16:10:10 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8D79438211; Sat,  7 Mar 2009 21:10:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200903071850.38045.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112586>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> l=F6rdag 07 mars 2009 17:05:02 skrev Daniel Cheng <j16sdiz+freenet@gm=
ail.com>:
> > Pushing to new Amazon S3 repository does not work.
> > It say "funny refname" without pushing anything:
> >=20
> > <<<<<<<<<
> > $ jgit push s3 master
> > To amazon-s3://0NQ4APQ8R7S6HQ65TWR2@egitsdiz/1.git
> >  ! [remote rejected] master -> master (funny refname)
> > $ s3cmd la
> >          DIR   s3://egitsdiz/1.git/
> > $
> > >>>>>>>>>
>=20
> This is not specific to s3. It seems jgit wants a fully qualified ref=
 for the remote
> side, so refs/heads/master will work for the other protocols, and I g=
uess s3 too.

Correct.

The "jgit push" command line client lacks the DWIMery of "git push".

Specifically, from a pure API usage perspective, "jgit push"
is responsible for expanding the user input of "master" into the
"refs/heads/master:refs/heads/master" refspec that the lower level
PushProcess class wants.

Here it failed to do that, and the lower-level transport (rightly)
rejected the invalid ref name.

  Side note:

  That API definition that says the client should do the DWIMery
  of ref expansion also makes it nearly impossible to implement
  "push matching" or "randomsha1:master" refspec, as the client
  doesn't have the network connection open and doesn't have the
  advertised ref information early enough.

The reason we punted on this and didn't do this particular
expansion DWIMery in "jgit push" is we lack a good way to resolve
"master" into "refs/heads/master", or "v1.0" into "refs/tags/v1.0".
Repository does not expose the ref lookup algorithm, only resolve(),
which converts "master" into a SHA-1 ObjectId.

If someone exposed this portion of the resolve logic in the
Repository class, I think it would be a fairly simple change
in Push to support this DIWMery.

But until then, you need to say:

  jgit push s3 refs/heads/master:refs/heads/master

or maybe this DWIMery might work:

  jgit push s3 refs/heads/master

Its been a while since I passed args.  I usually have
remote.$name.push in place for things that I push to.

--=20
Shawn.
