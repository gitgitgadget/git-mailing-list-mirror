From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG ext4?] Working tree getting out of date "spontaneously"
Date: Fri, 5 Jun 2009 08:39:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906050825120.6847@localhost.localdomain>
References: <20090605122444.GA11035@atjola.homenet> <20090605132126.GB11035@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 05 17:39:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbW9-0007T9-Ig
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 17:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbZFEPjd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 11:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbZFEPjc
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 11:39:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44874 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752079AbZFEPjc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 11:39:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n55FdPPJ000971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Jun 2009 08:39:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n55FdORs023071;
	Fri, 5 Jun 2009 08:39:25 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090605132126.GB11035@atjola.homenet>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.965 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120780>



On Fri, 5 Jun 2009, Bj=F6rn Steinbrink wrote:
> >=20
> > *wait a minute, doing nothing*
> >=20
> > doener@atjola:git (master) $ git diff-index --name-only HEAD
> > Documentation/RelNotes-1.6.3.2.txt
> > Documentation/git.txt
> > contrib/completion/git-completion.bash
> > grep.c
>=20
> Hm, looks like this is not a git bug. Went back to 1.5.4, and even th=
at
> shows the error. So I actually looked at the files, and indeed, the f=
ile
> in the working tree gets modified. stat(1) shows:

You have beagle running, don't you?

It's a piece of sh*t, and uses extended attributes to track indexing=20
information.

So the "wait a minute" will just give beagle the chance to index your g=
it=20
working tree, and update the extended attributes. That is entirely hidd=
en=20
from all normal filesystem stat information, *EXCEPT* it changes ctime,=
=20
since the inode is changed.

It's annoying as hell. Beagle is broken. It's a particularly inefficien=
t=20
way to store index information, and it is annoying that an indexing eng=
ine=20
actually changes the files it indexes.=20

You can tell git to ignore CTIME, by using

	[core]
		trustctime =3D false

and now git will ignore the mess that beagle makes of things.=20

The other alternative is to tell beagle to behave. The beagle people=20
claims this makes things slower. Which is quite possibly true, since th=
e=20
kernel is optimized and caches things well (extended attributes in the=20
filesystem), and beagles alternative model is probably some incredibly=20
crappy indexing built on top of MySQL.

Your choice.

		Linus
