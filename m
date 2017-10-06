Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B050A2036B
	for <e@80x24.org>; Fri,  6 Oct 2017 10:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdJFKkj (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 06:40:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750849AbdJFKki (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 06:40:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7BDD8763A;
        Fri,  6 Oct 2017 10:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com A7BDD8763A
Authentication-Results: ext-mx02.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx02.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=pbonzini@redhat.com
Received: from [10.36.117.205] (ovpn-117-205.ams2.redhat.com [10.36.117.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E241360605;
        Fri,  6 Oct 2017 10:40:37 +0000 (UTC)
Subject: Re: [RFC PATCH 0/4] interpret-trailers: introduce "move" action
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <20171005132243.27058-1-pbonzini@redhat.com>
 <CAP8UFD1X-aRN5sAB5PQt04jL_92APK279bjNf=Zt_x8KOxyL+A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <748131b7-bddd-08c2-ff72-9fd1a63ef6a0@redhat.com>
Date:   Fri, 6 Oct 2017 12:40:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1X-aRN5sAB5PQt04jL_92APK279bjNf=Zt_x8KOxyL+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 06 Oct 2017 10:40:38 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/10/2017 12:30, Christian Couder wrote:
> On Thu, Oct 5, 2017 at 3:22 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> The purpose of this action is for scripts to be able to keep the
>> user's Signed-off-by at the end.  For example say I have a script
>> that adds a Reviewed-by tag:
>>
>>     #! /bin/sh
>>     them=$(git log -i -1 --pretty='format:%an <%ae>' --author="$*")
>>     trailer="Reviewed-by: $them"
>>     git log -1 --pretty=format:%B | \
>>       git interpret-trailers --where end --if-exists doNothing --trailer "$trailer" | \
>>       git commit --amend -F-
>>
>> Now, this script will leave my Signed-off-by line in a non-canonical
>> place, like
>>
>>    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>    Reviewed-by: Junio C Hamano <gitster@pobox.com>
>>
>> This new option enables the following improvement:
>>
>>     #! /bin/sh
>>     me=$(git var GIT_COMMITTER_IDENT | sed 's,>.*,>,')
>>     them=$(git log -i -1 --pretty='format:%an <%ae>' --author="$*")
>>     trailer="Reviewed-by: $them"
>>     sob="Signed-off-by: $me"
>>     git log -1 --pretty=format:%B | \
>>       git interpret-trailers --where end --if-exists doNothing --trailer "$trailer" \
>>                              --where end --if-exists move --if-missing doNothing --trailer "$sob" | \
>>       git commit --amend -F-
>>
>> which lets me keep the SoB line at the end, as it should be.
>> Posting as RFC because it's possible that I'm missing a simpler
>> way to achieve this...
> 
> Did you try using `--where end --if-exists replace --trailer "$sob"`?

Yes, it's a different behavior; "--if-exists replace" matches on others'
SoB as well, so it would eat the original author's SoB if I didn't have one.

So "move" does get it wrong for

    Signed-off-by: Me
    Signed-off-by: Friend

(Me gets moved last, which may not be what you want) but "replace" gets
it wrong in the arguably more common case of

    Signed-off-by: Friend

which is damaged to just "Signed-off-by: Me".

Paolo
