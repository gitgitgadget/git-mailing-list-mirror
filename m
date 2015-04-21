From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] refs.c: enable large transactions
Date: Tue, 21 Apr 2015 10:24:42 -0700
Message-ID: <CAGZ79kay11Pd4ni1j6jSYbenSXVfUP-6irPBc_r1=gUZFe-Hjw@mail.gmail.com>
References: <CAGZ79kY842JXB37++nwYjkX1WK9ja5m-G1aDj=QgLN-qKLo9Lg@mail.gmail.com>
	<1429576506-10790-1-git-send-email-sbeller@google.com>
	<xmqqegndieqd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:24:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykbuh-0007mq-Pm
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 19:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbbDURYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 13:24:43 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33377 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755684AbbDURYm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 13:24:42 -0400
Received: by iecrt8 with SMTP id rt8so19131967iec.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=azCi1kwVokGDfUBPt0inMj+xWtC8RvzfJoOcdhGB5IE=;
        b=bRBPWUJYTiGAxLNf/1lx9Zwqen3tz1XSORrAlQHsJn/sLqw7vG0oDG9EScKtJfZ7/T
         shAbFY2hpzUxqL1OrS2YtglFH/ofxeAM7EHn5E9hR6JfbLG3kxNY413J5J90cJLgGu8b
         ZOF7MRIUs25EG759DYRCfAUo+malgK5/GqBF3YNL7i4iKzagHRQP4B1xwgWoM1tQEygk
         me5YPw7DEJI1wmpRIB1iP/wOu9sM/KAHPaYKVbxs3LlCTOqsaSspldPDudoXfkXFoLIM
         moYm73SFlEaNVmpzfBR8iEGyFpNg3/eHrGIjbIhbEF6wo6LnrvQdod6O5cZi0N6JH+1l
         CIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=azCi1kwVokGDfUBPt0inMj+xWtC8RvzfJoOcdhGB5IE=;
        b=JQRRR6Pp1wod8K0FFjUDRNyhunwHM+c08ByyR7b16FzvbDzp+qQA6wcycm96UgY87b
         bPXPS0htKCiGwZ6VTzMDOvoPsvCpHpPYcSy7QT9WksDJ0XTV4VhRWwEw8DcT0MRhcmVY
         zznwUWeKZdsWPiBLUkZR+kyfi9fzqSQ4mCf8PH0Qwy+Tig2HNO+hZB1qqPP1KoTnNcy3
         PzzgwepCZyVNuSxjL+SpbNdDhIYshU058md1tSLaHVs1OOzezOb91cyXQ+uN9MgsH42l
         LDOGvGEUZ9CwD71P/URzGX6243WcPTGa/qLQAXBUZ3CpBQco86fzbWPr6tc54VRCyb5a
         Ue+w==
X-Gm-Message-State: ALoCoQnGqAVPglI2tS20O4Ltw0TG2H2ZtVsp3pwZ7Gtc18DTXM7RWUFQ2SWg+L/ha20PjelJEBAg
X-Received: by 10.42.30.141 with SMTP id v13mr4879923icc.76.1429637082207;
 Tue, 21 Apr 2015 10:24:42 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Tue, 21 Apr 2015 10:24:42 -0700 (PDT)
In-Reply-To: <xmqqegndieqd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267538>

On Tue, Apr 21, 2015 at 10:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +     /*
>> +      * We may want to open many files in a large transaction, so come up with
>> +      * a reasonable maximum, keep some spares for stdin/out and other open
>> +      * files.
>> +      */
>> +     int remaining_fds = get_max_fd_limit() - 32;
>
> Can this go negative?  If it does so, does it matter?  I think the

Yes it can go negative. It doesn't matter as we'd then run into the
"close_lock_file(update->lock->lk);" case below.

I thought about putting a cap on it to not let it go negative in the first
place, but I did not find an easily accessible max() function, as I'd like
to write it as

    int remaining_fds = max(get_max_fd_limit() - 32, 0);

to have it in one line. The alternative of

    int remaining_fds = get_max_fd_limit() - 32;
    ...
    if (remaining_fds < 0)
        remaining_fds = 0

seemed to cuttered to me. Yet another alternative

     int remaining_fds = get_max_fd_limit() - 32 < 0 ? 0 :
get_max_fd_limit() - 32;

is also not appealing as we'd have to call get_max_fd_limit 2 times.
That's why I thought going negative is not as bad, but have readable
code instead.

As you think about the possibility of remaining_fds being negative,
this might not
be the best idea though


> code doesn't barf, but starting from a negative "remaining" feels
> cryptic, compared to starting from a zero "remaining".
>
>>       struct ref_update **updates = transaction->updates;
>>       struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
>>       struct string_list_item *ref_to_delete;
>> @@ -3762,6 +3770,11 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>                                   update->refname);
>>                       goto cleanup;
>>               }
>> +             if (remaining_fds > 0) {
>> +                     remaining_fds--;
>> +             } else {
>> +                     close_lock_file(update->lock->lk);
>> +             }
>
> Any plan to add more code to these blocks in future updates?

I'll remove the braces. :(

>
> Thanks.
>
>> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
>> index 7a69f1a..636d3a1 100755
>> --- a/t/t1400-update-ref.sh
>> +++ b/t/t1400-update-ref.sh
>> @@ -1071,7 +1071,7 @@ run_with_limited_open_files () {
>>
>>  test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
>>
>> -test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
>> +test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
>>  (
>>       for i in $(test_seq 33)
>>       do
>> @@ -1082,7 +1082,7 @@ test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches
>>  )
>>  '
>>
>> -test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
>> +test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
>>  (
>>       for i in $(test_seq 33)
>>       do
