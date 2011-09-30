From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's keychain
Date: Fri, 30 Sep 2011 18:42:22 -0400
Message-ID: <CAG+J_Dww1yOeq1LHQYMiObPKqrWbk4t8Hn=G9WpYWXFBbHiuhQ@mail.gmail.com>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
	<20110929075627.GB14022@sigill.intra.peff.net>
	<CAG+J_DwntGc+j3duCVqsnoJGV18FqnwXJ99C1XqKope_zbGHAA@mail.gmail.com>
	<20110930221111.GB9384@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 01 00:42:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9lmm-0003Rh-6t
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 00:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab1I3WmY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 18:42:24 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46807 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab1I3WmX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 18:42:23 -0400
Received: by ywb5 with SMTP id 5so1912286ywb.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 15:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VRmw7znxeobuZn11vdT4xlbMlr1RYzznam4zrj8ADD4=;
        b=kvfMPmzGHCCkSGdAQJSnDfi5VxPVh33MT5GaGLGWJ8HUukD9xxPsXESzYRkheODoUh
         IN6sTuk+cg9EyM3zXHWKJAZz7E6vq23KGEtjGe2Ute0mNx/0h2dpsSNAbJoGPtznXfBu
         6aB2f8LYsNH2agEVFPdEFs88je9I+T8YLTpAI=
Received: by 10.236.155.1 with SMTP id i1mr57927668yhk.8.1317422542248; Fri,
 30 Sep 2011 15:42:22 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 30 Sep 2011 15:42:22 -0700 (PDT)
In-Reply-To: <20110930221111.GB9384@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182521>

On Fri, Sep 30, 2011 at 6:11 PM, Jeff King <peff@peff.net> wrote:
> Because security prompts sometimes are out of band. In particular,
> you're already interacting with the user outside of the terminal;
> opening the keychain will get you an "allow git to open the keychain"
> dialog.

Usually it won't. In the default case, the keychain is unlocked and no
permission is needed to add an entry, nor to retrieve that entry by
the application which added it. The prompt will only occur if the
credential helper is not on the entry's ACL, or if the keychain is
locked.

> Another example: if you're running gpg-agent, and you run "git tag -s=
",
> you'll be prompted for your key passphrase in an out-of-band dialog.
>
> Maybe it doesn't make sense for the actual username/password, though.

Personally, it made sense to me do it at the CLI (obviously). But the
source code in in contrib now. :-)

> I meant running sshd on OS X, and then ssh-ing in from some other box=
=2E
> Your credential helper doesn't seem to work at all (I guess because i=
t
> has no access to the keychains). I don't think it's a big deal, thoug=
h.
> It's the minority case, and if somebody wants to figure out how to ma=
ke
> it work later, they can.

As far as I know there's no way to make this work. When you login over
ssh, it's a different security context, and there is no access to the
password field of keychain entries.

>> I found it ugly that git's native getpass doesn't echo the username
>> back, and it seems hackish to me for the credential helper to turn
>> back around and invoke it in any case. :-(
>
> Yes, but I think that's a bug that should be fixed in git. :)

Yes it should. :-)

> As far as being hack-ish, the original design was that you could chai=
n
> these things if you wanted. But in practice, I don't know how useful
> that is. In fact, after all of this discussion, I'm wondering how use=
ful
> it is that the helpers are allowed to prompt themselves at all.
>
> The KDE one does it. But would people be happier if git simply did:
>
> =C2=A01. ask the helper for a credential. if we get it, done
>
> =C2=A02. prompt the user
>
> =C2=A03. if the credential is valid, ask the helper to store
>
> That's way less flexible. But it also makes the helpers really simple=
=2E

I think that actually makes more sense. There's already an existing
mechanism to customized (2) via GIT_ASKPASS, right? So it overlaps for
the credential helper to do that doesn't it?

> Because the helper might have an alternate way of asking for the
> password (e.g., the KDE helper has its own dialog). Maybe it will nev=
er
> be useful. I just wanted to future-proof helpers by giving them sane
> behavior for this case, on the off chance that future versions of git=
 do
> actually do this.
>>
> Don't get me wrong; I think you did the only sane thing. It was more
> "Hmm, I was hoping that the right way to use the various security API=
s
> wouldn't need to...". And clearly my hope was wrong. :)
>
> But this is exactly the sort of feedback I was hoping for; the interf=
ace
> to the helpers could be better, and we are catching it now.

Okay, the more I think about this, the more I think the existing
design is both too much (asking the credential helper to do anything
other than store/retrieve passwords) and too little (not breaking out
the fields distinctly).

> That's not an unreasonable attitude. I mostly let the browser store
> passwords, but sometimes override it for specific sites. But in this
> case, I think it would be more per-repo. And you can turn off the hel=
per
> for a particular repo (actually, I'm not sure you can, but you probab=
ly
> should be able to).

If the credential helper becomes no more than a store/retrieve, it's
git that would do the prompting "Store credentials via
git-osxkeychain?" after logging in successfully with the credentials.

>> It is for security reasons. 99% of users will probably just click

> Anyway, that's neither here nor there. It would be nice if we could s=
et
> the text, but if we can't, then we'll have to live with it.

The C version of the helper will use the name of the helper binary.

j.
