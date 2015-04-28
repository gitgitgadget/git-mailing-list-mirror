From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: How are submodule conflicts resolved during rebase?
Date: Tue, 28 Apr 2015 13:19:00 -0500
Message-ID: <CAHd499AMKd4aRfDxraArmBGE5eeAhTHQKPbAhcXC-kfPEJPtYQ@mail.gmail.com>
References: <CAHd499CSshO-929PF7fiR4hpxd9J=S+XFuE3sdQHFjPvXT_C0w@mail.gmail.com>
	<20150428164904.GA4477@sandbox-ub1410>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 20:19:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnA67-0000HB-PE
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 20:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030650AbbD1STD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 14:19:03 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34537 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030476AbbD1STA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 14:19:00 -0400
Received: by iedfl3 with SMTP id fl3so27979889ied.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 11:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jWuAHkqFKrwV94EGOBYleuQIvfbQzd2TIaxh+jaeTvM=;
        b=ePBeRJcTr+ywZ2Yz8vzg31K+tcHqiX33ZHWNgi2ObWrCqyNjNlPC722C1OEcHTayKr
         KMHRbOTxWA4x0vfP35UKNGFJhxh755EeWv2J7iaIKeybX9C4pEKHS7buS8/pTOTTjUJ/
         xg3eRnuw3Qpp2htHbGESE90iBcLHMrIGvcImucWO4D0kZ5GgsAkPaVxyGEglnSZXcr2J
         CbJLGKCCRKBA4pq1cjJ+uYj5ifMGcHVW0TaX7bOiWS1SHPbY2c8JeaNGhmo8AmCSEoA4
         ZU0cQshXRdSc/9EnWa8Pn+zRxznSMZaekfHHhqo2wB3dlj+HNPwuvInwrH58RxANJZRQ
         9cfw==
X-Received: by 10.107.14.78 with SMTP id 75mr22487039ioo.15.1430245140391;
 Tue, 28 Apr 2015 11:19:00 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Tue, 28 Apr 2015 11:19:00 -0700 (PDT)
In-Reply-To: <20150428164904.GA4477@sandbox-ub1410>
X-Google-Sender-Auth: daveyeGpLLdOQQuO2Adq6feV2Eg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267931>

On Tue, Apr 28, 2015 at 11:49 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Tue, Apr 28, 2015 at 09:34:06AM -0500, Robert Dailey wrote:
>> Suppose I have a branch with 10 commits on it, 3 of those commits
>> contain a change to the same (and only) submodule in the repository.
>> When I rebase this branch onto the tip of its parent branch, I get a
>> conflict in each of the 3 commits because the submodule also changed
>> on the parent branch since my last rebase.
>>
>> I've seen some cases where I am asked to resolve the submodule
>> conflict with local or remote. I expect this behavior and it isn't
>> confusing to me. However, I have also seen cases where rebase auto
>> resolves the conflicted submodule.
>>
>> How does Git know to auto resolve some submodule conflicts but not the
>> others? I find this behavior unpredictable and I haven't found any
>> documentation on it (I'm giving the git docs the benefit of the doubt
>> and assuming it's there, since the git docs are very very good).
>
> There is some logic for submodule merges, but to prevent false merges
> only the straight forward case results in a clean merge. In short:
> Conflicts for submodules are auto resolved when one side is contained in
> the other and both changes point forward.
>
> I.e. when merging A and B in the superproject and the submodule looks
> like this:
>
>         base---*---*---B
>         \             /
>          *---A---*---*
>
> It will result in a clean merge in the superproject.
>
> If there is a common commit that contains both sides but that commit is
> not part of any side in the superproject the merge will fail but suggest
> that commit as a conflict resolution.
>
> Hope that helps.
>
> Cheers Heiko

So if I understand this correctly, you are saying that during a rebase
if it sees a potential conflict for a submodule in the commit being
rebased, it will inspect the ancestry of the actual commits in the
submodule logs? For a rebase, does this mean that the local (latest
SHA1 from the submodule in the target branch of the rebase) submodule
commit must be reachable from the remote (SHA1 contained in the diff
of the commit currently being rebased) submodule commit?

I just want to make sure this is the logic. Thanks for explaining,
still trying to wrap my head around it.
