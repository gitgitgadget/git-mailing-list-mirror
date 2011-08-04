From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/48] Handling more corner cases in merge-recursive.c
Date: Thu, 4 Aug 2011 11:26:20 -0600
Message-ID: <CABPp-BE=9r+upGUD45J7fPshqQE97UMZzaA+cu_WJ1A2p_Bigg@mail.gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
	<7v4o1y81sv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 19:26:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp1gl-0003Mo-QT
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 19:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab1HDR0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 13:26:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46055 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab1HDR0W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 13:26:22 -0400
Received: by fxh19 with SMTP id 19so1932930fxh.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 10:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tfpa3Frv+t1XtEufzbe61oTVzQKnI+zKcj9YSIQNHrI=;
        b=CyBNGCB8DIcv8We5zpBm4YrlX61XAkhIAJdfe3gfg7UZoM7z3gd0cxaR4DLwb+QFpI
         rcT+tsY2gnex1itlH03dEAtjPynth3jfPi1xhsvedv+KWwXrCnf7lDumqbIvq5ZGnAhC
         yk0gFrEarq3Lov85rib2fqo1gRYVHgcG8h7Wc=
Received: by 10.223.91.147 with SMTP id n19mr615073fam.53.1312478780700; Thu,
 04 Aug 2011 10:26:20 -0700 (PDT)
Received: by 10.223.109.198 with HTTP; Thu, 4 Aug 2011 10:26:20 -0700 (PDT)
In-Reply-To: <7v4o1y81sv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178753>

On Wed, Aug 3, 2011 at 6:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Unfortunately I seem to have found a regression that manifests in the real
> life.
>
> When this series is merged to 'next', it mismerges a trivial renamed path.

I know the problem, and can think of a couple potential solutions but
I'm not sure which one of those (if any) should be used.  I may need
advice from an unpack_trees expert.

This breakage was introduced in d487486 (merge-recursive: When we
detect we can skip an update, actually skip it 2011-06-08), and the
reason for the breakage is that was_tracked(path) is lying to us.  Let
me explain...

If you run with GIT_MERGE_VERBOSITY=3, you'll note that you get the message
  "Skipped two (merged same as existing)"
which is NOT the path it should be taking.  The reason for this is
that the call to was_tracked('two') just before that is returning true
for us when the correct answer is false.  Explaining why we get the
wrong answer requires understanding a couple things.

Using your simple reproduction recipe as an example to explain this,
the sha1sums and paths for your merge case are:
  Base commit: d00491f... one
  HEAD commit: 0cfbf08... one
  side commit: d00491f... two
In other words, 'one' is modified in HEAD, and unchanged other than
being renamed (to 'two') on side.

Now, was_tracked() simply checks whether there is a cache entry in the
current index with either stage 0 or stage 2.  Clearly, I was
expecting 'two' to only appear with stage 3, but that's not what
happened.

When unpacking these trees, we got three cache entries: one for path
'one' at stage 1, one for path 'one' at stage 2, and one for path
'two' at stage 0.  Yes, stage 0 and not stage 3.  The reason for this
is that this is case 2ALT from
Documentation/technical/trivial-merge.txt:

case  ancest    head    remote    result
----------------------------------------
...
2ALT  (empty)+  *empty* remote    remote

This means the threeway_merge code considers it a clean merge and
calls merged_entry on it, which clears the CE_STAGEMASK bits from the
cache entry flags.

Since the cache entry for path 'two' has the CE_STAGEMASK bits
cleared, when we call was_tracked on that path, we get back the answer
true.  'two' was not tracked in HEAD, though, so this is the wrong
answer and the source of the bug.


Now, the question is...how do we fix the was_tracked function?  It
would be nice to make use of the original index we had before
unpacking, but that is overwritten at the end of unpack_trees.  Should
we save it somewhere?  Or should we save off all the tracked filenames
before unpacking into a linked list and then have was_tracked() use
that instead of looking it up in the current cache? (I'm slightly
worried that may be slow given the number of lookups that exist).

Thoughts?

Elijah
