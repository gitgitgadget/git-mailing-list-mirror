From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 6/5] sequencer.c: refrain from adding duplicate s-o-b lines
Date: Fri, 16 Nov 2012 15:55:43 -0800
Message-ID: <CA+sFfMfQz1qWpVZ4GCJdN8rOQNn+zkh9cd5wd7ouZL9xyqZRJQ@mail.gmail.com>
References: <1352943474-15573-5-git-send-email-drafnel@gmail.com>
	<1353021875-7552-1-git-send-email-drafnel@gmail.com>
	<7v4nkq8fsn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>,
	Brandon Casey <bcasey@nvidia.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 00:56:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZVlO-0001yH-Uf
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 00:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567Ab2KPXzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 18:55:45 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:61549 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab2KPXzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 18:55:44 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so3429279vcb.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 15:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A4wpUbqjHXOfJOYYTvGQPMB64KrFPZ2pUrSHuiFatQI=;
        b=ioMzdityr0CLgE6Z/t8b+pWrISUyUIdcd3HrUXB+r60i3HyG3111hbU0dBEw+Kq7N5
         mJ/nQg+O5yXNIjusHGVhTMXQtJP9I+DmzJSYVudd+7UcewlfWcQwWOWri3KGFJtWZXPz
         kKahEJNCY+HX73p1BZN4QH/WYQW3o304ESOSvSBDvk3UL3PJC8Kt4/GA06bfCnpn38Yn
         Hxz3OCoGOPGIh907ErD+P7KOZXr+E6uCFC6nNYYLr9e+kwQsPsUwtRQr32tZk1NB3xHg
         bIQqWjzitNTATal9FUG+sBErOfMpcAkfjGLsUut9ONc+xs6LsN8N0FVHkzEj3PmKUmjq
         9U6A==
Received: by 10.58.172.103 with SMTP id bb7mr9499882vec.41.1353110143561; Fri,
 16 Nov 2012 15:55:43 -0800 (PST)
Received: by 10.58.143.5 with HTTP; Fri, 16 Nov 2012 15:55:43 -0800 (PST)
In-Reply-To: <7v4nkq8fsn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209922>

On Thu, Nov 15, 2012 at 6:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> Detect whether the s-o-b already exists in the commit footer and refrain
>> from adding a duplicate.
>
> If you are trying to forbid
>
>         git cherry-pick -s $other
>
> from adding s-o-b: A when $other ends with these two existing s-o-b:
>
>         s-o-b: A
>         s-o-b: B
>
> then I think that is a wrong thing to do.
>
> In such a case, the resulting commit should gain another s-o-b from
> A to record the provenance as a chain of events.  A originally wrote
> the patch, B forwarded it (possibly with his own tweaks), and then A
> picked it up and recorded the result to the history, possibly with a
> final tweak or two.

Hmm.  I've never thought that it was necessary to add an additional
sob for the patches that I've cherry picked that I had previously
signed-off-on.  I considered one sign-off to be enough.  In your
example, A is the committer and the patch set already contains A's
sign-off.  For me that indicates that A still considers the commit to
comply with whatever s-o-b implies.

We also seem to have a few tools to help people avoid adding duplicate
sob's, like the current behavior of format-patch and the sample
commit-msg hook.

I did some quick searching through the kernel commits to try to find
some examples that could set a precedence.  I didn't find anything
that supported either argument.  I didn't see any commits that were
cherry-picked _and_ had an existing sob that was not the last sob.  I
didn't see any that had duplicate sob lines either.  I'm not
mentioning this to say that lack of a prior use should mean we should
actively disallow the practice of adding duplicate sob's, I'm just
providing it as a data point.

I've always thought that the reason that 'commit -s' and 'cherry-pick
-s' checked only the last line of the commit message was simply that a
full scan of the footer had not been implemented.

Whichever behavior is determined to be the right way for git to do it,
format-patch should be brought in-line with the others and be built on
top of the code in sequencer.c.  So, if git _should_ create duplicate
sob's then this patch should just be dropped.  Duy's unification patch
can just be built on top of sequencer.c:append_signoff() without
bringing over any of the duplicate sob detection from log-tree.c.

-Brandon
