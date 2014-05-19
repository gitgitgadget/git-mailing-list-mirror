From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 08/31] refs.c: only write reflog update if msg is non-NULL
Date: Mon, 19 May 2014 15:55:52 -0700
Message-ID: <CAL=YDWm3N28jMmdWwWLrseK9bG0kwAmYDZ6+yRoa8cfA3S_kxQ@mail.gmail.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
	<1400105610-21194-9-git-send-email-sahlberg@google.com>
	<xmqqtx8p8lj2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 20 00:55:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmWTN-0002k9-8a
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 00:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbaESWzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 18:55:53 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:35466 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbaESWzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 18:55:52 -0400
Received: by mail-ve0-f179.google.com with SMTP id oy12so7349715veb.10
        for <git@vger.kernel.org>; Mon, 19 May 2014 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rHx8VUm18XiNNGUePUHoz99fPqq8cpkAd/hlh7h89/4=;
        b=FP1SXJDL7yAgwIbqEx2qomZkfLjYKhJ1SWnXLgUIAN4RCpcUFgfrM9P33G9OvMxZQM
         XYMvTou5t6ZipIUoJ1PxoGhp7zlj78bVDhSXvyhz5a3yiry/Bf233cEXKXNdi9gmQhrR
         gQYZOU1O08cXnB5xoXYFyAtMbwZNZg7tghrJmGmkdlX7HLceUpwJTVZUp6H5D7b12T6x
         n4x1L7CbP0dXji6qLYQoozPM6r6Gp5SoT+qEmp+G+dBq6auZ2RL6voDaONtbYzXz4V4k
         3Iup5eElb4K+Otrg/jjELshrS4UOuW5B+XaY53eGyNinRujB5RWAqsnnFI1umlEuaglk
         pCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rHx8VUm18XiNNGUePUHoz99fPqq8cpkAd/hlh7h89/4=;
        b=YRwccyN7b7bLgVKe3ZQ1Stv3Ev+5Q0hardG9lDUTZvyt8U57uZhzb/yrz/mTpbr12J
         aOVBBm4VzIVRkHbnolze/zq1xw+S3HZIjmmZXmep2Z8GgB5qSKu6T7g/kHkFvn5d1Uq2
         IoKoGccjVt6U9xPaGmaELM2NDNE6jQW6V5XRjfriKVZekavnBayR2FD42lLbDsq7dKgO
         MiJrIQRdNNEIbHxBlwlKcOx2adas9XtJUCHGyN6JdK6yBgxOpjtJJIOVch0N4wAVSIH+
         gDgFk5z9vpYj8+4AgrHFyB/iZeo1jT0fRj4Y2XiW9c6djJaBMyqUS1IBO5P6ZtSJHLbZ
         cbzA==
X-Gm-Message-State: ALoCoQmCCYR+U/y/7uK5jPVDa+RRT1KR6z/DVG4pIGgefk9F4dHh3ujSV1p59gUoxr9NPE95BABq
X-Received: by 10.58.127.101 with SMTP id nf5mr77114veb.50.1400540152201; Mon,
 19 May 2014 15:55:52 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Mon, 19 May 2014 15:55:52 -0700 (PDT)
In-Reply-To: <xmqqtx8p8lj2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249631>

On Fri, May 16, 2014 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> When performing a reflog transaction update, only write to the reflog iff
>> msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
>> an update that only truncates but does not write.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 8 +++++---
>>  refs.h | 1 +
>>  2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index a8b583a..a3f60ad 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3625,9 +3625,11 @@ int transaction_commit(struct ref_transaction *transaction,
>>                           ftruncate(update->reflog_fd, 0)) {
>>                               error("Could not truncate reflog");
>>                       }
>> -             if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
>> -                                  update->new_sha1,
>> -                                  update->committer, update->msg)) {
>> +             if (update->msg && log_ref_write_fd(update->reflog_fd,
>> +                                                 update->old_sha1,
>> +                                                 update->new_sha1,
>> +                                                 update->committer,
>> +                                                 update->msg)) {
>
> Wouldn't it make it easier to read if you chopped immediately after
> the &&, i.e. chopping at a gap at a higher-level in the parse tree?

Yepp it does.
Changed. Thanks.
>
>         if (update->msg &&
>             log_ref_write_fd(update->reflog_fd,
>                              update->old_sha1, update->old_sha1,
>                              update->committer, update->msg)) {
