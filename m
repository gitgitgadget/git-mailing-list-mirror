From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Mon, 7 Apr 2008 09:15:27 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804070905410.11277@woody.linux-foundation.org>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net> <alpine.DEB.1.00.0804062204580.12583@eeepc-johanness> <20080406220447.GB5822@adamsimpkins.net> <alpine.DEB.1.00.0804062315090.12583@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 07 18:16:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jiu1D-0004sX-4G
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 18:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbYDGQPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Apr 2008 12:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbYDGQPi
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 12:15:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40362 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751405AbYDGQPg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2008 12:15:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m37GFS9S022857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 Apr 2008 09:15:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m37GFRdH014798;
	Mon, 7 Apr 2008 09:15:27 -0700
In-Reply-To: <alpine.DEB.1.00.0804062315090.12583@eeepc-johanness>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.873 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78977>



On Sun, 6 Apr 2008, Johannes Schindelin wrote:
>=20
> AFAICT you do not even need them then.  Using "struct strbuf *" witho=
ut=20
> ever declaring struct strbuf before that is perfectly valid.

In traditional C, and inside structure declarations etc, yes.

In modern C, in other contexts, no.

Modern C considers a function declaration to be its own scope (it's the=
=20
scope of the function definition, which in a declaration is obviously=20
just the declaration). So if you use a "struct xyzzy *" in a function=20
declaration, it will be a *different* "struct xyzzy *" from one declare=
d=20
later.

Try to compile something like this:

	int fn(struct xyzzy *);
	int fn(struct xyzzy *);

with a modern C compiler, and it will actually say something along the=20
lines of "conflicting types for =A1fn=A2", because while the two declar=
ations=20
look identical, they actually have two different (private) declarations=
 of=20
"struct xyzzy" going on.

But to make it even more interesting, you don't actually need a full=20
declaration of "struct xyzzy" to make the compiler happy, you only need=
 an=20
implicit one ahead of time. You can do that with the incomplete=20
declaration, of course (like the --graph patch did), ie just a simple

	struct xyzzy;

before those declarations is sufficient, but so is the implicit=20
declaration of just using the pointer to it in some non-private scope, =
ie=20
it's equally valid to do

	struct foobar {
		struct xyzzy *ptr;
	};

and this will already be enough to declare "struct xyzzy" in scope for =
the=20
function declarations afterwards.

Is this illogical? Somewhat. Why is it a private scope in a function=20
declaration but not in a struct declaration? Why isn't the function sco=
pe=20
limited to the stuff *inside* the function? Somebody probably knows, bu=
t=20
for the rest of us the answer is just "that's how it is, deal with it".

			Linus
