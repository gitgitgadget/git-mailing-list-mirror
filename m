From: Stephen Connolly <stephen.alan.connolly@gmail.com>
Subject: Re: [Feature Request] git blame showing only revisions from git
 rev-list --first-parent
Date: Fri, 11 Sep 2015 16:31:18 +0100
Message-ID: <CA+nPnMxbVnMzj8d2K0U56AV3R4m9O82U-LWdqcAsH=B21=ZUDg@mail.gmail.com>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
	<20150911140133.GA14311@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 11 17:31:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaQIO-0003i4-Sm
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 17:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbbIKPbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 11:31:20 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36491 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbbIKPbT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 11:31:19 -0400
Received: by lbcao8 with SMTP id ao8so41535609lbc.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DP2Iytl/HlGZA3hV992JHgu5mlI5BcLZU4HFeC2BLso=;
        b=c7Iw5VjCB7NmBnVdtfmdiNb4pONmxr0wMIzNOq9YJdmud5x+Skqk8vMuI6hNLlCn/9
         phSuv4mjemoefCYY2yv2p1FBzV6V9yjAD0M6Gi/j2f/05yslneCekyl75hmLIlJp7d1S
         PpEcVwBhu5/Q20zH+Hu/UXPQIn9x7VCPebOnMcQZKkf7mX6BBYGvdqakQzullkd0Mnrq
         bAf925eIp+Gc+4RncPiLi3FYaq9E5qCAXCKlmLodLv5u9T81DZW4P/VMvXxAVJbVof2L
         khRaO7MX2WMBbdE8E+e2kxOHK7oNs9qhDJTzppL8QNqsFzEN7AYuSzl5PPavcVpnHei0
         LqSg==
X-Received: by 10.152.45.69 with SMTP id k5mr42694123lam.13.1441985478437;
 Fri, 11 Sep 2015 08:31:18 -0700 (PDT)
Received: by 10.25.20.28 with HTTP; Fri, 11 Sep 2015 08:31:18 -0700 (PDT)
In-Reply-To: <20150911140133.GA14311@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277672>

On 11 September 2015 at 15:01, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 11, 2015 at 11:47:30AM +0100, Stephen Connolly wrote:
>
>> A command line option to `git blame HEAD -- path` that instructs that
>> the revisions of blame be the revisions where the change was applied
>> to the current branch not the revision where the change first
>> originated (i.e. limit commits to `git rev-list --first-parent HEAD`)
>>
>> I can get what I want with the following:
>>
>> git rev-list --first-parent HEAD | awk '{print p " " $0}{p=$0}' >
>> tmpfile && git blame -b -S tmpfile HEAD -- path && rm tmpfile
>>
>> But that is a rather ugly command. Could we have something built in to
>> git blame to make this much easier for users?
>
> I agree this would be a useful feature. Though blame takes rev-list
> options, it doesn't use the stock rev-list traversal internally, so it
> has to handle first-parent itself.
>
> I'm not too familiar with the code, but this _seems_ to work for me:
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 21321be..2e03d47 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1375,6 +1375,10 @@ static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit
>  static int num_scapegoats(struct rev_info *revs, struct commit *commit)
>  {
>         struct commit_list *l = first_scapegoat(revs, commit);
> +       if (!l)
> +               return 0;
> +       if (revs->first_parent_only)
> +               return 1;
>         return commit_list_count(l);
>  }
>
>
> I suspect it doesn't work at all with `--reverse`. I also have the
> nagging feeling that this could be handled inside revision.c with
> parent-rewriting, but I don't really know.
>
> But "git blame --first-parent <file>" seems to behave sanely in git.git
> with this.
>
> -Peff

It would help if somebody who knew the code could comment, but I am
impressed with the progress ;-)
