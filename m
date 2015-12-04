From: Jason Paller-Rzepka <jasonpr@google.com>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Fri, 4 Dec 2015 16:38:16 -0500
Message-ID: <CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
	<CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
	<20151204212712.GA22493@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 04 22:38:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4y3b-0008Kh-5q
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 22:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756623AbbLDViS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 16:38:18 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:35899 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756614AbbLDViR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 16:38:17 -0500
Received: by iofh3 with SMTP id h3so130177013iof.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 13:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gT1IjskwcJE6s/buevEmKLh8zqJlFXpmmoNJBTmlYOA=;
        b=dZsv5MoWkqNbDintLo11g0CgvBxMSWSmljB2h1CvFVulnSRvg01SHM20+7qD5EVaz5
         hhNSBELwuiuCAncJmh0zY6aR00gZTEjjV5p4d5+pTagpRll/jNPFavu4CjcyMsSfc7wt
         tRMNFNZDWlPCIIRwBQIHMQSJqn8D71kSPmETsdC4Z44NpmbH6kf9WnrtmabYsjEEPjTF
         sOfxUN4kGT8yHkoVOHG512SAHtz02XY/eYOrS6GkchjngpiZVHTSjbeTovqlkY8zKma+
         UuoDeLmpxNyYwyLTYh3Hfqe2yLzlIdk0c6KHUetd375ROcytH26q8I4B42Jfo/hzHGgR
         AS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gT1IjskwcJE6s/buevEmKLh8zqJlFXpmmoNJBTmlYOA=;
        b=klD0VbKzDXoHUuoPQUexPDKNtHxRfga7pQYD8IsHOXBwryIWUrHyQkAkffzDfekeqk
         Hal1/bPycPJZTUfP3DYs4q83NYbPDSiXuLOmvjouvuZLyeL7qHsZnTNbHZjsPfHarGFg
         EIsQVzvDzsz0swnCufJ+dab9jYMfIRAT7E8ru0C+SUSZLay90h1CfioYR2oW++M3aA21
         Ca5t7CE5/Tmmjow5BSLd2tMQiLAnxWA1sVqL3Znj31wfdpStxSeBqHpRPLluLtPedjlE
         kUXkRgMwLlsOmsLjjMmQvppMe7wmmvfTX3X/KsBcMwt+Lnmqx3QRBpxXAQH/MyZ73bnG
         DVyg==
X-Gm-Message-State: ALoCoQnvsS/nLPhu29wfRHKvX1P25f85FoFLGHxV7I+IHXDGz4Fr31QOETUqi9a/FOaXanpz0F0H
X-Received: by 10.107.164.24 with SMTP id n24mr16448962ioe.21.1449265096438;
 Fri, 04 Dec 2015 13:38:16 -0800 (PST)
Received: by 10.36.19.74 with HTTP; Fri, 4 Dec 2015 13:38:16 -0800 (PST)
In-Reply-To: <20151204212712.GA22493@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282007>

It appears that it happens when the shallow history grows to include a
commit that's pointed to by a previously unseen tag.  For example,
when I deepen a checkout of git to depth 8, I hit v2.5.2, and a second
fetch takes place.

```
$ git clone --depth=1 http://github.com/git/git
Cloning into 'git'...
remote: Counting objects: 2925, done.
remote: Compressing objects: 100% (2602/2602), done.
remote: Total 2925 (delta 230), reused 2329 (delta 206), pack-reused 0
Receiving objects: 100% (2925/2925), 6.17 MiB | 0 bytes/s, done.
Resolving deltas: 100% (230/230), done.
Checking connectivity... done.
$ git -C git fetch --depth=8
remote: Counting objects: 858, done.
remote: Compressing objects: 100% (774/774), done.
remote: Total 858 (delta 793), reused 138 (delta 80), pack-reused 0
Receiving objects: 100% (858/858), 364.53 KiB | 0 bytes/s, done.
Resolving deltas: 100% (793/793), completed with 476 local objects.
remote: Counting objects: 1, done.
remote: Total 1 (delta 0), reused 1 (delta 0), pack-reused 0
Unpacking objects: 100% (1/1), done.
From http://github.com/git/git
 * [new tag]         v2.5.2     -> v2.5.2
$
```

But why would fetching a tag (or set of tags) merit a depth of zero?
Doesn't depth 1 mean "give me the the objects, and none of their
descendants"?  Why use 0?

Thanks!
Jason

On Fri, Dec 4, 2015 at 4:27 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 04, 2015 at 12:46:59PM -0800, Stefan Beller wrote:
>
>> On Mon, Nov 30, 2015 at 11:35 AM, Jason Paller-Rzepka
>> <jasonpr@google.com> wrote:
>> > Hi all,
>> >
>> > Would anyone be willing to help me understand some shallow-clone
>> > behavior?  (I found a bug in Dulwich, and I'm looking for some context
>> > so I can determine how to fix it.)
>> >
>> > I learned that cgit sometimes performs two fetches for a `git fetch
>> > --unshallow`: one with depth 'infinity', and a subsequent one with
>> > depth zero.
>>
>> Is there a condition to trigger this 'sometimes' ?
>>
>> I just tried reproducing via
>> $ GIT_TRACE=1 git fetch --unshallow
>>
>> and could not see a second fetch, but only a
>> fetch-pack with --depth=2147483647
>
> This seems to reproduce consistently for me:
>
>   $ git clone --depth=1 git://github.com/git/git
>   Cloning into 'git'...
>   remote: Counting objects: 2925, done.
>   remote: Compressing objects: 100% (2602/2602), done.
>   remote: Total 2925 (delta 230), reused 2329 (delta 206), pack-reused 0
>   Receiving objects: 100% (2925/2925), 6.17 MiB | 10.80 MiB/s, done.
>   Resolving deltas: 100% (230/230), done.
>
>   $ cd git
>   $ git fetch --unshallow
>   remote: Counting objects: 185430, done.
>   remote: Compressing objects: 100% (46933/46933), done.
>   remote: Total 185430 (delta 140505), reused 181589 (delta 136694), pack-reused 0
>   Receiving objects: 100% (185430/185430), 52.80 MiB | 10.84 MiB/s, done.
>   Resolving deltas: 100% (140505/140505), completed with 1784 local objects.
>   remote: Counting objects: 579, done.
>   remote: Compressing objects: 100% (579/579), done.
>   remote: Total 579 (delta 0), reused 579 (delta 0), pack-reused 0
>   Receiving objects: 100% (579/579), 266.85 KiB | 0 bytes/s, done.
>   [... fetch output ...]
>
> That looks like two packs being received for the --unshallow case.
>
> -Peff
