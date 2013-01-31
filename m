From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH/RFC 0/6] commit caching
Date: Thu, 31 Jan 2013 09:14:26 -0800
Message-ID: <CAJo=hJtTYZg+1+RZVfEGTgOGzqxQbN1CLYWrvUp+WHKGxGwHMQ@mail.gmail.com>
References: <20130129091434.GA6975@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 18:15:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0xjB-0000uA-EK
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 18:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884Ab3AaROs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 12:14:48 -0500
Received: from mail-ia0-f179.google.com ([209.85.210.179]:33951 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab3AaROq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 12:14:46 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so4123480iak.38
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 09:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Qw5c6EAJURZV5QbfhuN4Q6KcPoTkUSMYY897EcCFRoA=;
        b=Rvx5NB0S2zknf0zVoC9qMOUh9kG0EKhWkuGeCUgSfP7QPZxABK+6lfeZ+r+itDuPAu
         8SEqZijbqwYLvVDR/CDwtnteFVmJo4Sn78rXNGGJ3zbxS4F3wneBdTXd93K0C0NqEY7z
         K8t4mTNJxH67Gc4KPjozIupJfMUVLTyR+9X4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=Qw5c6EAJURZV5QbfhuN4Q6KcPoTkUSMYY897EcCFRoA=;
        b=DestXzZ2lsEe+1oM1JHMB+Tf77+RUathjkykBXkSzkteyOYJMUprdtwNsSW1XVFIrV
         U7z4jDWeLlMHHIuB639F56Y8Xe4pj/jAVcinrB4CdeBHjtCuTrfPkjS/Rkqxot3EUv9t
         xVmEyq3eVnI5dxyywqb1KFrZzBjYK2MkQsdwqFjn2v9V6bFvcLU0T94qvBBN6c+MMFlf
         Mad2HdGaFdTJvZRO2J0/a7kCMaAbeu0Tp0LMVZV2FIcFd0ZUGRb7SdZEQsZfI3PMVwZi
         h2wh3H7cIyyWTpHxAXQgd8SjhGZbCkSuMfkBjRnRJqwYo9rF3aMA0TGn7mrcwBDZZBqf
         462Q==
X-Received: by 10.50.163.35 with SMTP id yf3mr1771892igb.60.1359652486248;
 Thu, 31 Jan 2013 09:14:46 -0800 (PST)
Received: by 10.64.170.100 with HTTP; Thu, 31 Jan 2013 09:14:26 -0800 (PST)
In-Reply-To: <20130129091434.GA6975@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQlK0YTqsFngAySVx8AexnIB2nG3dTk6p5Sn1aUtBElJB7RE2duVF83cOLy3SlO6DXASyFz2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215129>

On Tue, Jan 29, 2013 at 1:14 AM, Jeff King <peff@peff.net> wrote:
> This is the cleaned-up version of the commit caching patches I mentioned
> here:
>
>   http://article.gmane.org/gmane.comp.version-control.git/212329
...
> The short of it is that for an extra 31M of disk
> space (~4%), I get a warm-cache speedup for "git rev-list --all" of
> ~4.2s to ~0.66s.

I have to admit, this is a nice gain. I don't think users often dig
through all commits to the root but I can see how this might improve
git log with a path filter.

> Coupled with using compression level 0 for trees (which do not compress
> well at all, and yield only a 2% increase in size when left
> uncompressed), my "git rev-list --objects --all" time drops from ~40s to
> ~25s.

This uhm.... is nice?

But consider reachability bitmaps. ~40s to ~80ms. :-)

> Perf reveals that we're spending most of the remaining time in
> lookup_object. I've spent a fair bit of time trying to optimize that,
> but with no luck; I think it's fairly close to optimal. The problem is
> just that we call it a very large number of times, since it is the
> mechanism by which we recognize that we have already processed each
> sha1.

Yup. I have also futzed with the one in JGit for quite a while now. I
pull some tricks there like making it a 2 level directory to reduce
the need to find a contiguous array of 8M entries when processing the
Linux kernel, and I try to preallocate the first level table based on
the number of objects in pack-*.idx files. But the bottleneck is
basically the cache lookups and hits, these happen like 100M times on
2M objects, because its every link in nearly every tree.

Reachability bitmaps basically let you skip this. So they go fast. But
I have another that you could try.

If we modified pack-objects' delta compressor for tree objects to only
generate delta instructions at tree record boundaries, a delta-encoded
tree can be processed without inflating the full content of that tree.
Because of the way deltas are created, "most" tree deltas should have
their delta base scanned by the object traversal before the delta is
considered. This means the tree delta just needs to consider the much
smaller records that are inserted into the base. We know these are
different SHA-1s than what was there before, so they are more likely
to be new to the lookup_object table.

So the --objects traversal algorithm can change to get the delta base
SHA-1 and raw tree delta from the pack storage. Perform a
lookup_object on the base to see if it has been scanned. If it has,
just scan the delta insert instructions. If the base has not yet been
scanned, inflate the tree to its normal format and scan the entire
tree.

This is an approximation of what Nico and I were talking about doing
for pack v4. But doesn't require a file format change. :-)
