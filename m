From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Suggestion on hashing
Date: Fri, 2 Dec 2011 21:22:31 +0700
Message-ID: <CACsJy8CO1GtpZVo-oA2eKbQadsXYBEKVLfUH0GONR5jovuvH+Q@mail.gmail.com>
References: <1322813319.4340.109.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Bill Zaumen <bill.zaumen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 15:26:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWU3v-0007rS-Io
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 15:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707Ab1LBOXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Dec 2011 09:23:05 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54047 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab1LBOXD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2011 09:23:03 -0500
Received: by bkas6 with SMTP id s6so3908634bka.19
        for <git@vger.kernel.org>; Fri, 02 Dec 2011 06:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=r6A0WtlwiCsApzHZknw14ikjOnA6bRL0TfYFcjXGYzo=;
        b=VjSASqIJR/4Lu26cBZNFQsVRLPmA1h3jsObCaN9T00RMzp99ECOLXrIwOOOGCAnQg/
         jjDJtHMxqbkAQIw1NkwapDOkjAjyNW1UCHVU0jj3thfEImToWePFtUVSK6VRncMl7R04
         nOuqvgafHeIRGtWuX4DBC838kk+QbF97YgurU=
Received: by 10.204.9.211 with SMTP id m19mr10823589bkm.92.1322835782386; Fri,
 02 Dec 2011 06:23:02 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Fri, 2 Dec 2011 06:22:31 -0800 (PST)
In-Reply-To: <1322813319.4340.109.camel@yos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186219>

(I'm not sure why you dropped git@vger. I see nothing private here so
I bring git@vger back)

On Fri, Dec 2, 2011 at 3:08 PM, Bill Zaumen <bill.zaumen@gmail.com> wro=
te:
> At one point Nguyen said that "What I'm thinking is whether it's
> possible to decouple two sha-1 roles in git, as object identifier
> and digest, separately. Each sha-1 identifies an object and an extra
> set of digests on the "same" object."
>
> My code pretty much does that (it just uses a CRC instead of a real
> digest, but I can easily change that).

It'd be easier to look at your code if you split it into a series of
smaller patches.

> So the question is whether
> using SHA-1 as an ID and SHA-256(?) as a digest is a better long term
> solution than simply replacing SHA-1.

I would not stick with any algorithm permanently. No one knows when
SHA-256 might be broken.

> If there is some interest in pursuing it further, I could make those
> changes fairly easily. =C2=A0Then you'd have two message digests, a S=
HA-1
> and a longer one, with the longer one stored parallel to the actual
> object. Then it becomes easy to compute a digest of all the digests
> in a commit's tree and store that in a commit, if that is what you
> want to do.

I personally would like to see how it works out especially when
computing new digests is much more expensive than SHA-1. And I hope
that by delaying computing new digests (stored outside actual
objects), we could make minimum code changes to git. Though security
concerns may be the killer factor and I haven't worked that out yet.

> Replacing SHA-1 with something like SHA-256 sounds easier to implemen=
t,

SHA-1 charateristics (like 20 byte length) are hard coded everywhere
in git, it'd be a big audit.

> but the problem is all the existing repositories. =C2=A0While rewriti=
ng all
> the objects and trees to use new hashes is similar to a rebase in mos=
t
> cases, there is a complication - submodules. =C2=A0Git stores the has=
h of
> a submodule's commit in its tree because a particular revision of
> a project 'goes' with a particular revision of a submodule. But, a
> submodule can exist in one revision and not in the next or previous
> revision =C2=A0Furthermore A could be a submodule of B at one point i=
n time,
> and many commits later, B could end up being a submodule of A.
> Fixing it up could be pretty complicated (plus having to deal with
> network failures - to update GitHub for example, you'd have to downlo=
ad
> submodules it uses, possibly from somewhere else and some submodules =
may
> not be publicly accessible (e.g., a private project kept on GitHub bu=
t
> with a critical submodule kept in house behind a corporate firewall).
> Also, you might have to update a git repository and its submodules
> concurrently, so that you always can find a new value when you need
> it.
>
> My guess is that this could be far more complicated than what I did.
> Excluding two files that are not used (the symbol PACKDB is not
> defined), I added two new files, crcdb.h and objd-crcdb.c which store
> CRCs for loose objects - 517 lines total including lots of comments i=
n
> the header file - full documentation for each function. =C2=A0The oth=
er
> changes include 1475 lines of new code in previously existing git fil=
es
> and 136 deletions (most trivial). =C2=A0There were also minor changes=
 to
> the makefile and test scripts.

You'd need to convince git maintainer this is worth doing first,
before talking how big the changes are ;-)

> Bill
--=20
Duy
