From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: Re: [PATCH 4/7] commit: fix patch hunk editing with "commit -p -m"
Date: Tue, 11 Mar 2014 18:56:02 +0100
Message-ID: <CA+SSzV04KCGyTkFTtSx_9sYAZyh=UzHOPV6tf9JT82w_DsSLHg@mail.gmail.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
	<1394477377-10994-5-git-send-email-benoit.pierre@gmail.com>
	<20140310200756.GC24568@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jun Hao <jhao12@bloomberg.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 18:56:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNQuP-0005hq-Jk
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 18:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbaCKR4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 13:56:05 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:49852 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbaCKR4D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 13:56:03 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so8954404oah.10
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 10:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zyoEd+iffY/qwB7h9CtjQ8VLT1O969lpecKfowfcmvw=;
        b=mjk28do/2S3frI53J+tBcvlafB7Dtct+8+HhJEK8t4CLUBUvHbaXV34TYTWhw9w6Jy
         2Voz1qCQ1JFlF2+lPJwXovDX7SwuIqZ7tAeSvMkzga1+iy6pj1Jr+fvRs8SViUY57piT
         v2CrX4faNY6JwyxBdhRIZNljk1xYe/1M+jUmj6TIJzyQx/+2Op4mPDUb2Yf5avUzC1Aj
         bgSU5lYItjESJHhoG8i5J5N9Qhs3DOhOVchS0+brHnfDUv9N012rJtvqi/J2AQCUxHJp
         iGdmlTk9VFuSpW5slV1UgLvHkBzpsd2eDb9j3/tMUaW1rdAn5yoAo6DuIILfhWVwL5in
         Zoow==
X-Received: by 10.60.220.137 with SMTP id pw9mr22544850oec.14.1394560562840;
 Tue, 11 Mar 2014 10:56:02 -0700 (PDT)
Received: by 10.76.94.143 with HTTP; Tue, 11 Mar 2014 10:56:02 -0700 (PDT)
In-Reply-To: <20140310200756.GC24568@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243873>

On Mon, Mar 10, 2014 at 9:07 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 10, 2014 at 07:49:34PM +0100, Benoit Pierre wrote:
>
>> Don't change git environment: move the GIT_EDITOR=":" override to the
>> hook command subprocess, like it's already done for GIT_INDEX_FILE.
>> [...]
>
> This is a lot of change, and in some ways I think it is making things
> better overall. However, the simplest fix for this is basically to move
> the setting of GIT_EDITOR down to after we prepare the index.
>
> Jun Hao (cc'd) has been preparing a series for this based on the
> Bloomberg git hackday a few weeks ago, but it hasn't been sent to the
> list yet.
>
> Commits are here:
>
>   https://github.com/bloomberg/git/compare/commit-patch-allow-hunk-editing
>
> if you care to look. I'm not sure which solution is technically
> superior, but it's worth considering both.
>
> I regret not encouraging Jun to post to the list sooner, as we might
> have avoided some duplicated effort. But that's a sunk cost, and we
> should pick up whichever is the best for the project.

Replying here instead of to Jun Hao message (I'm not subscribed to the
mailing list, so I did not received it):

Jun Hao wrote:
> I like the idea that the environment setting should be done in one
> place. Just not sure run_hook is the right place tho. If user doesn't have
> any hook setup, will this kick in?
> One more question, will this work for dry run? Or dry run doesn't matter
> in this case?

According to the original commit, the change to GIT_EDITOR is only
here for hooks:

commit 406400ce4f69e79b544dd3539a71b85d99331820
Author: Paolo Bonzini <bonzini@gnu.org>
Date:   Tue Feb 5 11:01:45 2008 +0100

    git-commit: set GIT_EDITOR=: if editor will not be launched

    This is a preparatory patch that provides a simple way for the future
    prepare-commit-msg hook to discover if the editor will be launched.

    Signed-off-by: Junio C Hamano <gitster@pobox.com>

So there is really no reason to set it earlier, and not just in the
hook subprocess environment.

Regarding dry run: the bug is present, and my patch fix it too (but is
missing a test for this).

As to which patch is better: it's really not for me to decide! It's a
question for the maintainer(s), Jun Hao patch is sure much smaller and
simpler, mine is more involved and I believe cleaner in the long term:
there is no risk of another part of the commit process to be impacted
by the change of environment. Also note that my patch changes the
merge builtin too: GIT_EDITOR will not be overriden if an editor will
be launched (when used with --edit).

-- 
A: Because it destroys the flow of conversation.
Q: Why is top posting dumb?
