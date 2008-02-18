From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 2/5] Add platform-independent .git "symlink"
Date: Mon, 18 Feb 2008 14:18:32 +0100
Message-ID: <8c5c35580802180518x5c392bddya21c48ea4db9a7cd@mail.gmail.com>
References: <1203331463-13857-1-git-send-email-hjemli@gmail.com>
	 <1203331463-13857-2-git-send-email-hjemli@gmail.com>
	 <1203331463-13857-3-git-send-email-hjemli@gmail.com>
	 <alpine.LSU.1.00.0802181217580.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 14:19:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR5tj-0002Z3-Tz
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 14:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760572AbYBRNSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 08:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760252AbYBRNSf
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 08:18:35 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:12682 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbYBRNSd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 08:18:33 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2796090wah.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 05:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oHrMCkyR540t6apZLzyHYwzX8tVuiXLWGnmhnZ2l8ug=;
        b=qBKkr7aEgIU4O0Cxjx7x0jl8MiXW75V//uldFFwOLxIVAf9MAHWNvqQb7dgHKgr8DCDYU3dNoD2BoB9dSHzEWcvDW0bDqUGbwdc1MDHFeT7SjCofaqoKM1e57fH/SBvB5kRgZdDYKyYado/4LLbylHgmTdJ66MGspfGn/lCbvGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iOK2aJzROQPqxoRAVFduc1zKRF95QRSb/k9BXP2ICJ+FLbwAdd1sCXTPAQbXRwVTbp25aix+y6F0mhq0IW9U4YWF/1O45viF9Xv7zDQLDT4USJOoLRYJABMf1L21HMyAuP9Hl90zl/+n0buNkSidg/FjMzbQrudD4egrJs3XpQI=
Received: by 10.114.37.1 with SMTP id k1mr2787769wak.6.1203340712895;
        Mon, 18 Feb 2008 05:18:32 -0800 (PST)
Received: by 10.115.92.8 with HTTP; Mon, 18 Feb 2008 05:18:32 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802181217580.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74280>

On Feb 18, 2008 1:34 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 18 Feb 2008, Lars Hjemli wrote:
>
> > diff --git a/environment.c b/environment.c
> > index 3527f16..8058e7b 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -49,6 +49,8 @@ static void setup_git_env(void)
> >  {
> >       git_dir = getenv(GIT_DIR_ENVIRONMENT);
> >       if (!git_dir)
> > +             git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
> > +     if (!git_dir)
> >               git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
>
> I still maintain that the code (maybe not the diff) is easier to read like
> this:
>
>         if (!git_dir) {
>                 git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
>                 if (!git_dir)
>                         git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
>         }

IMHO such constructs are butt ugly, but if there's consensus for your
way, I'll abide...


> [* snip *]
>
> So maybe we can just scratch all that, and I agree that an invalid .git
> file means "no repository" (as opposed to "no valid repository").
>
> In that case, you might want to test for that, too...

I think I do, did you find a loophole in the testing?


>
> Speaking about tests:
>
> > +test_expect_success 'setup' '
> > +       REAL="$(pwd)/.real" &&
> > +       mv .git "$REAL" &&
> > +       echo "gitdir: $REAL" >.git
> > +'
>
> Let's not do this.  It would clutter the t/ directory unnecessarily.

What do you mean? The test just moves t/trash/.git to t/trash/.real...

--
larsh
