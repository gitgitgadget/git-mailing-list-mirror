From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 05:15:29 -0500
Message-ID: <20070115101529.GB12257@spearce.org>
References: <200701151000.58609.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:33:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVr-0000Sb-VD
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:51 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9Y-0003eK-Ns
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbXAOKPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbXAOKPf
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:15:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46191 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932184AbXAOKPe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:15:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6OsD-00039K-Tj; Mon, 15 Jan 2007 05:15:30 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4755520FBAE; Mon, 15 Jan 2007 05:15:30 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <200701151000.58609.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36836>

Andy Parkins <andyparkins@gmail.com> wrote:
> I was just talking to another developer in my office about version control.  
> He's working with Windows so has chosen Monotone for a version control 
> system.  I didn't have any huge objections, as I'm sure monotone can be 
> migrated to git without much trouble (they look to support the same features 
> from my brief reading).
> 
> Of course my favourite is git, but we were talking about the certificates 
> needed by monotone for each developer.  I assume that monotone therefore 
> signs every commit.  It obviously crossed my mind as to how one would do that 
> with git?  We obviously already have the ability to sign a tag, but is there 
> a way in which one could sign every commit.
> 
> The more I think about it, the more it could be a reasonable question.  In my 
> own repository I can obviously create whatever commits i like, claiming them 
> to be from whomever I like just by altering a few config settings.  If I put 
> a few of those in my own repository and then managed to persuade Junio to 
> pull from me - wouldn't I have faked commits from another developer?  
> However, I wouldn't be able to fake a gpg signature.

You could sign the content of the raw commit and include the signature
in the payload, much like we do with tags.  E.g.:

	tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
	parent 5064201cfd47822e567456fb1d6a76a5e81da800
	parent e6987d056595deace8cba91ce0a2524bb91770a9
	author Shawn O. Pearce <spearce.org> 1168855184 -0400
	committer Shawn O. Pearce <spearce.org> 1168855184 -0400

	Merge branch 'branch' into 'master'.

	-----BEGIN PGP SIGNATURE-----
	Version: GnuPG v1.4.6 (GNU/Linux)

	iD8DBQBFiY2zwMbZpPMRm5oRAll0AJ0ZR+Bu8zjMVe8eEKR8Xr+3QMtndACcC2Kl
	aWSkKLptN0LAOpDinq+aqOc=
	=dZlu
	-----END PGP SIGNATURE-----

But that's horribly ugly and probably vast overkill.  Plus the only
way to really verify each commit is to have the complete database of
PGP public keys handy.  A commit-msg hook could probably implement
the signing.


What I'm actually doing in one particular environment is checking
the committer string against a database of known committer strings
associated with the current UNIX uid.  My update hook[*1*] performs
a `git log --pretty=raw $3 --not --all` query to determine any
commits which are coming in as part of this push and which are not
already referenced by an existing head or tag in this repository.
For each of those the committer line *must* match one stored in
the allowed-committers file for the current user, as these are
brand new commits being introduced to the repository.

This works well as everyone has a UNIX account on the same system
and logs in via SSH.  The easiest way for us to share changes is to
just push them to a single central repository.  That repository is
performing the checking.  And since every commit signs the entire
chain of commits which came before it, we're in effect implicitly
signing our commits by pushing them to that server.  And other
developers are agreeing by building on top of that work.


[*1*] If anyone wants the hook, let me know.  I'd be happy to
      share it.  But since its undocumented I haven't offered it
      up as a contrib in git.git yet.

-- 
Shawn.
