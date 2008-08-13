From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why doesn't git-apply remove empty file
Date: Wed, 13 Aug 2008 16:09:46 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808131602200.3462@nehalem.linux-foundation.org>
References: <38b2ab8a0808120917h10f15c81v4d1f04c0174dc994@mail.gmail.com>  <7vod3xpxq2.fsf@gitster.siamese.dyndns.org> <38b2ab8a0808130048t506dbb7ah1d6fcd6bd4f3c90c@mail.gmail.com> <48A357BA.8060003@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francis Moreau <francis.moro@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Aug 14 01:11:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTPUh-0003Kp-V2
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 01:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbYHMXKE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2008 19:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754263AbYHMXKE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 19:10:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47697 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751386AbYHMXKC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Aug 2008 19:10:02 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7DN9l5J010803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Aug 2008 16:09:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7DN9kl3011422;
	Wed, 13 Aug 2008 16:09:46 -0700
In-Reply-To: <48A357BA.8060003@lsrfire.ath.cx>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.415 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92290>



On Wed, 13 Aug 2008, Ren=C3=A9 Scharfe wrote:
>=20
> I bet you are using GNU patch.  It removes files that are empty after
> patching and you need to specify --posix to make it keep empty files.

GNU patch' behavior wrt empty files is a bit more complex than that. It=
's=20
true that you can disable it all with the POSIX mode (not that anybody=20
ever does), but it's not an unconditional removal, I think.

It does look at the date of the destination if there is one, ie accordi=
ng=20
to the man-page:

      "You can create a file by sending out a diff that compares /dev/n=
ull  or
       an empty file dated the Epoch (1970-01-01 00:00:00 UTC) to the f=
ile you
       want to create.  This only works if the file you want to create =
doesn=E2=80=99t
       exist  already  in  the target directory.  Conversely, you can r=
emove a
       file by sending out a context diff that compares the file to be =
deleted
       with  an  empty  file dated the Epoch.  The file will be removed=
 unless
       patch is conforming to POSIX and the -E or --remove-empty-files =
 option
       is  not  given.  An easy way to generate patches that create and=
 remove
       files is to use GNU diff=E2=80=99s -N or --new-file option."

and no, git never did that file date thing, so git acts differently fro=
m=20
GNU patch in this thing (as in so many others, for that matter).

I don't think it would necessarily be wrong to try to emulate GNU patch=
=20
for the case where git is guessing at removal, though (ie for the=20
"traditional diff" case - for a "git diff", the removal question is=20
unambiguous thanks to the git extensions, of course).

That said, I'm also not personally very motivated to add yet another od=
d=20
GNU patch behavior quirk. Especially as we very much try to avoid parsi=
ng=20
that insane and not-well-specified date format anyway, and just ignore =
it.=20
But if somebody sends out a tested patch to add such logic, I wouldn't=20
think it _wrong_ either.

			Linus
