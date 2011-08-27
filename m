From: Michael Witten <mfwitten@gmail.com>
Subject: Re: git for game development?
Date: Sat, 27 Aug 2011 15:32:29 +0000
Message-ID: <CAMOZ1BsiFdSwhi2xMx7_-hsKYccUTf09W-4UpK8CwQjqY4cpig@mail.gmail.com>
References: <416D1A48-9916-4E44-A200-3A13C39C4D70@gmail.com>
 <20110824012418.GA19091@sigill.intra.peff.net> <7vwre2pw3m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
	Lawrence Brett <lcbrett@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 17:33:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxKsn-0008JV-Nj
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 17:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab1H0PdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 11:33:04 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64106 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab1H0PdA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 11:33:00 -0400
Received: by ywf7 with SMTP id 7so3637478ywf.19
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9gw6l06J8lxDqeF2Ft7QQ+6CMSwxMBbPGvt1rjr657o=;
        b=PDjDE8LIpN7tmlGilPLd45ri9miAS7exaCrEOE67pamZ7Wv0xOhn1VoC1iWoBOj9sS
         x5uzsgfwMAgGPavrqU+BDiG+z/C/PNUb1J1qJ5dT3PmpyVSS+myMeOw0lt6oiWCApKat
         iIA8O0BLcIKwDwjtCzGa7GtzrM2wKMJYv7rX0=
Received: by 10.42.158.7 with SMTP id f7mr2429707icx.89.1314459179073; Sat, 27
 Aug 2011 08:32:59 -0700 (PDT)
Received: by 10.42.138.66 with HTTP; Sat, 27 Aug 2011 08:32:29 -0700 (PDT)
In-Reply-To: <7vwre2pw3m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180232>

On Wed, Aug 24, 2011 at 17:17, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I don't remember all of the details of bup, but if it's possible to
>> implement something similar at a lower level (i.e., at the layer of
>> packfiles or object storage), then it can be a purely local thing, and
>> the compatibility issues can go away.
>
> I tend to agree, and we might be closer than we realize.
>
> I suspect that people with large binary assets were scared away by rumors
> they heard second-hand, based on bad experiences other people had before
> any of the recent efforts made in various "large Git" topics, and they
> themselves haven't tried recent versions of Git enough to be able to tell
> what the remaining pain points are. I wouldn't be surprised if none of the
> core Git people tried shoving huge binary assets in test repositories with
> recent versions of Git---I certainly haven't.
>
> We used to always map the blob data as a whole for anything we do, but
> these days, with changes like your abb371a (diff: don't retrieve binary
> blobs for diffstat, 2011-02-19) and my recent "send large blob straight to
> a new pack" and "stream large data out to the working tree without holding
> everything in core while checking out" topics, I suspect that the support
> for local usage of large blobs might be sufficiently better than the old
> days. Git might even be usable locally without anything else, which I find
> implausible, but I wouldn't be surprised if there remained only a handful
> minor things remaining that we need to add to make it usable.
>
> People toyed around with ideas to have a separate object store
> representation for large and possibly incompressible blobs (a possible
> complaint being that it is pointless to send them even to its own
> packfile). One possible implementation would be to add a new huge
> hierarchy under $GIT_DIR/objects/, compute the object name exactly the
> same way for huge blobs as we normally would (i.e. hash concatenation of
> object header and then contents) to decide which subdirectory under the
> "huge" hierarchy to store the data (huge/[0-9a-f]{2}/[0-9a-f]{38}/ like we
> do for loose objects, or perhaps huge/[0-9a-f]{40}/ expecting that there
> won't be very many). The data can be stored unmodified as a file in that
> directory, with type stored in a separate file---that way, we won't have
> to compress, but we just copy. You still need to hash it at least once to
> come up with the object name, but that is what gives us integrity checks,
> is unavoidable and is not going to change.
>
> The sha1_object_info() layer can learn to return the type and size from
> such a representation, and you can further tweak the same places as the
> "streaming checkout" and the "checkin to a pack" topics touched to support
> such a representation.
>
> I would suspect that the local object representation is _not_ the largest
> pain point; such a separate object store representation is not buying us
> very much over a simpler "single large blob in a separate packfile", and
> if the counter-argument is "no, decompressing still costs a lot", then the
> real issue might be we decompress and look at the data when we do not have
> to (i.e. issues similar to what abb371a addressed), not "decompress vs
> straight copy make a bit difference".

I've added Avery to the Cc list, because he really needs to chime in here.

I am completely unqualified to make a comment about this, but I think
that it would be silly to ignore the insights that Avery has about
storing large objects; `bup' uses rolling checksums and a `bloom
filter' implementation and who knows what else.
