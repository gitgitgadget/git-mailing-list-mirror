From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH-resent] gitk: fix in procedure drawcommits
Date: Sat, 20 Oct 2007 18:02:47 +0200
Message-ID: <200710201802.48111.barra_cuda@katamail.com>
References: <20071019052823.GI14735@spearce.org> <200710191544.22228.barra_cuda@katamail.com> <18201.54648.707559.480169@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	pdmef@gmx.net
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 17:58:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjGiv-0003Rq-FQ
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 17:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756319AbXJTP6h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Oct 2007 11:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756318AbXJTP6h
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 11:58:37 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:38358 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756315AbXJTP6h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Oct 2007 11:58:37 -0400
Received: from host157-57-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.57.157]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.57.157+nHkbl2LPlQh; Sat, 20 Oct 2007 17:58:32 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <18201.54648.707559.480169@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61842>

[Rocco Rutte added on CC:, since he wrote the hg-fast-export scripts]

On Saturday 20 October 2007, Paul Mackerras wrote:
> Well no. =A0I'd rather understand why this is happening, in case the=20
> error indicates that I'm not handling a corner case correctly. =A0Can
> you make a copy of the repo that triggers the bug available to me?

IIRC, I just cloned mutt's hg repo:

  hg clone http://dev.mutt.org/hg/mutt

then imported it in git with the scripts at

  http://repo.or.cz/w/fast-export.git

with

  hg-fast-export.sh -r ../mutt


After that, I've done the usual maintenance repack.

Then, running gitk and keeping pressed pgdown triggers that

	"Error: can't unset..."

window.

Uh-oh. I think I just found the issue. That's probably a bug
somewhere in the import (either fast-export or fast-import or
the original repo, I don't know), so I'm not sure if gitk
should be patched, but since the resulting repo seems correct
as far as git is concerned (i.e. git fsck --full --strict
doesn't complain), I guess something should be done.

Here is the culprit (or so I think). One of the guilty commits is:

	commit a3b4383d69e0754346578c85ba8ff7c05bd88705
	tree 1bf99cd22abe97c59f8c0b7ad6b8244f0854b8af
	parent 6d919fccf603aba995035fa0fb507aa2bd3bf0ae
	parent 6d919fccf603aba995035fa0fb507aa2bd3bf0ae
	author Brendan Cully <brendan@kublai.com> 1179646159 -0700
	committer Brendan Cully <brendan@kublai.com> 1179646159 -0700
=09
	    Forget SMTP password if authentication fails.
	    Thanks to Gregory Shapiro for the initial patch (I've moved the re=
set
	    from smtp_auth_sasl up to smtp_auth, and used the account API
	    instead of twiddling account bits by hand). Closes #2872.

This commit (and many others) has two parents, but the two parents
have the same hash. So gitk tries to unset the same variable twice,
hence the error. At this point, the fix for gitk should be either to
check if the parents have the same hash when reading the commit or
avoiding to unset two times the same variable.

This explanation makes sense to me, now the problem is: have I messed
up the import myself, the scripts/commands used are to blame, or is
it entirely the original repo's fault?

Since I've redone the import and the error remains, I guess
that's not my fault :)
