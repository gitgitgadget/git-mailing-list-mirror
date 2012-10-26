From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: git push tags
Date: Fri, 26 Oct 2012 14:07:09 -0400
Message-ID: <CAM9Z-nkBO1dbF-sBFLuxM_S_MT79Cx=gLEL+83XKB7ys8VTqNQ@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
	<CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
	<CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
	<20121026174255.GE10560@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 20:07:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRoJa-00058v-Pb
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 20:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965615Ab2JZSHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 14:07:12 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64913 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965545Ab2JZSHL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 14:07:11 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1364034bkc.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 11:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8wzfQIeLpemHLk6gvUWwdCfHG2O/WakDLAtzDjlHF/8=;
        b=WTjn3u7L4zGWLue/Gm3ZJCK2gU6tzOCWfJZ7KU4Z0TqnxcPq/phHGkGN/9H5gSZpKP
         KnKnHUUGmE6lse63+mwD13jEV6Rj3Nuz8QCq7I4wydUUm0FcHA0HiDDcHMdzxvz3TBFf
         uM9VSDN11hyj3NZ0PFs/rCZg35bRSHvmih0HwuWvgT1y8DR11IWDRQDCFW4+SbOW61mL
         +eSw4a2EvuJqPH4HFmnih7xGgkB7hAm2PNAKr7b7gLDWspjUY0TpS5Bd6M9FHbCSQFb1
         2Pj5KrEr3+eoBIY0VjWX3MI4+M7afymYJ2HE7hb8UllGSWm9AjuOMpaayNqg3Do2ZTOs
         bMCA==
Received: by 10.204.5.151 with SMTP id 23mr7572671bkv.3.1351274829613; Fri, 26
 Oct 2012 11:07:09 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Fri, 26 Oct 2012 11:07:09 -0700 (PDT)
In-Reply-To: <20121026174255.GE10560@camk.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208472>

On Fri, Oct 26, 2012 at 1:42 PM, Kacper Kornet <draenog@pld-linux.org> wrote:
> On Thu, Oct 25, 2012 at 05:16:00PM -0400, Drew Northup wrote:
>> On Thu, Oct 25, 2012 at 3:05 PM, Angelo Borsotti
>> <angelo.borsotti@gmail.com> wrote:
>> > Are remote repositories less protected than the local ones? I
>> > think that to be consistent, the same strategy should be used on all
>> > repositories, i.e. rejecting changes on tags by default, unless they
>> > are forced.
>
>> So here we come to the core argument. Is sounds to me like you want
>> changes to remote tags to work differently from push updates to ALL
>> other references. The required change, if I'm not mistaken, would be
>> for tags to not permit fast-forward updates while all other references
>> would be pushed normally. From my brief and un-enlightened look at the
>> push code I can't see that being as easy as it sounds.
>
> I think the patch below obtains the requested behaviour:
>
> diff --git a/remote.c b/remote.c
> index 04fd9ea..7fcb51e 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1320,7 +1320,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>                         !ref->deletion &&
>                         !is_null_sha1(ref->old_sha1) &&
>                         (!has_sha1_file(ref->old_sha1)
> -                         || !ref_newer(ref->new_sha1, ref->old_sha1));
> +                         || !prefixcmp(ref->name, "refs/tags") || !ref_newer(ref->new_sha1, ref->old_sha1));
>
>                 if (ref->nonfastforward && !ref->force && !force_update) {
>                         ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
>
> --
>   Kacper Kornet

Kacper,
I obviously didn't dig deep enough. In any case, I presume that's what
he's asking for. I can't remember if git is still forcing tags to
always be located in "refs/tags" however. I didn't think it was.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
