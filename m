From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v18 14/48] refs.c: log_ref_write should try to return
 meaningful errno
Date: Wed, 18 Jun 2014 14:38:57 -0700
Message-ID: <CAL=YDWnH2ovsLOCWaMgOf3jjSmGF8uyVo=kuFEDiC1Bi8N1Hew@mail.gmail.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
	<1403020442-31049-15-git-send-email-sahlberg@google.com>
	<53A1FFE3.9060006@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 18 23:39:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxNZO-0000r3-HA
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 23:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbaFRVi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 17:38:59 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:40404 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbaFRVi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 17:38:58 -0400
Received: by mail-vc0-f176.google.com with SMTP id ik5so1401535vcb.7
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 14:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ShkiNn4T6Q+wFWVawBcG2gRpgCT7m46mfGi07sMLeBY=;
        b=XNwDjdDl4MIIcwszmYxH6JoNqQrwEKFWu+qYRac8GExg/28UMgC2dtjZnQnd3XtzS4
         0MMQNE0bR5LJcntlVA/CUPbsUaB6av7j1WVVMr8ruZtgPvG0FrYPxDVWw4I5q5EbrJa/
         PRWYuTpnUdNCDM5Rkbq8lPiHsEh2ObHSu9x83sIQNmf5Q+0YDb/2plR+9S9t3oR3T5hg
         JhzCTetF+6ti+kTiOtHHkrpEzrNG1uiNDDfrwrBziff4Ifd42QBc3ueoN70XbF1RdePx
         q5BSS0q6jcO9NvXkhFRubIpUZ8Ckz4/liZ71azHC6/hwn5u8LP/l+87ILCErXP+z98UG
         WfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ShkiNn4T6Q+wFWVawBcG2gRpgCT7m46mfGi07sMLeBY=;
        b=YjAFu61PXszYmeZrMKb6qYgVW5cAlglBNy8YbxN1txKzinYFzXA9OH6S14e7yJ7UAN
         P3/vWOun2zP8M5ia2q286Po4Iv1ifCoFUCgG6+9BjAtWd8Qr7IMVIHvVkGUsoWR0j/iQ
         4bXUNofP2ed6eciwL4aay5auhFGbcJqZZ44LFBBraG9McsiBhhDJCiJwF9MbfLQQKv2x
         3Kr2V+jwBwQ3u2JkfXK+cNGpJJzh9GXUzYGAiACURYhJDQcb5x7wnTFWWsx4ZSERjEiw
         nnpzDJ/yje/Wq1dl4GsYIVVlDALiy+wIj6bfS+vAK9btqctAapuqF8jfFtRrmVe6oDb4
         NZ0g==
X-Gm-Message-State: ALoCoQlxAKmX8lQVUXVL93vSr+MJzF9PCxuPY9UitoWICtOLQnZTj/cKgoh0U8Kso/8z3m98exHj
X-Received: by 10.58.74.201 with SMTP id w9mr121260vev.56.1403127537257; Wed,
 18 Jun 2014 14:38:57 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Wed, 18 Jun 2014 14:38:57 -0700 (PDT)
In-Reply-To: <53A1FFE3.9060006@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252073>

On Wed, Jun 18, 2014 at 2:08 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/17/2014 05:53 PM, Ronnie Sahlberg wrote:
>> Making errno from write_ref_sha1() meaningful, which should fix
>>
>> * a bug in "git checkout -b" where it prints strerror(errno)
>>   despite errno possibly being zero or clobbered
>>
>> * a bug in "git fetch"'s s_update_ref, which trusts the result of an
>>   errno == ENOTDIR check to detect D/F conflicts
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 29 ++++++++++++++++++++++++-----
>>  1 file changed, 24 insertions(+), 5 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 211429d..1f2eb24 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1979,6 +1979,7 @@ static int remove_empty_directories(const char *file)
>>       result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
>>       save_errno = errno;
>>
>> +     errno = save_errno;
>>       strbuf_release(&path);
>>       errno = save_errno;
>
> This new line looks like an accident.

Yepp.  Too many rebases.

Thanks.

>
>> [...]
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
