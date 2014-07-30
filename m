From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 2/5] refs.c: write updates to packed refs when a
 transaction has more than one ref
Date: Wed, 30 Jul 2014 12:19:42 -0700
Message-ID: <CAL=YDWn60wSnY3cKBDgZYdCnNDzyF9VyJ72CbBcHSi7kM2uY2A@mail.gmail.com>
References: <1406310926-4080-1-git-send-email-sahlberg@google.com>
	<1406310926-4080-3-git-send-email-sahlberg@google.com>
	<xmqq4mxz3m8q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:20:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCZPf-0002KT-FI
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 21:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769AbaG3TTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 15:19:43 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:62846 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755537AbaG3TTn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 15:19:43 -0400
Received: by mail-vc0-f177.google.com with SMTP id hy4so2572720vcb.8
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 12:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lnBIKZdlZ45txkL4RFwtKRQNw6bFxuF67Da1r8uwRrc=;
        b=eu8iG9SNaLyyMUVo5kUJqHyPiHt3jzeBGU184IwtC0uXE+khA3KrEgCrn9985Le+wS
         VPDJfpI64jC1/+VmZEdDe8tRPfo7wCwmDFZT0QrQ7tXhcWtIQG7IMC5pPIIFuKLCQWhb
         PDdDI4r8XglWEC0u21vc5+z/LBy6lUc0cZa66SQNlT9UzocAHy2X/zMYbvLcekvUXGon
         xTd9vrFGMDZqt+EUi/DrrZ833q/p+d/qcOvbtrKvNy5RYMg6TE9aZSF+Sp9q9H7OgLj0
         4f4VErELsCXJAGCjQ28wBtKHqcgsKgetcEopLJmCQkcLJd8LrepX2F72gAaMXuoT8tXz
         1fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lnBIKZdlZ45txkL4RFwtKRQNw6bFxuF67Da1r8uwRrc=;
        b=bgfo7iKeVb3A8hlYKLI0BWMaaODPzEQJ0LwRbgZexhLT5VF5u6Vw4FqrTvcXXuUaYU
         EXMwTH7QuM5BMvhcaDNSxOkWDbTIZGlcV2RLbsRYyvcFFz0USkmp6mJG4i8Z7Ady9wD0
         +2PnMaGYmXe+264RghoUBd96nopMo2vU5a3Qi5Pqxir3XkKYNvMnmBcCZMyuZSB3idrv
         vTG1m1jxamnsMRP/gbOms24Y2Edeloe2LXqMDFpLDehk9Giqb3VHETFaNx31uvcLMt5v
         6imRcDrJebLgYIFqvQ/kg8exKDmo5F75yffa5WebRfJcw6F6DORVhYc60YpPdA612rVM
         F9+w==
X-Gm-Message-State: ALoCoQmdJhjWTX4/k3BPA+JCxZfzDobph1l9O2bVGTNVZxX0dcI6xzyRCGFRM64rwqHzZD4n6BIt
X-Received: by 10.52.228.40 with SMTP id sf8mr4791533vdc.78.1406747982181;
 Wed, 30 Jul 2014 12:19:42 -0700 (PDT)
Received: by 10.52.180.6 with HTTP; Wed, 30 Jul 2014 12:19:42 -0700 (PDT)
In-Reply-To: <xmqq4mxz3m8q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254511>

On Tue, Jul 29, 2014 at 2:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> +     /*
>> +      * Always copy loose refs that are to be deleted to the packed refs.
>> +      * If we are updating multiple refs then copy all non symref refs
>> +      * to the packed refs too.
>> +      */
>>       for (i = 0; i < n; i++) {
>>               struct ref_update *update = updates[i];
>>               unsigned char sha1[20];
>> +             int flag;
>>
>>               if (update->update_type != UPDATE_SHA1)
>>                       continue;
>> -             if (!is_null_sha1(update->new_sha1))
>> +             if (num_updates < 2 && !is_null_sha1(update->new_sha1))
>>                       continue;
>>               if (get_packed_ref(update->refname))
>>                       continue;
>>               if (!resolve_ref_unsafe(update->refname, sha1,
>> -                                     RESOLVE_REF_READING, NULL))
>> +                                     RESOLVE_REF_READING, &flag))
>> +                     continue;
>> +             if (flag & REF_ISSYMREF)
>>                       continue;
>
> This skipping of symref didn't use to be here.
>
> Is this an enhancement needed to implement the new "feature"
> (i.e. use packed refs to represent multi-update as an atomic
> operation)?  It looks to me more like an unrelated "oops, forgot
> that we cannot use packed refs to store symrefs" fix-up, unless no
> caller passed symref in updates[] in the original code, and now we
> have callers that do.
>
> Puzzled...

It was mainly as an enhancement.
Prior to this patch we were only using the packed-refs trick for the
delete+rename operation part of a rename_ref() call.
And for that case we already explicitly test for and disallow symbolic
refs already in rename_ref().

I added this just for extra safety for "now that we possibly delete
multiple refs in one transaction, should I special case/disallow the
packed refs trick for symrefs?"
Looking at it again I don't think we need this special casing and it
only makes the code more complex and confusing.
I will review the use of this a little and run some tests and if all
looks sane I will remove this ISSYMREF special casing.

Thank!
ronnie sahlberg
