From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] pkt-line: support tracing verbatim pack contents
Date: Tue, 16 Jun 2015 09:39:19 -0700
Message-ID: <xmqqvben6214.fsf@gitster.dls.corp.google.com>
References: <20150612212526.GA25447@peff.net>
	<20150612212827.GC25757@peff.net>
	<CAHcr6HYvVR4uTmtegWHK0h+v_aVs4JVLsSwvjthGY3pb=-Q0yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Augie Fackler <augie@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 18:39:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4ttX-00072I-PI
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 18:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbbFPQjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 12:39:23 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:32870 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbbFPQjW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 12:39:22 -0400
Received: by igbos3 with SMTP id os3so48191582igb.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=V0JDcdw2mBtr06nLdeYIWlTRW49RoHoud4LZ7blKT/c=;
        b=qmAndrNgKLHKRajQPrgqY35gCtXi6PpvxTDL3JJ8h9Ga1inq3NZfL/g/6znj13Vfxx
         7Dn0zQgkJK8yDAnEblCQACRGvbAQdR9rdO9Ai+CNXKLdOeWTEi3SaosqJYQLeH8zuF3O
         1Bze3iSti/K6XZvOD8gP4YdhsABNyBDcMfYKBppJj33VLPrntXMGMNuurFyAYsvYObzh
         cDgVIucy5lXJbnvnNvBhhUL/HNCVy1gggCbtHHxSr96Tya8LutHuDH+xHMgBcNjJkN2H
         x0lnLsrLAIrje0et9N0sriPlPysR8P8ivKW5IEliyhfxpqDAzsBDY2e5kVOvLjRyK30Z
         7rbg==
X-Received: by 10.107.135.138 with SMTP id r10mr1780480ioi.13.1434472761908;
        Tue, 16 Jun 2015 09:39:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6c2b:219c:23d9:cf91])
        by mx.google.com with ESMTPSA id u38sm836479ioi.0.2015.06.16.09.39.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jun 2015 09:39:20 -0700 (PDT)
In-Reply-To: <CAHcr6HYvVR4uTmtegWHK0h+v_aVs4JVLsSwvjthGY3pb=-Q0yQ@mail.gmail.com>
	(Augie Fackler's message of "Tue, 16 Jun 2015 11:38:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271777>

Augie Fackler <augie@google.com> writes:

> On Fri, Jun 12, 2015 at 5:28 PM, Jeff King <peff@peff.net> wrote:
>> When debugging the pack protocol, it is sometimes useful to
>> store the verbatim pack that we sent or received on the
>> wire. Looking at the on-disk result is often not helpful for
>> a few reasons:
>>
>>   1. If the operation is a clone, we destroy the repo on
>>      failure, leaving nothing on disk.
>>
>>   2. If the pack is small, we unpack it immediately, and the
>>      full pack never hits the disk.
>>
>>   3. If we feed the pack to "index-pack --fix-thin", the
>>      resulting pack has the extra delta bases added to it.
>>
>> We already have a GIT_TRACE_PACKET mechanism for tracing
>> packets. Let's extend it with GIT_TRACE_PACK to dump the
>> verbatim packfile.
>
> FWIW, this also works for me - I have no preference between my patches
> and Jeff's. I suspect yours are much better given that you have a clue
> about git internals ;).
>
> One bit of feedback is that it might be worth mentioning (though I
> don't feel strongly) that GIT_TRACE_PACK works with or without
> GIT_TRACE_PACKET - that wasn't immediately obvious to me, but it makes
> sense once I read the code.
>
> Thanks!

Thanks, both.  I think this series makes sense.

As to the documentation, I have a feeling that, unless the reader
and/or the user intimately knows that TRACE_PACK is implemented by
hooking into the same mechanism that TRACE_PACKET needs to, s/he
would not even wonder if TRACE_PACKET needs to be enabled when
asking for TRACE_PACK.  Yes, one is a proper substring of the other,
but the similarity between the two stops there.  While I do not
think it would hurt very much to mention that they are independent,
I have a slight suspicion that it might make it more likely to get
user confused.
