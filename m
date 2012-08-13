From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] index-pack: produce pack index version 3
Date: Mon, 13 Aug 2012 07:57:01 +0700
Message-ID: <CACsJy8CNp2w6PsMSrQ4aFBwHKbOGid4pVHUhE4xgmTatrnEepQ@mail.gmail.com>
References: <1344772889-8978-1-git-send-email-pclouds@gmail.com>
 <7vtxw8exii.fsf@alter.siamese.dyndns.org> <7vlihjgaaj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 02:58:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0iz3-0000Hf-Bi
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 02:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab2HMA5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 20:57:32 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36247 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab2HMA5c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 20:57:32 -0400
Received: by obbuo13 with SMTP id uo13so6055321obb.19
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 17:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nh16uG7c7KiZi2y3liIkSbtw1VE8C210lQ7Ssu+8OmM=;
        b=IzJKVV1vFCO1Gt11tVEGnjnFQxJ9+IgkJ9v5uGfBoPvYyjimQJsughPHW+arNOyw5T
         T6tOFqCFHHpkeLDQEbd0zuAt6DjpxqBJNXiZMA+XpTp2kRMOjCj5tGwD6eWm90ngCEcU
         nFvkiG3lczKgl6vv+eydEkPIzZ60pwTK+8yu2dXAyzSDx1JxxhLzo8vpsiIpDsBWR79m
         0cn78c01u/WPAkdPLi8OUC6mvss5FFeqQP4v1FPMFT7XiMgQBQNoEedxr0PvAIth6VT7
         01RQZJrZMobblqHcj2h8htB6CbaN/tPsvjkjLiz6zypuh0I0wnXsIQ2q4qG8EC6mR6cn
         zAhA==
Received: by 10.50.193.201 with SMTP id hq9mr3756423igc.48.1344819451551; Sun,
 12 Aug 2012 17:57:31 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Sun, 12 Aug 2012 17:57:01 -0700 (PDT)
In-Reply-To: <7vlihjgaaj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203319>

On Mon, Aug 13, 2012 at 2:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> For example, the reachability bitmap would want to say something
> like "Traversing from commit A, these objects in this pack are
> reachable."  The bitmap for one commit A would logically consist of
> N bits for a packfile that stores N objects (the resulting bitmap
> needs to be compressed before going to disk, perhaps with RLE or
> something).  With the single "sorted by SHA-1" table, we can use the
> index in that single table to enumerate all reachable objects of any
> type in one go.  With four separate tables, on the other hand, we
> would need four bitmaps per commit.

No we still need one per commit. The n-th bit is in the order of the
object in the pack, not the index. How sha-1 is sorted does not
matter.

> Either way is _possible_, but I think the former is simpler, and the
> latter makes it harder to introduce new types of objects in the
> future, which I do not think we have examined possible use cases
> well enough to make that decision to say "four types is enough
> forever".

New types can be put in one of those four tables, depending on its
purpose. The reason I split because I care particularly about commits
and trees. If the new type serves the same purpose as tree, for
example, then it's better put in tree table...

> In either way, we would have such bitmap (or a set of four bitmaps
> in your case) for more than one commit (it is not necessary or
> desirable to add the reachability bitmap to all commits), and such a
> "reachability extension" would need to store a sequence of "the
> commit object name the bitmap (or a set of four bitmaps) is about,
> and the bitmap (or set of four bitmaps)".  That object name does not
> have to be 20-byte but would be a varint representation of the
> offset into the "sorted by SHA-1" table.

How do you reach the bitmap, given its commit sha-1?

> That varint representation
> would be smaller by about 3.5 bits if you have a separate "commit
> only, sorted by SHA-1" table (as the number of all objects tend to
> be 10x larger than the number of all commits that need them).  For
> the particular case of "we want to only annotate the commits, never
> other kinds of objects" use case, it would be a win.  But without
> knowing what other use cases we will want to use the "object
> annotation in the pack index file" mechanism for, it feels like a
> premature optimization to me to have four tables to shave 3.5 bits
> per object.

caching trees for faster traversal in general case (sort of pack v4
but it comes as a cache instead of replacing the real pack).
-- 
Duy
