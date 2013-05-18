From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Sat, 18 May 2013 23:44:31 +0530
Message-ID: <CALkWK0nQVkmq+OdhWhM2EnZKmHxzLQonhd2tUeUvqJNf27GCXA@mail.gmail.com>
References: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com>
 <51968311.1020107@bracey.fi> <7va9ntxu3w.fsf@alter.siamese.dyndns.org> <51979065.4060609@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sat May 18 20:15:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdlfF-0001ah-IC
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 20:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444Ab3ERSPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 14:15:13 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:35676 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab3ERSPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 14:15:12 -0400
Received: by mail-ia0-f182.google.com with SMTP id z3so6105289iad.13
        for <git@vger.kernel.org>; Sat, 18 May 2013 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=INRsx97S5Bk3wBvyXKofh3E3pAVF+c3lgMhsyLnacTU=;
        b=WICb2nnSxeak02pVSuOPcPZvIaCx/HWuueyC+0+Jghfm/2IQiSnhI9nna0ykCes81h
         1I9hRL2tZtsLUaaYkyUtP2WRwn894+ZmirJ45olMo5lEK2OCKSpDz8DHX74ieyLCMUWH
         9lXDqutBHHMAXnIdWtmoPA8lPYHV0KN/nD9pLp8FWTGLcZu7q16xUmXgntN7f2NVCh95
         vDU4Zb45/U1x/sS2VbeT/ev9vGUfrIOGYJ+i8XhgroBfslko/CYMsUAb0bhbc1Vo73MS
         D3Un+iyF8Wli16iudaEfhNIcqv+LEx7AqCxnbz5U1P89HJzI3Y0hh20beyju6Avm2EcO
         KDjQ==
X-Received: by 10.50.33.19 with SMTP id n19mr1600314igi.44.1368900911703; Sat,
 18 May 2013 11:15:11 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sat, 18 May 2013 11:14:31 -0700 (PDT)
In-Reply-To: <51979065.4060609@bracey.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224799>

Kevin Bracey wrote:
> What I'll often be doing is creating a topic branch based on master or
> origin/master. (I would hardly ever be updating master or pushing to
> origin/master myself, so I probably should be just doing origin/master, but
> I tend to create a local master just to save typing on all those "git rebase
> origin/master").

branch.<name>.merge was designed primarily for pull and merge.  I use
operations like git diff origin.., git log origin.., git rebase [-i]
origin.  Ofcourse, rebase is a bit of a special case because it
defaults to operating on branch.<name>.merge by default: this is
useful to me when I want to rebase against what I just fetched
(central workflows: we're slowly getting triangular workflows).
Abusing branch.<name>.merge because you want a different default for
rebase means we're doing something wrong.  Perhaps we should get a
rebase.defaultUpstream = @{u}|origin|... -- @{u} being the current
default.  In my opinion, branch.<name>.base is a huge overkill.

> During work, to give others visibility, and the possibility to tinker with
> the topic branch during development (as we don't have full inter-site
> sharing of work areas), I would push the topic branch up to the central
> "origin" server, often with a "kbracey/" prefix, partially for namespacing,
> and partially to indicate it's currently "private" work and subject to
> rebasing.  I guess I could create the topic branch as "kbracey/topic"
> locally, but I'd rather not have to.

All we have to do for this is to allow the user to set a custom
refspec using remote.<name>.push.  The refspecs you get now are
limited to the ones set by the different modes of push.default (see
builtin/push.c to see what refspec each of them set).  We discussed
branch.<name>.push too on another thread, but I'm not convinced that
we need it.

> (Although I'm not much of a puller - I tend to fetch then rebase manually).

pull needs to be fixed.  I've partially fixed the rebasing pull thing
with rebase.autostash (still in pu), but there's a lot of work to be
done there.

> And it would be ideal if the initial base and push tracking information
> could be set up automatically on the first "git checkout -b"/"git branch"
> and "git push". (For one, I've always found it odd that there's an asymmetry
> - if you check out a topic branch from the server to work on or use it, you
> get a local copy with upstream set by default. But if you create a topic
> branch yourself then push it, the upstream isn't set by default - you need
> the -u flag. This seems odd to me, and I've seen others confused by this).

It happens because @{u} doesn't exist before the first push.  We
should definitely fix git checkout -b to inherit branch.<name>.remote
and infer branch.<name>.merge.

To sum it up, lots of work to be done.
