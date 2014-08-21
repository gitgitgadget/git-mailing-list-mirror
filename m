From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH 3/4] Added tests for the case of merged and unmerged
 entries for the same file
Date: Thu, 21 Aug 2014 15:51:42 +0200
Message-ID: <CAPuZ2NGUTw8NLTyJSgphh=XBgxy4eTFQLF5yxGD3GgpKbc-Vog@mail.gmail.com>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
	<cover.1408533065.git.jsorianopastor@gmail.com>
	<7782c581021d529947a1385939231eeb145d150e.1408533065.git.jsorianopastor@gmail.com>
	<xmqq8umiub9x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 15:51:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKSmJ-0001jv-BO
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 15:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbaHUNvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 09:51:43 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:41067 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778AbaHUNvm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 09:51:42 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so14491843pac.31
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=b7bnoJ6mdDzWemwtfojKsudaXuMT4hmElNaoI+hb5YA=;
        b=q+g9TLDuv14mybAJSQ+ZNvogn+MXkjjx8eF52eIt9HSDYrxv7MW9S5ElW+xLLc5/6c
         ilJSvTq0Pj6wIJ2wi+fJnEa7Q/LkBnDjf70FQoiHkBUQuYkeg2jHD+YxuS4hiettQSER
         ZIzJRUDo/3pgxGjcV/8kPVMAaie2cfk84uwxfQuCqEY9sCcxKlqqCJoRY1loocPjydry
         Wyvl14Xl/k+ZYF0CKlREWKfNmP6RcL8UBCBiMvoPYod1KNo+0TqZ2yU3yXGzYhJuTvqs
         YwsKGvYsrELeqxk/uLVqa1wbXelhOnJPxGiam8WVjuagVcuppnZmWCm+nbYXkmieQ35s
         1ZDQ==
X-Received: by 10.68.87.65 with SMTP id v1mr61540176pbz.118.1408629102596;
 Thu, 21 Aug 2014 06:51:42 -0700 (PDT)
Received: by 10.70.37.2 with HTTP; Thu, 21 Aug 2014 06:51:42 -0700 (PDT)
In-Reply-To: <xmqq8umiub9x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255614>

On Wed, Aug 20, 2014 at 11:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:
>
>> Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
>> ---
>>  t/t9904-unmerged-file-with-merged-entry.sh | 86 ++++++++++++++++++++++++++++++
>
> Isn't this number already used for another test?  A test on the
> index probably belongs to t2XXX or t3XXX family.
>
Umm, I though this test number was free, I just added it to the last+1
position, if I finally add a test I'll take this into account. Thanks.

>>  1 file changed, 86 insertions(+)
>>  create mode 100755 t/t9904-unmerged-file-with-merged-entry.sh
>>
>> diff --git a/t/t9904-unmerged-file-with-merged-entry.sh b/t/t9904-unmerged-file-with-merged-entry.sh
>> new file mode 100755
>> index 0000000..945bc1c
>> --- /dev/null
>> +++ b/t/t9904-unmerged-file-with-merged-entry.sh
>> @@ -0,0 +1,86 @@
>> +#!/bin/sh
>> +
>> +test_description='Operations with unmerged files with merged entries'
>> +
>> +. ./test-lib.sh
>> +
>> +setup_repository() {
>> +     test_commit A conflict A
>> +     test_commit A conflict2 A2 branchbase
>> +     test_commit B conflict B
>> +     test_commit B conflict2 B2
>> +     git checkout branchbase -b branch1
>> +     test_commit C conflict C
>> +     test_commit C conflict2 C2
>> +     test_commit something otherfile otherfile
>> +}
>
> No error is checked here?
>
This is only a helper function for setup, not a test itself.

>> +setup_stage_state() {
>> +     git checkout -f HEAD
>> +     {
>> +             git ls-files -s conflict conflict2
>> +             git merge master > /dev/null
>> +             git ls-files -s conflict conflict2
>> +     } > index
>
> No error is checked here?
>
Same here.

> Style: no SP between redirection operator and its target, i.e.
>
>         git merge master >/dev/null
>         { ... } >index
>
>> +     cat index | git update-index --index-info
>
> Do not cat a single file into a pipeline, i.e.
>
>         git update-index --index-info <index
>
True :) Thanks.
