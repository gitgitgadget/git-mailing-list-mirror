From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 39/44] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Thu, 22 May 2014 10:28:47 -0700
Message-ID: <CAL=YDW=fqDFFMomX-GDyANsABz6E5zww+JKgD6V0A+mc6Ja96g@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-40-git-send-email-sahlberg@google.com>
	<20140522014242.GO12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 19:28:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnWnY-0001up-HP
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 19:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbaEVR2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 13:28:50 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:54680 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbaEVR2t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 13:28:49 -0400
Received: by mail-vc0-f175.google.com with SMTP id id10so1453271vcb.6
        for <git@vger.kernel.org>; Thu, 22 May 2014 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UZ3yekFa1fzskVgw3Xyi3nhKDbzXoBoTPzWiwnaGASs=;
        b=UKg6YVIVwp1mVl4bdCzu8rYK9R/5lId9QY6F5eGn0ZF7RFazIHzaP8Cet7wDlc1BeW
         PEG0vUp5+2t7+CCZzqyajoRJZXljpcYdzjy4wAkhXyx+cjJ2zuz3lx1R9loHQsiUrwBm
         R3eLjJlMDFsME0CSeJ2zkg5k1g/8T/aP68udZdu7ojULiogncBRYZGY/EWmxVuPtbi/Z
         4CN6heK4RSHoHZOkQaUjGMiYwyBHTPZ1FyQJ00TdNJNctSLcINQlvF9HYTh5mShN4xRT
         6zrkzDGE/HGzFaynTB51GdRSVr28wMGH25zEwKSMnfnQ6PEF/Cojx17CPb/i9km5yPHN
         ZdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UZ3yekFa1fzskVgw3Xyi3nhKDbzXoBoTPzWiwnaGASs=;
        b=LcsdD1UDvSl3nIRnhQyw1Uxw+OCuxWFcwCRpsIWTGG9JdBfvf0E45Wn5wkK3jpDril
         LEcpNliqo+Rt1jo+n19+BwWeYZWlfIjX4NQ3fnhwVDtTEVUcT8s1stXEvr4WFNY3FYaq
         4v1S4Yx5ssSxNKnymwiPzA1u1RPO432bQLAJeIjsodEkDLk+VeMblIwHPSD3bevJ0xcI
         3LO4OJi9r8VGcvM5FkyHsj84WZ8XE7Kc9kwXjx1caRMdFK1gsYYk5UPmQOae45NcjmRY
         wD7SRuCX5hDyx7WFusbPcTxtJB9jirvGk/hbZkLlSAXR2BiIAKDaec7AfnqEXVjky6kx
         Wo9g==
X-Gm-Message-State: ALoCoQnfUFzJ1XJg1JZ+W4+2dSnDvgDiZLUkAsFNI2xcFRhk7gTol5ahYdERBzHH+652IsOdwIA5
X-Received: by 10.58.219.166 with SMTP id pp6mr50583988vec.1.1400779727541;
 Thu, 22 May 2014 10:28:47 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 22 May 2014 10:28:47 -0700 (PDT)
In-Reply-To: <20140522014242.GO12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249920>

On Wed, May 21, 2014 at 6:42 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2044,6 +2044,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>>       int missing = 0;
>>       int attempts_remaining = 3;
>>
>> +     if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
>> +             return NULL;
>
> Are we sure that no callers are locking a poorly named ref
> as preparation for repairing it?
>
> To see what works already in that vein, I tried:
>
>         $ git rev-parse HEAD >.git/refs/heads/foo..bar
>         $ git branch -m foo..bar something-saner
>         fatal: Invalid branch name: 'foo..bar'
>
> "git branch -m" has an explicit codepath ("recovery = 1;") to handle
> this case, but it looks like it was not well tested and regressed in
> v1.7.8-rc0~19^2~7 (resolve_ref(): verify that the input refname has
> the right format, 2011-09-15).
>
> Is what the recovery codepath of branch -m does misguided?  One
> school of thought would be that people with malformed refs are
> responsible for recovering using low-level tools like "mv" and "vi"
> instead of normal git commands since normal git commands should never
> have created such a bad situation.  Another school of thought would
> assert that
>
>  * git commands can have bugs
>  * the format checked by check_refname_format() keeps getting stricter
>    over time
>
> which means it's nice when people can recover with 'update-ref -d'
> or 'branch -m'.  It's not obvious to me what the right thing to do
> here is (maybe a special flag to be attached to a ref update during
> recovery?).
>

I don't think we should allow external caller any other way to
access/modify refs than through
the transaction api. This may make it awkward to handle cases such as
foo/../bar was created  and how would you now delete it ?

The exception to this I think would be 'git fsck'. We could allow fsck
to have low level access to the backing store and allow it to access
the files directly,
or allow fsck to set magic flags that disable various checks.




> Hope that helps,
> Jonathan
