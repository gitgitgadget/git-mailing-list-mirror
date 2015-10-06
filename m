From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 8/9] branch: use ref-filter printing APIs
Date: Tue, 6 Oct 2015 21:00:27 +0530
Message-ID: <CAOLa=ZS5x=ksfnBt1kLp5bJJHmqeBztR7Zn7U5VKZN-56T-_5A@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-9-git-send-email-Karthik.188@gmail.com> <vpqvbao86pj.fsf@grenoble-inp.fr>
 <CAOLa=ZSk8-6nkfEd+Kz1srOJxPLj6+zLEU9DnLgW3rW1O6kZGg@mail.gmail.com> <vpq7fn1qhp2.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 06 17:31:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjUCs-00015E-UM
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 17:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbbJFPbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 11:31:00 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36588 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbbJFPa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 11:30:58 -0400
Received: by vkfp126 with SMTP id p126so119650496vkf.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RoUmIl9h2th1Hq4No2IRZxHihw+CAbYt5eXAyc3/cdM=;
        b=EPs+6rWBtuyQBXd/7PUxq0ul/sYTv0JXP5lV65A21Hvqh0i0bBy/7osIiYMwX8BKCO
         xs+EedvSisb6VLPgviK7B0JTfqnrTBh4pwzuuRARrWeAbblNgrgWSrfvmtFXB1meOBVJ
         0WeHtp0EkCywWdCJVNeoR/BtjXZVssd/B9fR2PrlmCH1UGqFGtx71qe4bO7o6v6Xw47Q
         TN5WIkJ6ku2K1rJKCx84SphD09QAgV+mc7uOiNfriOW7pwxQHN5FnPZOkADy5XX7M+JQ
         0p/QEzRke6/1nkY2HFrxLOwPi8yFP/3DW5Pf7iexgVK6qpUawE8F/qZitFJVsP8643JK
         UDsg==
X-Received: by 10.31.162.81 with SMTP id l78mr24096380vke.13.1444145457230;
 Tue, 06 Oct 2015 08:30:57 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Tue, 6 Oct 2015 08:30:27 -0700 (PDT)
In-Reply-To: <vpq7fn1qhp2.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279152>

On Tue, Oct 6, 2015 at 12:13 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Sat, Oct 3, 2015 at 6:11 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Actually, this is not a performance-cricical piece of code at all, so I
>>> think it's even better to build an strbuf little by little using
>>> repeated strbuf_addf calls. This way you can do things like
>>>
>>> strbuf_addf(fmt, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)",
>>>             branch_get_color(BRANCH_COLOR_CURRENT));
>>> strbuf_addf(fmt, "%%(align:%d,left)%%(refname:short)%%(end)", maxwidth);
>>>
>>> which makes it much easier to pair the %s and the corresponding
>>> branch_get_color() or the %d and maxwidth.
>>>
>>> But fundamentally, I think this function is doing the right thing. The
>>> function is a bit complex (I think it will be much nicer to read when
>>> better factored), but 1) it allows getting rid of a lot of specific code
>>> and 2) it's a proof that --format is expressive enough.
>>>
>>
>> I like the idea of using "#define" it might make things simpler.
>>
>> Not sure about using a strbuf cause I don't see how that could make things
>> simpler, we'll end up with something similar to what we have
>> currently.
>
> It allows you to really break the way you build the string into several
> small steps, and use if/then locally on steps which require it.
>
> For example, you currently have
>
> +        if (filter->verbose) {
> +                if (filter->verbose > 1)
> +                        local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(align:%d,left)%%(refname:short)%%(end)%s"
> +                                        " %%(objectname:short,7) %%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s] %%(end)"
> +                                        "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)",
> +                                        branch_get_color(BRANCH_COLOR_CURRENT), maxwidth, branch_get_color(BRANCH_COLOR_RESET),
> +                                        branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
> +
> +                else
> +                        local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(align:%d,left)%"
> +                                        "%(refname:short)%%(end)%s %%(objectname:short,7) %%(if)%%(upstream:track)%"
> +                                        "%(then)%%(upstream:track) %%(end)%%(contents:subject)",
> +                                        branch_get_color(BRANCH_COLOR_CURRENT), maxwidth, branch_get_color(BRANCH_COLOR_RESET));
> +
> +                remote = xstrfmt("  %s%%(align:%d,left)%s%%(refname:short)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
> +                                 "%%(else) %%(objectname:short,7) %%(contents:subject)%%(end)",
> +                                 branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
> +                                 remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
> +                final = xstrfmt("%%(if:notequals=remotes)%%(path:short)%%(then)%s%%(else)%s%%(end)", local, remote);
> +
> +        } else {
> +                local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(refname:short)%s",
>
> The first bits of local are identical in all branches of the two-level
> if/else. You could use something like
>
>         strbuf_addf(format, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)",
>                     branch_get_color(BRANCH_COLOR_CURRENT));
>         if (filter->verbose) {
>                 ...
>         }
>
> to factor it out of the if/else. Similarly, the "if (filter->verbose >
> 1)" could be much smaller, and probably doesn't require an else branch
> (just say "if very verbose, then add XYZ at this point in the format
> string").
>

If you look closely, thats only for the local branches, the remotes
have `align` atom when
printing in verbose.

So like I said, I couldn't really make it quite simpler. Maybe a line
or two, but using `#define`
I could cook up this:

char *remote = NULL;
char *final = NULL;

struct strbuf local = STRBUF_INIT;

strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)",
            branch_get_color(BRANCH_COLOR_CURRENT));

if (filter->verbose) {
        strbuf_addf(&local, "%%(align:%d,left)%%(refname:short)%%(end)",
                    maxwidth);
        strbuf_addf(&local, "%s", branch_get_color(BRANCH_COLOR_RESET));
        strbuf_addf(&local, " %%(objectname:short=7) ");

        if (filter->verbose > 1)
                strbuf_addf(&local,
"%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
                    "%%(then): %%(upstream:track,nobracket)%%(end)]
%%(end)%%(contents:subject)",
                    branch_get_color(BRANCH_COLOR_UPSTREAM),
branch_get_color(BRANCH_COLOR_RESET));
        else
                strbuf_addf(&local,
"%%(if)%%(upstream:track)%%(then)%%(upstream:track)
%%(end)%%(contents:subject)");

        remote = xstrfmt("
%s%%(align:%d,left)%s%%(refname:short)%%(end)%s%%(if)%%(symref)%%(then)
-> %%(symref:short)"
                         "%%(else) %%(objectname:short=7)
%%(contents:subject)%%(end)",
                         branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
                         remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
} else {
        strbuf_addf(&local, "%%(refname:short)%s",
branch_get_color(BRANCH_COLOR_RESET));
        remote = xstrfmt("
%s%s%%(refname:short)%s%%(if)%%(symref)%%(then) ->
%%(symref:short)%%(end)",
                         branch_get_color(BRANCH_COLOR_REMOTE),
remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
}

final = xstrfmt("%%(if:notequals=remotes)%%(refname:base)%%(then)%s%%(else)%s%%(end)",
local.buf, remote);

strbuf_release(&local);
free(remote);

return final;

Couldn't see anything else I could break down.


-- 
Regards,
Karthik Nayak
