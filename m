From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Proper plumbing for porcelain gpg formats on git show?
Date: Fri, 16 Jan 2015 15:05:00 -0500
Organization: PD Inc
Message-ID: <6B1E582B25CD4722B8993C5A3C304ECA@black>
References: <EB979B4B153D49909C78239A333869FB@black><20150116192947.GD29365@google.com> <xmqqk30m1p0t.fsf@gitster.dls.corp.google.com>
Reply-To: "Junio C Hamano" <gitster@pobox.com>,
	  "Jonathan Nieder" <jrnieder@gmail.com>, <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Jonathan Nieder'" <jrnieder@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 21:05:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCD8r-0003kH-QA
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 21:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbbAPUFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 15:05:07 -0500
Received: from mail.pdinc.us ([67.90.184.27]:56449 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbbAPUFG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2015 15:05:06 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id t0GK505G021960;
	Fri, 16 Jan 2015 15:05:00 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <xmqqk30m1p0t.fsf@gitster.dls.corp.google.com>
Thread-Index: AdAxxgfsehDv/wyXRCOuZgylWRDk6AAADHvQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262571>

> -----Original Message-----
> From: Junio C Hamano
> Sent: Friday, January 16, 2015 14:53
> 
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >> would there be interest in accepting a patch for 
> >>
> >> %Gs - the raw GPG text from the commit
> >> %Gf - the key fingerprint
> >
> > There may be bikeshedding on the exact format specifier, but aside
> > from that I don't see why not. ;-)
> 
> I was about to say "As long as the execution is good, why not?
> Spawning an extra process 'gpg --list-packets' is not quite
> acceptable without properly being lazy is not acceptable".
> 
> But verify_signed_buffer() reads "gpg --status-fd=1 --verify"
> output, it is already done lazily in format_commit_one() only when
> the "%G?" placeholder is used, and the output we parse that are
> prefixed by [GNUPG:] should have enough information to grab the
> fingerprint from on the VALIDSIG line.
> 
> So I do not see a lot of room to screw-up the execution ;-).

This kind of begs the question of extracting signatures, not in one's keyring. I was surprised to see %GK fail because it was not yet in the keyring. I would also expect a "B", not a "N" for %G?, maybe there should be a "X" for can't verify.

$ gpg --delete-keys DA0848AD
gpg (GnuPG) 2.0.14; Copyright (C) 2009 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.


pub  2048R/DA0848AD 2014-06-24 Jason Pyeron <jpyeron@pdinc.us>

Delete this key from the keyring? (y/N) y

$ git diff-tree -s --format=%G? HEAD
N

$ git diff-tree -s --format=%GG HEAD
gpg: Signature made Fri 16 Jan 2015 01:33:12 PM EST using RSA key ID DA0848AD
gpg: Can't check signature: No public key


$ git diff-tree -s --format=%GK HEAD

$ gpg --keyserver hkp://pgp.mit.edu --recv-keys 8D6B5984DA0848AD
gpg: requesting key DA0848AD from hkp server pgp.mit.edu
gpg: key DA0848AD: public key "Jason Pyeron <jpyeron@pdinc.us>" imported
gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)

$ git diff-tree -s --format=%G? HEAD
U

$ git diff-tree -s --format=%GG HEAD
gpg: Signature made Fri 16 Jan 2015 01:33:12 PM EST using RSA key ID DA0848AD
gpg: Good signature from "Jason Pyeron <jpyeron@pdinc.us>"
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 8C88 9ECF 7A2F 7977 7CE9  13B4 8D6B 5984 DA08 48AD


$ git diff-tree -s --format=%GK HEAD
8D6B5984DA0848AD



--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00. 
