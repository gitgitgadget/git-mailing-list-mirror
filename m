From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: Re: [PATCH v5 2/3] upload-pack: prepare to extend allow-tip-sha1-in-want
Date: Sat, 23 May 2015 01:47:40 +0200
Message-ID: <CABA5-zm4E71DV4hMw1Tifn-gqE4LzDDRzuo4vRL848bo_V5LLA@mail.gmail.com>
References: <1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
 <1432239819-21794-1-git-send-email-fredrik.medley@gmail.com>
 <1432239819-21794-2-git-send-email-fredrik.medley@gmail.com> <xmqqpp5th9dy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 01:48:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvwfg-0008Ak-Rx
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 01:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757590AbbEVXsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 19:48:05 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:33363 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757496AbbEVXsD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 19:48:03 -0400
Received: by lami4 with SMTP id i4so21953743lam.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 16:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zNvM+HzmHCTyEWltNYGrpT4ubsvSp7NyBvbJrKAOyNk=;
        b=zT5ifqsgGTyNoRwqsaYBsHmBqzoWpHuQb417z3SfAJnT3LqhlBSjkdD0OcmuMumCaJ
         lmELDa0AiwAfjxw3O4oR0WLqToqBcif4zGS20NK/EJZ610RSUIfwEDYK4CIIvwCeJ27M
         7cU7mO3XGTdlZwp2p3NC2ZxQW1R0Z2QVWR6OaGjyZ5IsdorTjrwfp9kdvShkM0jcwh6N
         XSArv5m5t5gmMrBLEeNZRWXOWzDLgUSgl0sATzF+xZpldsAPq2Qn6k506aI0Wi5jO7wt
         E3mRsafdne6LnpKKyEdGdepy8POnurHPooKXwStBWfh5P98PO0Hy/4c1ncLNV2nK+l0n
         U3gw==
X-Received: by 10.152.203.162 with SMTP id kr2mr8457327lac.68.1432338481579;
 Fri, 22 May 2015 16:48:01 -0700 (PDT)
Received: by 10.114.246.235 with HTTP; Fri, 22 May 2015 16:47:40 -0700 (PDT)
In-Reply-To: <xmqqpp5th9dy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269775>

2015-05-22 0:07 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Fredrik Medley <fredrik.medley@gmail.com> writes:
>
>> To allow future extensions, e.g. allowing non-tip sha1, replace the
>> boolean allow_tip_sha1_in_want variable with the flag-style
>> allow_request_with_bare_object_name variable.
>>
>> Signed-off-by: Fredrik Medley <fredrik.medley@gmail.com>
>> ---
>>  fetch-pack.c  |  9 ++++++---
>>  upload-pack.c | 20 +++++++++++++-------
>>  2 files changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index 48526aa..699f586 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -43,7 +43,10 @@ static int marked;
>>  #define MAX_IN_VAIN 256
>>
>>  static struct prio_queue rev_list = { compare_commits_by_commit_date };
>> -static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
>> +static int non_common_revs, multi_ack, use_sideband;
>> +/* Allow specifying sha1 if it is a ref tip. */
>> +#define ALLOW_TIP_SHA1       01
>> +static int allow_unadvertised_object_request;
>
> It is better to use "unsigned int" for these bit masks, as we are
> not interested in the top-most bit getting special-cased by using a
> signed type.  I'll amend this (and the one in upload-pack.c) while
> applying, so no need to resend only to correct these two, unless you
> have other reasons to reroll.

Sounds like a good idea to change. Please amend it while applying.

>
> Thanks.

Thank you too for the review.

>
>> diff --git a/upload-pack.c b/upload-pack.c
>> index 745fda8..726486b 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>> @@ -35,7 +35,9 @@ static int multi_ack;
>>  static int no_done;
>>  static int use_thin_pack, use_ofs_delta, use_include_tag;
>>  static int no_progress, daemon_mode;
>> -static int allow_tip_sha1_in_want;
>> +/* Allow specifying sha1 if it is a ref tip. */
>> +#define ALLOW_TIP_SHA1       01
>> +static int allow_unadvertised_object_request;
>
