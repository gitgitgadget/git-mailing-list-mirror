From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's keychain
Date: Thu, 29 Sep 2011 06:03:29 -0400
Message-ID: <CAEBDL5WhpVg17aPuRqrE5=2Q293kVD4fYtxGqRzx_K=87t-jgw@mail.gmail.com>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
	<20110929075627.GB14022@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 29 12:03:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9DSr-000547-O9
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 12:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341Ab1I2KDc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 06:03:32 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34319 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325Ab1I2KDb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 06:03:31 -0400
Received: by iaqq3 with SMTP id q3so519750iaq.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fqZQzL2wENDDKjowx/OerGmBlq0bDKZVhYQyIVAMefc=;
        b=QOAulqk1mfhl9JieJdimoD1tjBM2KrcjIgZbtOKqcW75+5e1XK5FNBTSCzj07ZpvT1
         74uIIxK62TN7zHUBbapEaiZoOMtBGriaudLIALn9Jk+7dkpwmyrtHHzp8VCA505IPt/X
         fLkWZUk9MCRdfibJjQCpVnqIGXTXcjhWPwhm0=
Received: by 10.231.81.211 with SMTP id y19mr14690877ibk.70.1317290609881;
 Thu, 29 Sep 2011 03:03:29 -0700 (PDT)
Received: by 10.231.207.83 with HTTP; Thu, 29 Sep 2011 03:03:29 -0700 (PDT)
In-Reply-To: <20110929075627.GB14022@sigill.intra.peff.net>
X-Google-Sender-Auth: gJIKARAk_oYlEmgJEzvfT8rVCFY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182390>

On Thu, Sep 29, 2011 at 3:56 AM, Jeff King <peff@peff.net> wrote:
[snip]
> This was my first one. I kind of expected there to be some kind of
> graphical password dialog. Especially because keychain will pop up a
> dialog and ask you "is it OK for git to access this password?". So I
> sort of assumed that people would assume that credentials happened
> outside of the regular terminal session (I see the same thing on Linu=
x,
> for example, with gpg-agent, which will open a new window and grab
> focus).
>
> But I have no idea what's "normal" on OS X.

I've been working on a version of the keychain credential cache as
well.  I did create a gui, although it's a bit painful.

> I wondered if you were trying to be friendly to people who were
> connecting via ssh. But that doesn't seem to work at all. I couldn't =
get
> either version of your helper to actually do anything in an ssh sessi=
on
> (even with the same user logged in on console). =C2=A0I guess there i=
s some
> magic to hook it into the keychain manager.

