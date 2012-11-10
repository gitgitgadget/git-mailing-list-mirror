From: John Szakmeister <john@szakmeister.net>
Subject: Re: Rename edge case...
Date: Fri, 9 Nov 2012 21:01:03 -0500
Message-ID: <CAEBDL5UGxGqE+-P54KeZnV=2Tx6Rpx=MXowJ9RdH5WPuDTg0hw@mail.gmail.com>
References: <CAEBDL5U+OSTCAqgWoApE_m21Nef24Wqvt78oB6qqV4oEvU0vXQ@mail.gmail.com>
	<20121109160925.GA19725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 03:01:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX0Nt-0000dw-Bn
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 03:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750Ab2KJCBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 21:01:06 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:63171 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab2KJCBE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 21:01:04 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so3178508iag.19
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 18:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=mz9qLnpPJyA/PWYJlC3vJLPuzJSCs9aUKj9AaoYBiYs=;
        b=vIKTLHT0eFw31nVJDhRtiuj/cmYnrkt3QzswcRbS9fWVPGxn5zLNHLfCu5kYpCIn02
         sUVqyZZNV6UF54XXG/spjvzjqYO+lyq0zpL86vxPUqjiLF3n26buuln1rrS2qq2uBeuB
         GVECi3tVQ/MjRcFNHSaJqrj/uOfXf73Enx72y9UsytBdZmu9w609o5nzU8Cl0nyLhm0i
         p9Gz3goqQNCT6E9ktc5+EQPQiDVebCM6E4Jdd3yPBiP1YLbSSo3Pjn1qg+usC/S+07td
         UFDLcFsrKTLBOzWvBDTA2IlE00QkSi8G6FNuM73m/BMUrwW87tOb+aLQ2/ttSE/wrH1Y
         ruwA==
Received: by 10.43.116.135 with SMTP id fi7mr12742023icc.3.1352512863494; Fri,
 09 Nov 2012 18:01:03 -0800 (PST)
Received: by 10.50.2.106 with HTTP; Fri, 9 Nov 2012 18:01:03 -0800 (PST)
In-Reply-To: <20121109160925.GA19725@sigill.intra.peff.net>
X-Google-Sender-Auth: F8ZhWPxRD6ewVT8OizJKRBR4kDM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209257>

On Fri, Nov 9, 2012 at 11:09 AM, Jeff King <peff@peff.net> wrote:
[snip]
> Right. If the source didn't go away, it would be a copy. We can do copy
> detection, but it is not quite as obvious what a merge should do with a
> copy (apply the change to the original? To the copy? In both places? You
> would really want hunk-level copy detection for it to make any sense).

Yeah, I wasn't advocating that.  More along the lines of what you're
talking about below...

> Usually git deals with this double-rename case through the use of
> "break" or "rewrite" detection. We notice that the old "foo.txt" and the
> new "foo.txt" do not look very much like each other, and break the
> modification apart into an add and a delete. That makes each side
> eligible for rename detection, and we can end up finding the pairs of
> renames above.

I did try using the -B option, and it did detect that foo.txt was
renamed to fooOld.txt, but it didn't show fooNew.txt being renamed to
foo.txt.  I'm running git 1.7.12.3.  It could be that 1.8.0 does
better, but I haven't tried.

> So in theory it just as simple as a one-liner to turn on break-detection
> in merge-recursive. Sadly, that only reveals more issues with how
> merge-recursive handles renames. See this thread, which has pointers to
> the breakages at the end:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/169944

Thank you.  I'll definitely read up on this.

> I've become convinced that the best way forward with merge-recursive is
> to scrap and rewrite it. It tries to do things in a muddled order, which
> makes it very brittle to changes like this. I think it needs to have an
> internal representation of the tree that can represent all of the
> conflicts, and then follow a few simple phases:
>
>   1. "structural" 3-way merge handling renames, breaks, typechanges,
>      etc. Each path in tree might show things like D/F conflicts, or it
>      might show content-level merges that still need to happen, even if
>      the content from those merges is not coming from the same paths in
>      the source trees.
>
>   2. Resolve content-level 3-way merges at each path.
>
>   3. Compare the proposed tree to the working tree and list any problems
>      (e.g., untracked files or local modifications that will be
>      overwritten).
>
> Right now it tries to do these things interleaved as it processes paths,
> and as a result we've had many bugs (e.g., the content-level merge
> conflating the content originally at a path and something that was
> renamed into place, and missing corner cases where we actually overwrite
> untracked files that should be considered precious).
>
> But that is just off the top of my head. I haven't looked at the topic
> in quite a while (and I haven't even started working on any such
> rewrite).

That certainly sounds like a better approach.

>> So I played locally with a few ideas, and was surprised to find out
>> that even breaking up the two renames into two separate commits git
>> still didn't follow it.
>
> Right, because the merge only looks at the end points. Try doing a
> "diff -M" between your endpoints with and without "-B". We do not have
> any double-renames in git.git, but you can find "-B" helping a similar
> case: most of a file's content is moved elsewhere, but some small amount
> remains. For example, try this in git.git, with and without -B:
>
>   git show -M --stat --summary --patch 043a449
>
> It finds the rename only with "-B", which would help a merge (it also
> makes the diff shorter and more readable, as you can see what was
> changed as the content migrated to the new file).

I've played with the -B option before, and it's definitely nice in
certain cases.

Thank you for taking the time to write all this up.  It was very informative!

-John
