From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Thu, 27 Sep 2012 10:35:47 -0700
Message-ID: <CAJo=hJuXCYa=MKSqCRsxmwFdFYZamK_94zc3fE0tmvwUAVA2Ow@mail.gmail.com>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com> <20120927172037.GB1547@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>,
	David Barr <barr@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 19:36:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THI0Z-0003KX-1F
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 19:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab2I0RgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 13:36:09 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:59274 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab2I0RgI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 13:36:08 -0400
Received: by qchd3 with SMTP id d3so1238323qch.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5GQj52hi36pGClqrPfS/Cv5ry0U9G+w2fQt9J6PUsJo=;
        b=XNo8Gpl57jFnXDNxOY0Js4pKaNPBPqS9ZjaFOZYD3nUtypa+d1U7FNvfzTXProxCI/
         0NYFXDBiIkGkbccQ+8ZlMCpaKo8SAGnu+hCaQI3sdZ/KfuUawz8eZe3Oe7Wi6OyOQP93
         3motigDND7nC3NLpbfJnts3SHijzpvdNtQ7xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=5GQj52hi36pGClqrPfS/Cv5ry0U9G+w2fQt9J6PUsJo=;
        b=dTNKXu11HEl6W2PPnB8Y+tX0H1Jc0732c6qyXRs753tjq6G+N2vhmRZavp4tVvqY8e
         yCultWdFi7vHdwJL7cvmB2qY2Xx0F/8owPA8JJJM+Q9h7w4oraW8IUG47DEd+E2mcw/o
         Shf2EF3m8rIYjuIpE2MwceKDXmfxSAbGchth3g8sxwtXVGJN8mT45LZi9RgOHK/g4uFe
         PVd/8J5PxEb68kYiLLvkvR9W25dLd1Mk+mSaDFW3a9ez8764wFshRi4tk0CJG0sy8GuK
         QCtoVVqThF8Kt20vOWPDvG25SXpfS7h/yBl/lmmf7DGzL0I77YEbfYyftI4P0aXdhlOV
         BrQw==
Received: by 10.224.220.84 with SMTP id hx20mr11126078qab.5.1348767367587;
 Thu, 27 Sep 2012 10:36:07 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Thu, 27 Sep 2012 10:35:47 -0700 (PDT)
In-Reply-To: <20120927172037.GB1547@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmjiqCPTgkZSQBpVfAQQ+3HIyWxj3yWmh6+u6i5phmRBcKzkFw8v3WNCXwXYapdIyPLJEWh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206495>

On Thu, Sep 27, 2012 at 10:20 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 27, 2012 at 07:17:42PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> > Operation                   Index V2               Index VE003
>> > Clone                       37530ms (524.06 MiB)     82ms (524.06 MiB)
>> > Fetch (1 commit back)          75ms                 107ms
>> > Fetch (10 commits back)       456ms (269.51 KiB)    341ms (265.19 KiB)
>> > Fetch (100 commits back)      449ms (269.91 KiB)    337ms (267.28 KiB)
>> > Fetch (1000 commits back)    2229ms ( 14.75 MiB)    189ms ( 14.42 MiB)
>> > Fetch (10000 commits back)   2177ms ( 16.30 MiB)    254ms ( 15.88 MiB)
>> > Fetch (100000 commits back) 14340ms (185.83 MiB)   1655ms (189.39 MiB)
>>
>> Beautiful. And curious, why do 100->1000 and 10000->10000 have such
>> big leaps in time (V2)?
>
> Agreed. I'm very excited about these numbers.
>
>> >   Defines the new E003 index format and the bit set
>> >   implementation logic.
>> [...]
>> It seems the bitmap data follows directly after regular index content.
>> I'd like to see some sort of extension mechanism like in
>> $GIT_DIR/index, so that we don't have to increase pack index version
>> often. What I have in mind is optional commit cache to speed up
>> rev-list and merge, which could be stored in pack index too.
>
> As I understand it, both the bitmaps and a commit cache are
> theoretically optional. That is, git can do the job without them, but
> they speed things up.

Yes, entirely true.

> If that is the case, do we need to bump the index
> version at all? Why not store a plain v2 index, and then store an
> additional file "pack-XXX.reachable" that contains the bitmaps and an
> independent version number.

This is the alternate version we considered internally. It was a bit
more work to define a 3rd file stream per pack in our backend storage
system, so we opted for a revision of an existing stream. We could
spend a bit more time and add a 3rd stream, keeping the index format
unmodified.

But we could have also done this with the CRC-32 table in index v2. We
didn't. If the data should almost always be there in order to provide
good service then we should really be embedding into the files.

I'm on the fence. I could go either way on this. E003 was just the
fastest way to prototype and start testing. We would probably be
equally happy with the 3rd stream.

> The sha1 in the filename makes sure that the reachability file is always
> in sync with the actual pack data and index.

Depending on the extension dependencies, you may need to also use the
trailer SHA-1 from the pack file itself, like the index does. E.g. the
bitmap data depends heavily on object order in the pack and is invalid
if you repack with a different ordering algorithm, or a different
delta set of results from delta compression.

>  Old readers won't know
> about the new file, and will ignore it. For new readers, if the file is
> there they can use it; if it's missing (or its version is not
> understood), they can fall back to the regular index.
>
> I haven't looked at the details of the format change yet. If it is
> purely an extra chunk of data at the end, this Just Works.

Yes, its just extra chunk on the end.

> If there are
> changes to the earlier parts of the pack (e.g., I seem to recall the
> commit cache idea wanted separate indices for each object type), we may
> still need a v3. But it would be nice if we could make those changes
> generic (e.g., just the separate indices, which might support many
> different enhancements), and then let the actual feature work happen in
> the separate files.

Yes. One downside is these separate streams aren't removed when you
run git repack. But this could be fixed by  a modification to git
repack to clean up additional extensions with the same pack base name.

>> Definitely :-). I have shown my interest in this topic before. So I
>> should probably say that I'm going to work on this on C Git, but
>> sllloooowwwly. As this benefits the server side greatly, perhaps a
>> GitHubber ;-) might want to work on this on C Git, for GitHub itself
>> of course, and, as a side effect, make the rest of us happy?
>
> Yeah, GitHub is definitely interested in this. I may take a shot at it,
> but I know David Barr (cc'd) is also interested in such things.

Building this in C is also dependent on having a good implementation
of EWAH compressed bitmaps available. So its a bit more work, but not
insurmountable by any means.
