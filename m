From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's keychain
Date: Fri, 30 Sep 2011 15:33:37 -0400
Message-ID: <CAG+J_DyhcA7RmHwgGJBw4r9JRij0_ONp3ZMD6oMTJ_f4dvYW8w@mail.gmail.com>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
	<20110929075627.GB14022@sigill.intra.peff.net>
	<CAEBDL5WhpVg17aPuRqrE5=2Q293kVD4fYtxGqRzx_K=87t-jgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Sep 30 21:33:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9iq7-0006mh-VM
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 21:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314Ab1I3Tdj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 15:33:39 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44352 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096Ab1I3Tdi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 15:33:38 -0400
Received: by gyg10 with SMTP id 10so1769104gyg.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UkfeFChwCWXwiGAxe1vpjQYrREmqHTkgxDIUByrF7nU=;
        b=qpDck6wNrT3rqP82Wxler5tu5KWcl4T3uIK0UYCbz3AbildB9xHhKvLoHSo9wrLG1V
         J1JoBqZS3QfIX6Lss26TZFobNr/j2ua/bTevrwrQ92fyHFePGBDJQb401/QI5+4nBeyS
         O2xvOAp/SaE86XX4ye0L43ptmJQeNwD9C2U/w=
Received: by 10.236.155.1 with SMTP id i1mr56994892yhk.8.1317411217735; Fri,
 30 Sep 2011 12:33:37 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 30 Sep 2011 12:33:37 -0700 (PDT)
In-Reply-To: <CAEBDL5WhpVg17aPuRqrE5=2Q293kVD4fYtxGqRzx_K=87t-jgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182506>

On Thu, Sep 29, 2011 at 6:03 AM, John Szakmeister <john@szakmeister.net=
> wrote:
>
> I've been working on a version of the keychain credential cache as
> well. =C2=A0I did create a gui, although it's a bit painful.

I still don't understand why a CLI app should have a GUI credential pro=
mpt.

>> =C2=A02. The "get the username from the config" feature is triggered=
 at the
>> =C2=A0 =C2=A0 time of prompting the user (so instead of asking for t=
he username,
>> =C2=A0 =C2=A0 we check the config and pretend the user told us).
>>
>> =C2=A0 =C2=A0 I did it this way originally so that helpers would hav=
e the first
>> =C2=A0 =C2=A0 crack at setting a username, and we would fall back to=
 the config.
>> =C2=A0 =C2=A0 Thinking on it more, that may be backwards. If the use=
r has told
>> =C2=A0 =C2=A0 git "for github.com, I am user 'foo'", then that shoul=
d probably
>> =C2=A0 =C2=A0 take effect first, and --username=3Dfoo get passed to =
the helper.

Sorry, missed this part in my previous reply. I don't understand - how
do you ever send a username to the credential helper if you don't get
it from the config? But in any case, if you have a username (via
config or some other way), yes, I think it should be given to the
credential helper.

> I think that makes sense. =C2=A0I think one thing we have to be caref=
ul
> about partial matches. =C2=A0I wouldn't want the credential cache to =
send
> off the wrong password to a service. =C2=A0This may be me being cauti=
ous,
> but if I don't have all the necessary bits, I'd rather we fail that t=
o
> guess which entry is right.

The credential helper I wrote doesn't work that way. To do so would
mean using a rather more complicated form of the OS X Security API. It
asks for an entry using whatever fields it has, and OS X returns the
first match that satisfies. It's up to the user to yea/nay that match
if the credential helper isn't on the entry's ACL.

>>> + =C2=A0 =C2=A0 /* "GitHub for Mac" compatibility */
>>> + =C2=A0 =C2=A0 if (!strcmp(hostname, "github.com"))
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hostname =3D "github.co=
m/mac";
>>
>> Nice touch. :)
>
> I honestly don't understand why this needs to be done.

Because GitHub for Mac stores its entries using "github.com/mac" as
the hostname.

> I don't use GitHub for Mac... does that mean this is busted for me?

No. It just means that the credential helper and GitHub for Mac store
their entry in a compatible fashion. (So that each can locate the
entry stored by the other.)

> [snip]
>> My series will also produce "cert:/path/to/certificate" when unlocki=
ng a
>> certificate. The other candidates for conversion are smtp-auth (for
>> send-email) and imap (for imap-send). =C2=A0I guess for certs, you'd=
 want to
>> use the "generic" keychain type.
>
> There is a method for adding a certificate to the keychain:
> =C2=A0 <http://developer.apple.com/library/mac/#documentation/Securit=
y/Reference/certifkeytrustservices/Reference/reference.html#//apple_ref=
/doc/uid/TP30000157>
>
> I'm not sure what that does exactly, but I do have a cert, and it
> shows up as "certificate" in the keychain.

That's for storing a certificate itself. In this case, I think we're
just talking about storing the passphrase which protects the
certificate's private key.

>> I wonder if some people would not want to cache cert passwords. Spea=
king
>> of which, I remember keychain asking me "do you want to let git see =
this
>> password?", but I don't ever remember it asking "do you want to save
>> this password?". Is that usually automatic? Again, I was kind of
>> expecting a dialog with a "remember this" checkbox.
>
> By the time you get Keychain involved, the decision has been made.
> Most applications offer that ability... and you're right, this should
> probably offer the same capability. =C2=A0That also means stashing th=
at
> data somewhere. :-( =C2=A0OTOH, it does make for a better user experi=
ence.

What, no? If you don't want git to store usernames/passwords stored in
the OS X Keychain, don't use the git-osx-keychain credential helper.

j.
