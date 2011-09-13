From: John Szakmeister <john@szakmeister.net>
Subject: Re: git credential helper design [was: What's cooking in git.git (Aug
 2011, #07; Wed, 24)]
Date: Tue, 13 Sep 2011 04:29:30 -0400
Message-ID: <CAEBDL5UGhanJboiT2SppeXa6UaKbE1MOpajf9wSaQCkR9EdRYw@mail.gmail.com>
References: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
	<20110825202057.GB6165@sigill.intra.peff.net>
	<7vhb55i11i.fsf@alter.siamese.dyndns.org>
	<20110831023801.GB3340@sigill.intra.peff.net>
	<CAEBDL5XnoCtiKQB8jRxvueWc9zy-yzC+MxgTLmP1amY+U=7aOw@mail.gmail.com>
	<20110910065332.GA10935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Lukas_Sandstr=C3=B6m?= <luksan@gmail.com>,
	Ted Zlatanov <tzz@lifelogs.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 10:29:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3OND-00035C-7W
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 10:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389Ab1IMI3g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Sep 2011 04:29:36 -0400
Received: from mail-vw0-f52.google.com ([209.85.212.52]:47127 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373Ab1IMI3e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2011 04:29:34 -0400
Received: by vws16 with SMTP id 16so631231vws.11
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3BgCYJYjcVKY3PMO9eCi/eLXzq12fZbkX5grdEMCn8c=;
        b=fkLrAxB374uaB4t6SNJxdVkoY2LDxWZIgs3+Ekx1aOA3Mn+gkDmy6n0bD4Y15u7ymw
         vrbllprpBLmm9i7GE4Djsi4eiY17Mg6LdWrmFYItP4c29A8BRQF1WnfgjB9XKG9c9Ftq
         gOmfRyF7JHcQxzTF3lUoOmDHzYyw00k5iVpuU=
Received: by 10.52.23.130 with SMTP id m2mr1720859vdf.191.1315902570237; Tue,
 13 Sep 2011 01:29:30 -0700 (PDT)
Received: by 10.52.160.196 with HTTP; Tue, 13 Sep 2011 01:29:30 -0700 (PDT)
In-Reply-To: <20110910065332.GA10935@sigill.intra.peff.net>
X-Google-Sender-Auth: P3hFU6UdHodDoxbhZs5TteIMpJY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181276>

On Sat, Sep 10, 2011 at 2:53 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 09, 2011 at 05:55:38AM -0400, John Szakmeister wrote:
>
>> A little feedback here: I do look into my keychain on Mac OS X. =C2=A0=
I
>> tend to keep most of my credentials in a separate keychain that gets
>> whenever my computer sleeps or the screen saver kicks on. =C2=A0So t=
hat
>> blob ends up being user-visible to some degree. =C2=A0Could I munge =
it into
>> something else? =C2=A0Sure. =C2=A0But I do wonder if it might be bet=
ter to make
>> it something closer to what the user expects to see.
>
> Sure, I agree. I guess my question is: what does the user expect to s=
ee?

Originally I was going to use SecKeychainFindGenericPassword(), and
the token would have been the "serviceName".  However,
SecKeychainFindInternetPassword() is clearly the better fit, which
means busting out the individual bits.

[snip]
> Perhaps it's worth providing the information in two forms: parsed and
> broken out by individual pieces, and as a more opaque blob. Then syst=
ems
> which care can use the pieces, and systems which are trying to be as
> simple as possible can use the blob.

That would be useful.  Right now, it looks like I'll be parsing the tok=
en.

> That still leaves the question of how the user specifies policy about
> which parts of the blob are relevant. That is, how do they say that o=
nly
> the "domain" portion of the hostname is relevant? Or that the path is=
 or
> is not relevant?
>
> I was really hoping for the user to be able to specify this at the gi=
t
> level, to give each storage helper roughly the same feature set.

Ooh... yeah, I'm not sure. :-(

> Maybe it would be enough to do something like:
>
> =C2=A01. Assemble all of the parts (protocol, username (if any), host=
name,
> =C2=A0 =C2=A0 path) into a canonicalized URL representing the authent=
ication
> =C2=A0 =C2=A0 context.
>
> =C2=A02. Look for git config matching the context URL, and allow
> =C2=A0 =C2=A0 transformations (e.g., match and replace the whole thin=
g, or even
> =C2=A0 =C2=A0 regexp-style substitution).

That seems burdensome.  There is a method in HTTP/HTTPS for saying
"use this set of credentials".  You'd do that via the security domain.
 That doesn't necessarily apply to other urls (ssh, for example), but
it would allow a storage backend to cache it for a specific path, but
fallback to looking up the credential using the security domain.

[snip]
> I think this is somewhat outside the boundaries of what git can provi=
de.
> We don't know whether we are interactive or not; we can only make
> guesses based on things like whether there is a terminal available. T=
he
> helper should be able to make an even better guess, because it can as=
k
> for system-specific things (e.g., a Linux one might check whether
> $DISPLAY is set before trying to pop up a dialog). And helpers are fr=
ee
> to simply return nothing. Even though most people will only configure=
 a
> single helper, there is actually a stack, and git will try the next o=
ne,
> and so on until it gets an answer (or if it hits the end without an
> answer, will complain).

Okay, I won't worry about it then.  Thanks Jeff!

-John
