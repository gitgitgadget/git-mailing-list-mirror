From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 02/19] Improve documentation and comments regarding
 directory traversal API
Date: Wed, 2 Jan 2013 12:54:19 +0000
Message-ID: <CAOkDyE_DX8iAAd5ubJaQ_guPQ-PSz4-sFETZoRf7JRTrH6Qcpw@mail.gmail.com>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
	<1356575558-2674-3-git-send-email-git@adamspiers.org>
	<7vobh8aans.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 13:54:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqNqC-0003fx-9j
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 13:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab3ABMyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 07:54:22 -0500
Received: from mail-we0-f170.google.com ([74.125.82.170]:50554 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab3ABMyU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 07:54:20 -0500
Received: by mail-we0-f170.google.com with SMTP id r1so6636037wey.15
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 04:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=xfiyS4CMEoaXNXtJRBLRwT7knAWorrN8qHZMQzV5dFA=;
        b=KD0Df4qanU83/vb2ozih7seJiT/Adkn4HlMH6xsuHbubNQguHFyP9Dwx3WcISH5Om8
         cuF5CHsV9K451Gpia0XK1NfOqt3MTgCXYG0mFHWNUKYQNdIFympYlU4y5r8445ZWqPRJ
         u31KFG5SxBYbrchV4hcuM8FXbPMA96xloKWdqCUZFjfi7jNerocP2gsNYB1TdKdIsHyE
         Aah8W70xkKsnSDRsDJIqyYwo2/Hg5Pn5MtxUR5RjoUeQSjqL4LMxH3euHMRPhdp4/yX3
         hp0EUH7c7drmXw58/OxiE0IgvHx89CDz7uW6m7CHuzw+SBL1wIuOEFZwYzHGkoJls7NQ
         NubA==
Received: by 10.180.101.99 with SMTP id ff3mr71158984wib.21.1357131259091;
 Wed, 02 Jan 2013 04:54:19 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Wed, 2 Jan 2013 04:54:19 -0800 (PST)
In-Reply-To: <7vobh8aans.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: _FWE_Nd8DmlhTcGM6KmOzttK1kg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212513>

On Tue, Jan 1, 2013 at 8:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
>> index 0356d25..944fc39 100644
>> --- a/Documentation/technical/api-directory-listing.txt
>> +++ b/Documentation/technical/api-directory-listing.txt
>> @@ -9,8 +9,11 @@ Data structure
>>  --------------
>>
>>  `struct dir_struct` structure is used to pass directory traversal
>> -options to the library and to record the paths discovered.  The notable
>> -options are:
>> +options to the library and to record the paths discovered.  A single
>> +`struct dir_struct` is used regardless of whether or not the traversal
>> +recursively descends into subdirectories.
>
> I am somewhat lukewarm on this part of the change.
>
> The added "regardless of..." does not seem to add as much value as
> the two extra lines the patch spends.  If we say something like:
>
>         A `struct dir_struct` structure is used to pass options to
>         traverse directories recursively, and to record all the
>         paths discovered by the traversal.
>
> it might be much more direct and informative, I suspect, though.

I somewhat disagree ;) When I first encountered this code, I naturally
assumed that one struct would be created per sub-directory traversed.
This is after all a natural and very common design pattern.  The point
of this hunk was to make it explicitly clear that this is *not* how it
works in dir.c.  IMHO your rewording still contains a certain amount of
ambiguity in this regard.  For example, it could mean that each
dir_struct records all the paths discovered underneath the sub-directory
it represents, and that these recursively bubble up to a top-level
dir_struct.

>> diff --git a/dir.c b/dir.c
>> index ee8e711..89e27a6 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -2,6 +2,8 @@
>>   * This handles recursive filename detection with exclude
>>   * files, index knowledge etc..
>>   *
>> + * See Documentation/technical/api-directory-listing.txt
>> + *
>>   * Copyright (C) Linus Torvalds, 2005-2006
>>   *            Junio Hamano, 2005-2006
>>   */
>> @@ -476,6 +478,10 @@ void add_excludes_from_file(struct dir_struct *dir, const char *fname)
>>               die("cannot use %s as an exclude file", fname);
>>  }
>>
>> +/*
>> + * Loads the per-directory exclude list for the substring of base
>> + * which has a char length of baselen.
>> + */
>>  static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
>>  {
>>       struct exclude_list *el;
>> @@ -486,7 +492,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
>>           (baselen + strlen(dir->exclude_per_dir) >= PATH_MAX))
>>               return; /* too long a path -- ignore */
>>
>> -     /* Pop the ones that are not the prefix of the path being checked. */
>> +     /* Pop the directories that are not the prefix of the path being checked. */
>
> The "one" does not refer to a "directory", but to an "exclude-list".

No, if that was the case, it would mean that multiple exclude lists
would be popped, but that is not the case here (prior to v4).

>         Pop the ones that are not for parent directories of the path
>         being checked

Better would be:

    Pop the entries within the EXCL_DIRS exclude list which originate
    from directories not in the prefix of the path being checked.

although as previously stated, the v4 series I have been holding off
from submitting (in order not to distract you from a maint release)
actually changes this behaviour so EXCL_DIRS becomes an exclude_group of
multiple exclude_lists, one per directory.  So in v4, multiple
exclude_lists *will* be popped.  I'll tweak the comment in v4 to make
this clear.
