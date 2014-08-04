From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug report about symlinks
Date: Mon, 4 Aug 2014 18:03:13 +0700
Message-ID: <CACsJy8AKa2NBJT6+w87JqDM9eL5nw=3OjMCj-kq=yoyE6Oi_Ew@mail.gmail.com>
References: <web-416867478@relay1.vsu.ru> <53DABD69.7010004@web.de>
 <xmqqppgkw55g.fsf@gitster.dls.corp.google.com> <53DCF14D.8040705@web.de> <xmqqk36ptrs6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Nikolay Avdeev <avdeev@math.vsu.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 13:03:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEG3Q-0001rE-Lx
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 13:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbaHDLDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 07:03:44 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:45549 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbaHDLDo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 07:03:44 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn18so5138254igb.15
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 04:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IRofc6QDm7XQoqw68xpWSA8CdRqna1uw9nk0RmqY0Rc=;
        b=LrATL+h9ag3N7c+7RLy1O3CnHJNcPmOrhM0lcaioQGm5NEXBZ1CrGoWkFbssmu1yxS
         H23V4vag+l/C3lfyStY7zByL0uaX79OmRM3UBC8Tz4XNzDiDdNUTk4ojXi+/20qanOgZ
         A/tVzGIqHRYJJy12poetTXgVsHXjaiPNH9MFkm3EDTlitrzbgcO/S4Ke9HJl0eBeSJ9m
         D85zgc3cSGkBMyWyfCIVziVcPSIldY9AYICOtBdW2inTCl/h5FCGVhwfufaz2DfRMcOn
         o1xWA0Dq8OL7pv0faEJyzQJz6VLU2YGZpdMonTOdbFlaHhZP8JRVoj0CH1yU1vY4BU/8
         nusw==
X-Received: by 10.43.129.74 with SMTP id hh10mr29676012icc.48.1407150223454;
 Mon, 04 Aug 2014 04:03:43 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Mon, 4 Aug 2014 04:03:13 -0700 (PDT)
In-Reply-To: <xmqqk36ptrs6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254736>

On Mon, Aug 4, 2014 at 12:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I think you, who dug to find out where to add the check, already
> know this, and I am writing this mainly for myself and for the list
> archive, but when the knee-jerk "has-syjmlink-leading-path missing?"
> reaction came to me, two obvious optimizations also came to my mind:
>
>  - When checking a cache entry "a/b/c/d/e" and we find out "a/b/c"
>    is a symbolic link, we mark it as ~CE_VALID, but at the same
>    time, we learn "a/b/c/any/thing" are also ~CE_VALID with that
>    check, so we _could_, after the has_symlink_leading_path once
>    returns true, so there may be an opportunity to fast-forward the
>    scan, marking all paths under "a/b/c" as ~CE_VALID.
>
>  - After finding out "a/b/c" is a symbolic link to cause anything
>    underneath marked as ~CE_VALID, we also know "a/" and "a/b/"
>    exists as real directories, so a later check for "a/b/some/thing"
>    can start checking at "a/b/some/" without checking "a/" and "a/b/".

Just checking, you meant CE_UPTODATE, not CE_VALID, right? CE_VALID is
only used with --assume-unchanged

> The latter is more important as it is a much more common case that
> the shape of the working tree not to change.
>
> But I think the implementation of has_symlink_leading_path() already
> has these optimizations built inside around the (unfortunately named)
> "struct cache_def", so it probably would not give us much boost to
> implement such a fast-forwarding of the scan.

Yeah my first thought is another flood of lstat(). But it looks like
has_symlink_leading_path() tries hard to reduce lstat() already. We
could disable this call in filesytems that do not support symlinks
(e.g. vfat) but I guess that's just a minority.
-- 
Duy
