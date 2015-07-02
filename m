From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Wed, 1 Jul 2015 22:52:58 -0400
Message-ID: <CAPig+cT=U6LxpJuUMaCd-x=gQPvh89SDNUo12+2_3uYb_q3=Og@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<xmqqr3orakex.fsf@gitster.dls.corp.google.com>
	<CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
	<CACsJy8BdvLiM8Ki=N1k-fBrqqoEONhjwcN6jzGUk=3NPRRujQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 04:53:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAUcb-0004DE-3E
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 04:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbbGBCxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 22:53:01 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34875 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbbGBCw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 22:52:59 -0400
Received: by ykdy1 with SMTP id y1so57026452ykd.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 19:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fro87XuWR9NIdgEj7Q8W8754l1KwCIpo+dH6atEQvNs=;
        b=guw2JEY825MG6HMkXBsGljgE4rDDYOrD8BjRhc/jU8wuIuivoGBowHftyJ12fMMf4B
         w8o1S91s+nL8HG2ZUvHm7fo4zW7Ogj2wy5dWEH0x9y/mqMgfSvqDDaMQ2z3+VHuL37FS
         Ce+9lPcVeq8R1hKXMeRIhn5c7DiSr4HT2zWzxfeggUUTDJGEtZCwWH0+Y5YFmKbRjV6c
         ymNP/u0BCfCMpAE9RBK2l3ZsG2mf8fGOR+OtdFZDRaJiKdNIiTYaOrT12D+bKsWWAlZc
         yVHHi8MCxkqYnr56025YPmgMBde/bx33PjxaUS8NRaYn8aHkbIRwueI818tZasUjYQA2
         0Wqw==
X-Received: by 10.129.76.70 with SMTP id z67mr37034277ywa.17.1435805578445;
 Wed, 01 Jul 2015 19:52:58 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 1 Jul 2015 19:52:58 -0700 (PDT)
In-Reply-To: <CACsJy8BdvLiM8Ki=N1k-fBrqqoEONhjwcN6jzGUk=3NPRRujQw@mail.gmail.com>
X-Google-Sender-Auth: tKdKYl87khvx01dPSxwk3CwzTaU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273210>

On Wed, Jul 1, 2015 at 9:07 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jul 2, 2015 at 12:13 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>    I noticed GIT_CHECKOUT_NEW_WORKTREE environment variabl that does
>>>    not seem to be documented.  Is this something we still need?
>>>    The log message of 529fef20 (checkout: support checking out into
>>>    a new working directory, 2014-11-30) does not tell us much.
>>
>> Yes, it's still used for the same purpose as before the conversion: as
>> a private signal to the sub git-checkout invocation that it's
>> operating on a new worktree. When defined, it sets the
>> 'new_worktree_mode' flag in checkout.c, and there are still a few bits
>> of code which apparently need to know about it. It would be nice to
>> eliminate this special knowledge from checkout.c, however, I'm not yet
>> familiar enough with the checkout code to determine if doing so is
>> viable.
>
> I think it can go away. When "--to" is used, I have to re-execute "git
> checkout" command again after creating the new worktree. I could
> process the command line arguments from the first execution, delete
> "--to", then use the remaining options to run checkout the second
> time. But I chose to pass the entire command line to the second
> execution. The env is used to let the second run know it should ignore
> "--to" (or we get infinite recursion). With "git worktree add" this
> recursion disappears and this env var has no reason to exist.

The recursion protection is indeed no longer needed and gets removed
by the "worktree add" patch. However, there are still a few bits of
code which want to know that the checkout is happening in a new
worktree. I haven't examined them closely yet to diagnose if this
specialized knowledge can be eliminated. Perhaps you can weight in. In
particular:

checkout_paths:
    if (opts->new_worktree)
        die(_("'%s' cannot be used with updating paths"), "--to");

merge_working_tree:
    tree = parse_tree_indirect(old->commit &&
        !opts->new_worktree_mode ?
            old->commit->object.sha1 :
            EMPTY_TREE_SHA1_BIN);

switch_branches:
    if (!opts->quiet && !old.path && old.commit &&
        new->commit != old.commit && !opts->new_worktree_mode)
            orphaned_commit_warning(old.commit, new->commit);
