From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] contrib: add win32 credential-helper
Date: Mon, 2 Apr 2012 17:53:47 +0200
Message-ID: <CABPQNSac0opcTDVBwr4VeuA7pxqbtsqU7mdmYWms9tu3MjcpeQ@mail.gmail.com>
References: <1332198414-5884-1-git-send-email-kusmabite@gmail.com> <20120323211001.GA18198@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 02 17:54:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEjaU-0001Im-Hz
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 17:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310Ab2DBPya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 11:54:30 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49411 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab2DBPy2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 11:54:28 -0400
Received: by gghe5 with SMTP id e5so1270327ggh.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=b2Rzfo8hGJMQL8d6+VncAmPxDQpLLm7vpekZK4nxUMc=;
        b=tGxyXB0KYrKuhxD1Wv1cQo56ysTmzjlSLiT3052trlEt5YbM9lhnInH2YPYAkAkr0p
         GOsvqTETf++syYTAKPBrIrL/uCujC9zuFex0csQP11MJate7h1lfnB8bsW6Id06HbfIK
         iZ7W7ZJ4CPwbrwJi9/d7mjG+De3LZyWPJzyPa5L63yuMEPf0cw34WlDd7XTCLeokGP3O
         GvDgRwDs0iPFvOZEbBSDxI9hMePdIQkxD4Ifz2dOCcc5TwqAycxVfzwfi1UlNdNdwnux
         SXBmpm3gq0goUprltVNO/TQB5nDhZ56fWUsc51ju8jM+uv10f7TMfqGSc2TnjmAL4hrV
         zPdw==
Received: by 10.68.240.135 with SMTP id wa7mr21738523pbc.7.1333382068085; Mon,
 02 Apr 2012 08:54:28 -0700 (PDT)
Received: by 10.68.136.40 with HTTP; Mon, 2 Apr 2012 08:53:47 -0700 (PDT)
In-Reply-To: <20120323211001.GA18198@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194522>

On Fri, Mar 23, 2012 at 10:10 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 20, 2012 at 12:06:54AM +0100, Erik Faye-Lund wrote:
>
>> This one pretty much sucks. Mem-leaks and a sketchy deletion-filter.
>
> Thanks for moving forward on this. I'm sorry I can't be much help on =
the
> Windows-specific knowledge, but I'll answer what I can.
>

Thanks for following up :)

>> Currently uses "::" as an attribute-separator, but this is not robus=
t
>> without encoding if the attribute values themselves contains "::".
>
> Yeah. Can you store arbitrary bytes? If so, NUL would be a good
> terminator.

No. TargetName is an LPWSTR, which is supposed to be zero-terminated.
There's no way of specifying it's length directly.

> Otherwise, newline is a reasonable choice, as the protocol
> already can't communicate usernames/passwords with newlines (a
> limitation that I accepted to make the protocol much simpler for
> scripting use).
>

This works, but it causes Windows 7's credential manager to glitch in
rendering the credential (adding all the newlines to the end of the
line, and stretching an icon - yuck), which is also a bit unfortunate.

So I'm thinking that escaping the string needs to be done. It can't be
that big of a deal ;)

> That being said, I realized when writing credential-store that you ca=
n
> encode all of the components in a URL, like:
>
> =A0proto://user:password@host/path
>
> You do have to get the URL encoding/decoding right, of course, but si=
nce
> it is a standard format, you may have library or OS support (for the
> stock helpers, I was able to cheat and just link against git's code).
>

Yeah, I guess UrlCanonicalize from WinAPI or something along those
lines can be used.

So far I've simply tried to put the stuff in an order that made simple
string-compare sufficient to pass the test. It seems I need to
implement proper matching instead.

>> I'm not really sure how to make it less sucky in some regards, part
>> of this I blame on lacking documentation of the credential-helper
>> prococol :P
>
> Heh. OK, I'll take the blame. :)
>
>> =A01) Encoding of usernames. I'm assuming this is supposed to be
>> =A0UTF-8, because SecKeychainFindInternetPassword which is used by
>> =A0the OSX-helper is documented to take accountName as UTF-8.
>
> Like many other parts of git, we treat the data as binary goo as much=
 as
> possible. So git hands the helper whatever bytes the user provided, a=
nd
> ships off whatever bytes are provided by the helper over http without
> any further processing. The only two exceptions are:
>
> =A01. Fields cannot contain NUL (which means wide encodings like utf-=
16
> =A0 =A0 are pretty much out).
>
> =A02. Fields cannot contain newline (which effectively means that the
> =A0 =A0 encoding needs to be some ascii superset like utf8 or latin1)=
=2E
>
> In practice, I would expect most usernames and passwords only contain
> ascii bytes, if only because charset issues between the client and
> server would lead to insanity.
>

ASCII unsernames might be common in the UNIX-world, but in the Windows
world this is very much not the case. These functions can be used for
all kinds of services, so I don't think assuming ASCII makes much
sense.

And since OSX documents the encoding, I'm guessing that non-ASCII
usernames isn't entirely unheard of there either.

In general, I think the whole "let's try to get away with not
specifying encoding" is a bit dangerous. Without knowing what encoding
the input and output is, the helpers are pretty much useless for
people. Sure, saying "at least ASCII" helps, but it just takes us
halfway there. And, I think UTF-8 is the least insane option here.
After all, this is an internal protocol; if the credential helper
needs to store something else (like we do for Windows), we can
convert the string. Likewise, if the network protocol the caller is
going to pass this to assumes something else, convert.

>> =A02) Encoding of passwords. I'm assuming UTF-8, as mixing encodings
>> =A0here would be insane :P
>
> Same as above.
>

Again, my objection is pretty much the same as above, modulo the
comment about OSX.

Binary blob password doesn't make sense; human beings have
text-strings as passwords. They don't remember binary blobs.

About the rest of my questions: I think what you're saying pretty much
makes sense. I think some details could be mentioned in
Documentation/technical/api-credentials.txt, and I'll have a look at
adding what I think makes sense after reading through your mail a bit
closer.

Luckily, I'll have some coding time this Easter, so hopefully I'll be
able to finish up a new version soon-ish.
