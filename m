From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Fri, 30 May 2014 06:43:18 +0700
Message-ID: <CACsJy8BgriBBWJ6ZzQS8S7p4SUB=bdZHdnUQsyN03g+vtApbxA@mail.gmail.com>
References: <1401311055-480-1-git-send-email-dturner@twitter.com>
 <1401311055-480-2-git-send-email-dturner@twitter.com> <538658C0.8050001@alum.mit.edu>
 <1401320968.18134.98.camel@stross> <CACsJy8BcBmuC3KMu+5dhGiOXX=u7WtHWQzQuT=ZPTbSCduJdbw@mail.gmail.com>
 <xmqqfvjsbkz2.fsf@gitster.dls.corp.google.com> <CACsJy8BS_YhMB9ZZRx4faj=_YWZQrqm7B9AHkTGye=okja=m-Q@mail.gmail.com>
 <20140529234109.GA28683@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 01:43:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq9zE-000174-MI
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 01:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbaE2Xnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 19:43:49 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:57155 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaE2Xns (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 19:43:48 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so3242187qgd.13
        for <git@vger.kernel.org>; Thu, 29 May 2014 16:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wePmjr4G36mzRQ5OWOW82iDwn8Tm0u4TI65tie8yiDQ=;
        b=OcWAQLATJajXKFv0fT38CezhTgCO9TewScGbGETN/rkhMkOpRFiMcmtrw78hRSRwov
         tUGkaVTM0pMwMwSfzOQp/zLqLVBC4VxS5/cnwXWLV/v3lcTsAI4rpB//GgRHHA/qz24E
         V+lLReJRpZPFHX3BOOWEWzfeyIa8gWgutQX/G7rP7pdUHQ63JJCv5dLmxC2EF5hcbX/M
         09eDDm0TTO3prPA2TWogqvYLiENwgrK1IrRVggLEZQNR4XzJ46xpgajQMrru3eAEdzfc
         UOU73p0XyAALOZ4w5hhaphFomJRDv2Idb6J5bbYiZtFUpLlvfKnOQrqhMXiRNgygzwTq
         6DLQ==
X-Received: by 10.140.91.161 with SMTP id z30mr14351343qgd.65.1401407028085;
 Thu, 29 May 2014 16:43:48 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Thu, 29 May 2014 16:43:18 -0700 (PDT)
In-Reply-To: <20140529234109.GA28683@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250421>

On Fri, May 30, 2014 at 6:41 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 30, 2014 at 06:24:30AM +0700, Duy Nguyen wrote:
>
>> >> I wonder if we can get away without SSE code by saving stat info of
>> >> the packed-refs version that we have verified. When we read pack-refs,
>> >> if stat info matches, skip check_refname_component(). Assuming that
>> >> pack-refs does not change often, of course.
>> >
>> > Can you elaborate a bit more?
>>
>> The first time we read packed_refs, check_refname_format() is called
>> in read_packed_refs()->create_ref_entry() as usual. If we find no
>> problem, we store packed_refs stat() info in maybe packed_refs.stat.
>> Next time we read packed_refs, if packed_refs.stat is there and
>> indicates that packed_refs has not changed, we can make
>> create_ref_entry() ignore check_refname_format() completely.
>
> I'm confused. Why would we re-open packed-refs at all if the stat
> information hasn't changed?

No, not in the same process. In the next run.

>
> read_packed_refs is only called from get_packed_ref_cache, and we only
> do so if !refs->packed. And refs->packed is only NULL if we haven't read
> the file yet, or it is stat-dirty.
>
> If that is working as intended, then we should generally only open and
> read packed-refs once per invocation of git.
>
> -Peff



-- 
Duy
