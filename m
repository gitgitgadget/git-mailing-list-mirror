From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Mon, 1 Oct 2012 08:59:17 +0700
Message-ID: <CACsJy8D5AXSWAdK7tgtXnE4Ro_+okaYM=zf9JnQfObkcx=FCOw@mail.gmail.com>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8AUdRyjSrAgM+ABzWet2NKz7N7M4re2QVoRPrrA=zfvvg@mail.gmail.com> <CAJo=hJsWczUqhvj6Kqsomeh9WxAAJO-Yc-=61k94jos6vVtEjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 04:00:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIVJJ-0000X8-Aq
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 04:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487Ab2JAB7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 21:59:48 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41561 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab2JAB7r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 21:59:47 -0400
Received: by ieak13 with SMTP id k13so11085461iea.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 18:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LJmknJZ+MY8eNdV8sHnQmCLDu/x+MdLUKzQ3jPf+4X0=;
        b=FhMNjA0Ql/LSbtZvui55fswgjYHbVWPopNmADG8p8dtLtzCq/lIsQk89oZgZKBNssv
         jXmlPWIfhA7MA4dyRvOXqTWNo7/YLJq6jJPmWhexxSloAjkCy8bnAPqeDpAoxOP/vLkq
         lEOlUGfkdKLcOpPPlyY0foqYFJZoHUd5GbSb+IG3LK1GnPinu7gGGvFmNcZUS16Rs1ol
         yLx7zKJCpnH1EKSTx/hLJvJAbl8FvX5wpOO5W8ByhpXwMjMaRrzUDq45o/NLaYYcO7H1
         xJkiMRXjiwV723m2RBG+e/ONQGfjVRE7lr42lnEKP8z89jYob6x89IpndDuSf1ULeeWl
         AcSg==
Received: by 10.50.158.194 with SMTP id ww2mr4413268igb.40.1349056787267; Sun,
 30 Sep 2012 18:59:47 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Sun, 30 Sep 2012 18:59:17 -0700 (PDT)
In-Reply-To: <CAJo=hJsWczUqhvj6Kqsomeh9WxAAJO-Yc-=61k94jos6vVtEjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206705>

On Mon, Oct 1, 2012 at 8:07 AM, Shawn Pearce <spearce@spearce.org> wrote:
>> You mentioned this before in your idea mail a while back. I wonder if
>> it's worth storing bitmaps for all packs, not just the self contained
>> ones.
>
> Colby and I started talking about this late last week too. It seems
> feasible, but does add a bit more complexity to the algorithm used
> when enumerating.

Yes. Though at server side, if it's too much trouble, the packer can
just ignore open packs and use only closed ones.

>> We could have one leaf bitmap per pack to mark all leaves where
>> we'll need to traverse outside the pack. Commit leaves are the best as
>> we can potentially reuse commit bitmaps from other packs. Tree leaves
>> will be followed in the normal/slow way.
>
> Yes, Colby proposed the same idea.
>
> We cannot make a "leaf bitmap per pack". The leaf SHA-1s are not in
> the pack and therefore cannot have a bit assigned to them.

We could mark all objects _in_ the pack that lead to an external
object. That's what I meant by leaves. We need to parse the leaves to
find out actual SHA-1s that are outside the pack. Or we could go with
your approach below too.

> We could
> add a new section that listed the unique leaf SHA-1s in their own
> private table, and then assigned per bitmap a leaf bitmap that set to
> 1 for any leaf object that is outside of the pack.


> One of the problems we have seen with these non-closed packs is they
> waste an incredible amount of disk. As an example, do a `git fetch`
> from Linus tree when you are more than a few weeks behind. You will
> get back more than 100 objects, so the thin pack will be saved and
> completed with additional base objects. That thin pack will go from a
> few MiBs to more than 40 MiB of data on disk, thanks to the redundant
> base objects being appended to the end of the pack. For most uses
> these packs are best eliminated and replaced with a new complete
> closure pack. The redundant base objects disappear, and Git stops
> wasting a huge amount of disk.

That's probably a different problem. I appreciate disk savings but I
would not want to wait a few more minutes for repack on every
git-fetch. But if this bitmap thing makes repack much faster than
currently, repacking after every git-fetch may become practical.
-- 
Duy
