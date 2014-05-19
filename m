From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 23/44] fetch.c: change s_update_ref to use a ref transaction
Date: Mon, 19 May 2014 09:58:26 -0700
Message-ID: <CAL=YDWm67m2KC306g2gaqEoifLFnhj+aTFQQNUEYCa+2QdBNNQ@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-24-git-send-email-sahlberg@google.com>
	<20140516225421.GJ12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 18:58:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmQtT-0007l9-Cy
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 18:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbaESQ61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 12:58:27 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:44948 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbaESQ61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 12:58:27 -0400
Received: by mail-vc0-f182.google.com with SMTP id la4so9850807vcb.41
        for <git@vger.kernel.org>; Mon, 19 May 2014 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=njh6CsJTSF/Ts7ykbay5NzJ1gl1nkCXKRFpBRak2w/I=;
        b=F401t3YYqCy3TWSzHTGq8bSY3WTqYVBmINKM4s2xqWz7DOFRZgCh8cELUVDLigQLLy
         lHlezXB2bbOQHAdN9kR2veeecPsCpzqW/b7bulGqTxLTqVeg3HRYZzG9TopCVxf+sLbN
         NR5I3TNj90H8WjcSPvOQU4MnMQQpEX11lrdIUUSjUoMbS68DMURzk/RQmfU6cc+WBH6k
         Uua9dM3qGmIofffNYZxuF/1YjvuyyHGZmqYAqQwnBAguEDUXNp2LyIsYCepU7DR5aDOt
         0mucq5EBOaLoV+aoBylvxDiMHvTTNo4YHaQDNzmT75Y3uZCMK/SpzH5FC2SOWjPW50An
         7NHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=njh6CsJTSF/Ts7ykbay5NzJ1gl1nkCXKRFpBRak2w/I=;
        b=HBrBMvXHFteqoGnrRR7aWkZICYqi1KXDbIcO0/lJY2wsOhPU9IxUYCJmuDxv+yGBl3
         PJ0M7AArOkpfOQOCfQGCvwb0gzHPQvfsNwyyaj7ooRpy0KaAmdaLCJxivaRvW6M/cRxK
         5Q2NNn/2aiOSZWkPnW+Zr5ocD74BGk3lKHCxFC2iXm6E70nQmXSgwvi+9Jq5SH4DOEin
         zuAeHgWuxYWjTVe5KGTLWbWDG7hleYxANIBBj2E5doe1jNRmdi1hFS6PWerSQYEkrm65
         t9VB0FBuwXoqo1MlQ4puxnAK6emYN/rc7YlRpmFAjQ63TKdFKZ/y8l9eixALU5Qd1EsX
         Y0JA==
X-Gm-Message-State: ALoCoQnnFWWzLUeVTVkL/tL4xSy6pZNtsGA8ut9lnkkkrc+61m9aDQcNBAPQWEKUQ7V+UDNZqZS2
X-Received: by 10.52.171.80 with SMTP id as16mr1158229vdc.68.1400518706169;
 Mon, 19 May 2014 09:58:26 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Mon, 19 May 2014 09:58:26 -0700 (PDT)
In-Reply-To: <20140516225421.GJ12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249600>

On Fri, May 16, 2014 at 3:54 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
> [...]
>> @@ -384,15 +384,16 @@ static int s_update_ref(const char *action,
>>       snprintf(msg, sizeof(msg), "%s: %s", rla, action);
>>
>>       errno = 0;
>> -     lock = lock_any_ref_for_update(ref->name,
>> -                                    check_old ? ref->old_sha1 : NULL,
>> -                                    0, NULL);
>> -     if (!lock)
>> -             return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
>> -                                       STORE_REF_ERROR_OTHER;
>> -     if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
>> +     transaction = ref_transaction_begin();
>> +     if (!transaction ||
>> +         ref_transaction_update(transaction, ref->name, ref->new_sha1,
>> +                                ref->old_sha1, 0, check_old) ||
>> +         ref_transaction_commit(transaction, msg, NULL)) {
>
> Since 'err' is NULL, does that mean there's no message shown to the
> user on error?

Yes.  Updated in the ref-transactions branch.
