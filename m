From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Pack v4 again..
Date: Mon, 16 Feb 2015 17:11:18 +0700
Message-ID: <CACsJy8A46Xgnh8rsrvAXDGkNDA0fu-jCT3qtwpsHN2KTmsJGRw@mail.gmail.com>
References: <CACsJy8CMCTirggRhD28xvv4tM8b4+NL_ruF4LgW293dHAmLYdA@mail.gmail.com>
 <alpine.LFD.2.11.1502152221480.22104@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 11:13:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNIgR-0001Wo-Qn
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 11:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428AbbBPKNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 05:13:39 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:38191 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932661AbbBPKLt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 05:11:49 -0500
Received: by iecrd18 with SMTP id rd18so32925951iec.5
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 02:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=laP2qDb2F1T4ZUEWQeeF2PXlqiLl7Dr4hFqtlVuYArQ=;
        b=w6/izGhKH6XFTwbpXyjeQ3+WuqBpg7Hts+MhxX77cZjncp9nvZqi/koFCDCkfRkA2o
         txpc8EdMB/ThL0MfYDVeuPezG94KYKeV0+W45y/vbLii3LUZKZ1uS4YB06P1MU582DFx
         eU0jdDDfM+4plz6wu3YYnBD2Vs8OAdxGcfbNJi4fhgmDHJza3CyB1oSSDMvd6+5oFtTs
         piy9Zs8imjQvCP3+9YGVHz5qu3sejixZxbv2NNwZ3QZd2XLE8c6QkQeJbePeJbbx22W8
         FzylB0K8kZKl1QoAQpzu2LDAW/X0pKtAynj949il94ziXz40g8x2uzJje5oK8PsZznNt
         fVZg==
X-Received: by 10.50.147.99 with SMTP id tj3mr20354275igb.41.1424081509121;
 Mon, 16 Feb 2015 02:11:49 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 16 Feb 2015 02:11:18 -0800 (PST)
In-Reply-To: <alpine.LFD.2.11.1502152221480.22104@knanqh.ubzr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263891>

On Mon, Feb 16, 2015 at 11:59 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> I think pack v4 does not deliver its best promise that walking a tree
>> is simply following pointers and jumping from place to place. When we
>> want to copy from the middle of another tree, we need to scan from the
>> beginning of the tree. Tree offset cache helps, but the problem
>> remains. What do you think about an alternative format that each
>> "copy" instruction includes both index of the tree entry to copy from
>> (i.e. what we store now)  _and_ the byte offset from the beginning of
>> the tree? With this byte offset, we know exactly where to start
>> copying without scanning from the beginning. It will be a bit(?)
>> bigger, but it's also faster.
>
> That would make the format inflexible.  If we want to do partial
> repacking by, say, copying some objects and repacking others (some
> objects might need repacking because the objects they refer to are
> omitted from the repack) then if those repacked objects are themselves
> referred to by byte offset then we lose as the offset is no longer
> valid.

When generate new packs, we could rip out these offsets, but it
depends on whether we can reuse v4 trees unchanged like we do with v2
deltas. If we can, ripping is not an option because then we need to
parse more.

>> I imagine this is an optimization that can be done locally. The pack
>> transferred over network does not have these byte offsets. After the
>> pack is stored and verified by index-pack, we can rewrite it and add
>> this info. The simplest way is use a fixed size for this offset (e.g.
>> uint16_t or even uint8_t), add the place holder in copy instructions
>> of all v4 trees. After that object offsets will not change again and
>> we can start filling real offsets to placeholders.
>
> Having a local extra index is fine.  Just like the pack index which is
> always created locally and can be recreated at any time.  Some tree
> offset cache might be beneficial, but I'd avoid making it into the pack
> file itself.

Hm.. right.

> Yet, I think the biggest problem with pack v4 at the moment is the
> packing algorithm for tree objects.  We are piggy-backing on the pack v2
> object delta compression sorting and that produces suboptimal results
> due to deep recursions.  And it is the recursion that kills us. The pack
> v4 requires a new packing algorithm for its tree objects.

Yep. I made a conversion tool a few days ago to "flatten" v4 trees. So
if tree A copies some entries from B, but then B copies from C, tree A
could copy directly from C. Performance improves significantly (close
to v2 with rev-list, but still slower). But pack size doubles because
copy sequences are fragmented and we're duplicating same copy patterns
over and over again. All because we follow the single delta chain
decided since v2 time so we only have one tree with no copy sequences
(best to copy from).

> What I imagined is something like this:
>
> - Each canonical tree entry is made of a SHA1, mode and path.  Let's
>   assume this is hashed into a 24-bit value.
>
> - Each tree object can therefore be represented as a string of 24-bit
>   "characters".
>
> - Delta-compressing a tree object becomes a substring search where we
>   try to replace a sequence of "characters" with the longest "string"
>   possible from another object.  Repeat with the remaining sequences.
>
> Having a 24-bit hash value is totally arbitrary.  It could be 16 bits
> with more collisions but much faster search and less memory usage.  The
> optimal value would need to be determined after some experimentation.
>
> Algorithms for the longest common substring problem already exist.  So
> one of the classical algorithms could probably be adapted here.
>
> This would allow for exploiting the provision in pack v4 to copy from
> more than one tree object.  And this would also favor shallower
> recursions and even smaller packs.  Imposing a minimum substring length
> (rather than a maximum delta depth) would determine the runtime
> performance when using the pack afterwards.
>
> If you have enough free cycles to work on this, that's what I'd suggest
> you explore at this point. I wish I could myself as I think this ought
> to be rather cool work.

I'm getting there. I'm writing an alternative implementation to your
pv4_encode_tree() that takes multiple base trees instead of just one,
finding all copy sequences from these bases, then somehow pick the
best ones. After trees are sorted by similarity in pack-objects, we
preserve n trees as base trees (no copy sequences). There is a window
to feed some of these base trees to this encode function, like how we
do it in try_delta().

Your encoding tree entries as strings would be faster, but that's not
the immediate problem. Using the longest common substring is kinda
greedy (exactly what I'm thinking to do), but it probably produces a
suboptimal copy sequences. Maybe using two shorter copy sequences
would reduce fragmentation than one large copy sequence and a bunch of
individual tree entries, that sort of thing. Haven't worked it out
yet..
-- 
Duy
