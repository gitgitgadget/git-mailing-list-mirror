From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Wed, 26 Jun 2013 00:30:06 +0200
Message-ID: <CAFFjANQ_PoTT5bUrZ_0oARz=oZysJdMC1MAsHR2MCZVubfSbsw@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-10-git-send-email-tanoku@gmail.com> <87y59xlvt7.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 26 00:30:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrblB-0007ay-FI
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 00:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab3FYWaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 18:30:39 -0400
Received: from mail-vb0-f54.google.com ([209.85.212.54]:38836 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab3FYWa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 18:30:27 -0400
Received: by mail-vb0-f54.google.com with SMTP id q12so10076614vbe.27
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ra1tXJeYZh2GpqQcDO0oQev4VBOPbnY2k1PZCNTM5Os=;
        b=Ae9xMLJ5M06iWfRJP6HqPCN36K+Q0Jr3h9kSE4sDC1cliHtwY9b0OjlV08gjRaZsd3
         dhaoXYrzheyewnHkHS5PCMqvVPZhYO4tarsluSl1dkN9ZH/QypFjeBR4Lu8DvTkhZvUP
         178pD8E80O7MoIwRzqgl+n9QQs45Mb+3dG7MVxYPLXyp7VcK2zcCJmrvGuKidiNslqfC
         wwFammKsqx9M7E6fSNtVckGeFzFOQKYhuF+GEHkAin4KlpBAojoT6p7FAJEAmlOZOeW+
         dNU5xd7Fa6AuP4EkVtUYsfeo4C5DAJmG0G3BrB75CWu9JIuXWbRCuRLw0f8MDyPZ1buc
         cV3Q==
X-Received: by 10.58.230.135 with SMTP id sy7mr670040vec.42.1372199426322;
 Tue, 25 Jun 2013 15:30:26 -0700 (PDT)
Received: by 10.221.45.131 with HTTP; Tue, 25 Jun 2013 15:30:06 -0700 (PDT)
In-Reply-To: <87y59xlvt7.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229008>

On Tue, Jun 25, 2013 at 5:58 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>
>> This is the technical documentation and design rationale for the new
>> Bitmap v2 on-disk format.
>
> Hrmpf, that's what I get for reading the series in order...
>
>> +                     The folowing flags are supported:
>                               ^^
>
> typos marked by ^
>
>> +             By storing all the hashes in a cache together with the bitmapsin
>                                                                              ^^
>
>> +             The obvious consequence is that the XOR of all 4 bitmaps will result
>> +             in a full set (all bits sets), and the AND of all 4 bitmaps will
>                                            ^
>
>> +             - 1-byte XOR-offset
>> +                     The xor offset used to compress this bitmap. For an entry
>> +                     in position `x`, a XOR offset of `y` means that the actual
>> +                     bitmap representing for this commit is composed by XORing the
>> +                     bitmap for this entry with the bitmap in entry `x-y` (i.e.
>> +                     the bitmap `y` entries before this one).
>> +
>> +                     Note that this compression can be recursive. In order to
>> +                     XOR this entry with a previous one, the previous entry needs
>> +                     to be decompressed first, and so on.
>> +
>> +                     The hard-limit for this offset is 160 (an entry can only be
>> +                     xor'ed against one of the 160 entries preceding it). This
>> +                     number is always positivea, and hence entries are always xor'ed
>                                                  ^
>
>> +                     with **previous** bitmaps, not bitmaps that will come afterwards
>> +                     in the index.
>
> Clever.  Why 160 though?

JGit implementation detail. It's the equivalent of the delta-window in
`pack-objects` for example.

HINT HINT: in practice, JGit only looks 16 positions behind to find
deltas, and we do the same. So the practical limit is 16. harhar

>
>> +             - 2 bytes of RESERVED data (used right now for better packing).
>
> What do they mean?
>
>> +  With an index at the end of the file, we can load only this index in memory,
>> +  allowing for very efficient access to all the available bitmaps lazily (we
>> +  have their offsets in the mmaped file).
>
> Is there anything preventing you from mmap()ing the index also?

Yeah, this format allows you to easily do a SHA1 bsearch with custom
step to lookup entries on the bitmap index, except for the fact that
the index is not sorted by SHA1, so you'd need a linear search
instead. :)

I decided against it because during most complex invocations of
`pack-objects`, we perform a couple thousand commit lookups to see if
they have a bitmap in the index, so it makes a lot of sense to load
the index tightly in a hash table before hand (which takes very little
time, to be fair). We more-than-make up for the loading time by having
much much faster lookups. I felt it was the right tradeoff (JGit does
the same, but in their case, because they cannot mmap. :p)

>> +== Appendix A: Serialization format for an EWAH bitmap
>> +
>> +Ewah bitmaps are serialized in the protocol as the JAVAEWAH
>> +library, making them backwards compatible with the JGit
>> +implementation:
>> +
>> +     - 4-byte number of bits of the resulting UNCOMPRESSED bitmap
>> +
>> +     - 4-byte number of words of the COMPRESSED bitmap, when stored
>> +
>> +     - N x 8-byte words, as specified by the previous field
>> +
>> +             This is the actual content of the compressed bitmap.
>> +
>> +     - 4-byte position of the current RLW for the compressed
>> +             bitmap
>> +
>> +Note that the byte order for this serialization is not defined by
>> +default. The byte order for all the content in a serialized EWAH
>> +bitmap can be known by the byte order flags in the header of the
>> +bitmap index file.
>
> Please document the RLW format here.

Har har. I was going to comment on your review of the Ewah patchset,
but might as well do it here: the only thing I know about Ewah bitmaps
is that they work. And I know this because I did extensive fuzz
testing of my C port. Unfortunately, the original Java code I ported
from has 0 comments, so any documentation here would have to be
reverse-engineered.

Personally, I'd lean towards considering Ewah an external dependency
(black box); the headers for the library are commented accordingly,
clearly explaining the interfaces while hiding implementation details.
Of course, you're welcome to help me reverse engineer the
implementation, but I'm not sure this would be of much value. It'd be
better to make sure it passes the extensive test suite of the Java
version, and assume that Mr Lemire designed a sound format for the
bitmaps.

Swiss kisses,
vmg
