From: Derek Moore <derek.p.moore@gmail.com>
Subject: Re: smudge filters during checkout & crash consistency
Date: Wed, 12 Nov 2014 13:41:54 -0600
Message-ID: <CAMsgyKa7zSqYFHVt9VGz2zarBwCcJRxjGtkAoaxbtrnMJCZxpg@mail.gmail.com>
References: <CAMsgyKbox7e2pv4+_=jG6Ywh3Km2gPsw+Qf6qj-28GWrVg7RZQ@mail.gmail.com>
	<xmqqk33046ha.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 20:42:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xodnj-0000Pa-UC
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 20:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbaKLTl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 14:41:56 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:56461 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbaKLTlz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 14:41:55 -0500
Received: by mail-ob0-f178.google.com with SMTP id vb8so9795506obc.9
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 11:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=o+KlwA8fqvMeWRuRXjCWqO+WSfMcLeArLP+iUGMmMc8=;
        b=OGRMaALmDWJgTAM9ZRQQSeZvHCw+iXi7bbdDIIRKNr5NVnO1OYYz7UjN4uTk/JtrcK
         1MbUvzN2IoXFO2Ik9hRAN/qXn843N/Zt41UfHzIN6fGayBgucOh9lSfUeVhsK1CaEVeU
         TDzGU++5Q/WZJHYY9xyZPAvoXe70ZgOXOIayvwRKBH/5t2Ku65Q85ygc4dtwhH0JnKxq
         uVgk6bPS2L2Ax8LZ0NnOsTznefY3uxHRLpz0olbMY6OTJa4MGa42SZs/cKNdpS2qX30M
         BGokWbSu1MwC0F9vLUjk7gkg5r95lo09NkDft8jLdEvn5qiDLK/zyBD+UsAgGH0Gx4PV
         W0Vw==
X-Received: by 10.60.160.232 with SMTP id xn8mr20325314oeb.29.1415821314675;
 Wed, 12 Nov 2014 11:41:54 -0800 (PST)
Received: by 10.76.33.68 with HTTP; Wed, 12 Nov 2014 11:41:54 -0800 (PST)
In-Reply-To: <xmqqk33046ha.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a solution that depends only/mostly on blob contents:

1) construct the ident of the blob via an `(echo -e -n "blob <size>\0"
; cat file) | sha1sum` equivalent if an $Id$ string is not found in
its contents,

2) look up the earliest commit with that blob hash at that path, and

3) use the reflog metadata from that earliest commit.

Then when switching from C-to-A or C-to-B, F will have the same
contents as a noop switch when switching A-to-B from C-to-A (although,
conceivably, you may get a commit that is in neither A nor B, but you
will have the earliest introduction of that file at that state).

In other words, always use the earliest occurrence of a specific
content at a given path, earliest commit wins irrespective of
branches. Not the most elegant solution.

I may have to go back and let these people know that outside of build
scripts they can't get what they think they want.

Thanks!

:D

On Wed, Nov 12, 2014 at 12:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Derek Moore <derek.p.moore@gmail.com> writes:
>
>> I have a case where I would like to smudge files according to the
>> reflog information of the switching-to branch.
>
> Don't do that.
>
> When you have branches A, B and C, and a path F is the same between
> branches A and B but different in branch C, if you start from branch
> C and switch to branch A, F will be updated and obtain your smudge
> tailored for "branch A's instance of F".
>
> But if you then switch to B from that state, F will not even be
> modified (i.e. it will keep the contents you prepared for "branch
> A's instance of F").
>
> In short, do not make clean/smudge depend on anything but blob
> contents.
