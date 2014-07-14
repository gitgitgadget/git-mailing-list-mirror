From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 39/48] refs.c: make delete_ref use a transaction
Date: Mon, 14 Jul 2014 13:50:51 -0700
Message-ID: <CAL=YDWmVpB3uj_was-Tyqkgxhd9-5LN6Pg0scG0JkzeWDp0pqA@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-40-git-send-email-sahlberg@google.com>
	<53BBF794.1090702@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 14 22:50:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nD7-0007XH-7b
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756940AbaGNUuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:50:54 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:36068 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756838AbaGNUuw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:50:52 -0400
Received: by mail-vc0-f179.google.com with SMTP id id10so8291714vcb.38
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SzOjZVmSXLRuYyOtigjOrMisplwoNnuPPfBkJX+/YFA=;
        b=Gg8fjRqA53sCAnHYZ7F8MuIPuxCPrT5jwybKnKIQSl8rUMZwYQtJShH78QmDkdq3bu
         8nFng5GlgBWDGJ79PzcDjmXTmRj951VEACerLMK7gVIjAXQXD7drlt2TMxh3ThFX5f1V
         t5XQJzRaaK86RFxcXs9Klp9RoJ5kjjrx0h+oUvuq2k4IBjbsWSEQnW5rr/2YQqx51IaD
         R5+vF2UEhSdm6lY9ih3HSFWBAxT1Bwqwzzn5ku34cr5S/H2uKArmldPvBxNxkoF3K7Gw
         1LN50SAz23s8iQ5eyyUeDKsRpMw8L49qJQk+SyrhOf4Mxwz8Kv6RkncMY3LECyG4xBl1
         GlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SzOjZVmSXLRuYyOtigjOrMisplwoNnuPPfBkJX+/YFA=;
        b=Vo7J0GDCO/F6xARnbqxW5xYg3QeMKY7Jr9s+0EwmUCq4xpvXDsRvlsZs0Nh5ohPB6S
         19jTv/J+m6Qx8SmmbwpTmh0Pot9EF9t3aP7xBEDh4EZyOCrnhCcw7Yr4GuQY/q0ZMWpN
         e42fox4a4ovMl7huKUchOrdTW3WjmEMdnWLVWD6t0LFFQBRuu+reb2k4qvpTqCdut7lM
         r+NpUUVJNuZfQ5FsRRUNQK+KY1OZxEQIaWSmXdns0tx/gCiO0fufFg/0+1XsHGEO5c/S
         UOs7Gi6KI/1/G/cAPouZX77yqLFxbv/P14pvDI6mFMvDL6QttBebCbzN/4WrOUPGt+Nt
         K8cA==
X-Gm-Message-State: ALoCoQmpMrdFzvyO4fvj6Z5mbdzDlJRUSbBQG96/udIamNuNzuqhBS9BL0v9XTjBhk+QMpxPFGWi
X-Received: by 10.52.244.138 with SMTP id xg10mr1977421vdc.40.1405371051720;
 Mon, 14 Jul 2014 13:50:51 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Mon, 14 Jul 2014 13:50:51 -0700 (PDT)
In-Reply-To: <53BBF794.1090702@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253513>

On Tue, Jul 8, 2014 at 6:52 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
>> Change delete_ref to use a ref transaction for the deletion. At the same time
>> since we no longer have any callers of repack_without_ref we can now delete
>> this function.
>>
>> Change delete_ref to return 0 on success and 1 on failure instead of the
>> previous 0 on success either 1 or -1 on failure.
>>
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 34 +++++++++++++---------------------
>>  1 file changed, 13 insertions(+), 21 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 3d070d5..92a06d4 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2544,11 +2544,6 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
>>       return ret;
>>  }
>>
>> -static int repack_without_ref(const char *refname)
>> -{
>> -     return repack_without_refs(&refname, 1, NULL);
>> -}
>> -
>>  static int delete_ref_loose(struct ref_lock *lock, int flag)
>>  {
>>       if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
>> @@ -2566,24 +2561,21 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
>>
>>  int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>>  {
>> -     struct ref_lock *lock;
>> -     int ret = 0, flag = 0;
>> +     struct ref_transaction *transaction;
>> +     struct strbuf err = STRBUF_INIT;
>>
>> -     lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
>
> The old code checked that the old value of refname was sha1, regardless
> of whether sha1 was null_sha1.  Presumably callers never set sha1 to
> null_sha1...

They sometimes do.

>
>> -     if (!lock)
>> +     transaction = ref_transaction_begin(&err);
>> +     if (!transaction ||
>> +         ref_transaction_delete(transaction, refname, sha1, delopt,
>> +                                sha1 && !is_null_sha1(sha1), &err) ||
>
> ...But the new code explicitly skips the check if sha1 is null_sha1.
> This shouldn't make a practical difference, because presumably callers
> never set sha1 to null_sha1.

There are actually a few cases where callers do call delete_ref() with
sha1 == null_sha1.
For example fast-import.c:update_branch() will do this is the ref can
not be resolved.
It can also happen in builtin/update-ref.c where we are passing user
supplied data into the call to delete_ref.

So I think the current behaviour should be ok.

There are a few options we could do:
We could change the semantics for ref_transaction_update|delete and
start allowing
   have_old==1
   old_sha1==null_sha1
and have this behave the same way as
   have_old==0
but I think that would be horrible I think.

We could also change all callers to delete_ref() to be careful to only
specify a sha1 IFF it is not null_sha1
but that would just mean we require all callers to do this type of check.
But that would also be fragile since if/when we get new callers to
delete_ref we risk breaking delete_ref if we are not careful.


I think the least bad option is to just have this check in
delete_ref() as now and have the semantics for delete_ref be that if
sha1 is either NULL or null_sha1 then it means we don't care what the
old value is.



regards
ronnie sahlberg
