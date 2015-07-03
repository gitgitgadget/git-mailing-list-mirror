From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: Re: [PATCH v2 2/4] log: add --count option to git log
Date: Fri, 3 Jul 2015 01:05:50 -0700
Message-ID: <CAKDoJU5vHP8c+Cvk1vBjjMG3kHD_rN3XwmfVngMYLN2Tkcg-tQ@mail.gmail.com>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
	<1435881011-13879-3-git-send-email-lawrencesiebert@gmail.com>
	<vpqa8vd66ms.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 03 10:05:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAvyw-0002p6-QF
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 10:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbbGCIFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 04:05:55 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33446 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549AbbGCIFv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 04:05:51 -0400
Received: by obpn3 with SMTP id n3so64913229obp.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 01:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=w2mpm36bucUtlCwmPWe0/2SlYW+zMqM9d3geeYA5m0Q=;
        b=BbKqhPd7izXQCgZXnSoi+hVfCiS0DdBk+sQXFB/JWIaPCPQ286HU5IrRmydEpuBr9T
         sR5WM5hCXs88P3Iz1wul87C5p8cdxIyIWPL1xCCCUIDdHJi2VVtXuEsyvGD4G6cQIjdC
         FtKOiDkVGvhwzUrpXqE0CIg7Rzj4eQsU410zp7zH06T1NcWN0ltQT/mKsj7T0TD3FbZu
         sceK2Z3HUaAAUt3CdhuFPb9Oh1J+EyME4KPXBS6GZqBFLSrvAdOfjaZKGuk0L6gH+yTe
         YHrmA8wSyT9BSJSKUijVfhGiiiY+8LU4yCfVPZURienatUSpLMP0GXO2j7msx1hmNloa
         gdkw==
X-Received: by 10.202.174.82 with SMTP id x79mr24491575oie.50.1435910750560;
 Fri, 03 Jul 2015 01:05:50 -0700 (PDT)
Received: by 10.76.153.101 with HTTP; Fri, 3 Jul 2015 01:05:50 -0700 (PDT)
In-Reply-To: <vpqa8vd66ms.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273284>

traverse_commit_list requires a function to be passed to it.  That
said, after further review it can probably pass NULL and have it work
fine.  If not, I'll use your naming convention.

`git rev-list --count` (or actually `git rev-list --count HEAD`, which
this borrows the code from, produces a single value, a numeric count.
I think walking the entire list is necessary to get the final value,
which is what we want with --count.

Thanks,
Lawrence Siebert





On Fri, Jul 3, 2015 at 12:29 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Lawrence Siebert <lawrencesiebert@gmail.com> writes:
>
>> +static void show_object(struct object *obj,
>> +                     const struct name_path *path, const char *component,
>> +                     void *cb_data)
>> +{
>> +     return;
>> +}
>
> It seems streange to me to have a function named show_object when it
> does not show anything. Maybe name it null_travers_cb to make it clear
> it's a callback and it does nothing?
>
> Not a strong objection though, it's only a static function.
>
>> +static void show_commit(struct commit *commit, void *data)
>> +{
>> +     struct rev_info *revs = (struct rev_info *)data;
>> +     if (commit->object.flags & PATCHSAME)
>> +             revs->count_same++;
>> +     else if (commit->object.flags & SYMMETRIC_LEFT)
>> +             revs->count_left++;
>> +     else
>> +             revs->count_right++;
>> +     if (commit->parents) {
>> +             free_commit_list(commit->parents);
>> +             commit->parents = NULL;
>> +     }
>> +     free_commit_buffer(commit);
>> +}
>> +
>>  static int cmd_log_walk(struct rev_info *rev)
>>  {
>>       struct commit *commit;
>>       int saved_nrl = 0;
>>       int saved_dcctc = 0;
>>
>> +     if (rev->count) {
>> +             prepare_revision_walk(rev);
>> +             traverse_commit_list(rev, show_commit, show_object, rev);
>> +             get_commit_count(rev);
>> +     }
>
> I didn't test, but it seems this does a full graph traversal before
> starting the output. A very important property of "git log" is that it
> starts showing revisions immediately, even when ran on a very long
> history (it shows the first screen immediately and continues working in
> the background while the first page is displayed in the pager).
>
> Is it the case? If so, it should be changed. If not, perhaps explain why
> in the commit message.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/



-- 
About Me: http://about.me/lawrencesiebert
Constantly Coding: http://constantcoding.blogspot.com
