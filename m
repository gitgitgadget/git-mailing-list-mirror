From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 33/48] walker.c: use ref transaction for ref updates
Date: Mon, 14 Jul 2014 11:05:39 -0700
Message-ID: <CAL=YDWk=oazaCpGGS_pcO2u=JrJvwxd-CORY2SZM+PXqv8Qj0w@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-34-git-send-email-sahlberg@google.com>
	<53BBF333.903@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 14 20:05:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6kdF-0007Gq-8X
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 20:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126AbaGNSFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 14:05:42 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:38972 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbaGNSFk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 14:05:40 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so4217453vcb.29
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oiTSFAGBVxoJoqaJ9L7dW6flUUQ8DyDtfAgnaebVDjk=;
        b=SoanjhVus7S+P0aGzaPzRpk3FrCYGdsKqinZguawpHsg12f6JVHS7RyCCi+H40kpOx
         Zv/0tUkOnEa+6idYQXALmuw+/9YwNICp9Pc9V5//+3BHw8Lh5XTYb66HwhX0pBVggQQD
         jP9h+XIRwW6SxZbmiWefWzSeEWAdGX7YKkpYX1FBK337fRPhcVCLbcpm7z3oblb0tlNi
         YdOnwbKD6TT5jJsMPJJZ0l1CvIXwihtiE0J9Re/IhyuCM/7xEB0O+1ev5mqiRXfTz63U
         /76G0waw6iqNPXUZqumMUSKeGIak89wMh1xdJYRzDt1BPfjrXjbFUWXmh5u/ClaFh+uo
         /hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oiTSFAGBVxoJoqaJ9L7dW6flUUQ8DyDtfAgnaebVDjk=;
        b=TPyV9mLAflPRR5VVAExGAjCavkfm286aMG046LgBnzQfNRwDf54kBs+sz1jbDEhoOW
         sO0ykRT2J+Mo5X6YkpyA29UZyFmDe2rVgVD93yAxurNnvltXBhxyjae6qmFETy6YVrlu
         C9WrtfoWkgYWUvxYFyui8AAsfjUCc9nHwGd8hJ6zcLQo+8ev1ywZit7WDqlEBUV85wke
         7FgmC/9JHl17ve6nFL440d5Grg0dMpQkGVeI1s0vKEfdiXFdw7T8RNTKwuanAtrzAl4P
         33TzEPFqI0c8uW9BhJlAdQMTTsIYDlNDfBmxStjkhw1fXpENqH+1zO7sWQBqmJivBD+B
         jZ2Q==
X-Gm-Message-State: ALoCoQkmX/v+ILLNiNTsZYUgVMqrDh0E9ShmZm2ATbGuXG40Lhx1NjsdBmPmZQACmcxwgAI9Gfk8
X-Received: by 10.52.0.177 with SMTP id 17mr14633111vdf.12.1405361139984; Mon,
 14 Jul 2014 11:05:39 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Mon, 14 Jul 2014 11:05:39 -0700 (PDT)
In-Reply-To: <53BBF333.903@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253505>

On Tue, Jul 8, 2014 at 6:33 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
>> Switch to using ref transactions in walker_fetch(). As part of the refactoring
>> to use ref transactions we also fix a potential memory leak where in the
>> original code if write_ref_sha1() would fail we would end up returning from
>> the function without free()ing the msg string.
>>
>> Note that this function is only called when fetching from a remote HTTP
>> repository onto the local (most of the time single-user) repository which
>> likely means that the type of collissions that the previous locking would
>
> s/collissions/collisions/
>
>> protect against and cause the fetch to fail for to be even more rare.
>
> Grammatico: s/to be/are/ ?

Thanks.  Fixed.

>
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  walker.c | 59 +++++++++++++++++++++++++++++++++++------------------------
>>  1 file changed, 35 insertions(+), 24 deletions(-)
>>
>> diff --git a/walker.c b/walker.c
>> index 1dd86b8..60d9f9e 100644
>> --- a/walker.c
>> +++ b/walker.c
>> @@ -251,39 +251,36 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
>>  int walker_fetch(struct walker *walker, int targets, char **target,
>>                const char **write_ref, const char *write_ref_log_details)
>>  {
>> -     struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
>> +     struct strbuf ref_name = STRBUF_INIT;
>> +     struct strbuf err = STRBUF_INIT;
>> +     struct ref_transaction *transaction = NULL;
>>       unsigned char *sha1 = xmalloc(targets * 20);
>> -     char *msg;
>> -     int ret;
>> +     char *msg = NULL;
>>       int i;
>>
>>       save_commit_buffer = 0;
>>
>> -     for (i = 0; i < targets; i++) {
>> -             if (!write_ref || !write_ref[i])
>> -                     continue;
>> -
>> -             lock[i] = lock_ref_sha1(write_ref[i], NULL);
>> -             if (!lock[i]) {
>> -                     error("Can't lock ref %s", write_ref[i]);
>> -                     goto unlock_and_fail;
>> +     if (write_ref) {
>> +             transaction = ref_transaction_begin(&err);
>> +             if (!transaction) {
>> +                     error("%s", err.buf);
>> +                     goto rollback_and_fail;
>>               }
>>       }
>> -
>
> Is there some reason why the transaction cannot be built up during a
> single iteration over targets, thereby also avoiding the need for the
> sha1[20*i] stuff?  This seems like exactly the kind of situation where
> transactions should *save* code.  But perhaps I've overlooked a
> dependency between the two loops.

I did it this way to keep the changes minimal. But you are right that
with this we can do a larger refactoring and start saving some code.
I can add changes to a later series to do that change but I want to
keep this change as small as possible for now.

regards
ronnie sahlberg
