X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Sun, 5 Nov 2006 08:44:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611050831250.25218@g5.osdl.org>
References: <20061101090046.1107.81105.stgit@localhost>
 <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com>
 <20061102113631.GA30507@diana.vm.bytemark.co.uk>
 <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com>
 <20061103095859.GC16721@diana.vm.bytemark.co.uk> <20061103100142.GD16721@diana.vm.bytemark.co.uk>
 <454B30E4.8000909@shadowen.org> <454B4C43.2040607@shadowen.org>
 <Pine.LNX.4.64.0611031034520.25218@g5.osdl.org> <20061105114353.GB19707@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-618473499-1162745053=:25218"
NNTP-Posting-Date: Sun, 5 Nov 2006 16:45:25 +0000 (UTC)
Cc: Andy Whitcroft <apw@shadowen.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061105114353.GB19707@diana.vm.bytemark.co.uk>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30976>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggl7J-00020N-7X for gcvg-git@gmane.org; Sun, 05 Nov
 2006 17:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161341AbWKEQo2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 11:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161347AbWKEQo2
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 11:44:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11962 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1161346AbWKEQo0 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 11:44:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA5GiEoZ012365
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 5
 Nov 2006 08:44:15 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA5GiD4Z025744; Sun, 5 Nov
 2006 08:44:14 -0800
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-618473499-1162745053=:25218
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Sun, 5 Nov 2006, Karl Hasselström wrote:
> 
> So the right thing to do would be to teach StGIT to generate
> 8bit-encoded output, and trust the SMTP transfer path do mangle it
> correctly? (Hmm. No, since StGIT talks directly with the first SMTP
> server in the chain, it needs to be able to QP-encode the mail itself
> if necessary -- but it should seldom be necessary, then.)

Right. You could even just consider it an error if the mailserver doesn't 
reply to EHLO with 8BITMIME, I really think it's that rare.

> In that case, the problem with the current implementation (without my
> patch applied) is likely to be that it fails to provide the headers
> needed for the SMTP path to be able to transform it losslessly.

I _think_ it should be sufficient to just set the Content-Type and 
Content-Transfer-Encoding to say something like "text/plain; charset=UTF8" 
and "8bit" respectively. But somebody who know the SMTP rules better 
should check.

HOWEVER:

>   Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
>           id S1750700AbWJVMCV (ORCPT <rfc822;kha-list-git@hemma.treskal.com>);
>           Sun, 22 Oct 2006 08:02:21 -0400
>   X-Warning: Original message contained 8-bit characters, however during
>              the SMTP transport session the receiving system did not announce
>              capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
>              message does not have MIME headers (RFC 2045-2049) to enable
>              encoding change, we had very little choice.

This does seem to say that somebody didn't even announce 8-bit capability 
in the first place. That's a zmailer error message, and it does imply that 
somebody was running a bad server.

That said, _if_ your message had had the proper mime-type specifiers, then 
zmailer would happily have QP-converted the message for you, so everything 
would have been fine.

> The mail server (vger talking to itself, if the Received: headers were
> added in order) complained that there were no MIME headers, so it had
> to guess the charset.

vger itself? Strange.

		Linus
