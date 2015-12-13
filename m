From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 08/10] ref-filter: introduce remote_ref_atom_parser()
Date: Sun, 13 Dec 2015 14:02:28 +0530
Message-ID: <CAOLa=ZQD1ZhkOGr6Y3ZTwkRC--gMVjwXhpvGpBUGuoHjw9hoJQ@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <1447271075-15364-9-git-send-email-Karthik.188@gmail.com> <CAPig+cQrTvDQdCiJGLs8iFj2nS1RvtzbSrDRBpx500JRsAiEtQ@mail.gmail.com>
 <CAOLa=ZQKR4+a-hpL-8xjE-93btWpUt4zAfCGTHBGWwhvLtQoRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 09:33:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a825Y-0002KC-SR
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 09:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbbLMIc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 03:32:59 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34777 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbbLMIc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 03:32:59 -0500
Received: by vkgj66 with SMTP id j66so42099254vkg.1
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 00:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qw0+XOGzgX7Xvajma4KzWo0RrOACX4WGWhfqcsSi1G0=;
        b=SC2NejA/BE0sOazfBpjvqoedhZHyMVxCPOdykx3stQ+mtP5xlnbHcaGT9AMyW8rJf2
         LaEGHqu5mqxoe8nLETvGGtASsN0Q7ARC3xzKF8lw8St0osr3v7xj+rGfcoVfHq0Jo7ik
         G/CIurovgeeeNN2utRpcwt5KH10k1q6N0wF9JpySAJRUltlSrDcx4Yo1sh/8fddmBfBq
         Ahq/imSB/zp4WzFb5pmBiGTB4XOvOIwTT04hLy6bRqwfWu2kXHeKRMCQWt7wrSPKuQYi
         9FN7R0Mr9OO86lNf2bp3Bj4SRKqfZBb6NTf5QOE18PP4iEc/Q8FRVMovIapTvnhLIGIY
         J4Qw==
X-Received: by 10.31.8.204 with SMTP id 195mr19970486vki.30.1449995577995;
 Sun, 13 Dec 2015 00:32:57 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Sun, 13 Dec 2015 00:32:28 -0800 (PST)
In-Reply-To: <CAOLa=ZQKR4+a-hpL-8xjE-93btWpUt4zAfCGTHBGWwhvLtQoRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282325>

On Sun, Dec 13, 2015 at 11:32 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Dec 13, 2015 at 6:23 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
>>> and '%(push)' atoms and store information into the 'used_atom'
>>> structure based on the modifiers used along with the corresponding
>>> atom.
>>>
>>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>>> ---
>>> diff --git a/ref-filter.c b/ref-filter.c
>>> @@ -37,6 +37,11 @@ static struct used_atom {
>>>         union {
>>>                 const char *color;
>>>                 struct align align;
>>> +               struct {
>>> +                       unsigned int shorten : 1,
>>> +                               track : 1,
>>> +                               trackshort : 1;
>>> +               } remote_ref;
>>
>> Are 'shorten', 'track', and 'trackshort' mutually exclusive? If so, a
>> simple enum would be clearer than bitfields:
>>
>>     union {
>>         const char *color;
>>         struct align align;
>>         enum { RR_PLAIN, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
>>             remote_ref;
>>     };
>>
>> Or something.
>>
>
> Sure, will do that.
>

There's also a slight problem with using enum's with the current implementation.
The problem is the enum is set to 0 by default (since we use memset).
so the first
value is set by default, not something we'd want. So either we stick
to the structure
with unsigned bits or we introduce a pseudo value in the enum. I
prefer the former.



On Sun, Dec 13, 2015 at 11:45 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Dec 13, 2015 at 1:02 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Sun, Dec 13, 2015 at 6:23 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> +               if (!num_ours && !num_theirs)
>>>> +                       *s = "";
>>>> +               else if (!num_ours)
>>>> +                       *s = xstrfmt("[behind %d]", num_theirs);
>>>> +               else if (!num_theirs)
>>>> +                       *s = xstrfmt("[ahead %d]", num_ours);
>>>> +               else
>>>> +                       *s = xstrfmt("[ahead %d, behind %d]",
>>>> +                                    num_ours, num_theirs);
>>>
>>> Tangent: These xstrfmt()'d strings are getting leaked, right? Is that
>>> something that we need to worry about (if, for instance, a repository
>>> contains a lot of tracking refs)? Should there be a NEEDSWORK comment
>>> here regarding the issue?
>>
>> This is sort of a problem with most of the values in ref-filter, we dynamically
>> allocate memory and do not free it, since the program exits soon after and
>> we leave it to the Operating System to do the garbage collection.
>
> I'm not worried about memory dynamically allocated for the used_atom[]
> array being leaked (and cleaned up automatically at program exit), but
> rather about memory being leaked for each processed reference, which
> might become substantial for a project with a lot of references.
>
>> Not sure if we'd want to work on this though.
>
> It's likely outside the scope of the current patch series anyhow, and
> probably not something that needs to be tackled right away (or perhaps
> ever), which is why a NEEDSWORK comment might be appropriate, as a
> reminder that the situation could be improved.

Yes I got what you're saying. I'm talking about other values which are
dynamically
allocated in ref-filter itself.

For e.g.

When we use the deref option
v->s = xstrfmt("%s^{}", refname);

or the color option
v->s = xstrdup(color);

So seems like we need a way to go around all of these.

-- 
Regards,
Karthik Nayak
