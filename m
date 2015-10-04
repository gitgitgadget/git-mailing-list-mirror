From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/9] ref-filter: add support for %(path) atom
Date: Sun, 4 Oct 2015 22:37:21 +0530
Message-ID: <CAOLa=ZSdM34_J+gb_=K4-9fgNsMfseAYxUYGm_ncWZstcW+SYw@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-4-git-send-email-Karthik.188@gmail.com> <vpqwpv49so7.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 04 19:07:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZimlR-0003YJ-0C
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 19:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbbJDRHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 13:07:52 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34883 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbbJDRHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 13:07:51 -0400
Received: by vkao3 with SMTP id o3so84299449vka.2
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xZqn/17SDoktMK16I/qB/VeU7ddL6JooDhDBtqjk3Ys=;
        b=VKTJWxcyVH6SJN8nSacSg3c+Eab0vrJ1mIj4NmGpFprsnrsNWoYmcDf2ooNgoOF9eW
         rNhSddHaOXZ9HXHp+xqyZKJubrhaHxFBZ0UgMEmaf9NZ59t1qW9B08bLijNPjvjK8L3x
         PyUDfcRE/UGOTrxpOgOzkmqbpnhAbyQXS+EWSy2/55C0BRnBjbbSuvEnELp0v8QCtRFK
         /Ixm5tSlz5H/rG/QPGNPk9AmEi0WT2qf1WaKEk6vBCzCVBsad07iEVHnwlfG+A3eMzp0
         +R5CjqQDKJRug9IuKmrRy/gYQbuo1Q+j7f9fMqN1J6ASSxsFRgWxJI01K89zy9edbkpT
         lGbA==
X-Received: by 10.31.50.214 with SMTP id y205mr16875406vky.77.1443978471104;
 Sun, 04 Oct 2015 10:07:51 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sun, 4 Oct 2015 10:07:21 -0700 (PDT)
In-Reply-To: <vpqwpv49so7.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279003>

On Sat, Oct 3, 2015 at 3:32 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This adds %(path) and %(path:short) atoms. The %(path) atom will print
>> the path of the given ref, while %(path:short) will only print the
>> subdirectory of the given ref.
>
> What does "path" mean in this context? How is it different from
> %(refname)?
>
> I found the answer below, but I could not guess from the doc and commit
> message. Actually, I'm not sure %(path) is the right name. If you want
> the "file/directory" analogy, then %(dirname) would be better.
>

Noted will change.

>> +             } else if (match_atom_name(name, "path", &valp)) {
>> +                     const char *sp, *ep;
>> +
>> +                     if (ref->kind & FILTER_REFS_DETACHED_HEAD)
>> +                             continue;
>> +
>> +                     sp = strchr(ref->refname, '/');
>> +                     ep = strchr(++sp, '/');
>
> This assumes you have two / in the fullrefname. It is normally the case,
> but one can also create eg. refs/foo references. AFAIK, in this case sp
> will be NULL, and you're then calling strchr(++NULL) which may segfault.
>

Not really, but you made me think of another possible issue.

Assume refs/foo "sp = strchr(ref->refname, '/');" would set sp to point at
'/' and ++sp will now point at 'f'.

The problem now is refs/foo is supposed to print just "refs" whereas it'll
print "refs/foo". and %(dirname:short) is supposed to print "" whereas it'll
print "foo". Will look into this :)

>> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
>> index d7f7a18..5557657 100755
>> --- a/t/t6302-for-each-ref-filter.sh
>> +++ b/t/t6302-for-each-ref-filter.sh
>> @@ -312,6 +312,7 @@ test_expect_success 'check %(if:equals=<string>)' '
>>       test_cmp expect actual
>>  '
>>
>> +
>>  test_expect_success 'check %(if:notequals=<string>)' '
>
> Useless new blank line.
>

Will remove.

>> +test_expect_success 'check %(path)' '
>> +     git for-each-ref --format="%(path)" >actual &&
>> +     cat >expect <<-\EOF &&
>> +     refs/heads
>
> You should add eg.
>
> git update-ref refs/foo HEAD
> git update-ref refs/foodir/bar/boz HEAD
>
> before the test to check and document the behavior for such refnames.

Yeah makes sense.

-- 
Regards,
Karthik Nayak
