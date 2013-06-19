From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] http.c: don't rewrite the user:passwd string multiple times
Date: Tue, 18 Jun 2013 19:41:15 -0700
Message-ID: <CA+sFfMcsOx14UdzLF_JsgkpUQU6yG7DE+00eA3d+Lo-qncDgew@mail.gmail.com>
References: <1371520840-24906-1-git-send-email-bcasey@nvidia.com>
	<20130618051902.GA5916@sigill.intra.peff.net>
	<CA+sFfMdEvwzmnEBeO+_pwdmN3m5rkJvUCVFFJU8mtmyN+WxH6w@mail.gmail.com>
	<20130618221327.GA14234@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <bcasey@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, daniel@haxx.se
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 19 04:41:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up8Ko-00023E-Ef
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 04:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934000Ab3FSClS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 22:41:18 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:43915 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933901Ab3FSClR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 22:41:17 -0400
Received: by mail-we0-f171.google.com with SMTP id m46so3998764wev.16
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 19:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=toxR2MTEZdqbg4dSAKOBlqxiHDXX5B6dAKogXAb5AQc=;
        b=zcWiUXBfgY3I8T77ZSG+NPaufYF3nBEPBwbkUTuBw/S2GzxyveKf0c7SzwcNNC+noB
         JA5ZD6F9DdWuRxqUEWbgaiEBQaHsayDFc/Nt5AiSujxyAjchV/QFF/Urj2LQKaQDOiPG
         HDT31WVspYPhCIDuMyd4UEopelcaNgxvyCnCBTXtaouEqXfYR6L/gkVrLaS6UiaPRB6E
         51SOXBNmxMcYLyJAS40dkP8sUvGJhzfkbNkfbyw6g5ryFl96QZ/AJ0OKlWYGA6kiej+b
         355y64A2+AhJ0q+ZLLlcmIt2+pmGJhQ0edmcIG/0UQ2+7rwfyUe82qu8IzMvrTLN4Lsv
         ldIQ==
X-Received: by 10.180.20.46 with SMTP id k14mr454175wie.14.1371609675785; Tue,
 18 Jun 2013 19:41:15 -0700 (PDT)
Received: by 10.194.71.170 with HTTP; Tue, 18 Jun 2013 19:41:15 -0700 (PDT)
In-Reply-To: <20130618221327.GA14234@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228326>

On Tue, Jun 18, 2013 at 3:13 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 18, 2013 at 12:29:03PM -0700, Brandon Casey wrote:

>> > It could be a problem when we have multiple handles in play
>> > simultaneously (we invalidate the pointer that another simultaneous
>> > handle is using, but do not immediately reset its pointer).
>>
>> Don't we have multiple handles in play at the same time?  What's going
>> on in get_active_slot() when USE_CURL_MULTI is defined?  It appears to
>> be maintaining a list of "slot" 's, each with its own curl handle
>> initialized either by curl_easy_duphandle() or get_curl_handle().
>
> Yes, we do; the dumb http walker will pipeline loose pack and object
> requests (which makes a big difference when fetching small files). The
> smart http code may use the curl-multi interface under the hood, but it
> should only have a single handle, and the use of the multi interface is
> just for sharing code with the dumb fetch.
>
>> So, yeah, this is what I was referring to when I mentioned
>> "potentially dangerous".  Since the current code does not change the
>> size of the string, the pointer will never change, so we won't ever
>> invalidate a pointer that another handle is using.
>
> Agreed. I did not so much mean to dispute your "potentially dangerous"
> claim as clarify exactly what the potential is. :)

Ah, yes, I did read your sentence "It could be a problem when we have
multiple handles in play simultaneously" as "It could be a problem [at
some point in the future] when we [modify the code to] have multiple
handles in play simultaneously, [but since we are not doing that now,
it is not a problem]".  Now that I read that sentence again, I see you
are alluding to the dumb http walker code path that I was also
thinking about.

>> The other thing I thought was potentially dangerous, was just
>> truncating the string.  Again, if there are multiple curl handles in
>> use (which I thought was a possibility), then merely truncating the
>> string that contains the username/password could potentially cause a
>> problem for another handle that could be in the middle of
>> authenticating using the string.  But, I don't know if there is any
>> multi-processing happening within the curl library.
>
> I don't think curl does any threading; when we are not inside
> curl_*_perform, there is no curl code running at all (Daniel can correct
> me if I'm wrong on that).
>
> So I think from curl's perspective a truncation and exact rewrite is
> atomic, and it sees only the final content.  I don't know what would
> happen if you truncated and put in _different_ contents. For example, if
> curl would have written out half of the username/password, blocked and
> returned from curl_multi_perform, then you update the buffer, then it
> resumes writing.
>
> IOW, I believe the current code is safe (though in a very subtle way),
> but if you were to allow password update, I'm not sure if it would be or
> not (and if not, you would need a per-handle buffer to make it safe).
>
> I'm fine with making the safety less subtle (e.g., your patch, with a
> comment added).

Ok, will do.

-Brandon
