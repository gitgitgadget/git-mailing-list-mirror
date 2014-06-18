From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v18 10/48] refs.c: verify_lock should set errno to
 something meaningful
Date: Wed, 18 Jun 2014 14:40:00 -0700
Message-ID: <CAL=YDWnkXZFYMSRz9y-d5aRN8a-aaWPi1DiyPgGczM0Cb_eW5g@mail.gmail.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
	<1403020442-31049-11-git-send-email-sahlberg@google.com>
	<53A1F8BD.4060203@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 18 23:40:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxNaU-00027v-MD
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 23:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbaFRVkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 17:40:03 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:33110 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbaFRVkB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 17:40:01 -0400
Received: by mail-vc0-f180.google.com with SMTP id im17so1424848vcb.11
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=saSLDcRKel8tsFWj7qaOu8sDyq6ZwgGKRsOHDXm3PYM=;
        b=BRF0ZoR7XZbs5x0kFleoEw15vxn+DoJgELo4ZWaEm2/sUnEsntRTlWIUUNqF2PKp33
         loUht6tylzyGmO9iPliWabBwztyhsKZnY30ZmpMJskv9R5afDtzGdiiTOdQxJoKio3PS
         hy/n74MjEDj8UKJsaxZqGQ0fP2Xf9/hvhyE0d7F3OcAssLyTjira/wX6qNFcbpiCmekv
         UNh0914Tm9a6gwl4EDgTTMmpIVLkKNkdOynJg/SCMu5vFDozVKMydSqRQ6lHMUAIW8ii
         N+Iy5oniBPp/e5HSOgKxkYjL0SMlFTaYwTdwh58KvqgkEYr5wug9KvPEi3nuAIsQOWgS
         7Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=saSLDcRKel8tsFWj7qaOu8sDyq6ZwgGKRsOHDXm3PYM=;
        b=kXGlyPc+zscSXugbjrq0+GVHkrCCJaoIm/XU/ZlRcAdIwCyNFerYkPw//NB3uULtjW
         TykVXm3EFwoEneMEj+icfa52sMyrnFE2Hnkl4PEzx3Cy+FmX9Bl11jqYi+Wl0Gqx9w9A
         KDWzp6rDnSeQmtLkh1k4bQed9Z8BMT4Z47BKuxPWS6rccM/7LTbB+pzF6Rp7BV4yVA06
         +h4mJ/TsfMjPw1YD7av1L9d05HokCVdd8b+rg0h8B3yx2B+WpB0Sha7ECotiI/c0e5MY
         p4hcUJq+Xpwn6gjHafTfnItcQgsCt3nEV49pg/l2PLOWkCB7NvD7F5XOG78lYONMdq4P
         Q4Ww==
X-Gm-Message-State: ALoCoQkw/4LhQWZxu9MLa8PiVuHdMenPWEdmdSbWxDitLcGsvsUy88XEtOlaAghCxlymD++TRt9h
X-Received: by 10.220.47.201 with SMTP id o9mr80492vcf.65.1403127600702; Wed,
 18 Jun 2014 14:40:00 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Wed, 18 Jun 2014 14:40:00 -0700 (PDT)
In-Reply-To: <53A1F8BD.4060203@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252074>

fixed in 19

On Wed, Jun 18, 2014 at 1:38 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/17/2014 05:53 PM, Ronnie Sahlberg wrote:
>> Making errno when returning from verify_lock() meaningful, which
>> should almost but not completely fix
>>
>>  * a bug in "git fetch"'s s_update_ref, which trusts the result of an
>>    errno == ENOTDIR check to detect D/F conflicts
>>
>> ENOTDIR makes sense as a sign that a file was in the way of a
>> directory we wanted to create.  Should "git fetch" also look for
>> ENOTEMPTY or EEXIST to catch cases where a directory was in the way
>> of a file to be created?
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 4 ++++
>>  refs.h | 6 +++++-
>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 9ea519c..a48f805 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1932,18 +1932,22 @@ int refname_match(const char *abbrev_name, const char *full_name)
>>       return 0;
>>  }
>>
>> +/* This function should make sure errno is meaningful on error */
>>  static struct ref_lock *verify_lock(struct ref_lock *lock,
>>       const unsigned char *old_sha1, int mustexist)
>>  {
>>       if (read_ref_full(lock->ref_name, lock->old_sha1, mustexist, NULL)) {
>> +             int save_errno = errno;
>>               error("Can't verify ref %s", lock->ref_name);
>>               unlock_ref(lock);
>> +             errno = save_errno;
>>               return NULL;
>>       }
>>       if (hashcmp(lock->old_sha1, old_sha1)) {
>>               error("Ref %s is at %s but expected %s", lock->ref_name,
>>                       sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
>>               unlock_ref(lock);
>> +             errno = EBUSY;
>>               return NULL;
>>       }
>>       return lock;
>> diff --git a/refs.h b/refs.h
>> index 82cc5cb..af4fcdc 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -137,11 +137,15 @@ extern int ref_exists(const char *);
>>   */
>>  extern int peel_ref(const char *refname, unsigned char *sha1);
>>
>> -/** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
>> +/*
>> + * Locks a "refs/" ref returning the lock on success and NULL on failure.
>> + * On failure errno is set to something meaningfull.
>
> s/meaningfull/meaningful/
>
>> + */
>>  extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
>>
>>  /** Locks any ref (for 'HEAD' type refs). */
>>  #define REF_NODEREF  0x01
>> +/* errno is set to something meaningful on failure */
>>  extern struct ref_lock *lock_any_ref_for_update(const char *refname,
>>                                               const unsigned char *old_sha1,
>>                                               int flags, int *type_p);
>>
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
