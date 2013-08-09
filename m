From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Fri, 9 Aug 2013 19:04:23 +0530
Message-ID: <CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
 <CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
 <7v61vihg6k.fsf@alter.siamese.dyndns.org> <CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
 <7va9ksbqpl.fsf@alter.siamese.dyndns.org> <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org> <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org> <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
 <20130809110000.GD18878@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 09 15:35:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7mqV-0006oW-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 15:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967839Ab3HINfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 09:35:05 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:41495 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966148Ab3HINfD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 09:35:03 -0400
Received: by mail-ie0-f180.google.com with SMTP id aq17so4099860iec.11
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 06:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zEJQn7Q7udjd8CldupQfrbiRQJC+HjgNgT57zmGsxog=;
        b=jDRhfuDzdTR5ObpaC60b/yNCEU805vJSQ5exfOjVyijgW9fNwL3Xn1wb8hLtEg9BM8
         5Du9sVFU9fgtN0j46RxI+LXnjOvVLi84OMB5qXgBqeg87Y7l1UoUcaPGX9d+SNJYkxuM
         9k+hvGtYZG7VhFSNo5llHLDcXKGzoUpY2JQm4z8H2GIF2bJgu0QvUO5OQ8wLxPCu2jAC
         Ct2mweLrcqKHRUa7XDp4nkzsj4YefDVzskhAeUprCA7vH5Ltq1RbWgPMGoc89y6HO3ni
         O9TcsIRXpBgP5tANAzwPoq4sfB5T1rFvMIkXXvXQ/ZfFgsvBKYkmgcYxrCfxxEOZzMAV
         Hg3g==
X-Received: by 10.50.6.16 with SMTP id w16mr2186353igw.29.1376055303157; Fri,
 09 Aug 2013 06:35:03 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 9 Aug 2013 06:34:23 -0700 (PDT)
In-Reply-To: <20130809110000.GD18878@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231982>

Jeff King wrote:
> It depends on what each side has it, doesn't it? We generally try to
> reuse on-disk deltas when we can, since they require no computation. If
> I have object A delta'd against B, and I know that the other side wants
> A and has B (or I am also sending B), I can simply send what I have on
> disk. So we do not just blit out the existing pack as-is, but we may
> reuse portions of it as appropriate.

I'll raise some (hopefully interesting) points. Let's take the example
of a simple push: I start send-pack, which in turn starts receive_pack
on the server and connects its stdin/stdout to it (using git_connect).
Now, it reads the (sha1, ref) pairs it receives on stdin and spawns
pack-objects --stdout with the right arguments as the response, right?
Overall, nothing special: just pack-objects invoked with specific
arguments.

How does pack-objects work? ll_find_deltas() spawns some worker
threads to find_deltas(). This is where this get fuzzy for me: it
calls try_delta() in a nested loop, trying to find the smallest delta,
right? I'm not sure whether the interfaces it uses to read objects
differentiates between packed deltas versus packed undeltified objects
versus loose objects at all.

Now, the main problem I see is that a pack has to be self-contained: I
can't have an object "bar" which is a delta against an object that is
not present in the pack, right? Therefore no matter what the server
already has, I have to prepare deltas only against the data that I'm
sending across.

> Of course we may have to reconstruct deltas for trees in order to find
> the correct set of objects (i.e., the history traversal). But that is a
> separate phase from generating the pack's object content, and we do not
> reuse any of the traversal work in later phases.

I see. Are we talking about tree-walk.c here? This is not unique to
packing at all; we need to do this kind of traversal for any git
operation that digs into older history, no? I recall a discussion
about using generation numbers to speed up the walk: I tried playing
with your series (where you use a cache to keep the generation
numbers), but got nowhere. Does it make sense to think about speeding
up the walk (how?).
