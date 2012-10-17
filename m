From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: git rebase -p and patch equivalent commits
Date: Tue, 16 Oct 2012 22:13:28 -0700
Message-ID: <CANiSa6iecBnnjqcfZjQTrhz0-_=LO_AQpDz=J3aR1==6TB3M3Q@mail.gmail.com>
References: <k5ke9q$gom$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Damien Robert <damien.olivier.robert+gmane@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 07:13:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOLwq-000374-NP
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 07:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab2JQFN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 01:13:29 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54980 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab2JQFN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 01:13:28 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so11190877iea.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 22:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gGuKmEEsMLjlfaMalDLWop0Ku2R67ifxMiMD9uu5JyI=;
        b=THQNgMqJ76N/vYONdWMBIpbKGEB0M/nUKXvj4HpsMz2qpk5a1jBYuXDf03dVXpWroA
         WEVWrFoSNtB1ydvRuJ42/327FRQLJN4vAUYQqRP5O3Kfv5+E+QI6VoKOghvEYo2Z6LoS
         GLFvXfUePcGxdR66TUMLQfmzA8Ye+YlPm685VWw7jSExCn9CkalLLSk6qEzf19fzaGxW
         pCOTmkLMGjFHd3U9qrsHZAD+LBsqG4bdTEzIRaTzUgi0brc0Flbu3b3fwdYo1Gqng/zw
         37Mok0EV6/DfPzl8oew8KK1TkEFPBZ8NqrBje/4QDhzi0i6ZWuDoPqGngWwT3jgCAW1X
         LR2A==
Received: by 10.43.135.135 with SMTP id ig7mr13455109icc.8.1350450808462; Tue,
 16 Oct 2012 22:13:28 -0700 (PDT)
Received: by 10.64.103.5 with HTTP; Tue, 16 Oct 2012 22:13:28 -0700 (PDT)
In-Reply-To: <k5ke9q$gom$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207891>

On Tue, Oct 16, 2012 at 12:58 PM, Damien Robert
<damien.olivier.robert+gmane@gmail.com> wrote:
> Now feature is rebased against master. How would you rebase the branches
> patch1, patch2 and build so that they keep the same layout?
>
> I tried to rebase patch1 and patch2, hoping that rebase -p build would use
> the rebased commits for the merge but it creates new commits (that are
> patch equivalents to patch1 and patch2) and merge them.
>
> So I can think of two ways to proceed:
> 1) only rebase patch1 and patch2, and then remerge them again in build.

If the build branch really is just a build branch, then I would
probably choose this option.

>    This start to get complicated if I have some commits in build after the
>    merge

What would such commits contain? Is it something related to your build
system that you can automate? If not, should they perhaps rather have
been included in one of the patch branches? Or are they related to
interactions between the patch branches? If the latter, I would
probably serialize the dependent branches (e.g. basing "patch2" on
"patch1").

> 2) I can rebase -p the build branch first, and then reset --soft patch1

Did you mean --hard/--keep here? Or why would you use --soft?

>    and
>    patch2 so that they point to the right commits in the rebased branch.
>    This way looks easier to do with more complicated layout, I just need to
>    find a good way of finding where the rebased commits for patch1 and
>    patch2 are, and I was thinking of using notes for that.

I don't quite understand why you would want to do that if the build
branch is just to make sure test pass on the merged result, but, yes,
this method would probably be easier if you do need to keep both the
build branch and the patchX branches up to date. Which branch do you
actively work on at this point? Both the build branch and the patchX
branches? Is it that you have sent patch1 and patch2 for review and
you want to base your next topic on the merged result? I assume not,
since you said it was a "build" branch. But if that was the case (i.e.
somewhat active development on build, patch1 and patch2 (perhaps due
to review comments)), I would probably still rebase one branch at a
time, recreate the merge (possibly using rerere), and then "rebase
--onto new-merge old-merge build".
