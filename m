From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: Re: [PATCH v2] upload-pack: Optionally allow fetching reachable sha1
Date: Wed, 6 May 2015 22:10:11 +0200
Message-ID: <CABA5-zm-PxX-WWtoDnLhtJVZFhO2G1pOTApoz4DtmmUQ61iC6w@mail.gmail.com>
References: <1430604075-5951-1-git-send-email-fredrik.medley@gmail.com>
 <1430860888-6146-1-git-send-email-fredrik.medley@gmail.com> <xmqqmw1id610.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 22:10:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq5eR-0004O8-2x
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 22:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbbEFUKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 16:10:36 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35629 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbbEFUKe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 16:10:34 -0400
Received: by lbbuc2 with SMTP id uc2so15965224lbb.2
        for <git@vger.kernel.org>; Wed, 06 May 2015 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ihMXfGKpt6BL2Psb43eoYkdOK/aJ9sEnOd2Mzw7ILlY=;
        b=YOW263Vb3lzfe8o+CRKiKQ+eEMjvr9iSpv3p1EPKRhiIt6XhzdGZNnyxkkV32R3lsB
         ph0OpnNcnWGugOeXNvixIEs/Idg5nwsf97q6D0+U4kJVpwWuWPPpvGvw0V/rEpfCzwnv
         Nd0Cu15vtWg8s8My2e62OIZ0RXtv2R1XUEEq2f3mj2W0ZQczqjshAf8UcQdRZBtG4geK
         eVX8TOP42UZ1dJJmi9XabqfdXBO/3eD6VWyf7lhvfFm0cjL3XZKN+koPM025h/WpVniq
         3POiRMRVYYVv6+CjOOP4Vr3yUu1Ky2Fp+fjCT4BF8+zPeSwDj1XXw5twqZfCm55rYYOF
         Sj6w==
X-Received: by 10.152.42.242 with SMTP id r18mr374685lal.8.1430943032570; Wed,
 06 May 2015 13:10:32 -0700 (PDT)
Received: by 10.114.10.130 with HTTP; Wed, 6 May 2015 13:10:11 -0700 (PDT)
In-Reply-To: <xmqqmw1id610.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268492>

2015-05-06 0:16 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Fredrik Medley <fredrik.medley@gmail.com> writes:
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 2e5ceaf..76cd713 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2538,6 +2538,12 @@ uploadpack.allowtipsha1inwant::
>>       of a hidden ref (by default, such a request is rejected).
>>       see also `uploadpack.hideRefs`.
>>
>> +uploadpack.allowreachablesha1inwant::
>
> I know that the existing allowtipsha1inwant is spelled that way, and
> it may be better done as a separate clean-up patch (either before or
> after this step), but the documentation and the first line of the
> log message would be easier to read with
>
>         uploadpack.allowReachableSHA1InWant
>
> I'd think.
>

I would prefer using allowReachableSha1InWant. Please tell
me if I should use SHA1InWant instead of Sha1InWant.
(I cannot find anything similar in the repository.)

>
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index 48526aa..fb01b6c 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -43,7 +43,7 @@ static int marked;
>>  #define MAX_IN_VAIN 256
>>
>>  static struct prio_queue rev_list = { compare_commits_by_commit_date };
>> -static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
>> +static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want, allow_reachable_sha1_in_want;
>
> Do we anticipate need for other variations of "allowing bare SHA-1
> that they did not advertise" in the future?
>
> That is a trick question.  We didn't anticipate it, and that is why
> the existing feature squats on a whole integer variable.  And we are
> paying the price of that lack of foresight by having to enhance with
> this patch.  So the only sensible answer to that question is "we
> might need to keep this extensible".
>
> How about renaming the existing allow_tip_sha1_in_want to something
> more generic to cover all such needs, e.g.
>
>     #define ALLOW_TIP          01
>     #define ALLOW_REACHABLE    02
>     static int allow_request_with_bare_object_name;
>
> Then you do not have to write (tip || reachable), and more
> importantly, you do not have to force the next person to update that
> to (tip || reachable || his_new_kind), I would think.
>

I think the reasoning is sensible and I can see a possibility to allow
non-reachable SHA1 in the future, even I would very much recommend
against the use of such option for security reasons.

What I can understand, the capability protocol will still need both options
as separate variables. (I forgot to update the technical documentation
before will do that as well.)

Thank you all for quick replies.
