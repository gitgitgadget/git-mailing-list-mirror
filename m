From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] sha1_name: reorganize get_sha1_basic()
Date: Thu, 2 May 2013 14:10:18 -0500
Message-ID: <CAMP44s3UTwgcxQ0Y89UtjBAw46ps_2EOGqZ=OG499G_uYL0DCA@mail.gmail.com>
References: <1367516919-4735-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0k4YisL0Nc6906FRsx7556UVqy_DD9Wo=1j4OWMkwqK-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 21:10:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXytd-0002sK-Ex
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 21:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761763Ab3EBTKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 15:10:21 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35038 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761288Ab3EBTKU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 15:10:20 -0400
Received: by mail-lb0-f176.google.com with SMTP id v20so872645lbc.35
        for <git@vger.kernel.org>; Thu, 02 May 2013 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=K21eB46e7TRjCs4WYRd+FXXbQ9teBKkfo3m1BF4TugA=;
        b=xhfiD7GaeX6TWG5PZ0ZzG+7BjBIbELpbm4ux4kNaepEFCR1/Mtf78UNvAoRP2cvPYw
         EKnMN3Rvz56GBBxnP3LiY6GxLftbImv5LZcE2zeVHy5mQKXzJxUyV8KtsXDYp7bgxKYF
         yA7wPLJCOGRkVOJ+suNjLB4osQPReK22F0ZEBxfZWHxp/rwlj4gLjO8BhHkmsFxnK8Uj
         vY7bIcEaJBTH97z+jeQfbxdAps7JZKFf09+B1/vyGShS2WGm7mGp7t9/Kmk4kUvgHk1H
         G7jAfB5zrq954kxidWQ4KefGx57AUxqcr3efXtPKvQkPqk4AdLcgsDDWuOtxW//4sAWH
         odGw==
X-Received: by 10.112.135.70 with SMTP id pq6mr3227945lbb.82.1367521818892;
 Thu, 02 May 2013 12:10:18 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 12:10:18 -0700 (PDT)
In-Reply-To: <CALkWK0k4YisL0Nc6906FRsx7556UVqy_DD9Wo=1j4OWMkwqK-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223250>

On Thu, May 2, 2013 at 1:55 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> [...]
>
> Okay, you used nth_prior in this one.
>
>> There is no need to call this function recursively with the branch of
>> @{-N} substituted because dwim_{ref,log} already replaces it.
>
> I figured that the recursion is because dwim_{ref,log} didn't exist
> when this was written.

They did, but they were not substituting the branches.

>> @@ -447,6 +448,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>>         if (len && str[len-1] == '}') {
>>                 for (at = len-2; at >= 0; at--) {
>>                         if (str[at] == '@' && str[at+1] == '{') {
>> +                               if (at == 0 && str[2] == '-') {
>> +                                       nth_prior = 1;
>> +                                       continue;
>> +                               }
>
> Looking at this closely once again.
> You've already hit the beginning.  What are you continuing?  Take the
> example of a compound expression with @{-

Yeah, we could break, but I would prefer the break to happen naturally
when in the for loop check.

> On another note, I think you've fixed a bug: @{-1}{0} was parsing to
> the same value as @{-1}@{0} before your patch.

Yeap.

>> @@ -460,20 +465,22 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>>         if (len && ambiguous_path(str, len))
>>                 return -1;
>>
>> -       if (!len && reflog_len) {
>> +       if (nth_prior) {
>
> nth_prior makes this much cleaner overall.
>
>>                 struct strbuf buf = STRBUF_INIT;
>> -               int ret;
>> -               /* try the @{-N} syntax for n-th checkout */
>> -               ret = interpret_branch_name(str+at, &buf);
>> -               if (ret > 0) {
>> -                       /* substitute this branch name and restart */
>> -                       return get_sha1_1(buf.buf, buf.len, sha1, 0);
>> -               } else if (ret == 0) {
>> -                       return -1;
>> +               int detached;
>> +
>> +               if (interpret_nth_prior_checkout(str, &buf) > 0) {
>> +                       detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
>> +                       strbuf_release(&buf);
>> +                       if (detached)
>> +                               return 0;
>
> Neat.  I'd set reflog_len to zero and made sure that the last part of
> the function wouldn't be executed.  How did you get away without
> setting refs_found to 1 though?

The rest of the code is not executed, there's no need if @{-N}
evaluates to a SHA-1. There's no ref to dwim, and there's no reflog
anyway. We just fetch the SHA-1 and return.

>>                 }
>> +       }
>> +
>> +       if (!len && reflog_len)
>>                 /* allow "@{...}" to mean the current branch reflog */
>>                 refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
>
> I got this part wrong too: I said dwim_log() instead of dwim_ref().

Fortunately we are not changing the code this time, which is the best
way to make sure that the behavior doesn't change.

It took me a long time to play with alternatives and find a clean
solution with minimal changes that is easy to understand, but I think
this code does the trick.

Cheers.

-- 
Felipe Contreras
