From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git am --abort" screwing up index?
Date: Sun, 16 Aug 2015 16:33:33 -0700
Message-ID: <CA+55aFwwD=K-i9d40N5FtnTLT-ApZOzmgnXhnuA=C0zw2eBt3Q@mail.gmail.com>
References: <CA+55aFwDkQAS8ULiLt9N5NVOYJ242Nd2MOWeiRX8HrVHXf2zog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 01:33:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZR7Qp-00051r-W5
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 01:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbbHPXdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 19:33:35 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36129 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbbHPXde (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 19:33:34 -0400
Received: by igxp17 with SMTP id p17so44338148igx.1
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FnIeBe3mJ5qBGoDdlyO7303+mZS3YnLOTu4qB/K8RD0=;
        b=xYqDIAwnq+ETGIPewvwIqkdUPDNFTE2UrrlFszax2nT696figieH7PcXbIitv6eZEn
         FfNCsw1ymqaFfBeP0XAnjrz7cld1OU8lhLps+8drBW47QebX3dAGWe1QfQNaRvDbHFzP
         SyFl0BgQ6wVznmC5N323OzCR7W5qX16W7R0xtwK6b+2CRh+oeYnc4PBqccJkjb2GbZD1
         nAdD0N80SjmyiwUvofNm6gp2qNRV3hNfccz6LXVMTedn0n3KFYGyolRX2NFeY9DP/tFs
         5bqNAncMNj4dZmYnBkVVp0LQsVUJqDrzwdmZPBigmmgHDBYn8R4ZTaFkdn4Qy2/eBSsC
         Dd8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FnIeBe3mJ5qBGoDdlyO7303+mZS3YnLOTu4qB/K8RD0=;
        b=DJ1WfuHgVXnPLT7tZ58uNjt4kfDoMsMRiekIdXAz51irhhYrmUnMMTyZLaCW73OQv4
         6wj8Th9c9WgZDborZlNMP2CgdssL7xS03XnQ9It90YpMnw77r6+to7o3j7e0eu6jU3tX
         t88jxGZXSGJIzieSfS2RsS3deS9mxo10h7GfM=
X-Received: by 10.50.102.68 with SMTP id fm4mr13226942igb.25.1439768014152;
 Sun, 16 Aug 2015 16:33:34 -0700 (PDT)
Received: by 10.36.219.130 with HTTP; Sun, 16 Aug 2015 16:33:33 -0700 (PDT)
In-Reply-To: <CA+55aFwDkQAS8ULiLt9N5NVOYJ242Nd2MOWeiRX8HrVHXf2zog@mail.gmail.com>
X-Google-Sender-Auth: wt4fWYAI4WxuYQOUH7Cw8DNJpzY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276025>

On Sun, Aug 16, 2015 at 12:46 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Maybe it has always done this, and I just haven't noticed (I usually
> _just_ do the "git reset --hard" thing, don't ask me why I wanted to
> be doubly sure this time). But maybe it's an effect of the new
> built-in "am".

I bisected this. It's definitely used to work, and the regression is
from the new built-in am. But I cannot bisect into that branch
'pt/am-builtin', because "git am" doesn't actually work in the middle
of that branch.

So I've verified that commit c1e5ca90dba8 ("Merge branch
'es/worktree-add'") is good, and that commit 7aa2da616208 ("Merge
branch 'pt/am-builtin'") is bad, but I cannot pinpoint the exact
commit where "git am --abort" starts breaking the index.

But I assume it's simply that initial implementation of "--abort" in
commit 33388a71d23e ("builtin-am: implement --abort") that already
ends up rewriting the index from scratch without applying the old stat
data.

The test-case is pretty simple: just force a "git am" failure, then do
"git am --abort", and then you can check whether the index stat()
information is valid in various ways. For the kernel, doing a "git
reset --hard" makes it obvious because the reset will force all files
to be written out (since the index stat information doesn't match the
current tree). But you can do it by just counting system calls for a
"git diff" too. On the git tree, for example, when the index has
matching stat information, you get something like

  [torvalds@i7 git]$ strace -cf git diff
  ..
    0.04    0.000025           1        26         4 open
  ..

ie you only actually ended up with 26 open() system calls. When the
index is not in sync with the stat information, "git diff" will have
to open each file to see what the actual contents are, and you get

  [torvalds@i7 git]$ strace -cf git diff
  ...
    0.30    0.000070           0      5987       302 open
  ...

so now it opened about 6k files instead (and for the kernel, that
number will be much larger, of course).

I _think_ it's because git-am (in "clean_index()") uses read_tree(),
while it probably should use "unpack_trees" with opts.update and
opts.reset set (like reset_index() does in builtin/reset.h).

I have to go off do my weekly -rc now, and probably won't get to
debugging this much further. Adding Stefan to the cc, since he helped
with that "--abort" implementation.

          Linus
