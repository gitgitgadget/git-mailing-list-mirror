From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Tue, 19 Apr 2016 16:02:55 -0700
Message-ID: <CA+P7+xp60r6Tsv0_=Qy6Wo39MmXMbCba7g5goPQD-e8FNaaEjw@mail.gmail.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
 <1461013950-12503-3-git-send-email-sbeller@google.com> <20160419050342.GA19439@sigill.intra.peff.net>
 <CAGZ79kbzg7SmJHFpxeJNKmLaEEw+irCxUedo45jGx8G8fmPtKg@mail.gmail.com> <20160419170624.GA3999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 01:03:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asefx-00014r-CR
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbcDSXDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 19:03:17 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36712 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbcDSXDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:03:16 -0400
Received: by mail-vk0-f51.google.com with SMTP id n67so34005466vkf.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9XdVoBwG7dsFj0FESvKjeQC6SKol+H6wv6Tx+waMPIM=;
        b=Y3HoNloytd01Vicre5qaIrJZquzwEV60L4LQX+CelG7Ee1Vo5jF9BcNvnmUJPXcXre
         flGELDh+V4/9SWlAPEfqRzBvVRZevtqoOwxgF973PKrQp9btNCC3X3zeFooaOkWVZ8P3
         nbHJ1bdM0ljuyfAyZxergf/zbhsok+ZXvTXzg4TEK8JT33ysWsYqf3aD/3Raw8iaeC7L
         cjzL3Z2/4kjyJt/M7Msn3Az5/3zPm0sXoC6EBvuKQ/PC+vg2gJCpKmMH7EeLe84KvzW0
         hwun1nLYLibjzR00MbpK0dNbXxJlZ7qrnJCIOgoa6Gx8JHIinfusfJHaVFtQ+mw/SPQa
         Dxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9XdVoBwG7dsFj0FESvKjeQC6SKol+H6wv6Tx+waMPIM=;
        b=Ze59OAUNScvnJnI78pPhAlfOl++r4VRx9qc/cL2vLaPNxre4qdZgHAiUR0Yd4Qtau+
         D8PJQgFSYZs9T/qu2cLrk8bXfg6NUCMlA2swPE5UlEci0eRYsrJfzHareqaTXrxtj6IO
         5JyisrkdrEoSC0EDsofjWVBIK4J6zrDe5RyC+lJs3P2lemz2uEIH3b86eLwSgdakrloV
         w5dctsMB8EBvWUjBEsTazSapDHA73WEY83ObpbgunVGqmULNkTaaxcKtWLhfg7yDfyXv
         lHpbxMDDrl+0lMdMsfTjswI6YMaCWdvdTxMf6NrGR9XKHLyfh5r/tp+9Z3qmQIg76KYi
         Au6Q==
X-Gm-Message-State: AOPr4FW1RTJRRVC+OAKb/yTAIZNUIjQLgVKyPY/6v2WvTplKOs18XOu4lyDWlxThjFt2UoPltC3JV+fH7CfPYQ==
X-Received: by 10.31.1.67 with SMTP id 64mr2688213vkb.130.1461106995431; Tue,
 19 Apr 2016 16:03:15 -0700 (PDT)
Received: by 10.159.53.112 with HTTP; Tue, 19 Apr 2016 16:02:55 -0700 (PDT)
In-Reply-To: <20160419170624.GA3999@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291948>

On Tue, Apr 19, 2016 at 10:06 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 19, 2016 at 08:17:38AM -0700, Stefan Beller wrote:
>
>> On Mon, Apr 18, 2016 at 10:03 PM, Jeff King <peff@peff.net> wrote:
>>
>> > I guess this will invalidate old patch-ids, but there's not much to be
>> > done about that.
>>
>> What do you mean by that? (What consequences do you imagine?)
>> I think diffs with any kind of heuristic can still be applied, no?
>
> I mean that if you save any old patch-ids from "git patch-id", they
> won't match up when compared with new versions of git. We can probably
> ignore it, though. This isn't the first time that patch-ids might have
> changed, and I think the advice is already that one should not count on
> them to be stable in the long term.
>
> -Peff

Plus they'll be stable within a version of Git, it's only recorded
patch ids that change, which hopefully isn't done very much if at all.

Thanks,
Jake
