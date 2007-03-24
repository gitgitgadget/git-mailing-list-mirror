From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git / Subversion Interoperability
Date: Sat, 24 Mar 2007 02:45:56 -0400
Message-ID: <20070324064556.GD25863@spearce.org>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org> <eu0njb$q3b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 07:46:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV00p-0004Xf-Rv
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 07:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbXCXGqB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 24 Mar 2007 02:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753466AbXCXGqB
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 02:46:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36637 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbXCXGqA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2007 02:46:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HV00i-0005Ak-Qn; Sat, 24 Mar 2007 02:45:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7688820FBAE; Sat, 24 Mar 2007 02:45:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <eu0njb$q3b$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42985>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn O. Pearce wrote:
>=20
> > - Assigning repository-wide revision numbers. =A0Git doesn't have
> > such a concept, but its key to SVN. =A0These would need to be store=
d
> > in a file so the server can quickly map from revision number to
> > Git commit SHA-1. =A0The reflogs may help here, but currently they
> > also expire. =A0Any reflog that is being used to do this mapping
> > cannot be expired, ever.
>=20
> Another idea is to use lightweight tags for that, especially now
> with packed refs support in git.

Yes, not a bad idea.

Except the packed refs file can have variable sized records.  It has
no faster access path than to just scan it.  Some SVN repositories
have revision counts up into the 5 and 6 digits.  These would take
quite a while to scan, even as packed refs.  ;-)

I'm inclined to lean towards a really simple binary flat file holding
just 20 byte SHA-1s, in "SVN order".  Then its just a simple array
index operation to locate the correct Git commit.  And adding a
new commit is really just an append to the end operation.

Yea, I know, append =3D=3D bad on some older Linux systems, and is
hard to roll back if you partially appended as it gets into some
possible nasty mess with truncate, but I think that when combined
with a simple lock file we can make it safe enough that its not
really going to be a problem.

--=20
Shawn.
