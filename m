From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 0/6] Reject non-ff pulls by default
Date: Wed, 30 Apr 2014 13:44:00 -0500
Message-ID: <53614470489f9_f9b15012ecbc@nysa.notmuch>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
 <xmqqr44eg0s0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 20:54:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfZeU-00040x-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 20:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758958AbaD3Syi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 14:54:38 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:60450 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbaD3Syi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 14:54:38 -0400
Received: by mail-yh0-f49.google.com with SMTP id t59so2067026yho.8
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Naq4TSi1aSXfRJZrPN1n5MekkBT35hlW500t2QEXIzE=;
        b=U+8XSbRsBdHBO8mLwEjW19jNHV6fORQKGvEILxGi+c80+dxUsUjjW6h5USN/qPDwNN
         CX0yi1yqfr5lfIDuEQIu2YHuLRG/h9dI2LdK5gvqBMl+rCUFfL6iwHrSBPLH2Ic7SBsC
         TpXQrPGsHN47bA8K2SFaJMXUwLoqBVe/WUBPk4qShAyMXCOy+1tskqO09b9kuuf/fBR3
         zsaEb3LwHs7p11bRKGk+Ns96zllMK2NP21UpFelbAxAN0JN1DYJLCPBJOw+ceXZvCf+c
         7mWkmCU66sfhfbpk0H0oKMcCJHl9GQ7sRfVK0d9pmaN4fJf2oPbbMlCbHc1VuJUSx5/J
         dT5w==
X-Received: by 10.236.230.41 with SMTP id i39mr8603127yhq.14.1398884077376;
        Wed, 30 Apr 2014 11:54:37 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c25sm44346263yhn.3.2014.04.30.11.54.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 11:54:36 -0700 (PDT)
In-Reply-To: <xmqqr44eg0s0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247757>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > These are the steps needed to achieve this:
> 
> The overall progression (this comment is only about the design, not
> the implementation) looks almost sensible, but I may have missed
> some issues because the presentation was done in reverse.
> 
> In the following comment, I'll flip the presentation order to better
> show natural progression of what the users will see.
> 
> > 1) Rename pull.rename to pull.mode and
> >    branch.<name>.rebase to branch.<name>.pullmode
> >
> > This way the configurations and options remain consistent:
> >
> >   git pull --merge
> >   pull.mode = merge
> >   branch.<name>.pullmode = merge
> >
> >   git pull --rebase
> >   pull.mode = rebase
> >   branch.<name>.pullmode = rebase
> >
> >   git pull --rebase=preserve
> >   pull.mode = rebase-preserve
> >   branch.<name>.pullmode = rebase-preserve
> >
> >   git pull
> >   pull.mode = merge-ff-only
> >   branch.<name>.pullmode = merge-ff-only
> 
> Until the "--merge" option is added, "pull.mode = merge" cannot be
> the same as "git pull --merge".  I think you either need to squash
> these two steps into one, or flip the order of them.

Yeah, but the documentation of --merge should mention `pull.mode` and
`branch.<name>.pullmode`. If I do --merge first I would have to mention
pull.rebase and branch.<name>.rebase, which is weird.

I think it's more sensible to do the less visible changes first.

> > 2) Add --merge option
> >
> > Since we have a message that says "If unsure, run 'git pull --merge'", which is
> > more friendly than 'git pull --no-rebase', we should add this option, and
> > deprecate --no-rebase.
> 
> Obviously s/have a/will have a/, but the intention is good.
> 
> > However, the documentation would become confusing if --merge is configured in
> > pull.rebase, instead, we want something like this:
> >
> >   See `pull.mode`, `branch.<name>.pullmode` in linkgit:git-config[1] if you want
> >   to make `git pull` always use `--merge`.
> 
> It gets unclear to me how the transition is planned around here.  Is
> this a correct paraphrasing of these four steps?
> 
>     - Add pull.mode (and its branch-specific friend) and "pull
>       --merge" so that people can set the former to "merge" or train
>       their fingers to type the latter to keep doing the
>       fetch-and-merge (your steps 1 and 2)
> 
>     - Add ff-only to pull.mode (your step 3)

Correct.

>     - With the endgame of "out of box Git without any configuration
>       refuses 'git pull' (without --merge/--rebase) that does not
>       fast forward" in mind, start warning "In the future you will
>       have to either set pull.mode (and/or its friends) or type
>       "pull --merge" (or "pull --rebase") when the endgame version
>       of 'git pull' would fail with the error message, but still do
>       as was asked to do as before.  At this step, existing users
>       can set pull.mode to "merge" or "rebase" or whatever to
>       squelch the warning.
> 
>     - Flip the default.  By the time this happens, thanks to the
>       previous step to warn beforehand, nobody needs to see the
>       warning. (your step 4)

This is what my last version of the series did[1]. However, my plan was
to land this in 1.x so users could see the warning, and then flip the
switch on 2.0.

This plan, however, fell off the cliff.

> If that is the rough outline, I think it is sensible.
> 
> > 3) Add merge-ff-only config
> >
> > This option would trigger a check inside `git pull` itself, and error out with
> > the aforementioned message if it's not possible to do a fast-forward merge.
> >
> > However, this option conflicts with --rebase, and --no-rebase. Solution below.
> 
> Am I reading you correctly that setting "pull.mode = ff-only" will
> require you to explicitly say "git pull --merge/--rebase"?  If that
> is the case, I think the step makes sense.

pull.mode = merge-ff-only

[1] http://article.gmane.org/gmane.comp.version-control.git/235951

-- 
Felipe Contreras
