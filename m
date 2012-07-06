From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] stash: Delete MERGE_RR before stash apply
Date: Fri, 6 Jul 2012 11:53:23 -0400
Message-ID: <CABURp0rOfr=c-TcF7O6Ms=2iRA3SC9ckt_ukeozBS5vGqaKZaQ@mail.gmail.com>
References: <CABURp0pNsRQgbf7_iYc-xVaySa9-gGiA++Lw4-WgSCQ4QGCXsA@mail.gmail.com>
 <7v7guiruxo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com, tytso@mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 17:54:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnAqs-0007TG-4c
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 17:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792Ab2GFPxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 11:53:45 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36796 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766Ab2GFPxo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 11:53:44 -0400
Received: by yhmm54 with SMTP id m54so9532842yhm.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L86nszvuIeAL54DjXg4wr9pN9l7niZvOJZ2KYzA6LFE=;
        b=dtU+/bv+LvkZyJDHO6btY8VMlzPNO/4+WoohdeCtoCXaHxKPCvfBYZn8efWLMdn+2i
         UM6UoxPYtDKRfu0M9Q3SAJH8NnDHrAs2PP1bEaxwUyuLpmXkM0QJ8DDFXGPyztDHF1FC
         vnrVUoTcszxXYHka2oRPQCxWWU5WSAbgPdq1hDj94d6NouMalVGMo4r628JySiRyf3Tv
         s6KOV1v5CgkBYulP1l5rv+tXmqIunGuRNORIsWBpuRmjVTBx+Y10RyRKLTrqiUuNrt+Z
         NwzaQvVXKUPcudR1Lfp/NltkJB0qmviuREUVOE0XfWIhUC4c2kgBbzQV5B1x4JhXS9tl
         cKmw==
Received: by 10.100.213.1 with SMTP id l1mr10661069ang.42.1341590023489; Fri,
 06 Jul 2012 08:53:43 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Fri, 6 Jul 2012 08:53:23 -0700 (PDT)
In-Reply-To: <7v7guiruxo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201116>

On Thu, Jul 5, 2012 at 1:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> The presence of a GIT_DIR/MERGE_RR file indicates we
>> were resolving a merge which had rerere candidates for
>> recording.  But the file does not get deleted after
>> all resolutions are completed.  This is ok for most
>> cases because the file will get replaced when the
>> next merge happens.  But stash apply does not use
>> a merge that supports rerere, and so the old
>> MERGE_RR does not get replaced with a current one.
>
> Thanks for digging to the real cause.

Well, it only took me a year.
http://permalink.gmane.org/gmane.comp.version-control.git/177224

> It does use merge-recursive
> backend directly, and as a backend, it probably is correct that it
> does not invoke rerere itself.
>
> In your patch, you are removing the state before you check and
> notice that the user is in the middle of a merge and give control
> back with "Cannot apply a stash in the middle of a merge".  Wouldn't
> it be nicer to the user if you didn't remove the rerere state when
> this happens (i.e. the user mistakenly said "stash apply" after a
> conflicted merge), as that rerere state likely is from that merge
> that produced the conflicted state?
>
> Would an obvious alternative of running "git rerere" ourselves after
> running "git merge-recursive" in this script work?
>
>  git-stash.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 4e2c7f8..bbefdf6 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -469,6 +469,7 @@ apply_stash () {
>         else
>                 # Merge conflict; keep the exit status from merge-recursive
>                 status=$?
> +               git rerere
>                 if test -n "$INDEX_OPTION"
>                 then
>                         gettextln "Index was not unstashed." >&2

Yes, except it needs "git rerere clear".  "git rerere" is not enough
to cause the clean-up to occur.

I'll roll a patch.

Phil