I'm not sure there is.  For instance, ssh will look up passphrases for
ssh keys in the keychain, but if you ssh into the box, and then try to
ssh to somewhere else, it'll prompt you for the passphrase for the
key.  In my own experiments, the lookup will come back with a failure,
despite the fact that the keychain is already unlocked. :-(

Looking at the Subversion source, they recognize the issue too:

> * XXX (2005-12-07): If no GUI is available (e.g. over a SSH session),
> * you won't be prompted for credentials with which to unlock your
> * keychain.  Apple recognizes lack of TTY prompting as a known
> * problem.

=2E..obviously, Apple hasn't fixed this issue. :-(

> Also, regarding opening /dev/tty yourself versus using getpass. There
> are a few magic things getpass will do that your helper won't:
>
> =C2=A01. It respects core.askpass, GIT_ASKPASS, and SSH_ASKPASS if th=
ey are
> =C2=A0 =C2=A0 set.
>
> =C2=A02. The "get the username from the config" feature is triggered =
at the
> =C2=A0 =C2=A0 time of prompting the user (so instead of asking for th=
e username,
> =C2=A0 =C2=A0 we check the config and pretend the user told us).
>
> =C2=A0 =C2=A0 I did it this way originally so that helpers would have=
 the first
> =C2=A0 =C2=A0 crack at setting a username, and we would fall back to =
the config.
> =C2=A0 =C2=A0 Thinking on it more, that may be backwards. If the user=
 has told
> =C2=A0 =C2=A0 git "for github.com, I am user 'foo'", then that should=
 probably
> =C2=A0 =C2=A0 take effect first, and --username=3Dfoo get passed to t=
he helper.

I think that makes sense.  I think one thing we have to be careful
about partial matches.  I wouldn't want the credential cache to send
off the wrong password to a service.  This may be me being cautious,
but if I don't have all the necessary bits, I'd rather we fail that to
guess which entry is right.

[snip]
> Hrm. I was really hoping people wouldn't need to pick apart the "uniq=
ue"
> token, and it could remain an opaque blob. If helpers are going to do
> this sort of parsing, then I'd just as soon have git break it down fo=
r
> them, and do something like:
>
> =C2=A0git credential-osxkeychain \
> =C2=A0 =C2=A0--protocol=3Dhttps \
> =C2=A0 =C2=A0--host=3Dgithub.com \
> =C2=A0 =C2=A0--path=3Dpeff/git.git
> =C2=A0 =C2=A0--username=3Dpeff
>
> to just hand over as much information as possible, and let the helper
> throw it all together if it wants to.

I think this is a good idea too.  Keychain definitely wants this
information stored in separate fields, and I suspect the secrets api
does too (I haven't found any formal docs about the preferred way of
storing attributes related to urls though).

>> + =C2=A0 =C2=A0 /* "GitHub for Mac" compatibility */
>> + =C2=A0 =C2=A0 if (!strcmp(hostname, "github.com"))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hostname =3D "github.com=
/mac";
>
> Nice touch. :)

I honestly don't understand why this needs to be done.  I don't use
GitHub for Mac... does that mean this is busted for me?

[snip]
> My series will also produce "cert:/path/to/certificate" when unlockin=
g a
> certificate. The other candidates for conversion are smtp-auth (for
> send-email) and imap (for imap-send). =C2=A0I guess for certs, you'd =
want to
> use the "generic" keychain type.

There is a method for adding a certificate to the keychain:
   <http://developer.apple.com/library/mac/#documentation/Security/Refe=
rence/certifkeytrustservices/Reference/reference.html#//apple_ref/doc/u=
id/TP30000157>

I'm not sure what that does exactly, but I do have a cert, and it
shows up as "certificate" in the keychain.

> I wonder if some people would not want to cache cert passwords. Speak=
ing
> of which, I remember keychain asking me "do you want to let git see t=
his
> password?", but I don't ever remember it asking "do you want to save
> this password?". Is that usually automatic? Again, I was kind of
> expecting a dialog with a "remember this" checkbox.

By the time you get Keychain involved, the decision has been made.
Most applications offer that ability... and you're right, this should
probably offer the same capability.  That also means stashing that
data somewhere. :-(  OTOH, it does make for a better user experience.

[snip]
> I noticed that when using the python helper, the dialog asking someth=
ing
> like: "security wants to know this password. Allow it?"
>
> Which was kind of lame. I would hope we could convince it to say "git=
".
> But I didn't see any option in the "security" tool for specifying the
> context[1]. The C helper says "git-credential-osxkeychain". Which isn=
't
> the end of the world, but it would be prettier if it just said "git".

I'm not sure how easy it is to do that.  I think it's meant to be a
security measure that it points out the executable name... but it does
make it less friendly for users. :-(

> -Peff
>
> [1] I can kind of see why they might not want you to set this for
> security reasons (because it makes impersonating other programs easy)=
=2E
> On the other hand, saying "security" conveys absolutely nothing. And =
as
> far as I can tell, I could just call my program /tmp/iTunes, and it
> would say "iTunes wants to know this password...".

Yep, I agree.  And it's worse when using the security command line
tool... when you grant security access to the key, then any app could
technically gain access to the item via the security tool.  That's one
of the reasons I didn't pursue that route early on.

-John
