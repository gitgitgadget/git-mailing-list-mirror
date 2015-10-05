From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 8/9] branch: use ref-filter printing APIs
Date: Mon, 5 Oct 2015 23:16:42 +0530
Message-ID: <CAOLa=ZSk8-6nkfEd+Kz1srOJxPLj6+zLEU9DnLgW3rW1O6kZGg@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-9-git-send-email-Karthik.188@gmail.com> <vpqvbao86pj.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 05 19:47:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj9r4-00063v-Cn
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 19:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbbJERrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 13:47:14 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34970 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbJERrN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 13:47:13 -0400
Received: by vkao3 with SMTP id o3so101358205vka.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=88Mvz9JsRZwLLlBlhkn9Z01iHtDnKRFfexE2brJqJ5Q=;
        b=xJSo/XWOTtYJYp7OTUsctM6UDY2jzDf5AsF8JauanxIF/NK2d4jFg2CIRZpYsi53sG
         0Y/io8UBebOcWPVPe1+/V1k4fbgym0Wc11hbrOBiQ4Q28/5pTjWnpQAHD9L+iEtUvhdP
         3ldbTqMsALplI4Y/slrrfIIKzncnhx0DxXyFDHETCejj4nd9CKIADptwhRcQIzwikn/R
         mkPg/ncLXj3+BqydzVMEf9fy2Nw+uEwdyLua5o+la/aNQu6pB/SmibigWkRrmpZyLvvo
         8mYpfv175dworbv2mHcCIfh01koa0a0oLYAfNOT91MbLbbCpp0vOFtMqD8aP/D6S+eKU
         avkQ==
X-Received: by 10.31.21.149 with SMTP id 143mr20776611vkv.79.1444067232035;
 Mon, 05 Oct 2015 10:47:12 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Mon, 5 Oct 2015 10:46:42 -0700 (PDT)
In-Reply-To: <vpqvbao86pj.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279064>

On Sat, Oct 3, 2015 at 6:11 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> -     if (upstream_is_gone) {
>> -             if (show_upstream_ref)
>> -                     strbuf_addf(stat, _("[%s: gone]"), fancy.buf);
>
> The old string was translated, and you're replacing it with one which
> isn't.
>
> I'm not a big fan of translation, so that change doesn't disturb me, but
> people used to having "git branch" talk their native language here may
> care.
>
> Be careful: translation should happen only in porcelain. Typicall,
> "for-each-ref" should anyway continue saying "gone" in english whatever
> the configuration is.
>
> See e.g. 7a76c28 (status: disable translation when --porcelain is used,
> 2014-03-20) for an example of translation only for porcelain (that was
> for status, but also for ahead/behind/gone).
>

I'm not how translation works, thanks for the hint, I'll look around.

>> +static char *get_format(struct ref_filter *filter, int maxwidth, const char *remote_prefix)
>
> I'd call that "build_format", since "get_..." usually implies that the
> value exists already and you're retrieving it.
>

Makes sense.

>> +{
>> +     char *remote = NULL;
>> +     char *local = NULL;
>> +     char *final = NULL;
>> +
>> +     if (filter->verbose) {
>> +             if (filter->verbose > 1)
>> +                     local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(align:%d,left)%%(refname:short)%%(end)%s"
>> +                                     " %%(objectname:short,7) %%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s] %%(end)"
>> +                                     "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)",
>> +                                     branch_get_color(BRANCH_COLOR_CURRENT), maxwidth, branch_get_color(BRANCH_COLOR_RESET),
>> +                                     branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
>
> OK, that is a hell of a block of code ;-).
>
> You should factor the common portions out of these if/else. C allows you
> to write several string litteral next to each other, so you can eg.
>
> #define STAR_IF_HEAD "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)"
> #define ALIGNED_REFNAME "%%(align:%d,left)%%(refname:short)%%(end)"
>
> and then
>
> STAR_IF_HEAD ALIGNED_REFNAME ...
>
> Actually, this is not a performance-cricical piece of code at all, so I
> think it's even better to build an strbuf little by little using
> repeated strbuf_addf calls. This way you can do things like
>
> strbuf_addf(fmt, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)",
>             branch_get_color(BRANCH_COLOR_CURRENT));
> strbuf_addf(fmt, "%%(align:%d,left)%%(refname:short)%%(end)", maxwidth);
>
> which makes it much easier to pair the %s and the corresponding
> branch_get_color() or the %d and maxwidth.
>
> But fundamentally, I think this function is doing the right thing. The
> function is a bit complex (I think it will be much nicer to read when
> better factored), but 1) it allows getting rid of a lot of specific code
> and 2) it's a proof that --format is expressive enough.
>

I like the idea of using "#define" it might make things simpler.

Not sure about using a strbuf cause I don't see how that could make things
simpler, we'll end up with something similar to what we have currently. Just
that instead of using variables like "local", "remote" and "final" we'd just
make multiple calls to strbuf_addf().

>> @@ -58,11 +58,11 @@ test_expect_success 'branch -v' '
>>  '
>>
>>  cat >expect <<\EOF
>> -b1 [origin/master: ahead 1, behind 1] d
>> -b2 [origin/master: ahead 1, behind 1] d
>> -b3 [origin/master: behind 1] b
>> -b4 [origin/master: ahead 2] f
>> -b5 [brokenbase: gone] g
>> +b1 [origin/master] [ahead 1, behind 1] d
>> +b2 [origin/master] [ahead 1, behind 1] d
>> +b3 [origin/master] [behind 1] b
>> +b4 [origin/master] [ahead 2] f
>> +b5 [brokenbase] [gone] g
>
> This corresponds to this part of the commit message:
>
>> Since branch.c is being ported to use ref-filter APIs to print the
>> required data, it is constricted to the constraints of printing as per
>> ref-filter. Which means branch.c can only print as per the atoms
>> available in ref-filter. Hence the "-vv" option of 'git branch' now
>> prints the upstream and its tracking details separately as
>> "[<upstream>] [<tracking info>]" instead of "[<upstream>: <tracking
>> info>]".
>>
>> Make changes in /t/t6040-tracking-info.sh to reflect the change.
>
> nit: /t/t... -> t/t... (remove leading /)
>
> That is a behavior change, and I actually prefered the previous one.
>
> I actually don't understand why you can't get the old syntax: the []
> around the refname come from the format string it get_format(), so you
> could decide to change "[%s%%(upstream:short)%s]" to
> "[%s%%(upstream:short)%s: ". The brackets around the status are a bit
> more tricky, since they were here before your series. But we could have
> a %(upstream:track,nobracket) to display just the status without the
> brackets around.
>
> Then, the code must deal with up-to-date branches for which no
> " :ahead/behind" must be displayed. Probably one more if/then/else
> nested in the first one.
>
> So, it seems feasible to me to keep the old behavior with the new
> system, even though it's going to be a bit tricky.
>

Wasn't that hard to do, I got this working, I was just reluctant on making
a new subvalue like "%(upstream:track,nobracket)" (no real reason, just didn't
want to ).

-- 
Regards,
Karthik Nayak
