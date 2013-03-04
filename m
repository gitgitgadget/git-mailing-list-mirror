From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/5] status: show the ref that is checked out, even if
 it's detached
Date: Mon, 4 Mar 2013 19:17:02 +0700
Message-ID: <CACsJy8A+gw9oJYrJqa-b8noKM7qJTkZEd7ovmxqR68i6miCatA@mail.gmail.com>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
 <1362303681-6585-5-git-send-email-pclouds@gmail.com> <7vy5e49l3i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 13:18:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCULA-0003m5-8M
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 13:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243Ab3CDMRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 07:17:34 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:36670 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636Ab3CDMRe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 07:17:34 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so9084757oag.29
        for <git@vger.kernel.org>; Mon, 04 Mar 2013 04:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MV1n8nuYCruMUq0d7PzP4su61kSJk4VPoRoIr7a6Mv4=;
        b=Pn6L3DAjpNyYYcJufm2YnM7gz7yiePWha2/naNsi8oKtjdRoYcZlO5UTkdmYIRj5ua
         bDYNRbowdOm8TXj+yqLr20tJOkWkKYlK49ooyEebhDKrRaTj/7MhAapCItK30JFa1IwZ
         LaPg2FFfAU/m4uONKq0/qIhksP1PAxZaTDk/X0tTJ5GBEMNXltCwYlP6VcWthxTtN7O/
         SPXdNkzJqEljwPcnhYv8hx4qfecVHhjqPP5kpf/F8vfruh1JESwMf8UsoGlFI2v3/LGz
         Rz+YGZi79Js2TJ/WrBjuj7GEqqcxzkubUOTwc3EYPzjds6c923Te+y2ozW1b+61Q7V8z
         1nOQ==
X-Received: by 10.182.39.69 with SMTP id n5mr15659971obk.72.1362399453457;
 Mon, 04 Mar 2013 04:17:33 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Mon, 4 Mar 2013 04:17:02 -0800 (PST)
In-Reply-To: <7vy5e49l3i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217398>

On Mon, Mar 4, 2013 at 5:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> When a remote ref or a tag is checked out, HEAD is automatically
>> detached. There is no user friendly way to find out what ref is
>> checked out in this case. This patch digs in reflog for this
>> information and shows "Detached from origin/master" or "Detached from
>> v1.8.0" instead of "Currently not on any branch".
>
> "Detached from" is a nice attempt to compromise in the phrasing.
>
> We usually say you detach HEAD at v1.8.0, but what is shown is what
> started from such a state but then the user may have built more
> history on top of it and may no longer be at v1.8.0, so obviously we
> do not want to say "Detached at".  We are in a "detached at v1.8.0
> and then possibly built one or more commits on top" state (would it
> be helpful to differentiate the "nothing built on top" and "some
> commits have been built on top" cases, I wonder).

Hmm.. never thought of that subtlety. Differentiating should be
possible. I'm just not sure if it would be helpful. Comments people,
do or not do?

> Also I wonder if you could do a bit more to help the users who do:
>
>     $ git checkout $(git merge-base HEAD nd/branch-show-rebase-bisect-state)
>
> aka
>
>     $ git checkout ...nd/branch-show-rebase-bisect-state
>
> and then do one or more commits on top.
>
> Instead of punting to "Currently not on any branch", would it help
> to show the place you first detached at, so that the user can then
> grab that commit object name and run
>
>     $ git log --oneline $that_commit..
>
> or something?

$that_commit would be HEAD@{-1} right? Should that be used instead of
grabbing random SHA-1 shown in git-status?


>> +static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
>
> Can't this be done by generalizing grab_nth_branch_switch() and then
> exposing it as part of the general API?

We could share the code, yes. Initially I wanted something that
resolves "@{-1}" and gives me the reflog entry. Maybe we could add a
function to do that.


> I also feel uneasy about two issues this and the previous change

I assume "previous change" is 1/5, reflog format change.


>  2) The previous one records this sequence in a funny way:
>
>         : start from branch A
>         git checkout B
>         git checkout C
>
>     The resulting reflog entries result in
>
>         checkout: moving from A to refs/heads/B
>         checkout: moving from B to refs/heads/C
>
>     even though existing code and tools are expecting to read
>
>         checkout: moving from A to B
>         checkout: moving from B to C

It does not record exactly user input, but the "to" part is basically
extended sha-1 and I don't think current tools parse them manually.
Instead just they should just pass them to git-rev-parse to do the
job. So this change is not really bad. But again the recent '!'
incident in attr.c shows that I know nothing about real world usage.
We could do dwim when parsing the reflog, which introduces no changes
in reflog format.


> By the way, even though the title of this patch is "status: show the
> ref that is checked out, even if it's detached", a quick check with
>
>         $ cd ../linux-3.0
>         $ git describe
>         v3.8-rc7
>         $ ../git.git/git-checkout v3.8-rc7
>         $ tail -n 1 .git/logs/HEAD | sed -e 's/.*checkout/checkout/'
>         checkout: moving from master to refs/tags/v3.8-rc7
>         $ ../git.git/git-status | head -n 1
>         # Not currently on any branch.
>         $ ../git.git/git-branch -v
>         * (no branch) 836dc9e Linux 3.8-rc7
>           master      836dc9e Linux 3.8-rc7
>
> does not seem to give me anything more helpful.

Yeah. I blame myself for copying from interpret_nth_prior_checkout()
without full understanding, and git's poor documentation (there's no
description about for_each_recent_reflog_ent, and that the caller is
supposed to call for_each_reflog_ent in some case; but I think this
convention is unintuitive, for_each_recent_reflog_ent should do that
itself)
-- 
Duy
