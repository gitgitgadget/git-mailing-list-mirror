From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 5/8] branch: drop non-commit error reporting
Date: Thu, 24 Sep 2015 11:53:17 +0530
Message-ID: <CAOLa=ZS9oY0E43CqevAroECD40aPj6cmh=eP1qj5GOvjoj_-EQ@mail.gmail.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
 <1443031873-25280-6-git-send-email-Karthik.188@gmail.com> <xmqqfv25x80c.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 08:23:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zezwd-0003aP-94
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 08:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504AbbIXGXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 02:23:47 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34934 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbbIXGXr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 02:23:47 -0400
Received: by ykdz138 with SMTP id z138so65213216ykd.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 23:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A1HRnLQ3l1nZnQeQM93VaHTdfzbsNh3xHmg7PfaYoF8=;
        b=J96Y7Pa5EXP8IuXmdPwJzakzO9laJPod8DTKHD9nAknpfrSJjOA6ydDE/ADUXpkY5G
         LvTwxzX/2g91V/l0x56CJ2+dDJOaRuZG9dtAZt5xEKaR6BlNm1Zhiy9nk4NWj+c4a2HQ
         zYh+f2//X92a0NWFFE5Z9Q0TGYahJ7jDCg48J1T4oWE2LqAQKzOWLes4g8fmcj8rVz4r
         REmPWw/QigwgLI10jkO0ivntr3nlfzYjnR3EXeygkM43MbbHIFuHPt98VtuF0aIIybQ4
         tGe9vNSlch77/w17uPNXWL7A2evuxiPlZxC6LUItzGULVnwwh2sZyUU4Cd+VG4BnMNBh
         F63g==
X-Received: by 10.31.164.132 with SMTP id n126mr25433920vke.72.1443075826417;
 Wed, 23 Sep 2015 23:23:46 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Wed, 23 Sep 2015 23:23:17 -0700 (PDT)
In-Reply-To: <xmqqfv25x80c.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278535>

On Thu, Sep 24, 2015 at 12:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Remove the error reporting variable to make the code easier to port
>> over to using ref-filter APIs.
>>
>> This also removes the error from being displayed. As branch.c will use
>> ref-filter APIs in the following patches, the error checking becomes
>> redundant with the error reporting system found in the ref-filter
>> (ref-filter.c:1336).
>
> Hmm, do you mean these lines by the above reference?
>
>         if (filter->merge_commit || filter->with_commit) {
>                 commit = lookup_commit_reference_gently(oid->hash, 1);
>                 if (!commit)
>                         return 0;
>
> That is "silently return ignoring it if it is not a commit", i.e.  I
> do not think that deserves to be called error REPORTING system.
>
> Do you really understand what the error message you are removing is
> trying to diagnose?  A branch ref must not point at a blob or any
> non-commit object, and if we find such a branch ref, we report it as
> error.  That is what the error message is about.

What you're saying makes sense, It doesn't reflect the fact that the error
reporting is dropped, rather seems to be substituted by ref-filter.

>
> Now, ref-filter.c:1336 has in no position to issue that same error
> message because it does not know what it is looking at is supposed
> to be a branch ref, so it is WRONG if it gave the same error
> message.  After all, the caller may be using ref-filter to filter
> refs/tags/* with merge_commit or with_commit and found a
> light-weight tag in refs/tags/* that points at a blob.  That is not
> an event we want to get an error at all.
>
> I do not think we terribly mind if this message goes away from this
> location.  "It is a wrong codepath whose purpose is not to diagnose
> and report a repository corruption.  If we care about such a
> repository corruption, we should report it from fsck instead", would
> bea valid justification for the removal of the message.

Seems good, I'll incorporate this into the commit message.

>
> It is not a valid justification to claim that it is made redundant,
> when you actually are simply LOSING the error reporting without
> giving the same error message from another codepath to make it truly
> redundant.

Yes, my bad, Will resend the patch.

-- 
Regards,
Karthik Nayak
