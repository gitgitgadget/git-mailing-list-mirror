From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: avoid checking out $branch when possible
Date: Fri, 20 Apr 2012 13:06:19 -0700
Message-ID: <xmqqmx66mamc.fsf@junio.mtv.corp.google.com>
References: <fee3225e29915e1b61e29a5d2fe37db20fa4b596.1334933837.git.trast@student.ethz.ch>
	<xmqqwr5atn89.fsf@junio.mtv.corp.google.com>
	<87lilqjstf.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	"Martin von Zweigbergk" <martin.von.zweigbergk@gmail.com>,
	Shezan Baig <shezbaig.wk@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Apr 20 22:06:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLK67-0007OB-Mq
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 22:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340Ab2DTUGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 16:06:23 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:51024 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab2DTUGW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 16:06:22 -0400
Received: by bkcjm19 with SMTP id jm19so475059bkc.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 13:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=bLXOHo8cfUeucJhQLq7rKqMcdiKBE98aLAyFwc+gJdU=;
        b=gE7t2/iPRWY1ZRu9pB8gIYaehkTzQ9ExrobB7NCoAr1RKeHRPUW5jztRoaJULIs02P
         0L9A0N/wOQ1TtApkVnB9kLUlPc1IkvcW0gpK8iK5UsQ3RUge0/koqXGaswbxm94YrxkU
         YXZMe94Ml72rUcGEoQ5AM8fJdcdqWWnaeoRWkpCUfzmSwNO+vOC0CajKsRFWCD48ovgB
         4Vag8szrHn5g3v7RrNn4hksZyb1A2UpmOIl2gjzlkz5UD8zaGyLBDGyKmaaD4JVWLYWy
         +LQdEUrJvn+ugbeEkK62Ymi0895AhnyhicEREv3X6+zU+XTTrVUGvHeqM3dyf3sXRU12
         MZBA==
Received: by 10.14.48.66 with SMTP id u42mr2147546eeb.5.1334952381125;
        Fri, 20 Apr 2012 13:06:21 -0700 (PDT)
Received: by 10.14.48.66 with SMTP id u42mr2147529eeb.5.1334952380979;
        Fri, 20 Apr 2012 13:06:20 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si6213111een.0.2012.04.20.13.06.20
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 20 Apr 2012 13:06:20 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id C36D12000FF;
	Fri, 20 Apr 2012 13:06:20 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 16799E120A; Fri, 20 Apr 2012 13:06:20 -0700 (PDT)
In-Reply-To: <87lilqjstf.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
	"Fri, 20 Apr 2012 18:01:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQm6osFHHyQdYiVCOy0i9v4W2RU2fceFhDtY4DR5sxvlU5YFjNMM+PXHHjwclaoVCvS1lsd7ODXqPxUgQK3HNyEyW/yL/Ig2l2EagnqdWaGsCeh0YmaGu77zszoqtar1Z3jrS5H6GprYCoJ3sLs2q77znMQ+qsWdmDEGY8R1vGrsJlbY4S4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196017>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> I was a bit torn on whether I should abort with checkout, or without
>>> it.  The manual clearly states that rebase "will perform an automatic
>>> git checkout <branch> before doing anything else", which mandates at
>>> least *trying* the checkout in the error path, hence this version.
>>>
>>> However, in contrived cases this can lead to strange behavior.  For
>>> example, a checkout conflict with a file in the worktree may prevent
>>> the abort path from working correctly, even though going through with
>>> the rebase itself may succeed.
>>
>> Given all that contortion, is it even worth doing this?
>
> Well, the logic isn't new; 0cb0664 already does the same.  It just never
> carried over to interactive rebase.

OK.

The discrepancy in the "abort" case may come only in the three cases:

 - EDITOR is pointing at something funny; it is not worth introducing
   any backward incompatibility to optimize for this case, so
   abort-with-checkout is the right thing to do here.  One less thing we
   have to worry about (but see the third point below).

 - It turns out that everything is already contained and there is
   nothing to apply, i.e. after this sequence:

	git checkout branch
	git checkout $onto_or_merge_base_between_base_and_branch

   we find out that "git cherry $onto_or_merge_base branch" is empty.

   Because you will be one commit ahead of $onto_or_merge_base if "git
   cherry" were to give one commit to be replayed, I think it is
   logically correct if you stayed at the $onto_or_merge_base without
   checking out <branch>.  In other words, abort-with-checkout is not
   ideal for this case; we would want to just abort in this case.

 - The user told us not to do the rebase by making insn sheet empty.  In
   other words, this is "aborting the entire rebase", so ideally it
   should come back to the state before the user ran "git rebase"
   command (i.e. where she was before we switched to <branch>).

   I do not think this ideal behaviour is something neither batch or
   interactive rebase has traditionally implemented, but I can see how
   we can sell this as a bugfix to the end users.
