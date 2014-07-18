From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/12] wrapper.c: add a new function unlink_or_msg
Date: Fri, 18 Jul 2014 15:59:21 -0700
Message-ID: <CAPc5daW_6bVg4B4GHA-HCRL7bzmLAdVOF2xOYa9aOOjze-zTdA@mail.gmail.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
 <1405549392-27306-3-git-send-email-sahlberg@google.com> <xmqqha2el2x5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 00:59:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8H7z-0004x8-W7
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 00:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757420AbaGRW7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 18:59:43 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:35812 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbaGRW7m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 18:59:42 -0400
Received: by mail-la0-f46.google.com with SMTP id b8so3374325lan.33
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=pRKmrUfQvQICRuwmLmRc0vWcY/MAT8gmMymYWBc6/BY=;
        b=P+NKhs8f7OR6F+67KtrQjVyR554wbqkqaPm1F2A0G6+E2UD91LLfYxTvLyvbYDHO5M
         +wIzR8wuhvm5A8YxJowJ26zRIWyO2CrprBMcM6kcZX4Dh6e5r7jYcrqkum3UXHfDsL3p
         7QJpBRey5nAxY+MuqctyLS9Zl7NE+bqmWaf7nWVJbxY0uVgs/4h9j6AmJ0kXLzJ/XJAD
         Qtry8dzZl3MvGZ6MYioNnuVuPsn2V8d59J+7HB0eNpYd8PpxynU896QeSw3AV8WC8RvK
         2k7Ha1UaZ48TOo0/NG+JaTnJe29LnM2/pIfTjauml0sLKyTonD/OFAcI4DtKsj7wjCDX
         Yo9g==
X-Received: by 10.112.204.106 with SMTP id kx10mr8053957lbc.73.1405724381180;
 Fri, 18 Jul 2014 15:59:41 -0700 (PDT)
Received: by 10.112.26.212 with HTTP; Fri, 18 Jul 2014 15:59:21 -0700 (PDT)
In-Reply-To: <xmqqha2el2x5.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: mKG1d-54CCn04bwTRqFceN1l7cA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253857>

Hmm, the primary reason for this seems to be because you are going to handle
multiple refs at a time, some of them might fail to lock due to this
lowest-level
helper to unlink failing, some others may fail to lock due to some other reason,
and the user may want to be able to differentiate various modes of failure.

But even if that were the case, would it be necessary to buffer the messages
like this and give them all at the end? In the transaction code path,
it is likely
that you would be aborting the whole thing at the first failure, no?

I dunno...


On Fri, Jul 18, 2014 at 3:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  git-compat-util.h |  6 ++++++
>>  wrapper.c         | 18 ++++++++++++++++++
>>  2 files changed, 24 insertions(+)
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index b6f03b3..426bc98 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -704,12 +704,18 @@ void git_qsort(void *base, size_t nmemb, size_t size,
>>  #endif
>>  #endif
>>
>> +#include "strbuf.h"
>> +
>>  /*
>>   * Preserves errno, prints a message, but gives no warning for ENOENT.
>>   * Always returns the return value of unlink(2).
>>   */
>>  int unlink_or_warn(const char *path);
>>  /*
>> + * Like unlink_or_warn but populates a strbuf
>> + */
>> +int unlink_or_msg(const char *file, struct strbuf *err);
>> +/*
>>   * Likewise for rmdir(2).
>>   */
>>  int rmdir_or_warn(const char *path);
>> diff --git a/wrapper.c b/wrapper.c
>> index 740e193..74a0cc0 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -438,6 +438,24 @@ static int warn_if_unremovable(const char *op, const char *file, int rc)
>>       return rc;
>>  }
>>
>> +int unlink_or_msg(const char *file, struct strbuf *err)
>> +{
>> +     if (err) {
>> +             int rc = unlink(file);
>> +             int save_errno = errno;
>> +
>> +             if (rc < 0 && errno != ENOENT) {
>> +                     strbuf_addf(err, "unable to unlink %s: %s",
>> +                                 file, strerror(errno));
>> +                     errno = save_errno;
>> +                     return -1;
>> +             }
>> +             return 0;
>> +     }
>> +
>> +     return unlink_or_warn(file);
>> +}
>
> In general, I do not generally like to see messages propagated
> upwards from deeper levels of the callchain to the callers to be
> used later, primarily because that will easily make it harder to
> localize the message-lego.
>
> For this partcular one, shouldn't the caller be doing
>
>         if (unlink(file) && errno != ENOENT) {
>                 ... do its own error message ...
>         }
>
> instead of calling any of the unlink_or_whatever() helper?
>
>
>>  int unlink_or_warn(const char *file)
>>  {
>>       return warn_if_unremovable("unlink", file, unlink(file));
