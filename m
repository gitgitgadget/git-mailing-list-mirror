From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 0/4] Honor core.ignorecase for attribute patterns
Date: Thu, 15 Sep 2011 15:28:33 -0500
Message-ID: <CA+sFfMeLgdmUHq6YTymkC2bpMEGScQuwJ1SgyR0GGFjo-Gt=4g@mail.gmail.com>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
	<1316051979-19671-1-git-send-email-drafnel@gmail.com>
	<20110915181258.GA1227@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
	bharrosh@panasas.com, trast@student.ethz.ch, zapped@mail.ru
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 15 22:28:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4IY3-0003qB-N2
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 22:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934754Ab1IOU2f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 16:28:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63287 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934640Ab1IOU2e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 16:28:34 -0400
Received: by fxe4 with SMTP id 4so979517fxe.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/Fm/Qv2ubtsVVpz2eqHaty5TEftj8GFDjpxeLpDY1GI=;
        b=F8EG1NyHuf4gQFl4huhHUash/FWoIfW2pQfwSG+u0jQmTgifr+/gkooCx+D6jpSDVo
         BqZRyRrl8ih7wMGjNshjz3cGlBGpsdH9op0UJR4oEoI5XrlbMxALGY6eiMCgaaZC/nOo
         M+e+e1JOE8rWXDm+1D5xukUQD2RcclTAn9Zs8=
Received: by 10.223.63.8 with SMTP id z8mr396337fah.84.1316118513532; Thu, 15
 Sep 2011 13:28:33 -0700 (PDT)
Received: by 10.152.8.227 with HTTP; Thu, 15 Sep 2011 13:28:33 -0700 (PDT)
In-Reply-To: <20110915181258.GA1227@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181491>

On Thu, Sep 15, 2011 at 1:12 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 14, 2011 at 08:59:35PM -0500, Brandon Casey wrote:
>
>> > I haven't even tested that it runs. :) =C2=A0No, I was hoping some=
one
>> > who was more interested would finish it, and maybe even test on
>> > an affected system.
>>
>> Ok, I lied. =C2=A0Here's a series that needs testing by people on a
>> case-insensitive filesystem and some comments.
>
> Thanks. I was trying to decide if I was interested enough to work on =
it,
> but procrastination wins again.
>
> I'm not sure I understand why you need a case-insensitive file system
> for the final set of tests. If we have a case-sensitive system, we ca=
n
> force the filesystem to show us whatever cases we want, and check
> against them with both core.ignorecase off and on[1]. What are these
> tests checking that requires the actual behavior of a case-insensitiv=
e
> filesystem?

This is probably way more detail than this feature deserves, but...

Those tests are making sure that git handles the case where the
=2Egitignore file resides in a subdirectory and the user supplies a pat=
h
that does not match the case in the filesystem.  In that
case^H^H^H^Hsituation, part of the path supplied by the user is
effectively interpreted case-insensitively, and part of it is
dependent on the setting of core.ignorecase.  git should only be
matching the portion of the path below the directory holding the
=2Egitignore file according to the setting of core.ignorecase.

Imagine a hierarchy that looks like this:

   .gitattributes
   a/.gitattributes

On a case-insensitive filesystem, if you supply the path A/B,
regardless of whether ignorecase is true or false, git will read the
a/.gitattributes file and use it.

Then if you have:

   $ cat a/.gitattributes
   b/c test=3Da/b/c

then you should get the following results:

   # the case of a/ does not affect the attr check
   $ git -c core.ignorecase=3D0 check-attr a/b/c
   a/b/c: test: a/b/c
   $ git -c core.ignorecase=3D0 check-attr A/b/c
   A/b/c: test: a/b/c
   $ git -c core.ignorecase=3D0 check-attr a/B/c
   a/B/c: test: unspecified
   $ git -c core.ignorecase=3D1 check-attr a/B/c
   a/B/c: test: a/b/c
   $ git -c core.ignorecase=3D0 check-attr A/B/c
   A/B/c: test: unspecified
   $ git -c core.ignorecase=3D1 check-attr A/B/c
   A/B/c: test: a/b/c
   etc.

On a case-sensitive filesystem, a/.gitattributes would never be read
if A/b/c was supplied, regardless of core.ignorecase.

This is also partly future-proofing.  Currently, git builds the attr
stack based on the path supplied by the user, so we don't have to do
anything special (like use strcmp_icase) to handle the parts of that
path that don't match the filesystem with respect to case.  If git
instead built the attr stack by scanning the repository, then the
paths in the origin field would not necessarily match the paths
supplied by the user.  If someone makes a change like that in the
future, these tests will notice.

> I'm sure there is something subtle that I'm missing. Can you explain =
it
> either here or in the commit message?

Yeah, that commit message was really just a place-holder.  I meant to
add WIP in the subject field of the last patch too.  I'll try to
explain some of the above when I reroll.

-Brandon
