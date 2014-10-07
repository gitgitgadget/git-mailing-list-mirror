From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Can I fetch an arbitrary commit by sha1?
Date: Tue, 7 Oct 2014 19:34:36 +0700
Message-ID: <CACsJy8B0dbE0C3M0PO-EfaZ_bSxwGJSFVejEGFzjHSOZKOc+Jw@mail.gmail.com>
References: <CAENte7htO13s91UJFNzW4aBhsGxE=LpnvaZfce+vqQU5+a-cYg@mail.gmail.com>
 <CAPBPrnsA4KxNximtKXcC37kuwBHK0Esytdm4nsgLHkrJSg3Ufw@mail.gmail.com>
 <20141002161006.GB2505@peff.net> <CACh33FpWPuyJRryf6hzbAkqWJMwzz1mLLDDRxEQ0niT2CznTRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Dan Johnson <computerdruid@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Git <git@vger.kernel.org>
To: Patrick Donnelly <batrick@batbytes.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 14:35:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbTz1-000323-JV
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 14:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbaJGMfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 08:35:09 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35653 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbaJGMfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 08:35:07 -0400
Received: by mail-ig0-f180.google.com with SMTP id uq10so4571388igb.13
        for <git@vger.kernel.org>; Tue, 07 Oct 2014 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=v8SH5UG/SPv1E/UjjAzVpl2DvYJuQjQQeDSsIGUgtdw=;
        b=HPbUWRbammIk8R9Z3Rb/m5W6Pw8pJhXbH23FOQyMdMrTcugElYsipT+ohipsQV0LMh
         VNa8GLvDT/xP0dlEhSMnJycxL7RFJC8WfYuzxGxJI8P2Q5ou3Q0N9vvyxVA+XHRKrgEI
         OMZnpcHydpCrOVDjCDa9FbzlasY0nckCyvK8qpQCUwhQ2WuspOO5Q0cQbR4Kkib5Z50f
         MUSleWvvy1Kt/Fru3L/9rvRqUtStEU+e7HVstXpPv4ji+KpuPrMDHyj9tRIT0zX9fJmq
         Z9YQ08Z4CN6PSta8zEdnHAyHHAgjQDvlHhBNNDQIFrphNaG7Y87mG+4CqU7uu8uxyohZ
         NmkQ==
X-Received: by 10.42.10.209 with SMTP id r17mr1176560icr.65.1412685306928;
 Tue, 07 Oct 2014 05:35:06 -0700 (PDT)
Received: by 10.107.131.1 with HTTP; Tue, 7 Oct 2014 05:34:36 -0700 (PDT)
In-Reply-To: <CACh33FpWPuyJRryf6hzbAkqWJMwzz1mLLDDRxEQ0niT2CznTRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257924>

On Tue, Oct 7, 2014 at 1:25 AM, Patrick Donnelly <batrick@batbytes.com> wrote:
> On Thu, Oct 2, 2014 at 12:10 PM, Jeff King <peff@peff.net> wrote:
>> On Thu, Oct 02, 2014 at 10:22:50AM -0400, Dan Johnson wrote:
>>> My understanding is that you are allowed to ask for a SHA1, but most
>>> git servers refuse the request. But if you already have the SHA
>>> locally, then git doesn't neet to bother asking the server for it, so
>>> there's no request to be refused.
>>
>> That's right. It is the server which enforces the "you cannot fetch an
>> arbitrary sha1" rule.
>>
>> But I think Christian is arguing that the client side should complain
>> that $sha1 is not a remote ref, and therefore not something we can
>> fetch.  This used to be the behavior until 6e7b66e (fetch: fetch objects
>> by their exact SHA-1 object names, 2013-01-29). The idea there is that
>> some refs may be kept "hidden" from the ref advertisement, but clients
>> who learn about the sha1 out-of-band may fetch the tips of hidden refs.
>>
>> I'm not sure it is a feature that has been particularly well-used to
>> date, though.
>
> There are efforts in the scientific communities at preserving
> experimental software and results. One of the things we'd like to do
> is shallow clone a specific sha1 commit

You're not the first one asking about making a shallow clone from from
a specific point. I think the reason fetching from arbitrary sha-1 is
not supported is because of security. If we can verify the asked sha-1
is reachable from the visible ref set, then we should allow it. With
pack bitmaps, it's getting much cheaper to do such a test. If pack
bitmaps are not used, we could set a default/configurable limit, like
not traversing more than 1000 commits from any ref for this
reachability test). Anybody objecting this approach?
-- 
Duy
