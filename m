From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Wed, 20 Oct 2010 14:42:40 +0100
Message-ID: <1287582160.2673.25.camel@wpalmer.simply-domain>
References: <20101018051702.GD22376@kytes>
	 <8043579.526738.1287452576766.JavaMail.root@mail.hq.genarts.com>
	 <20101019064210.GA14309@kytes>
	 <1287563970.2673.12.camel@wpalmer.simply-domain>
	 <m3bp6pkrf0.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 15:42:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8YwQ-00086R-7D
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 15:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab0JTNmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 09:42:49 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58135 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab0JTNms (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 09:42:48 -0400
Received: by wyb28 with SMTP id 28so3787388wyb.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 06:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=w3qWDJvP17JsP5Pr98tWzc9Y0OR/EFUccmG8XSblWxE=;
        b=i8SvXRQ+tVmqM8KSAhSfZtYie5OGo1BoWa72xMSaDSzb/xszSLWlDTz2MBkWYj4/Pt
         S057XE0bVU4bceRBI0mTWi361pLXKK9m7qN4EYNARAKgmrpDOncNJFU4C2zdksjk/Oko
         aO2DYl5SA+LMMI133sv7cglc9+0izGV+brfDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=X7MaLTQzxw+qlQNq6IX3A1/SKyagfnbmiYx0AhsnUk5YkxZBKNQrcJCRGWHyIt/Oka
         bPG6cYbFluYSntfPNWCvBASHKOxt86d/w/r1DmbC39O6ssWjYla1XKPh0YPxMhcZoJ2N
         A99lgD09J+K2TJSW/O1urdkL2zmpxGDkZwQPg=
Received: by 10.216.90.132 with SMTP id e4mr7689042wef.73.1287582166329;
        Wed, 20 Oct 2010 06:42:46 -0700 (PDT)
Received: from [192.168.2.64] (09020403.dsl.redstone-isp.net [193.164.118.24])
        by mx.google.com with ESMTPS id x6sm171295weq.13.2010.10.20.06.42.42
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 06:42:45 -0700 (PDT)
In-Reply-To: <m3bp6pkrf0.fsf@localhost.localdomain>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159409>

On Wed, 2010-10-20 at 04:59 -0700, Jakub Narebski wrote:
> Will Palmer <wmpalmer@gmail.com> writes:
> > On Tue, 2010-10-19 at 12:12 +0530, Ramkumar Ramachandra wrote:
> > > Stephen Bash writes:
> > ...
> > > > 
> > > > I have 32 SVN revs in my history that touch multiple Git commit
> > > > objects.  The simplest example is
> > > >   svn mv svn://svnrepo/branches/badBranchName svn://svnrepo/branches/goodBranchName
> > > > which creates a single SVN commit that touches two branches
> > > > (badBranchName will have all it's contents deleted, goodBranchName
> > > > will have an "empty commit" as described above).  The more devious
> > > > version is the SVN rev where a developer checked out / (yes, I'm not
> > > > kidding) and proceeded to modify a single file on all branches in
> > > > one commit.  In our case, that one SVN rev touches 23 git commit
> > > > objects.  And while the latter is somewhat a corner case, the former
> > > > is common and probably needs to be dealt with appropriately (it's
> > > > kind of a stupid operation in Git-land, so maybe it can just be
> > > > squashed).
> > > 
> > > Ouch! Thanks for the illustrative example- I understand now. We have
> > > to bend backwards to perform a one-to-one mapping. It's finally struck
> > > me- one-to-one mapping is nearly impossible to achieve, and I don't
> > > know if it makes sense to strive for it anymore. Looks like Jonathan
> > > got it earlier.
> > 
> > It's been a while since I was involved in this discussion, so maybe the
> > design has changed by now, but I was under the impression that there
> > would be one "one-to-one" mapping branch (which would never be checked
> > out), containing the history of /, and that the "real" git branches,
> > tags, etc, would be based on the trees originally referenced by the root
> > checkout, with git-notes (or similar) being used to track the weirdness
> > in mappings. How does the "multiple branches touched in a single commit"
> > complicate anything other than the heuristics for automatic branch
> > detection (which I assume nobody is at the stage of talking about yet).
> 
> I think there might be a problem in that in git commit is defined by
> its parents and its final state, while revision in Subversion is IIRC
> defined by change.  Isn't it?
> 

A "change" is a delta between one state and another, so each revision is
dependent on those which came before it just as much as a a git commit
is. An svn "revision" is a snapshot, regardless of how it is stored, ie,
the "svn stores changes, git stores snapshots" is an implementation
detail. It's a detail which makes a lot of things easier/faster in git
than they would be in svn, but a mere detail none the less.

The difference of course is that the "name" of an svn revision stays the
same even if aspects of that revision (for example, the commit message)
are changed, while the "name" of a git commit is dependent on everything
that makes up a commit. In git terms, changing a commit message is
considered to be history rewriting, whereas in svn terms it is merely
something which happens occasionally as part of regularly maintained
repository.

the git Philosophy is ingrained in its object model: If you change
something which led to a state, you change the state itself. I don't
think there should be an attempt to work-around that philosophy when
talking to external repositories. That is to say: if a commit message
(or other revprop) in history changes, we want to treat it as if we were
recovering from an upstream rebase. Of course, a problem in that could
very well be "how would we know about it?", which is a good question,
but one not directly related to [revision+directory]<->[commit]
mappings, afaik ;)
