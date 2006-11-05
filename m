X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Sun, 5 Nov 2006 20:04:00 +0100
Message-ID: <20061105190400.GC25259@diana.vm.bytemark.co.uk>
References: <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com> <20061102113631.GA30507@diana.vm.bytemark.co.uk> <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com> <20061103095859.GC16721@diana.vm.bytemark.co.uk> <20061103100142.GD16721@diana.vm.bytemark.co.uk> <454B30E4.8000909@shadowen.org> <454B4C43.2040607@shadowen.org> <Pine.LNX.4.64.0611031034520.25218@g5.osdl.org> <20061105114353.GB19707@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0611050831250.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 5 Nov 2006 19:04:27 +0000 (UTC)
Cc: Andy Whitcroft <apw@shadowen.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611050831250.25218@g5.osdl.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30980>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgnHy-0008Q0-Dr for gcvg-git@gmane.org; Sun, 05 Nov
 2006 20:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161523AbWKETEJ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006 14:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161526AbWKETEJ
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 14:04:09 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:55302 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1161523AbWKETEH
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 14:04:07 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GgnHk-0006fo-00; Sun, 05 Nov 2006 19:04:00 +0000
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 2006-11-05 08:44:13 -0800, Linus Torvalds wrote:

> On Sun, 5 Nov 2006, Karl Hasselstr=F6m wrote:
>
> > So the right thing to do would be to teach StGIT to generate
> > 8bit-encoded output, and trust the SMTP transfer path do mangle it
> > correctly? (Hmm. No, since StGIT talks directly with the first
> > SMTP server in the chain, it needs to be able to QP-encode the
> > mail itself if necessary -- but it should seldom be necessary,
> > then.)
>
> Right. You could even just consider it an error if the mailserver
> doesn't reply to EHLO with 8BITMIME, I really think it's that rare.

Makes sense (unless the Python SMTP library can do this for us -- it
would be impolite to refuse then).

> > In that case, the problem with the current implementation (without
> > my patch applied) is likely to be that it fails to provide the
> > headers needed for the SMTP path to be able to transform it
> > losslessly.
>
> I _think_ it should be sufficient to just set the Content-Type and
> Content-Transfer-Encoding to say something like "text/plain;
> charset=3DUTF8" and "8bit" respectively. But somebody who know the
> SMTP rules better should check.

These are the headers that StGIT uses without my patch -- that is, the
headers used to get that error message:

  Content-Type: text/plain; charset=3Dutf-8; format=3Dfixed
  Content-Transfer-Encoding: 8bit

Which is obviously not good enough for some picky part of the SMTP
chain.

> HOWEVER:
>
> >   Received: (majordomo@vger.kernel.org) by vger.kernel.org via list=
expand
> >           id S1750700AbWJVMCV (ORCPT <rfc822;kha-list-git@hemma.tre=
skal.com>);
> >           Sun, 22 Oct 2006 08:02:21 -0400
> >   X-Warning: Original message contained 8-bit characters, however d=
uring
> >              the SMTP transport session the receiving system did no=
t announce
> >              capability of receiving 8-bit SMTP (RFC 1651-1653), an=
d as this
> >              message does not have MIME headers (RFC 2045-2049) to =
enable
> >              encoding change, we had very little choice.
>
> This does seem to say that somebody didn't even announce 8-bit
> capability in the first place. That's a zmailer error message, and
> it does imply that somebody was running a bad server.
>
> That said, _if_ your message had had the proper mime-type
> specifiers, then zmailer would happily have QP-converted the message
> for you, so everything would have been fine.

E-mail seems to be like driving. You can't just follow the rules, you
also have to be careful to make allowances for those who don't. :-(

Well, it added these headers:

  MIME-Version: 1.0
  Content-Transfer-Encoding: QUOTED-PRINTABLE
  Content-Type: TEXT/PLAIN; charset=3DISO-8859-1

Maybe MIME-Version was the only thing missing? I'll have to try.

> > The mail server (vger talking to itself, if the Received: headers
> > were added in order) complained that there were no MIME headers,
> > so it had to guess the charset.
>
> vger itself? Strange.

It looks that way, but I don't know enough about mail servers to be
very certain. The complete header of the message (in my git list
mailbox) is this:

=46rom git-owner@vger.kernel.org Sun Oct 22 14:02:35 2006
Received: from vger.kernel.org ([209.132.176.167])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Gbc2E-0005lw-00
	for <kha-list-git@hemma.treskal.com>; Sun, 22 Oct 2006 13:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWJVMCV (ORCPT <rfc822;kha-list-git@hemma.treskal.com>);
	Sun, 22 Oct 2006 08:02:21 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had =
to
	   write these MIME-headers with our local system default value.
MIME-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-Type: TEXT/PLAIN; charset=3DISO-8859-1
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbW=
JVMCV
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 08:02:21 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:50054 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750700AbWJVMCU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 08:02:20 -0400
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep01.bredband.com with ESMTP
          id <20061022120218.PHVT953.mxfep01.bredband.com@ironport2.bre=
dband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 14:02:18 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt=
=2Ehemma.treskal.com) ([83.227.180.148])
  by ironport2.bredband.com with ESMTP; 22 Oct 2006 14:02:18 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id 1DFDF4C010;
	Sun, 22 Oct 2006 14:02:18 +0200 (CEST)
=46rom:	Karl =3D?utf-8?q?Hasselstr=3DC3=3DB6m?=3D <kha@treskal.com>
Subject: [PATCH] RFC2047-encode email headers
Date:	Sun, 22 Oct 2006 14:02:17 +0200
To:	Catalin Marinas <catalin.marinas@gmail.com>
Cc:	git@vger.kernel.org
Message-Id: <20061022120217.7650.23715.stgit@localhost>
User-Agent: StGIT/0.11
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org
X-Envelope-Username: kha-list-git
X-Bogosity: Ham, tests=3Dbogofilter, spamicity=3D0.000000, version=3D0.=
94.4
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on=20
	diana.vm.bytemark.co.uk
X-Spam-Level:=20
X-Spam-Status: No, score=3D-0.3 required=3D5.0 tests=3DAWL,FORGED_RCVD_=
HELO=20
	autolearn=3Ddisabled version=3D3.0.3
X-Already-Filtered-By: kha@treskal.com, 2006-10-22 13:02:44 +0100
Status: RO
X-Status: A
Content-Length: 4148

--=20
Karl Hasselstr=F6m, kha@treskal.com
