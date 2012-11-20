From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] pathspec: apply "*.c" optimization from exclude
Date: Tue, 20 Nov 2012 20:23:35 +0700
Message-ID: <CACsJy8C=vdvHYgMr8Qa7M+Mq=QO6p6dsOFm_ZW=Nf2VQrPwaMg@mail.gmail.com>
References: <1353229989-13075-1-git-send-email-pclouds@gmail.com>
 <1353229989-13075-4-git-send-email-pclouds@gmail.com> <7vtxsluw3k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 14:24:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TanoN-0003Rr-Oy
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 14:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab2KTNYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 08:24:08 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53412 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab2KTNYH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 08:24:07 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5871101oag.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 05:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WVlBvQDpEekvagX4OMcxiyz0sq6XR1AfSC4RCFFozt4=;
        b=0WPSwEdImDgS2Qb0IlqhzcSBJPfBvLCyeN5S0SjOmnQIwuWoDJMgTnMxSJbOA1zXGW
         l7ugXm0azA6QLQzNcdHmRx0cPZecGlRcQLpsHq+HgIXGhXgwr0Sh65DiWMFvO9qy4os5
         5JbAjgP9Mud0TtuGhjiz13QV+lGgh6WCk3OgwrZtFdGrpb55aXpCF2Z7lfY4suge86/3
         oFylT++DYZURMpYWaLpNAlcJ6cI/R3JkZOAnXOtIsRUbwvt8RLRWB6m0CJnboHnLdIhW
         bmxNSv3A3ylGjLylHwgYeYgzyphqgwbxFRFqceKOkrgfnXF5OH2e3wV9sNb96epwJ0tJ
         i8SQ==
Received: by 10.60.171.11 with SMTP id aq11mr13149122oec.104.1353417846444;
 Tue, 20 Nov 2012 05:24:06 -0800 (PST)
Received: by 10.182.14.201 with HTTP; Tue, 20 Nov 2012 05:23:35 -0800 (PST)
In-Reply-To: <7vtxsluw3k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210100>

On Tue, Nov 20, 2012 at 4:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> $ time git rev-list --quiet HEAD -- '*.c'
>>
>> real    0m40.770s
>> user    0m40.290s
>> sys     0m0.256s
>>
>> With the patch
>>
>> $ time ~/w/git/git rev-list --quiet HEAD -- '*.c'
>>
>> real    0m34.288s
>> user    0m33.997s
>> sys     0m0.205s
>>
>> The above command is not supposed to be widely popular.
>
> Hrm, perhaps.  I use "git grep <pattern> -- \*.c" quite a lot, but
> haven't seen use case for \*.c in the context of the "log" family.

"git diff *.c" is also helpful (maybe "git diff *.[ch]" is more often
used). But I suspect I/O dominates in both grep and diff cases. I just
try to make sure matching code won't show up in profile.


>> +#define PSF_ONESTAR 1
>
> Together with the GF_ prefix in the previous, PSF_ prefix needs a
> bit of in-code explanation.  Is it just an RC3L (random combination
> of 3 letters?)

I'm pretty sure "PS" stands for pathspec. "F" is probably from
fnmatch. Any suggestions?


>> @@ -46,6 +46,12 @@ inline int git_fnmatch(const char *pattern, const char *string,
>>               pattern += prefix;
>>               string += prefix;
>>       }
>> +     if (flags & GF_ONESTAR) {
>> +             int pattern_len = strlen(++pattern);
>> +             int string_len = strlen(string);
>> +             return strcmp(pattern,
>> +                           string + string_len - pattern_len);
>> +     }
>
> What happens when pattern="foo*oob" and string="foob"?
>
> The prefix match before this code determines that the literal prefix
> in the pattern matches with the early part of the string, and makes
> pattern="*oob" and string="b".
>
> When you come to strcmp(), you see that string_len is 1, pattern_len
> is 3, and pattern is "oob".  string+string_len-pattern_len = "oob",
> one past the beginning of the original string "foob".  They match.
>
> Oops?

Oops indead. I'll need to check exclude code too :(


>         return (string_len < pattern_len) ||
>                 strcmp(pattern, string + string_len - pattern_len);
>
> perhaps?

Yeah.
-- 
Duy
