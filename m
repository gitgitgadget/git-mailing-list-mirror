From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: regression in multi-threaded git-pack-index
Date: Tue, 19 Mar 2013 19:35:28 +0700
Message-ID: <CACsJy8DgQZFewPjLSXSkdHHWqhQDqExoVq-pBGpKr1G8w06uvQ@mail.gmail.com>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
 <20130316114118.GA1940@sigill.intra.peff.net> <87fvzrajmr.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Stefan Zager <szager@google.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 13:36:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHvmG-0001EU-1n
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 13:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308Ab3CSMgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 08:36:00 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:39061 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab3CSMf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 08:35:59 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so352618obb.17
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=rk++uQC3jEZKMgPXIW9WPFrl4sBgMS+fGGxkazBxbE8=;
        b=y9ZGdQAfW4hdSkY8RvM3zrtEsgTUCkQa8idwN8ZooeISGF+YDa5gb+rziJ0wfU4/6R
         zf9baaKSqb63iAveFGaREQ72108fdE+ERmoRxSZ8DGLHk9XiSp1RRWmOPHgmXf2K6hGc
         WS62lsN0vY+6bClRb6HHR0Fhl83WE2AIMOKDQ2UY+Cxb3lfYC2BCFZOByeIUkPWu+88l
         uU/JmrEMtITYT9+Nz5IsMJvv6QyL6g2hP+x6S+6pwQ+mM1gJH/BuGSFJhF2Oti2Fq8nY
         z5qKV5aurQX7EQezSdbYZ7HCEzp0Sv89fg79+QfHwCiXFeyP0SLuOOT4cEgrzY8A6qXt
         LjTw==
X-Received: by 10.60.6.199 with SMTP id d7mr1062321oea.137.1363696558908; Tue,
 19 Mar 2013 05:35:58 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Tue, 19 Mar 2013 05:35:28 -0700 (PDT)
In-Reply-To: <87fvzrajmr.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218509>

On Tue, Mar 19, 2013 at 3:17 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>> but the line in question is:
>>
>>   if (deepest_delta < delta_obj->delta_depth)
>>
>...
>
> Duy, what was the reasoning why resolve_delta() does not need to hold
> locks when it looks when it looks at deepest_delta?  My coffee levels
> aren't up to this task yet.  It certainly seems extremely dubious to me,
> as the code uses the global deepest_delta in threaded sections.  You can
> probably argue that the load/store is atomic on most(?) platforms, but
> you get no guarantees that deepest_delta at any time in fact holds the
> maximum value of delta_obj->delta_depth.

Now that I have had dinner (and energy restored), the explanation
might be because I missed it. resolve_delta() deals with data in
delta_obj and does not share global state, except this one and
nr_resolved_deltas. The latter is protected. I guess we could protect
this one with a mutex. But only do so when "--verify" is specified

if (stat) {
   lock();
   if (deepest_delta < delta_obj->delta_depth)
      deepest_delta = delta_obj->delta_depth;
   unlock();
}

so that we don't need to hold/release lock when index-pack is run.
-- 
Duy
