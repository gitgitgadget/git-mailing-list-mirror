From: =?UTF-8?Q?Jens_Lindstr=C3=B6m?= <jl@opera.com>
Subject: Re: [PATCH 1/2] remote: defer repacking packed-refs when deleting refs
Date: Fri, 23 May 2014 12:03:06 +0200
Message-ID: <CAEef6WyXGXAdm_DkzNsuLgeFFpQsxvTiuJbK3ypc8-Cz2qD_KQ@mail.gmail.com>
References: <537B2FA4.7020001@opera.com>
	<537B30E7.5020505@opera.com>
	<xmqqtx8kxn7f.fsf@gitster.dls.corp.google.com>
	<xmqqlhtwxkg9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 12:03:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnmJm-0003KT-Ep
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 12:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbaEWKDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 06:03:09 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:59249 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbaEWKDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 06:03:08 -0400
Received: by mail-la0-f51.google.com with SMTP id gf5so3971929lab.10
        for <git@vger.kernel.org>; Fri, 23 May 2014 03:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=urYXcsM88tMhmzZhY2w0dGkshp1xKt0UAraLQrXWxz4=;
        b=b44bwevsvDPlTu9uGjVAaJ2+t1aaB3dJgkWFxQCaMGYuxTupNIF93ZDtiePijQ3+Yg
         gYKpxj06KXcy0VAc/AzchE/8Q8bwSYZ0vM3iiy+MYJoQYeCvjG8/Aqc5XPXI+EyzmC6r
         8GJstThM7FXquynIyp8KkJ7ZoDjBA7wFOWEOAZShg/vbbCK5TQPSaG16vtplbvFOARyY
         AufmL+py//BLLLbt6/SfSDgeVPWitPzzvPB29gBuR04UtVp0zTvC3lbZY+TH41kOBb5u
         0/3FAlzFp82DX+4B6dKPZimIoYohgAhwa1iYx0tgcWA9DO78zA6uD6xfiIqyhRL+oy/g
         S+6g==
X-Gm-Message-State: ALoCoQknYSwji2eZz/xqvVbKNXNb6g4NlLFDp8W3yE0bJU1Umdkqc7TVfyBa4Ab2uMX3/TwiAlpZ
X-Received: by 10.112.218.74 with SMTP id pe10mr2547095lbc.3.1400839386351;
 Fri, 23 May 2014 03:03:06 -0700 (PDT)
Received: by 10.112.106.102 with HTTP; Fri, 23 May 2014 03:03:06 -0700 (PDT)
In-Reply-To: <xmqqlhtwxkg9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249977>

On Tue, May 20, 2014 at 10:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> A bit safer way to organize might be to first create a list of the
>> refs to be removed in-core, update packed-refs without these refs to
>> be removed, and then finally remove the loose ones, but I haven't
>> thought things through.
>
> Perhaps a removal of remote can go in this order to be resistant
> against an abort-in-the-middle.
>
>  * update packed-refs without the refs that came from the remote.
>
>    - when interrupted before the new temporary file is renamed to
>      the final, it would be a no-op.
>
>    - when interrupted after the rename, only some refs that came
>      from the remote may disappear.
>
>  * remove the loose refs that came from the remote.
>
>  * finally, remove the configuration related to the remote.
>
> This order would let you interrupt "remote rm" without leaving the
> repository in a broken state.  Before the final state, it may appear
> that you have some but not all remote-tracking refs from the remote
> in your repository, but you would not have any ref that point at an
> obsolete object.  Running "remote rm" again, once it finishes, will
> give you the desired result.

Removing the remote configuration (I assume you mean the
"remote.<name>" section from .git/config) last in 'remote rm' would be
a bit better I think.  Especially with the very slow removal of
branches an impatient user would likely abort the command if there
were many remote-tracking branches, after which rerunning would fail
since the remote configuration was already gone, and then there would
be no obvious way to get rid of the remaining remote-tracking
branches.

Doing the repacking first and then run through and delete loose refs
and ref logs leads to a smaller and nicer patch as well; no need to
tell delete_ref() to not repack then, since repack_without_refs() will
just find that the ref isn't in packed-refs already and do nothing.

One additional change was required in
builtin/remote.c:remove_branches().  It used to pass in the expected
SHA-1 of the ref to delete_ref(), which only works if the ref exists.
If repack_without_refs() is called first, most refs won't exist, and
delete_ref() would fail.  Branch removal from 'remote prune' didn't
have this problem, since it called delete_ref() with a NULL SHA-1.


> A longer-term goal might be to have ref-transaction infrastructure
> clever enough to coalesce the "repack-without-these-refs" requests
> into one automatically without forcing the callers you are fixing
> care about these things, though.  And such a transaction semantics
> may have to also cover the updating of configuration files.

Yes, some kind of more advanced transaction mechanism would be great,
and would likely solve this type of performance issue by design.

/ Jens
