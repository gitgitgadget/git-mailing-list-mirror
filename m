From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 14:29:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905131420500.3343@localhost.localdomain>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>  <20090512151403.GS30527@spearce.org>  <20090512161638.GB29566@coredump.intra.peff.net>  <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain>  <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
  <alpine.LFD.2.01.0905131036040.3343@localhost.localdomain> <46a038f90905131126s79e5b8e1qd0c6c100ec836127@mail.gmail.com> <alpine.LFD.2.01.0905131131240.3343@localhost.localdomain> <alpine.LNX.2.00.0905131639580.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 13 23:29:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4M1E-000156-Tv
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757795AbZEMV3d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 17:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756645AbZEMV3c
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:29:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59953 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753695AbZEMV3b (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 17:29:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DLTPiM022265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2009 14:29:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DLTO5J008563;
	Wed, 13 May 2009 14:29:24 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LNX.2.00.0905131639580.2147@iabervon.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119113>



On Wed, 13 May 2009, Daniel Barkalow wrote:
> >=20
> > Now, the simple OS X case is not a huge problem, since the lstat wi=
ll=20
> > succeed with the fixed-up filename too.
>=20
> I'm not seeing what the general case is, and how it could possibly be=
have.

Here's a simple example.

Let's say that your company uses Latin1 internally for your filesystems=
,=20
because your tools really aren't utf-8 ready.=20

This is NOT AT ALL unnatural - it's how lots of people used to work wit=
h=20
Linux over the years, and it's largely how people still use FAT, I susp=
ect=20
(except it's not latin1, it's some windows-specific 8-bits-per-characte=
r=20
mapping).


IOW, if you have a file called '=E5=E4=F6', it literally is encoded as=20
'\xe5\xe4\xf6' (if you wonder why I picked those three letters, it's=20
because they are the regular extra letters in Swedish - Swedish has 29=20
letters in its alphabet, and those three letters really are letters in=20
their own right, they are NOT 'a' and 'o' with some dots/rings on top).

IOW, if you open such a file, you need to use those three bytes.

Now, even if you happen to have an OS and use Latin1 on disk, you may=20
realize that you'd like to interact with others that use UTF-8, and wou=
ld=20
want to have your git archive that you export use nice portable UTF-8.

But you absolutely MUST NOT just do a conversion at "readdir()" time. I=
f=20
you do that, then your three-byte filename turns into a six-byte utf-8=20
sequence of '\xc3\xa5\xc3\xa4\xc3\xb6' and the thing is, now "lstat()"=20
won't work on that sequence.

So obviously you could always turn things _back_ for lstat(), but quite=
=20
frankly, that's (a) insane (b) incompetent and (c) not even always=20
well-defined.

> There's the "insensitive" behavior: if you create "foo" and look for=20
> "FOO", it's there, but readdir() reports "foo".
>=20
> There's the "converting" behavior: if you create "foo", readdir() rep=
orts=20
> "FOO", but lstat("foo") returns it.

Then there's the behaviour above: you want your git repository to have=20
utf-8, but your filesystem doesn't convert anything at all, and all you=
r=20
regular tools (think editors etc) are all Latin1.

Latin1 is going away, I hope, but I bet EUC-JP etc still exist.=20

		Linus
