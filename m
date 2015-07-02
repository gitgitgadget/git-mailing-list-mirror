From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Thu, 2 Jul 2015 19:41:44 +0700
Message-ID: <CACsJy8Dce4ErwaRM7zTgLmRzcHxKOr4J8St46urettr5R4DbVg@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
 <xmqqr3orakex.fsf@gitster.dls.corp.google.com> <CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
 <CACsJy8BdvLiM8Ki=N1k-fBrqqoEONhjwcN6jzGUk=3NPRRujQw@mail.gmail.com> <CAPig+cT=U6LxpJuUMaCd-x=gQPvh89SDNUo12+2_3uYb_q3=Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 14:42:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAdoq-0002Y3-MJ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 14:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbbGBMmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 08:42:16 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36378 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbbGBMmO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 08:42:14 -0400
Received: by iecvh10 with SMTP id vh10so55551637iec.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3G3sWHslxzsJ1v5psobyuDoSqnOACOMriRSuQkVfnoo=;
        b=Sk687Pevrm1iKp4GOFmW6U0UKhMdktFFkJcOLIhhKUe4HBfXWjUSiiog+uD7KtAcHK
         5Q5MKEYyyem56IscFQvlJicawyxPrkVDuV8CcLUF06AxdpqWnUZQ9Vi67Av451KhB7Z3
         hkOLTwocgrRyZrLu2ZxlVEE1Xni6te5y1X2gO7Sau3ggVRfDQbT+wpPb8pQrgZZJ5cPg
         h4n8P6JwgANaQAfvt0E6bHCtW7ukEnYJq5kqlJ957O8jcWm9FuZZT+xN7wJVYZEAhEUb
         0hIqWXv6WfPNDmMHoI0ir7WtaooCAdcAjEV4NCKdlWFtV6IAB4Pu3ZjwzBOh1ZQ0RrI8
         I0Lw==
X-Received: by 10.107.15.153 with SMTP id 25mr49083650iop.44.1435840934080;
 Thu, 02 Jul 2015 05:42:14 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Thu, 2 Jul 2015 05:41:44 -0700 (PDT)
In-Reply-To: <CAPig+cT=U6LxpJuUMaCd-x=gQPvh89SDNUo12+2_3uYb_q3=Og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273225>

On Thu, Jul 2, 2015 at 9:52 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jul 1, 2015 at 9:07 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Thu, Jul 2, 2015 at 12:13 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>>    I noticed GIT_CHECKOUT_NEW_WORKTREE environment variabl that does
>>>>    not seem to be documented.  Is this something we still need?
>>>>    The log message of 529fef20 (checkout: support checking out into
>>>>    a new working directory, 2014-11-30) does not tell us much.
>>>
>>> Yes, it's still used for the same purpose as before the conversion: as
>>> a private signal to the sub git-checkout invocation that it's
>>> operating on a new worktree. When defined, it sets the
>>> 'new_worktree_mode' flag in checkout.c, and there are still a few bits
>>> of code which apparently need to know about it. It would be nice to
>>> eliminate this special knowledge from checkout.c, however, I'm not yet
>>> familiar enough with the checkout code to determine if doing so is
>>> viable.
>>
>> I think it can go away. When "--to" is used, I have to re-execute "git
>> checkout" command again after creating the new worktree. I could
>> process the command line arguments from the first execution, delete
>> "--to", then use the remaining options to run checkout the second
>> time. But I chose to pass the entire command line to the second
>> execution. The env is used to let the second run know it should ignore
>> "--to" (or we get infinite recursion). With "git worktree add" this
>> recursion disappears and this env var has no reason to exist.
>
> The recursion protection is indeed no longer needed and gets removed
> by the "worktree add" patch. However, there are still a few bits of
> code which want to know that the checkout is happening in a new
> worktree. I haven't examined them closely yet to diagnose if this
> specialized knowledge can be eliminated. Perhaps you can weight in. In
> particular:
>
> checkout_paths:
>     if (opts->new_worktree)
>         die(_("'%s' cannot be used with updating paths"), "--to");

This one is easy, as "--to" is gone, no reason to report anything about "--to"

> merge_working_tree:
>     tree = parse_tree_indirect(old->commit &&
>         !opts->new_worktree_mode ?
>             old->commit->object.sha1 :
>             EMPTY_TREE_SHA1_BIN);

I think it's to make sure empty sha-1 is used with --to. If
old->commit->object.sha1 is used and it's something, a real two way
merge may happen probably with not-so-fun consequences. If it's empty
sha1, the effect is like "reset --hard", silent and reliable..

> switch_branches:
>     if (!opts->quiet && !old.path && old.commit &&
>         new->commit != old.commit && !opts->new_worktree_mode)
>             orphaned_commit_warning(old.commit, new->commit);

to suppress misleading warning if old.commit happens to be something.
-- 
Duy
