From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Thu, 2 Aug 2012 19:08:25 +0700
Message-ID: <CACsJy8CndopS7fg4mevFD5T0KJ85ba6jjhamrKDdKvKsWa_fQw@mail.gmail.com>
References: <20120731141536.GA26283@do> <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net> <CACsJy8B14qSLkAt9VRQTCkoZx5UtGTpAmMHKyqk+_o14bc9GmQ@mail.gmail.com>
 <20120801020124.GA18071@sigill.intra.peff.net> <CACsJy8AYzYTJ+k72ZEuWW-RdKe7arYbbscVALNYakKSfYqD_zw@mail.gmail.com>
 <20120801212719.GA16233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 02 14:09:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwuD8-0003Az-2E
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 14:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab2HBMI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 08:08:57 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:39144 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2HBMI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 08:08:56 -0400
Received: by ggnl2 with SMTP id l2so1324119ggn.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0B1vsTiGA2v1TKvqHu4eEw1t/VnlOu807Sc3ggg8bcU=;
        b=zW5diPsIcbsSWNmCPezJAesxSZbA4voyJ3BfCEOPCiEHz6eAn3G9iaoIs0uIjVdL+k
         VT26IMcZuoiyD6q4XgePXLx9rpYo5jUHozazUMmktzOBMkRzHUYM/rFOjBiyHGpjnV03
         4qmyXXSD5/GGvH+jqPHAzl5ALMQqbK8pwTsEKXkcEF+XNYUx/Bmp+uaNhZV8EEjXRcuw
         VIOn1Sq2gUF5W394mQujEtA/cTDkZGQHXi1DOV1oaHfsHEQhXErtNBb3DWkEGQ/IvCGs
         8b7qm6Sc1eiN5VhS/bVF4L5/e12JRojYMnXs4KYziG1q2KkTXvrzWGbY7byJSSn65R59
         XLCQ==
Received: by 10.43.110.197 with SMTP id el5mr3598927icc.1.1343909335527; Thu,
 02 Aug 2012 05:08:55 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Thu, 2 Aug 2012 05:08:25 -0700 (PDT)
In-Reply-To: <20120801212719.GA16233@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202768>

On Thu, Aug 2, 2012 at 4:27 AM, Jeff King <peff@peff.net> wrote:
> Yes, if you go with a commit-based approach, you can do either notes or
> in-commit messages. In other words, I would break the solutions down as:
>
>   1. Store sha1+sha1 -> score mapping (i.e., what I suggested). This is
>      fundamentally a global store, not a per-commit store. For storage,
>      you can do one (or a combination) of:
>
>      a. Store the mapping in some local file. Fast, but can't be shared.
>
>      b. Store the mapping in a note (probably indexed by the destination
>         blob sha1). Less efficient, but easy to share.
>
> I implemented (1a). Implementing (1b) would be easy, but for a full-on
> cache (especially for "-C"), I think the resulting size might be
> prohibitive.

(1a) is good regardless rename overrides. Why don't you polish and
submit it? We can set some criteria to limit the cache size while
keeping computation reasonably low. Caching rename scores for file
pairs that has file size larger than a limit is one. Rename matrix
size could also be a candidate. We could even cache just rename scores
for recent commits (i.e. close to heads) only with the assumption that
people diff/apply recent commits more often.


> All solutions under (2) suffer from the same problem: they are accurate
> only for a single diff. For other diffs, you would either have to not
> use the feature, or you would be stuck traversing the history and
> assigning a temporary file identity (e.g., given commits A->B->C, and in
> A->B we rename "foo" to "bar", the diff between A and C could discover
> that A's "foo" corresponds to C's "bar").

Yeah. If we go with manual overrides, I expect users to deal with
these manually too. IOW they'll need to create a mapping for A->C
themselves. We can help detect that there are manual overrides in some
cases, like merge, and let users know that manual overrides are
ignored. For merge, I think we can just check for all commits while
traversing looking for bases.

> For this reason, I'm not sure that stored overrides like this are
> generally useful in the long run. I think storage is useful for
> _caching_ the results, because it doesn't have to be perfect; it just
> helps with some repetitive queries. Whereas for overriding, I think it
> is much more interesting to override _particular_ diff. E.g., to say "I
> am merging X and Y, and please pretend that Y renamed "foo" to "bar"
> when you do rename detection.
>
> And in that sense, your "git log" example can be considered a
> special-case of this: you are saying that the diff from $commit to
> $commit^ is done frequently, so rather than saying "please pretend..."
> each time, you would like to store the information forever. And storing
> it in the commit message or a note is one way of doing that.

Yep, specifying rename overrides between two trees is probably better.

> I don't think there's anything fundamentally _wrong_ with that, but I
> kind of question its usefulness. In other words, what is the point in
> doing so? If it is inform the user that semantically the commit did a
> rename, even though the content changed enough that rename detection
> does not find it, then I would argue that you should simply state it in
> the commit message (or in a human-readable git-note, if it was only
> realized after the fact).
>
> But there is not much point in making it machine-readable, since the
> interesting machine-readable things we do with renames are:
>
>   1. Show the diff against the rename src, which can often be easier to
>      read. Except that if rename detection did not find it, it is
>      probably _not_ going to be easier to read.

Probably. Still it helps "git log --follow" to follow the correct
track in the 1% case that rename detection does go wrong.

>
>   2. Applying content to the destination of a merge. But you're almost
>      never doing the diff between a commit and its parent, so the
>      information would be useless.

Having a way to interfere rename detection, even manually, could be
good in this case if it reduces conflicts. We could feed rename
overrides using command line.
-- 
Duy
