From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream local branches
Date: Mon, 18 Feb 2008 07:40:45 -0500
Message-ID: <76718490802180440o3041b1ffh4764199e2aeaa52b@mail.gmail.com>
References: <1203336248-9308-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.LSU.1.00.0802181209210.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 13:41:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR5JB-0006Os-95
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 13:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbYBRMkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 07:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758518AbYBRMkq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 07:40:46 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:43650 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbYBRMkq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 07:40:46 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2781098wah.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 04:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pdqOR2ImoxQKhV9uRAMc01KIkfMhh3o1ZC6XV63rk9Y=;
        b=MAMNlnnWM3886OY9Jb3aQArYpBXIB8Fa7VJ7l59PYsoNuz20PNVtgOsYEubodTQkD6f+vmLvPVsCTehxPzAaL8BCZ3CO0a/oFU/4MvV8aWGGwOzuk+z3vGziRyzE/+Fh9bsfBGsOTQk/AsYyywIbEPAIH81wzVMFXShQyTLOg8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oJxErJumzEmOHyeyYMKbGngaNITKEzEwAvIS9xVLz0eVdsNeeZMHgwL+y+J2vOFA3lqZ1cn0NLTVgqPDsMj6t0cQUWhAoJ5WcwiBj0ZboqoExGBJ54TRylvKTNd+MiI8e42IlWOGMMmN0Ii2soKTndLpWRvONxVRdqRrtX3ARk8=
Received: by 10.114.161.11 with SMTP id j11mr2994200wae.127.1203338445430;
        Mon, 18 Feb 2008 04:40:45 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Mon, 18 Feb 2008 04:40:45 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802181209210.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74275>

On Feb 18, 2008 7:14 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> On Mon, 18 Feb 2008, Jay Soffian wrote:
>
> > +enum branch_track {
> > +     BRANCH_TRACK_FALSE = 0,
> > +     BRANCH_TRACK_TRUE = 1,
>
> BRANCH_TRACK_REMOTES would be a better name here.  And you do not need the
> "= 1" and "= 2".

I was just following along. Plenty of enum examples in the current code
do this. Am I missing something subtle about when assigning explicit
values should be done?

> >
> > -static int branch_track = 1;
> > +static enum branch_track branch_track = BRANCH_TRACK_FALSE;
>
> That is a clear regression.

Perhaps. It's consistent with builtin-checkout.c though (which was
initializing it to 0). Who to believe?

> > @@ -77,6 +77,10 @@ static int git_branch_config(const char *var, const char *value)
> >               return 0;
> >       }
> >       if (!strcmp(var, "branch.autosetupmerge")) {
> > +             if (value && !strcasecmp(value, "always")) {
> > +                     branch_track = BRANCH_TRACK_ALWAYS;
> > +                     return 0;
> > +             }
> >               branch_track = git_config_bool(var, value);
> >               return 0;
> >       }
>
> You have this in builtin-branch.c and builtin-checkout.c.  Duplicated
> code.  IMHO it is time to move this into the git_default_config() function
> (with "branch_track" being renamed to "git_branch_track", and moved to
> environment.c).

Mkay, builtin-checkout.c author didn't do it, so...

> Personally, I have no problem with typing "git merge <branch>" in your
> workflow.  I would even avoid saying "git pull" for obviously-local
> branches, because I would have forgotten which branch it tracked
> originally.

Um, well, apply this patch, set branch.autosetupmerge=always and then
branch.*.merge will tell you which branch it tracked originally. :-)

Aside, then how do you figure out the upstream branch is if you've
forgotten?

j.
