From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/5] range-set and line-log bug fixes
Date: Thu, 25 Jul 2013 09:09:19 -0400
Message-ID: <CAPig+cToEX1b+3q-Mhw_ukvZzqSDnRR7bJymC962t+qkZE25fw@mail.gmail.com>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
	<CAPig+cRWaKv6UN5pZLwonXBpHnFE7+4ELXTnE+2nLr8h83bX6Q@mail.gmail.com>
	<51F0EBF5.80105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 25 15:09:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2LIM-0007kV-Hg
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 15:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595Ab3GYNJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 09:09:22 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:53470 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430Ab3GYNJV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 09:09:21 -0400
Received: by mail-lb0-f172.google.com with SMTP id a16so1527170lbj.31
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ofKUVtyYLSzyX9fDgfI43oquQPv+gdrPh0adzawLFno=;
        b=rPDfgVH4uUDXQaLLhtwXsjntzhcjnw6WI0zu98L2Ivgkgl7+kCPP7EHOd0U8R8oRzi
         8/iONbT34DCX4tF0UzYIWgmBfwXxKfz5OIemSH/4G6Sw4idAMCG1Sq+7/aLWSLECWWoZ
         pkf+NIHF27O53p5xxIfdeCOkDs8a68HlKXwDg6X2qlFd0tZGhA10aJXKZj/ECkDMBpkO
         Li2BfYuLbPwZCxUNFgKlVkjVZwd/eyWtBMMtKZe95ykZua4LGtnyiIKZ8O7qPxQ1oUlf
         AL22WEadaPWiLL8ugK9cONYCwZcN3CMzXkVshpTYBm8wForMkaxOYJbib2jkmOcoO1q9
         uI5Q==
X-Received: by 10.112.73.33 with SMTP id i1mr3243664lbv.24.1374757760181; Thu,
 25 Jul 2013 06:09:20 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Thu, 25 Jul 2013 06:09:19 -0700 (PDT)
In-Reply-To: <51F0EBF5.80105@viscovery.net>
X-Google-Sender-Auth: JKRLkESszj1R1FQYayslNwMjWZc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231133>

On Thu, Jul 25, 2013 at 5:12 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 7/25/2013 10:03, schrieb Eric Sunshine:
>> The tests in this series identify real bugs in dealing with empty
>> ranges, which the subsequent patches fix. The test are possible
>> because one can specify an empty range via blame/log -L, however, I
>> now realize that the ability for -L to create empty ranges was never
>> intended or part of the design, but is in fact itself a bug.
> ...
>> * Should we drop these new t4211 tests which guard against real potential bugs?
>>
>> * Should we add custom C code to the test suite to make the
>> empty-range testing possible?
>>
>> * Should we introduce another (undocumented) loophole just for the
>> sake of the tests?
>
> IIUC, the tests you added are protecting the *implementation* of range-set
> functions. For tests of the implementation, we usually write test-foo
> programs that call the functions directly.

You understand correctly. The added t4211 tests check range-set and
line-log functionality.

range-set is an implementation detail of git-log's -L and is entirely
private (static to the implementation file), so there's no API to test
via a test-foo program. It is sufficiently generic that its API could
(some day) be published, thus allowing a test-foo program, however,
doing so would involve writing documentation and covering its entire
API with tests: a large enough task in itself, and quite orthogonal to
fixing the log/blame -L loophole.

line-log is partially public, however, the code in which the bug was
discovered is private (static) and likely always will be since it is
not generic. Moreover, once the -L loophole is closed, there will be
no way to trigger the case under consideration via its public API, so
again there is no opportunity for a test-foo program.

Thus, the question remains: What to do with these two tests once the
-L loophole is closed? Remove them?

> Tests invoking git should test the observable behavior. Therefore, if
> calling a git utility with "-Lfoo,+0" should be an error, then the test
> suite should mark such a call with test_must_fail. I guess this rules out
> the loophole approach.

Indeed, nicely stated.
