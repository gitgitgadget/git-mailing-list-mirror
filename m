From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] test: accept death by SIGPIPE as a valid failure mode
Date: Thu, 5 Nov 2015 10:34:53 +0100
Message-ID: <457EAFF7-C649-4DEB-BB9E-E82851DC7F8A@gmail.com>
References: <9A3BCDA2-5915-4287-A385-95A3ACCBB850@gmail.com> <CABA5-z=1N5=8huSr=BLmjj_KHLbMMiXdo0qok7Mc_ZOeB=J9jA@mail.gmail.com> <CFEB6E3F-48A0-41D8-A8FD-D48B806461DB@gmail.com> <xmqq8u6qluh2.fsf@gitster.mtv.corp.google.com> <xmqqvb9ojcmf.fsf@gitster.mtv.corp.google.com> <xmqqr3kcjbll.fsf_-_@gitster.mtv.corp.google.com> <20151105074730.GA6819@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>,
	Fredrik Medley <fredrik.medley@gmail.com>,
	patrick.reynolds@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 10:35:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuGwn-0007yQ-G4
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 10:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030904AbbKEJfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 04:35:01 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34013 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756585AbbKEJe4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2015 04:34:56 -0500
Received: by wmnn186 with SMTP id n186so8722144wmn.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2015 01:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qXPbVRD8alL80y0UfARHqFygqCbYxA4tzntW6Fe/aLA=;
        b=rFKH3N3/U3FU8XjPA5tisc2HAzIJX4alvLOcHMYqvmrnUQv1E/gXJdB7jPKGK+tHnF
         Gtr5uS/SQSiEK5MRktcgTEEmssVNZjw5L2Mq//HW0mKt8okqgS7XpuRcaQ8lTcq5fgPb
         uU6eQxLjszv2GW99iOl3L++0yXGxMZqVruJLJenRIN7mrOv4xTKYAzAWvyXp34Dcu3Nr
         lx7QHhywOW3hpWunB9F1OEGaos0bqo7Eu9JzdCE8y5efmWIbRd6+9V4w3Qw9ziBurn4b
         lMI8sgRq1YUnTnGQKQy8gkKFBVOIJ2xdCCQ6QW6d9XCg5pnJCJU24q/A1yvYjBQDSxo4
         0I0g==
X-Received: by 10.28.16.1 with SMTP id 1mr2162344wmq.57.1446716095228;
        Thu, 05 Nov 2015 01:34:55 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id m137sm33118163wmb.2.2015.11.05.01.34.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Nov 2015 01:34:54 -0800 (PST)
In-Reply-To: <20151105074730.GA6819@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.3094)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280918>


> On 05 Nov 2015, at 08:47, Jeff King <peff@peff.net> wrote:
> 
> On Fri, Oct 30, 2015 at 02:22:14PM -0700, Junio C Hamano wrote:
> 
>> On a local host, the object/history transport code often talks over
>> pipe with the other side.  The other side may notice some (expected)
>> failure, send the error message either to our process or to the
>> standard error and hung up.  In such codepaths, if timing were not
>> unfortunate, our side would receive the report of (expected) failure
>> from the other side over the pipe and die().  Otherwise, our side
>> may still be trying to talk to it and would die with a SIGPIPE.
>> 
>> This was observed as an intermittent breakage in t5516 by a few
>> people.
>> 
>> In the real-life scenario, either mode of death exits with a
>> non-zero status, and the user would learn that the command failed.
>> The test_must_fail helper should also know that dying with SIGPIPE
>> is one of the valid failure modes when we are expecting the tested
>> operation to notice problem and fail.
> 
> Sorry for the slow review; before commenting I wanted to dig into
> whether this SIGPIPE ambiguity was avoidable in the first place.
> 
> I think the answer is "probably not". We do call write_or_die() pretty
> consistently in the network-aware programs. So we could ignore SIGPIPE,
> and then we would catch EPIPE (of course, we convert that into SIGPIPE
> in many places, but we do not have to do so). But since the SIGPIPE
> behavior is global, that carries the risk of us failing to check a write
> against some other descriptor. It's probably not worth it.
> 
> Teaching the tests to handle both cases seems like a reasonable
> workaround. Changing test_must_fail covers a lot of cases; I wondered if
> there are other tests that would not want to silently cover up a SIGPIPE
> death. But I could not really think of a plausible reason.
> 
> So I think your patch is the best thing to do.
> 
> -Peff

Oh, I missed this email thread. I am still working on a stable Travis-CI integration and I ran into this issue a few times. I fixed it in my (not yet published) patch with an additional function "test_must_fail_or_sigpipe" that I've used for all tests affected by this issue. Modifying the "test_must_fail" function seemed too risky for me as I don't understand all possible implications. However, if you don't see a problem then this is fine with me.

- Lars