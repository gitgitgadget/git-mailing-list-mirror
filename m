From: Junio C Hamano <gitster@pobox.com>
Subject: Re: glibc mutex deadlock in signal handler
Date: Fri, 04 Sep 2015 14:56:58 -0700
Message-ID: <xmqq7fo5g85x.fsf@gitster.mtv.corp.google.com>
References: <s5hfv2vn4wq.wl-tiwai@suse.de>
	<xmqqvbbrjrs9.fsf@gitster.mtv.corp.google.com>
	<s5h7fo7wb3e.wl-tiwai@suse.de> <87y4gn5ijr.fsf@igel.home>
	<s5hy4gmvii2.wl-tiwai@suse.de>
	<20150904092355.GA524@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Takashi Iwai <tiwai@suse.de>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 23:57:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXyyn-0007tz-Et
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 23:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933915AbbIDV5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 17:57:01 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35300 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933725AbbIDV5A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 17:57:00 -0400
Received: by pacfv12 with SMTP id fv12so36243694pac.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 14:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VLbpLKntQXqrtg9GwEQ4MHsgqJRBZuJVCpmowup4+wU=;
        b=bogLpyFUdzvET0PN5UhezpZmcXwAfmnR5B7V/ugY4J5+x3HV2dzNXNEEEVtLMvI2w1
         5lgK7cnj0SmFRDrhcgVrivWyUJDqo5kt01e2aHNmD1Zev8PKe+FLa2EN5t2oPMe6ZBMp
         eE7q2v8k4KggAl/4sdtIw8exYGZsnJ22eR4xO/kVTUnHVr9O+6qzxkaw1gKjLkLMKeBI
         Bn/Dx+qWqDNJW6qLTHAPD741mt+ArTBFk2an4DUAul8YWmotA0wN1g6NlCkZPWtpafdx
         BMPwgiRThs5euVhG81+wA8B3iuu4M4zzZcmLJ/ErJq1ETml4C+IQXvIaOAf2CwVHsHQp
         /Hgw==
X-Received: by 10.68.125.197 with SMTP id ms5mr13037087pbb.38.1441403819951;
        Fri, 04 Sep 2015 14:56:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2198:98f:3bb3:46bb])
        by smtp.gmail.com with ESMTPSA id mi6sm3625312pdb.1.2015.09.04.14.56.59
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 14:56:59 -0700 (PDT)
In-Reply-To: <20150904092355.GA524@sigill.intra.peff.net> (Jeff King's message
	of "Fri, 4 Sep 2015 05:23:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277340>

Jeff King <peff@peff.net> writes:

> Perhaps we should reconsider whether f4c3edc (vreportf: avoid
> intermediate buffer, 2015-08-11) is a good idea.  Note that snprintf is
> not on the list of safe functions, but I imagine that in practice it is
> fine. Though just avoiding error()/warning() in signal handlers might be
> a more practical solution anyway.

I had exactly the same thought when I read the initial report here.

I wish we can just do "if (in_signal) return;" at the beginning of
vreportf(), but we would not want a global variable there, so... ;-)

Further, I briefly hoped that avoiding error/warning in the signal
handler codepath would allow us to be more lax around allocations,
but I suspect that it unfortunately would not help us that much, as
we may be calling these functions in low memory situations.

So let's queue Takashi's patch as-is for now and look at other
signal codepaths.

Thanks.

	
	
