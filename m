From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 06/11] branch: roll show_detached HEAD into regular ref_list
Date: Wed, 29 Jul 2015 00:49:51 +0530
Message-ID: <CAOLa=ZR4DSzdnR8+3eiVTCX92aeFu2o6=iDm7QpdOewizSuxng@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-6-git-send-email-Karthik.188@gmail.com>
 <vpqlhe0xwpv.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 21:20:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKAQL-0001lg-VA
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 21:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbbG1TUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 15:20:22 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34309 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbbG1TUV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 15:20:21 -0400
Received: by oigd21 with SMTP id d21so74796941oig.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+F2EacuhXP7oQFQJhPS/fRZU415FoWTGpICcQvcxjLQ=;
        b=rfBlEDJzkxv3Z8Hehu4Zu/oCacllOKSoia3V8R42Ng+Z2Zqy8NuXuadYoUTk4KuxWt
         pIpQXBwcL43X7liwU9qTdt/RfHhQ00NRnWliCNDPuJAEnIlzg852ogNQ7cjrIjB/g2sW
         zi9DAAjrd3Sb3MGeknJjce+JWHLA7KVG77ZdZiS/8BJEciKJRSfvsSd73tCWERkKhlT9
         4iqX3SdjveJWKjC0ceNzJ4RgVYn9dNVPLAuoY8FW/JfCjq9sSXzsSExH83NMwhV/WbJg
         H/5odp17u+j26vNgHZlOtBPCr37erCMhdZwHQmo1frz2tPAoct0SDPw2ZdaZolxRRIjh
         woSA==
X-Received: by 10.202.186.132 with SMTP id k126mr34844114oif.60.1438111220543;
 Tue, 28 Jul 2015 12:20:20 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 12:19:51 -0700 (PDT)
In-Reply-To: <vpqlhe0xwpv.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274817>

On Tue, Jul 28, 2015 at 6:31 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Remove show_detached() and make detached HEAD to be rolled into
>> regular ref_list by adding REF_DETACHED_HEAD as a kind of branch and
>> supporting the same in append_ref().
>
> Again, this lacks the "why?" explanation.

Will include a small explanation.

>
>> Bump get_head_description() to the top.
>
> Here also: why? And this could easily go to a separate patch to let the
> reviewer focus on actual changes.

I'll move this to a preparatory patch.

>
> I think you're leaking a string here: get_head_description() builds an
> strbuf and returns the dynamically allocated string, which you never
> free.
>

Ah! good catch, will fix that.

>> -static void show_detached(struct ref_list *ref_list, int maxwidth)
>> -{
>> -     struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
>> -
>> -     if (head_commit && is_descendant_of(head_commit, ref_list->with_commit)) {
>
> I'm not sure what this if was doing, and why you can get rid of it. My
> understanding is that with_commit comes from --contains, and in the
> previous code the filtering was done at display time (detached HEAD was
> not shown if it was not contained in commits specified with --contains).
>
> Eventually, you'll use ref-filter to do this filtering so you won't need
> this check at display time.
>
> But am I correct that for a few commits, you ignore --contains on
> detached HEAD?
>

No we don't ignore --contains on detached HEAD.

Since detached HEAD now gets its data from append_ref(). The function
also checks for the --contains option.

>> @@ -678,15 +674,20 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>>       if (verbose)
>>               maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
>>
>> -     qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
>> +     index = ref_list.index;
>> +
>> +     /* Print detached heads before sorting and printing the rest */
>
> I think you mean head (no s) or HEAD. It's not Mercurial ;-).
>

I meant HEAD, lol.

>> +     if (detached && (ref_list.list[index - 1].kind == REF_DETACHED_HEAD) &&
>> +         !strcmp(ref_list.list[index - 1].name, head)) {
>> +             print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
>> +                            1, remote_prefix);
>> +             index -= 1;
>> +     }
>
> This relies on the assumption that HEAD has to be the last in the array.
> The assumption is correct since you call head_ref(append_ref, &cb) after
> for_each_rawref(append_ref, &cb). I think this deserves a comment to
> remind the reader that HEAD is always the last (here or at the call to
> head_ref to make sure nobody try to change the order between head_ref
> and for_each_rawref).
>

Yeah! makes sense, will add at the comment at the call to head_ref().

> It may be more natural to do it the other way around: call head_ref
> first and get HEAD first, as you are going to display it first (but in
> any case, you'll have to call qsort on a subset of the array so it
> doesn't change much).

That sorta messes things up with qsort, this keeps it clean I feel.

>
>> @@ -913,7 +914,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>                       die(_("branch name required"));
>>               return delete_branches(argc, argv, delete > 1, kinds, quiet);
>>       } else if (list) {
>> -             int ret = print_ref_list(kinds, detached, verbose, abbrev,
>> +             int ret;
>> +             if (kinds & REF_LOCAL_BRANCH)
>> +                     kinds |= REF_DETACHED_HEAD;
>
> Perhaps add
>
>         /* git branch --local also shows HEAD when it is detached */
>

Yeah definitely!

-- 
Regards,
Karthik Nayak
