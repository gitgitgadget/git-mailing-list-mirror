From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv1 0/6] Fix bug in large transactions
Date: Thu, 22 Jan 2015 09:52:10 -0800
Message-ID: <CAGZ79kZ5fdDiT=zXhQkt17kxLBbkJnh1F06nyZJN7ta9WZ2dmQ@mail.gmail.com>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
	<20150121234659.GE11115@peff.net>
	<xmqqsif3tfcf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Loic Dachary <loic@dachary.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 18:52:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YELvV-0007d6-7m
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 18:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbbAVRwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 12:52:13 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:50882 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597AbbAVRwL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 12:52:11 -0500
Received: by mail-ie0-f173.google.com with SMTP id tr6so2723012ieb.4
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 09:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SQxMQLOJaQgX4nT6OBVykoEkcNq7l4jVxS+KZMXqX/c=;
        b=pBBFm085YKbk7eCGDNYU7rpSccQSnUeUmnxhbHqF51h8TnXQVzvsBDH3ExiwwyqwO4
         IY/yK+rJ983NK2LGKlEnltU9BID42UXDRxljOt2qd0rRGnAIkucAjxn+Y0BvrwpWYaYa
         JaxL0fEFbR5/M6XMe5vI5AesI0D9bkz78dzpQOdq6PLRf6P+5nlyZc/trimhCP/VV1sF
         xwauMSVvMS9YT952oV2Hekd8Q+8LqO/nRrmeDHscnL0B6LwYD59I6moviZWljSZjsOoR
         C+aDNm8nUfnPxE+bRehXkQBw+Vv0rGKKdYW4y+uWjp7JYorzSb3SS+DMEuZ8ou2NXZ8U
         di2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SQxMQLOJaQgX4nT6OBVykoEkcNq7l4jVxS+KZMXqX/c=;
        b=kuZ6atxcnd630tekMhkD14q44AmBCqEieQhyXGWsv5Nl5lftB08EZ7NcQsVDdYEinS
         LMtZ9hOP0ZSA0thKN9OIra83dI4xqIlts6ktXe1pAku3EXCW76jCZOGWqxaA3tv+pFRb
         ne10yZmS9jsfhJwrwq339IE6iXPB642IEFYKH5lxttGDvLh9Ujw6Vn27iFbP01zP20Qf
         2Q7haE1vIFWl769TtNh8S97+RF6PL0YaA4N4xYBnxOT+Nxcg9UkJTgOi84aXRUfgGpqs
         kyfAVnBciqPAB3hzBd63fo4MvePxHPzv88A3JmwoFV3jf6SycqzBJKNLzYbAAWfFM0OR
         Hovg==
X-Gm-Message-State: ALoCoQmW8aVEQ1mEa2SyYd0HRV/Wp+Qz5XzdPRCVImAqPKMbhS7Yi1L7QBTwgvWzGwiG4jBQ+rVH
X-Received: by 10.50.108.108 with SMTP id hj12mr5435922igb.47.1421949130747;
 Thu, 22 Jan 2015 09:52:10 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 22 Jan 2015 09:52:10 -0800 (PST)
In-Reply-To: <xmqqsif3tfcf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262850>

On Thu, Jan 22, 2015 at 12:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Wed, Jan 21, 2015 at 03:23:39PM -0800, Stefan Beller wrote:
>>
>>> (reported as: git update-ref --stdin : too many open files, 2014-12-20)
>>>
>>> First a test case is introduced to demonstrate the failure,
>>> the patches 2-6 are little refactoring and the last patch
>>> fixes the bug and also marks the bugs as resolved in the
>>> test suite.
>>>
>>> Unfortunately this applies on top of origin/next.
>>
>> Saying "applies on next" is not very useful to Junio. He is not going to
>> branch a topic straight from "next", as merging it to master would pull
>> in all of the topics cooking in "next" (not to mention a bunch of merge
>> commits which are generally never part of "master").
>>
>> Instead, figure out which topic in next you actually _need_ to build on,
>> and then it can be branched from there. And if there is no such topic,
>> then you should not be building on next, of course. :) But I think you
>> know that part already.
>
> All very true.
>
> I consider anything new that appears late in the cycle, especially
> during deep in the pre-release freeze, less for me to apply but more
> for others to eyeball the preview of a series the submitter plans to
> work on once the next cycle starts, so basing on 'next' does not
> hurt too much.  For interested others,
>
>         git checkout origin/next^0
>
> would be shorter to type than
>
>         git checkout "origin/next^{/^Merge branch 'sb/atomic-push'}^2"
>
> so... ;-)
>
> But what is more troublesome is that neither this or updated v2
> applies to 'next'.

v2 applies to sb/atomic-push instead of next and will result in a one
line merge conflict with next.

I know we're late in the cycle, hence I was just sending out for reviews.
Though as it's not a feature, but a bug fix it may be worth picking it
up now if it's easy to apply.

Thanks,
Stefan

>
> Let me try to wiggle it in first.
>
> Thanks.
