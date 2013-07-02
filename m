From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] fetch-pack: avoid quadratic behavior in rev_list_push
Date: Tue, 2 Jul 2013 03:52:04 -0400
Message-ID: <CAPig+cRYdinZVA0+nU6tU_TcusFu6Pe0qaQ5Bv4Xbmg1izDbLQ@mail.gmail.com>
References: <20130702061149.GB1206@sigill.intra.peff.net>
	<20130702062420.GC27856@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 02 09:52:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtvNj-0003LA-01
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 09:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116Ab3GBHwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 03:52:07 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35843 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab3GBHwE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 03:52:04 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so11432167iec.41
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 00:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Y/NmE4LRvMdLhxsC4V19M6xhwzhSzw4XI+dx37BKn7Y=;
        b=A8hTMsv+mtcE3YmzbzTP+eA7rXT7bGReK8pV87dk/yDLrnxI+jliJg4eiqSUmNWZDe
         fDFUjjxbML5OpOZnA/LkTEd4aGJ3rvAKiMyCpawZtga0kOg355+5+hMR6IaPLgh56SLj
         0oE4IXp68KBsOhDNrzu3RMCdFULM2hu3Y7+c7Mx44UN8gXmpDfxdhWLznyblDQ+4HJHJ
         fBrLCCbTaomPZCah43qyR6+Cw2ye+MN4FSpueBnfqzUeq8Yc8QAPykkCJyeX8QwwmCpu
         IEgs9JZm12zT5cGm0ME114SJWo1SXKHTabtP/ewmSivXDps+d1HWH4/deoZGd1lQNq+R
         yWog==
X-Received: by 10.50.61.236 with SMTP id t12mr18736685igr.46.1372751524232;
 Tue, 02 Jul 2013 00:52:04 -0700 (PDT)
Received: by 10.64.86.164 with HTTP; Tue, 2 Jul 2013 00:52:04 -0700 (PDT)
In-Reply-To: <20130702062420.GC27856@sigill.intra.peff.net>
X-Google-Sender-Auth: -SH-CX-NI6Nmi1d5YSWvbH3nWqY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229371>

On Tue, Jul 2, 2013 at 2:24 AM, Jeff King <peff@peff.net> wrote:
> When we call find_common to start finding common ancestors
> with the remote side of a fetch, the first thing we do is
> insert the tip of each ref into our rev_list linked list. We
> keep the list sorted the whole time with
> commit_list_insert_by_date, which means our insertion ends
> up doing O(n^2) timestamp comparisons.
>
> We could teach rev_list_push to use an unsorted list, and
> then sort it once after we have added each ref. However, in
> get_rev, we process the list by popping commits off the
> front and adding parents back in timestamp-sorted order. So
> that procedure would still operate on the large list.
>
> Instead, we can replace the linked list with a heap-based
> priority queue, which can do O(log n) insertion, making the
> whole insertion procedure O(n log n).
>
> As a result of switching to the prio_queue struct, we fix
> two minor bugs:
>
>   1. When we "pop" a commit in get_rev, and when we clear
>      the rev_list in find_common, we do not take care to
>      free the "struct commit_list", and just leak its
>      memory. With the prio_queue implementation, the memory
>      management is handled for us.
>
>   2. In get_rev, we look at the head commit of the list,
>      possibly push its parents onto the list, and then "pop"
>      the front of the list off, assuming it is the same
>      element that we just peeked at. This is typically going
>      to be the case, but would not be in the face of clock
>      skew: the parents are inserted by date, and could
>      potentailly be inserted at the head of the list if they

s/potentailly/potentially/

>      have a timestamp newer than their descendent. In this
>      case, we would accidentally pop the parent, and never
>      process it at all.
>
>      The new implementation pulls the commit off of the
>      queue as we examine it, and so does not suffer from
>      this problem.
>
> With this patch, a fetch of a single commit into a
> repository with 50,000 refs went from:
>
>   real    0m7.984s
>   user    0m7.852s
>   sys     0m0.120s
>
> to:
>
>   real    0m2.017s
>   user    0m1.884s
>   sys     0m0.124s
>
> Before this patch, a larger case with 370K refs still had
> not completed after tens of minutes; with this patch, it
> completes in about 12 seconds.
>
> Signed-off-by: Jeff King <peff@peff.net>
