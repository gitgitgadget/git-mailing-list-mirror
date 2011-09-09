From: John Szakmeister <john@szakmeister.net>
Subject: Re: git credential helper design [was: What's cooking in git.git (Aug
 2011, #07; Wed, 24)]
Date: Fri, 9 Sep 2011 05:55:38 -0400
Message-ID: <CAEBDL5XnoCtiKQB8jRxvueWc9zy-yzC+MxgTLmP1amY+U=7aOw@mail.gmail.com>
References: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
	<20110825202057.GB6165@sigill.intra.peff.net>
	<7vhb55i11i.fsf@alter.siamese.dyndns.org>
	<20110831023801.GB3340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Lukas_Sandstr=C3=B6m?= <luksan@gmail.com>,
	Ted Zlatanov <tzz@lifelogs.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 11:55:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1xoI-0005aZ-3q
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 11:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933249Ab1IIJzk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 05:55:40 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:39320 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933080Ab1IIJzj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 05:55:39 -0400
Received: by vws10 with SMTP id 10so1180317vws.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4/CqU+g/S2gYbU/3fNd8JpDZ+RALWPLXfVDV4rlnNtg=;
        b=eeud6g7ha+9IEQY8m9HLA0FR7yF637u7ZMdYdzgfQfCHONuFvV8pb7MHxTZXQX6fwh
         O2rX7qMPZX+pYJMTe17IMxQ/QYeUnPNbkRoDzQbIpObQyc82a6Fm3jamEcXWeEvCItiM
         WY4Is3/ObLw//f99LhaO9/v6fzRpQsN14xchI=
Received: by 10.52.96.168 with SMTP id dt8mr276189vdb.57.1315562138240; Fri,
 09 Sep 2011 02:55:38 -0700 (PDT)
Received: by 10.52.160.196 with HTTP; Fri, 9 Sep 2011 02:55:38 -0700 (PDT)
In-Reply-To: <20110831023801.GB3340@sigill.intra.peff.net>
X-Google-Sender-Auth: fTUwy8dcZWOwFg1k74FJFOiHo_k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181040>

On Tue, Aug 30, 2011 at 10:38 PM, Jeff King <peff@peff.net> wrote:
[snip]
> It's "http:github.com", which has always looked a bit ugly to me. I h=
ad
> hoped they would just be opaque blobs and nobody would need to look a=
t
> them. But when you get into things like setting the username via the
> config, then users see them, and they need to look sane. Making them
> look more like a canonicalized URL is probably a good thing.

A little feedback here: I do look into my keychain on Mac OS X.  I
tend to keep most of my credentials in a separate keychain that gets
whenever my computer sleeps or the screen saver kicks on.  So that
blob ends up being user-visible to some degree.  Could I munge it into
something else?  Sure.  But I do wonder if it might be better to make
it something closer to what the user expects to see.

> After seeing the helper that Lukas posted recently on the list, I am
> wondering if they should include the username, too. I had left it
> separate, because I wanted helpers to be able to index "foo@example.c=
om"
> and "example.com" in the same slot. I.e., to realize that the latter
> could use the same credentials cached for the former. But it also
> complicates the helpers; instead of doing:

Having the username separate is useful.  At least under Mac OS X, the
"account name" field is a separate search field.  It does make it
easier to fallback to just looking at the domain and path without
having to parse the unique token.  But as it is, we stand a chance at
being able to reuse credentials already cached by the browser.

> =C2=A0credential =3D secure_storage_lookup(unique_token);
> =C2=A0return credential /* could be NULL */
>
> they have to do:
>
> =C2=A0for credential in secure_storage_lookup(unique_token) {
> =C2=A0 =C2=A0if (!username)
> =C2=A0 =C2=A0 =C2=A0return credential; /* take first one arbitrarily =
*/
> =C2=A0 =C2=A0else if (username =3D=3D credential.username)
> =C2=A0 =C2=A0 =C2=A0return credential; /* ok, matched preferred usern=
ame */
> =C2=A0}
> =C2=A0return NULL;
>
> which implies that the secure storage can even store a list indexed
> under the token.
>
> So perhaps a better model is to give the helper some canonicalized UR=
L,
> like:
>
> =C2=A0https://foo@example.com
>
> (where the canonicalization is important, because we want the helper =
to
> be able to just treat it like a string of bytes if it wants). =C2=A0A=
nd then
> we can naturally extend that to:
>
> =C2=A0https://foo@example.com/specific-repo.git
>
> if the user wants a repo-specific authentication context.

Or pass that the information via --domain and --path parameters.  It'd
be nice to keep most credential backends from having to parse urls.
Not that its hard, just cumbersome.  But the keychain implementation
and the gnome-keyring implementation could both benefit from having
the pieces broken out separately.  Likewise, it's probably not
difficult to parse it out of the token if we needed to.

[snip good discussion]

One thing that crossed my mind while looking at this: what happens
when a command is meant to be non-interactive?  Looking at the
kdewallet implementation, it appears that not only is the credential
helper intended to help do the lookup, but also ask the user for a
password, if it doesn't find anything.  That doesn't seem like it
would play well in a non-interactive environment.  Additionally, the
act of looking up the entry could pop up a dialog in most
keychain-like applications.  Is there a need to be sensitive to the
fact that we may be run non-interactively?

-John
