From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Git / Subversion Interoperability
Date: Sat, 24 Mar 2007 13:38:13 -0700
Message-ID: <20070324203813.GB25571@muzzle>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org> <eu0njb$q3b$1@sea.gmane.org> <20070324064556.GD25863@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 24 21:38:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVD0E-0004bv-FK
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 21:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbXCXUiQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 24 Mar 2007 16:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbXCXUiP
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 16:38:15 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44329 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932869AbXCXUiP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 16:38:15 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 775172DC01A;
	Sat, 24 Mar 2007 13:38:13 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 24 Mar 2007 13:38:13 -0700
Content-Disposition: inline
In-Reply-To: <20070324064556.GD25863@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43019>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > Shawn O. Pearce wrote:
> >=20
> > > - Assigning repository-wide revision numbers. =A0Git doesn't have
> > > such a concept, but its key to SVN. =A0These would need to be sto=
red
> > > in a file so the server can quickly map from revision number to
> > > Git commit SHA-1. =A0The reflogs may help here, but currently the=
y
> > > also expire. =A0Any reflog that is being used to do this mapping
> > > cannot be expired, ever.
> >=20
> > Another idea is to use lightweight tags for that, especially now
> > with packed refs support in git.
>=20
> Yes, not a bad idea.
>=20
> Except the packed refs file can have variable sized records.  It has
> no faster access path than to just scan it.  Some SVN repositories
> have revision counts up into the 5 and 6 digits.  These would take
> quite a while to scan, even as packed refs.  ;-)
>=20
> I'm inclined to lean towards a really simple binary flat file holding
> just 20 byte SHA-1s, in "SVN order".  Then its just a simple array
> index operation to locate the correct Git commit.  And adding a
> new commit is really just an append to the end operation.

The rev_db implementation in git-svn is very similar to what you're
describing.  However, I decided on 41-byte (SHA1 ascii + "\n") records
since it was easier to debug if any problems came up, and a ~50% size
reduction wasn't worth the potential headache (I already had a lot of
those from just dealing with SVN :).

The biggest weakness of fixed records is that tags or sparsely worked o=
n
branches waste a lot of disk space, but it hasn't been a huge problem
for me.

--=20
Eric Wong
