From: Kevin <ikke@ikke.info>
Subject: Re: Fwd: possible Improving diff algoritm
Date: Wed, 12 Dec 2012 20:30:01 +0100
Message-ID: <CAO54GHANKuv_+S-FJzrTfeFyiXcKDbm5hLGdADQ7GVMh7jEMxw@mail.gmail.com>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
 <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com> <7vvcc73yzh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:30:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tis0w-0001U3-EI
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 20:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779Ab2LLTaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 14:30:25 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:55469 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab2LLTaY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 14:30:24 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so469454wey.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 11:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=CIpAG6EGgSfLitCR3pyDhIvrB9gkDsoKHpwBn+Hptw0=;
        b=Oieu6QliM5RYm+9ZVNmnAeKQsi8SuJCl+sMGfL8tDT6iJxnxjTB4fXpplrM4ztn0zo
         IJfzUf5kmVBrK8QfQmqhv4VthSxGFYlHAKvFgml0oFVzjCpS+5NSVV7s843ShOs67D70
         ZcyOjOWBlQIBNdhFIn0YhFtXhqYhnasys1g1jlURSX7ec7cnfuLdcEnmtZvgRVoZIHS1
         TwDpGJ0ImOMLghDTXl22FyipbcbGmjIWWyxzZ4fwFiWVXTFcxm/icCecZBKY/4ZdwK1n
         Z6RoNcFj/kUJ96KNzGR56kG3JsgAbzlrmXa2bqws1ipEjkS07NDiAkN4voheOiwUPBFx
         teAw==
Received: by 10.180.19.73 with SMTP id c9mr24750566wie.8.1355340622855; Wed,
 12 Dec 2012 11:30:22 -0800 (PST)
Received: by 10.227.9.14 with HTTP; Wed, 12 Dec 2012 11:30:01 -0800 (PST)
In-Reply-To: <7vvcc73yzh.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: pMO1xW8_IHaPAqOEHs8BINvGOow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211384>

Yeah, I didn't mention it, but I didn't think it was doing this wrong
in a systematic way. I only wondered if there was some kind of
heuristic that could improve the cases where it goes wrong, without
affecting the cases where it would do it right.

I know this is not an easy problem, lest it would already been fixed.

On Wed, Dec 12, 2012 at 7:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Kevin <ikke@ikke.info> writes:
>
>> Regularly I notice that the diffs that are provided (through diff, or
>> add -p) tend to disconnect changes that belong to each other and
>> report lines being changed that are not changed.
>>
>> An example for this is:
>>
>>      /**
>> +     * Default parent
>> +     *
>> +     * @var int
>> +     * @access protected
>> +     * @index
>> +     */
>> +    protected $defaultParent;
>> +
>> +    /**
>>
>> I understand this is a valid view of what is changed, but not a very
>> logical view from the point of the user.
>>
>> I wondered if there is a way to improve this, or would that have other
>> consequences.
>
> I think your example shows a case where the end of the pre-context
> matches the end of the added text in the hunk, and it appears it may
> produce a better result if you shift the hunk up.  But I think that
> works only half the time.  Imagine:
>
>    @@ -K,L +M,N @@
>     }
>
>    +void new_function(void)
>    +{
>    +  printf("hello, world.\n");
>    +}
>    +
>     void existing_one(void)
>     {
>       printf("goodbye, world.\n");
>
> Here the end of the pre-context matches the end of the added lines,
> but it will produce worse result if you blindly apply the "shift the
> hunk up" trick:
>
>      ... what was before the } we saw in the precontext ...
>    +}
>    +
>    +void new_function(void)
>    +{
>    +  printf("hello, world.\n");
>     }
>
>     void existing_one(void)
>
> So I think with s/Regularly/About half the time/, your observation
> above is correct.
>
> I think the reason you perceived this as "Regularly" is that you do
> not notice nor appreciate it when things go right (half the time),
> but you tend to notice and remember only when a wrong side happened
> to have been picked (the other half).
