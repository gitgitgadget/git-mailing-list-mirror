From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Sun, 30 Sep 2012 18:07:45 -0700
Message-ID: <CAJo=hJsWczUqhvj6Kqsomeh9WxAAJO-Yc-=61k94jos6vVtEjQ@mail.gmail.com>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8AUdRyjSrAgM+ABzWet2NKz7N7M4re2QVoRPrrA=zfvvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 03:08:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIUUl-0000So-B8
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 03:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab2JABIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 21:08:16 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:49173 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab2JABIH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 21:08:07 -0400
Received: by qaas11 with SMTP id s11so1149577qaa.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 18:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WhdF8DdOYzkOXIXYVntASpoZ3KVsAKzyu71vEUHjqZU=;
        b=KrAIJXpIcu6w8fiC5zsioEY8J4GGv/V9UIir9dGZtinhkyf7daUVSiZmSsYENZyiIh
         BcerMRNl2h5/w6YjT/Vopeocj42wU6QSQ4lsXuKNShdUUfeCyWkBt/KSKOSZy4tm0Plc
         wmQK/zmxwH0pH8XtujwyvnQW65oatxlLfn3w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=WhdF8DdOYzkOXIXYVntASpoZ3KVsAKzyu71vEUHjqZU=;
        b=YR+b+XDizfjKu1zBHmAFsPrARSPHZWUBZhVXFd0LVqV1fODTLDiwd0/MxeSEaRV5oA
         1/TGyzKFRJHsaItQIfZ1PNwjD+aoeofe5q8HKJKrfeTO12W2oIL6jh6jTizK47rCvsjB
         zoUoRkjOpBcxZxSLYeVMynnM/EyHNZmvisL8pvVVbqlSDtUPDUAmeUYslJHXh8Ql+4iK
         ERQMsi/C+PX716RqrsOkyp2u0YHXHHVtcSazvd3ez1xztOrKw0t7KhF09r66NWuLV9B9
         P6eKzaze2nMSLpvnbjwRQUIc54b4fJy1glpaj3ETfwtpiegB/NjJzqo6KnrdqFyqAjXS
         AMaw==
Received: by 10.224.189.12 with SMTP id dc12mr33518054qab.59.1349053685878;
 Sun, 30 Sep 2012 18:08:05 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Sun, 30 Sep 2012 18:07:45 -0700 (PDT)
In-Reply-To: <CACsJy8AUdRyjSrAgM+ABzWet2NKz7N7M4re2QVoRPrrA=zfvvg@mail.gmail.com>
X-Gm-Message-State: ALoCoQk2zjiLhIozumsMzFt8nPlkWirgcDSbz2V4CZZVbkKXpkxuhpp3oNgFTY+Y31Lc1N6I8rXH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206702>

On Fri, Sep 28, 2012 at 5:00 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Thu, Sep 27, 2012 at 7:47 AM, Shawn Pearce <spearce@spearce.org> wrote:
>> * https://git.eclipse.org/r/7939
>>
>>   Defines the new E003 index format and the bit set
>>   implementation logic.
>
> Quote from the patch's message:
>
> "Currently, the new index format can only be used with pack files that
> contain a complete closure of the object graph e.g. the result of a
> garbage collection."
>
> You mentioned this before in your idea mail a while back. I wonder if
> it's worth storing bitmaps for all packs, not just the self contained
> ones.

Colby and I started talking about this late last week too. It seems
feasible, but does add a bit more complexity to the algorithm used
when enumerating.

> We could have one leaf bitmap per pack to mark all leaves where
> we'll need to traverse outside the pack. Commit leaves are the best as
> we can potentially reuse commit bitmaps from other packs. Tree leaves
> will be followed in the normal/slow way.

Yes, Colby proposed the same idea.

We cannot make a "leaf bitmap per pack". The leaf SHA-1s are not in
the pack and therefore cannot have a bit assigned to them. We could
add a new section that listed the unique leaf SHA-1s in their own
private table, and then assigned per bitmap a leaf bitmap that set to
1 for any leaf object that is outside of the pack. This would probably
take up the least amount of disk space, vs. storing the list of leaf
SHA-1s after each bitmap. If a pack has only 1 bitmap (e.g. it is a
small chunk of recent history) there is really no difference in disk
usage. If the pack has 2 or 3 commit bitmaps along a string of
approximately 300 commits, you will have an identical leaf set for
each of those bitmaps so using a single leaf SHA-1 table would support
reusing the redundant leaf pointers.

One of the problems we have seen with these non-closed packs is they
waste an incredible amount of disk. As an example, do a `git fetch`
from Linus tree when you are more than a few weeks behind. You will
get back more than 100 objects, so the thin pack will be saved and
completed with additional base objects. That thin pack will go from a
few MiBs to more than 40 MiB of data on disk, thanks to the redundant
base objects being appended to the end of the pack. For most uses
these packs are best eliminated and replaced with a new complete
closure pack. The redundant base objects disappear, and Git stops
wasting a huge amount of disk.

> For connectivity check, fewer trees/commits to deflate/parse means
> less time. And connectivity check is done on every git-fetch (I
> suspect the other end of a push also has the same check). It's not
> unusual for me to fetch some repos once every few months so these
> incomplete packs could be quite big and it'll take some time for gc
> --auto to kick in (of course we could adjust gc --auto to start based
> on the number of non-bitmapped objects, in additional to number of
> packs).

Yes, of course.
