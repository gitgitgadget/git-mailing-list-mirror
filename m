From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 7/8] branch.c: use 'ref-filter' APIs
Date: Mon, 21 Sep 2015 15:51:57 +0530
Message-ID: <CAOLa=ZTd6f2AoMc5QNNCxhAf9Jw9kj66YECp5R0Q4_KvSupwJw@mail.gmail.com>
References: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
 <1442772627-25421-8-git-send-email-Karthik.188@gmail.com> <vpqmvwgevx3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 21 12:22:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdyEz-0004y2-Ie
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 12:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbbIUKW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 06:22:28 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:32869 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756495AbbIUKW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 06:22:27 -0400
Received: by vkgd64 with SMTP id d64so61762534vkg.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A7dBxlxRO71HDqSWAP3UmBk+FWV2i0QZd0BxBytzBw0=;
        b=wOF1UTIfbsxRsSdhekep0thCiTEyPbfZc1SpYbgroxtdWa449rkKDOxfNuhZp0VYgO
         MCaRu3ViHnVix7kp94jcAvJDKTdAdiXXkpYbcjDYFPL5RLWvXUzVXb7C7P0v31gnvzPM
         yhV2Lg0IofSrZEM5uFlUHBVAgPI1o8/vZaxwRQqyyXY9qf3UM4W9j95Ln4rKGJbAuLlM
         BG5wZv5eZSYYxLgygW0Jlht+mLy/Dp3D5HmImQH4ihbEcPUR5b81Prq8XgBDB9LjJ80d
         3jl2Fn6WFFjSRDlFRCWhZns1OWa0zpvGdln4GXftRwvDa3FMJ+HJzG0+1X7HoR6XR2l2
         1hXg==
X-Received: by 10.31.164.132 with SMTP id n126mr12604116vke.72.1442830946622;
 Mon, 21 Sep 2015 03:22:26 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Mon, 21 Sep 2015 03:21:57 -0700 (PDT)
In-Reply-To: <vpqmvwgevx3.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278300>

On Mon, Sep 21, 2015 at 12:54 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -231,6 +231,13 @@ start-point is either a local or remote-tracking branch.
>>       The new name for an existing branch. The same restrictions as for
>>       <branchname> apply.
>>
>> +--sort=<key>::
>> +     Sort based on the key given. Prefix `-` to sort in descending
>> +     order of the value. You may use the --sort=<key> option
>> +     multiple times, in which case the last key becomes the primary
>> +     key. The keys supported are the same as those in `git
>> +     for-each-ref`. Sort order defaults to sorting based on branch
>> +     type.
>
> The last sentence is no longer true. Perhaps something like:
>
> Sort order defaults to sorting based on the full refname (including
> `refs/...` prefix). This lists detached HEAD (if present) first, then
> local branches and finally remote-tracking branches.
>

Sounds good will follow.

>> -static void print_ref_list(struct ref_filter *filter)
>> +static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting)
>>  {
>>       int i;
>>       struct ref_array array;
>> -     struct ref_filter_cbdata data;
>>       int maxwidth = 0;
>>       const char *remote_prefix = "";
>> -     struct rev_info revs;
>> +     struct ref_sorting def_sorting;
>> +     const char *sort_type = "refname";
>
> You are using refname without special-casing HEAD at all. So, this is
> relying on the fact that HEAD comes alphabetically before refs/..., and
> that we are only listing refs/... and HEAD.
>
> As I mentionned earlyer, if we ever allow branch to list e.g.
> FETCH_HEAD, then the detached HEAD will come in the middle. I first
> thought that this was too fragile, but after thinking about it, I think
> this is actually sensible. After all, if we ever allow FETCH_HEAD, then
> keeping the alphabetical order still makes sense.
>
> So, your code is OK, but a bit too subtle to my taste: you should add a
> comment explaining why sorting according to refname is sufficient (I
> would use a comment, but a better commit message may be OK too).

Since I'm re-rolling, I'll do both :)

-- 
Regards,
Karthik Nayak
