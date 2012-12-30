From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Sun, 30 Dec 2012 19:53:48 +0700
Message-ID: <CACsJy8C4UttGKcw11do1POcHZJM7iZ2r7F3ESOqEnWL8kdz+dQ@mail.gmail.com>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net> <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net> <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
 <20121229052747.GA14928@sigill.intra.peff.net> <20121230120542.GA10820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 30 13:54:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpIPd-0006ev-MI
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 13:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511Ab2L3MyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 07:54:21 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:55472 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482Ab2L3MyT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 07:54:19 -0500
Received: by mail-ob0-f179.google.com with SMTP id x4so10780629obh.24
        for <git@vger.kernel.org>; Sun, 30 Dec 2012 04:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ao/2KUyQpks/8tjgL0fMG+z939Mygo4NxySggd49xi0=;
        b=OTznzCGzc8KlDmVV1OL1I2MpTRu/7zaGIvwxfBqHSHlWu6dDgjnA1n/5oEkeVbM1rI
         l5kfWpAwsqqE/SkCws8MX/b2NEHAABItxuLktGQ247kXhHzZ5ToAnycn9+TziYGUbkdL
         uiFb3l84Tf0zG6PdSGpTOGu7LK27Tmsk5InI77EQrPlwKkJ8M8A0UdwbWvT+4z55jTNb
         9YTbHUHd4or8TrYEMtd3zgDiT8rxyFKVXQ4A3BnzE1eX0e+xgEXlcUr3mvOpUGveEcfk
         tFvMzbxWJXUDS/++Mwao0TmMGoScCabopTfEwPs4/aNesq79S73A8mmyEmoo/yL7f8hr
         NrEw==
Received: by 10.60.32.44 with SMTP id f12mr20599796oei.61.1356872058738; Sun,
 30 Dec 2012 04:54:18 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Sun, 30 Dec 2012 04:53:48 -0800 (PST)
In-Reply-To: <20121230120542.GA10820@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212330>

On Sun, Dec 30, 2012 at 7:05 PM, Jeff King <peff@peff.net> wrote:
> So I was thinking about this, which led to some coding, which led to
> some benchmarking.

I like your way of thinking! May I suggest you take a new year break
first, then "think" about reachability bitmaps ;-) 2013 will be an
exciting year.

> I want to clean up a few things in the code before I post it, but the
> general idea is to have arbitrary per-pack cache files in the
> objects/pack directory. Like this:
>
>   $ cd objects/pack && ls
>   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.commits
>   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.idx
>   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.pack
>   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.parents
>   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.timestamps
>   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.trees
>
> Each file describes the objects in the matching pack. If a new pack is
> generated, you'd throw away the old cache files along with the old pack,
> and generate new ones. Or not. These are totally optional, and an older
> version of git will just ignore them. A newer version will use them if
> they're available, and otherwise fallback to the existing code (i.e.,
> reading the whole object from the pack). So you can generate them at

You have probably thought about this (and I don't have the source to
check first), but we may need to version these extra files so we can
change the format later if needed. Git versions that do not recognize
new versions simply ignore the cahce.

> repack time, later on, or not at all. For now I have a separate command
> that generates them based on the pack index; if this turns out to be a
> good idea, it would probably get called as part of "repack".

I'd like to make it part of index-pack, where we have nearly
everything in memory. But let's leave it as a separate command first.

> Each file is a set of fixed-length records. The "commits" file contains
> the sha1 of every commit in the pack (sorted). A binary search of the
> mmap'd file gives the position of a particular commit within the list,

I think we could avoid storing sha-1 in the cache with Shawn's idea
[1]. But now I read it again I fail to see it :(

[1] http://article.gmane.org/gmane.comp.version-control.git/206485

> Of course, it does very little for the full --objects listing, where we
> spend most of our time inflating trees. We could couple this with
> uncompressed trees (which are not all that much bigger, since the sha1s
> do not compress anyway). Or we could have an external tree cache, but
> I'm not sure exactly what it would look like (this is basically
> reinventing bits of packv4, but doing so in a way that is redundant with
> the existing packfile, rather than replacing it).

Depending on the use case, we could just generate packv4-like cache
for recently-used trees only. I'm not sure how tree cache impact a
merge operation on a very large worktree (iow, a lot of trees
referenced from HEAD to be inflated). This is something a cache can
do, but a new pack version cannot.

> Or since the point of
> --objects is usually reachability, it may make more sense to pursue the
> bitmap, which should be even faster still.

Yes. And if narrow clone ever comes, which needs --objects limited by
pathspec, we could just produce extra bitmaps for frequently-used
pathspecs and only allow narrow clone with those pathspecs.
-- 
Duy
