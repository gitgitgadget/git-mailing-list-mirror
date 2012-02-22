From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH] cherry-pick: No advice to commit if --no-commit
Date: Tue, 21 Feb 2012 19:18:16 -0500
Message-ID: <4F443448.7010705@cisco.com>
References: <1329858317-3066-1-git-send-email-hordp@cisco.com> <20120221222049.GA31934@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 01:18:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzzuc-0005uO-W4
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 01:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345Ab2BVASW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 19:18:22 -0500
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:40466 "EHLO
	rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756330Ab2BVAST (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 19:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2333; q=dns/txt;
  s=iport; t=1329869899; x=1331079499;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=MQi/VVo98u3FoV/nnImjjvZfOIHn1zgVtATnahUtbQw=;
  b=PTGeukSVRAUDPInxakZ7CvkjtD+rrMfpEQIrfiNLE5fvuIzPvIk30NZh
   ciG3OLft7a4GlGnAO9x3vdQe7zs686DT7zFvRE+9Oju+IzEaULG+0Zw/M
   BSQ7zGgtJrYHHW+jsta1w3ApIVE/9sKlEV9vp4OqDLe1htShbCS92FiOJ
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aj4LADczRE+tJXHB/2dsb2JhbABDgw6rUoN5gQeBcwEBAQMBEgEUUQEFCwsOExYPCQMCAQIBDzYGDQEFAgEBHodemRsBnxeIfINJCwQGJwECCwQFAgsCCAMCBQIQAQoCCAKFHGQPgy0EiE+MaYVdhTqHdA
X-IronPort-AV: E=Sophos;i="4.73,460,1325462400"; 
   d="scan'208";a="60789435"
Received: from rcdn-core2-6.cisco.com ([173.37.113.193])
  by rcdn-iport-4.cisco.com with ESMTP; 22 Feb 2012 00:18:18 +0000
Received: from [10.117.80.99] (rtp-hordp-8912.cisco.com [10.117.80.99])
	by rcdn-core2-6.cisco.com (8.14.3/8.14.3) with ESMTP id q1M0IHkA008525;
	Wed, 22 Feb 2012 00:18:17 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20111229 Thunderbird/9.0
In-Reply-To: <20120221222049.GA31934@burratino>
X-Enigmail-Version: 1.3.5
X-TagToolbar-Keys: D20120221191816965
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191203>

Jonathan Nieder <jrnieder@gmail.com> wrote:

>> -	if (show_hint)
>> +	if (show_hint) {
>>  		advise(_("after resolving the conflicts, mark the corrected paths\n"
>> -			 "with 'git add <paths>' or 'git rm <paths>'\n"
>> -			 "and commit the result with 'git commit'"));
>> +			 "with 'git add <paths>' or 'git rm <paths>'"));
>> +		if (!opts->no_commit)
>> +			advise(_( "and commit the result with 'git commit'"));
> 
> "cherry-pick --no-commit" was not about to commit, but the user might
> have been.  I think the hint is intended to convey that authorship
> will be correctly preserved if the user continues with "git commit"
> and no special -c option is necessary.

If that were the case, the hint would also appear when there is no conflict.

> Could you say a little more about the motivation for this patch?  For
> example, did the existing message confuse someone, or was it grating
> in the context of some particular workflow?

I found it mildly confusing myself.  I cherry-picked a commit with
--no-commit with no intention of committing it.  I was testing how the
changes would build, but I do not need them on my branch yet.  After I
resolved the conflict and tested them, I wanted to make sure there was
no lingering effects, leaving git thinking a CP was still in progress.

  $ git cherry-pick --abort
  error: no cherry-pick or revert in progress

Ok, so the sequencer was smart enough to leave me on my own.  But just
in case, I wondered what the hint was. And I found it was not telling me
how to clean up at all, but instead telling me how to commit. It seemed
incongruous, and I assumed it was only someone's forgetting to consider
the --no-commit case.

It smelled like a bug.  I started to ask about it, but it seemed easier
to just correct it and lower the list noise.

> A smaller detail: splitting the message into two like this gives
> translators less control over how to phrase the message and where to
> wrap lines.  Luckily that is easy to fix with
> 
> 	if (opts->no_commit)
> 		advise(...);
> 	else
> 		advise(...);
>
> which means more flexibility in phrasing the message with pertinent
> advice for each case. ;-)

I did this at first and didn't like it.  I started to ask, but -- you
know, list noise.

I'll fix it in v2.

Thanks,
Phil
