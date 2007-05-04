From: Johan Herland <johan@herland.net>
Subject: [RFC?] Telling git about more complex relationships between commits
 (Was: Re: FFmpeg considering GIT)
Date: Fri, 04 May 2007 09:21:29 +0200
Message-ID: <200705040921.33443.johan@herland.net>
References: <loom.20070502T111026-882@post.gmane.org>
 <20070503010312.GF4489@pasky.or.cz> <200705040242.46156.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=nextPart4733995.TCIpCa8L3Y;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 09:21:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjs6o-0007eI-4M
	for gcvg-git@gmane.org; Fri, 04 May 2007 09:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbXEDHVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 03:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754315AbXEDHVi
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 03:21:38 -0400
Received: from smtp.getmail.no ([84.208.20.33]:48461 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507AbXEDHVh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 03:21:37 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JHI00L019S0QL00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 04 May 2007 09:21:36 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHI007739RXIR70@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 04 May 2007 09:21:34 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHI009559RXK7F4@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 04 May 2007 09:21:33 +0200 (CEST)
In-reply-to: <200705040242.46156.jnareb@gmail.com>
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46137>

--nextPart4733995.TCIpCa8L3Y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 04 May 2007, Jakub Narebski wrote:
> Besides I think it would be better to teach blame to ignore reversion
> commits (for example based on first line of commit message) than to
> mess with the history.

I'm starting to see a pattern where people would like to tell git about=20
more complicated relationships between commits, so that git can make=20
more intelligent decisions when doing merge, blame, pickaxe, etc.

Adding these relationships as part of the commit message seems like a=20
really stupid idea because git suddenly has to make sense of something=20
it has never parsed before, thus making all future and former git=20
commit messages a potential target for pattern (mis)matching by git.=20
Also, we seem to forget that we already have the perfect place to put=20
such information: The header fields preceding the commit message.

I therefore propose adding header field names to commit objects that=20
illustrate the relationships people want to tell git about. Examples=20
include:

1. "Reverts": Mark a commit as reverting another commit. This could be=20
used by git-log to cancel out pairs of commits, resulting in a cleaner=20
view of history. It can help blame/annotate. There are probably other=20
tools that can benefit from this information also.

2. "Cherry-Pick": When cherry-picking a commit onto another branch, you=20
should be able to tell git which commit you are cherry-picking=20
(git-cherry-pick would of course do this automatically). This could=20
enable git to make smarter decisions when merging the two branches: If=20
the cherry-picked commit would cause a conflict with the original=20
commit, git can either skip it (since it knows that one version of this=20
patch is already present), or it can at least present the conflict to=20
the user with some more context than what is available today. Not to=20
mention how this information could be used by blame/annotate.

3. "Rebased-From": This one can be filled in automatically by=20
git-rebase, but when I think about it, it may be too similar=20
to "Cherry-Pick" to warrant a separate field.

4. "Rebased-To": When doing a rebase like the following:

   A---B---C---D---E       <--- branch

       (Hmm. C is broken. Rebase D and E onto B)

   A---B---C---D---E
        \
         \--D'--E'         <--- branch

   git-rebase could now add a dummy commit F* to E with "Rebased-To:=20
{Commit ID of D'}", thus making:

   A---B---C---D---E---F*..
        \    ,............:  (yes, this is a poorly drawn meta-arrow)
         \   v
          \--D'--E'        <--- branch

   This would make it easier for git to do the Right Thing when someone=20
following the old branch tries to pull after the rebase.

5. Heck, while we're at it, move "Signed-off-by" into the header fields,=20
where git can make more use of it.

6. Finally, allow people to add custom header fields prefixed by "X-"=20
(like in HTTP), and make it easy for them to extend git tools to use=20
these custom fields in various ways. If some of them end up being=20
really useful, we can import them into git (and lose the "X-" prefix).


Now, in order to let people specify these fields we probably want to=20
make these fields names settable from the command line. It should also=20
be possible to use a template when doing the commit message in an=20
editor. Something like:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Optional headers fields (fill in if applicable)
Cherry-Pick:   ________
Reverts:       ________
Signed-Off-By: ________

Your commit message goes here:
________________________________
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Of course, git would have to verify/sanitize these fields when input, so=20
they probably need some type information associated with them.


=46urthermore we might want to think about the possibility of allowing=20
annotations to previous commits, in order to allow these fields to be=20
set after the commit has happened, but that's a topic for a=20
whole 'nother discussion.


Have fun!

=2E..Johan

=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart4733995.TCIpCa8L3Y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)

iD8DBQBGOt79BHj4kl4fT1wRAjQfAJ9157ZFyMt9xMTBwOJzlWcWP2lJsACfTbtf
r6ekO4pUHS0jzcMt90K/p0U=
=9l1O
-----END PGP SIGNATURE-----

--nextPart4733995.TCIpCa8L3Y--
