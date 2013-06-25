From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Wed, 26 Jun 2013 00:08:20 +0200
Message-ID: <CAFFjANRqZ0U5tGhgjACUtquyVKCyuHiS3CC2Xxwo0J1UJVrf=g@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-10-git-send-email-tanoku@gmail.com> <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
 <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com> <7vtxkl28m7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Colby Ranger <cranger@google.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 00:08:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrbPp-0007VB-As
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 00:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789Ab3FYWIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 18:08:41 -0400
Received: from mail-vb0-f49.google.com ([209.85.212.49]:34130 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab3FYWIl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 18:08:41 -0400
Received: by mail-vb0-f49.google.com with SMTP id 12so9916827vbf.22
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 15:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3h4qE56Q9xE1Ygd+frJwvWGvC/1hckp5GiLr7rLrr0o=;
        b=RbsRTVmEiLsHk6MVfSy1kQVNp3kkWDk8MO733UAgiOsElpyVmiHptqGFHekr9XxNKq
         chM/vvB148h2s5CQO0JTKqxB3E4oR0VxSsvVJ2NCaIB2HKy6woA0sZoWuh/T2x++Qh2i
         7a6Uk/hC/RdPgfpP20Dv54loJ2sPL9CNngjUJofPI4mwBGSNrVx/URmp/dcbgnBHAMs5
         xPgesGLmh6CTJ5aTK+h8nG+RVKuMFON1h13aG+0TqvP89mU9WANTUpuBaDXNveo4+CnK
         voL1Fg9AK9SS1kaDH9z5lY8/l+y0/hlpKXu3ksRxuNN0qC54JLiDiqwbMUn1qvHp/2PR
         lbfQ==
X-Received: by 10.58.255.229 with SMTP id at5mr616670ved.44.1372198120501;
 Tue, 25 Jun 2013 15:08:40 -0700 (PDT)
Received: by 10.221.45.131 with HTTP; Tue, 25 Jun 2013 15:08:20 -0700 (PDT)
In-Reply-To: <7vtxkl28m7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229005>

On Tue, Jun 25, 2013 at 11:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> What case are you talking about?
>
> The n-th object must be one of these four types and can never be of
> more than one type at the same time, so a natural expectation from
> the reader is "If you OR them together, you will get the same set".
> If you say "If you XOR them", that forces the reader to wonder when
> these bitmaps ever can overlap at the same bit position.

I guess this is just wording. I don't particularly care about the
distinction, but I'll change it to OR.

>
>> To sum it up: I'd like to see this format be strictly in Network Byte
>> Order,
>
> Good.
>
> I've been wondering what you meant by "cannot be mmap-ed" from the
> very beginning.  We mmapped the index for a long time, and it is
> defined in terms of network byte order.  Of course, pack .idx files
> are in network byte order, too, and we mmap them without problems.
> It seems that it primarily came from your fear that using network
> byte order may be unnecessarily hard to perform well, and it would
> be a good thing to do to try to do so first instead of punting from
> the beginning.

It cannot be mmapped not particularly because of endianness issues,
but because the original format is not indexed and requires a full
parse of the whole index before it can be accessed programatically.
The wrong endianness just increases the parse time.

>
>> and I'm going to try to make it run fast enough in that
>> encoding.
>
> Hmph.  Is it an option to start from what JGit does, so that people
> can use both JGit and your code on the same repository?  And then if
> you do not succeed, after trying to optimize in-core processing
> using that on-disk format to make it fast enough, start thinking
> about tweaking the on-disk format?

I'm afraid this is not an option. I have an old patchset that
implements JGit v1 bitmap loading (and in fact that's how I initially
developed these series -- by loading the bitmaps from JGit for
debugging), but I discarded it because it simply doesn't pan out in
production. ~3 seconds time to spawn `upload-pack` is not an option
for us. I did not develop a tweaked on-disk format out of boredom.

I could dig up the patch if you're particularly interested in
backwards compatibility, but since it was several times slower than
the current iteration, I have no interest (time, actually) to maintain
it, brush it up, and so on. I have already offered myself to port the
v2 format to JGit as soon as it's settled. It sounds like a better
investment of all our times.

Following up on Shawn's comments, I removed the little-endian support
from the on-disk format and implemented lazy loading of the bitmaps to
make up for it. The result is decent (slowed down from 250ms to 300ms)
and it lets us keep the whole format as NWO on disk. I think it's a
good tradeback.

The relevant commits are available on my fork of Git (I'll be sending
v2 of the patchset once I finish tackling the other reviews):

    https://github.com/vmg/git/commit/d6cdd4329a547580bbc0143764c726c48b887271
    https://github.com/vmg/git/commit/d8ec342fee87425e05c0db1e1630db8424612c71

As it stands right now, the only two changes from v1 of the on-disk format are:

- There is an index at the end. This is a good idea.
- The bitmaps are sorted in packfile-index order, not in packfile
order. This is a good idea.

As always, all your feedback is appreciated, but please keep in mind I
have strict performance concerns.

German kisses,
vmg
