From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: attr.c doesn't honor --work-tree option
Date: Mon, 10 Feb 2014 13:57:13 +0100
Message-ID: <CAB7pA0-dhFS_QOqxTdLmHAnsOUXSrmGi+dRR=+fMyY4M9m-XLA@mail.gmail.com>
References: <CAB7pA0_2kLJmRZb8Z_9+xOcrbwMZLgnZwC5f7etbE4OuJ1wgmA@mail.gmail.com>
	<xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 13:57:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCqQJ-00024Y-Si
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 13:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbaBJM5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 07:57:15 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:53018 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbaBJM5O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 07:57:14 -0500
Received: by mail-yh0-f49.google.com with SMTP id t59so4933659yho.22
        for <git@vger.kernel.org>; Mon, 10 Feb 2014 04:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WT7f9armmxJ2tU4l2TUMy5RkAlBkNAYjjC896WQjrG0=;
        b=FUxB5MosFLNFEfipp0509xiuVFpVOoEiJR8r5NkAi5gAf3TwxJwsPtxS47C4Hg7ESV
         Jx5FQLc/mE7v6w3lUEvP+5MRlVHcfY3adUEv0UR/CLEjUYphzNaaXdQ65gPmMKsoq7Iq
         7cA/SkjdR9M/1yZDGhobyYuSkC7+GPcgOyF2/bQ7XrRoGmTPDjcysdrN0EQmCltnxmIV
         Yz4vbJkpf8Hmq60Ci6FLMFaQoRFqouAuOfgDRP1tDihKdY2uqRlr8QPmN1qtY+7sLA5d
         1xvwQw3Z/0ZqJffIH5dDmMtWHOsEwxhFEvynzOiovsPpE5RgSLKjnPSyF0rue90XESkb
         qVoQ==
X-Received: by 10.236.115.73 with SMTP id d49mr28009511yhh.12.1392037033806;
 Mon, 10 Feb 2014 04:57:13 -0800 (PST)
Received: by 10.170.167.133 with HTTP; Mon, 10 Feb 2014 04:57:13 -0800 (PST)
In-Reply-To: <xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241911>

On 6 February 2014 18:54, Junio C Hamano <gitster@pobox.com> wrote:
> Lasse Makholm <lasse.makholm@gmail.com> writes:
>
>> Here's a repro with -DDEBUG_ATTR=1 and a printf() in read_attr_from_file():
>>
>> $ cd /tmp/
>> $ mkdir -p attr-test/repo
>> $ cd attr-test/repo
>> $ git init
>> Initialized empty Git repository in /tmp/attr-test/repo/.git/
>> $ echo 'dir/* filter=foo' >.gitattributes
>> $
>>
>> Inside the working tree, it works:
>>
>> $ ~/src/git.git/git check-attr -a dir/file
>
> Does check-ignore misbehave the same way?

No, check-ignore works but also has NEED_WORK_TREE set. And that
actually also feels a bit wrong to me because check-attr and
check-ignore both seem like reasonable things to do in a bare repo
because .git(attributes|ignore) files are likely to be committed in
the repo.

> I suspect that is this because check-attr is not a command that
> requires a working tree.  The command was written primarily as a
> debugging aid that can be used anywhere as long as you have a
> repository to read strings from either its standard input or its
> arguments, and gives them directly to check_attr(), but it does so
> without first going to the top of the real working tree like
> check-ignore does.

Fair point. I actually stumbled across this because a git cat-file
--textconv ... was failing, so that's at least one other (and arguably
more real) use case that is broken in the same way.

> Forcing it to go to the top of the working tree (see the attached
> one-liner, but note that I didn't test it) may give you want you
> want.

For this case, it does, yes. But it also breaks check-attr in bare
repos with attributes defined in $GIT_DIR/info/attributes because it
will refuse to run without a work tree...

In any case the current state seems broken because --work-tree clearly
doesn't work for all commands...

Setting NEED_WORK_TREE for check-attr risks breaking existing scripts
but on the other hand there doesn't seem to be any good reason why
check-attr and check-ignore should differ in this regard...

It seems like the ideal solution would be an optional NEED_WORK_TREE
of some sort that would let these commands work correctly both with
--work-tree, without it and in bare repos but I get that that might
not be easy to fix...

Another approach might be to deprecate --work-tree and tell people to
use -C instead...

/L

>  git.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git.c b/git.c
> index 7cf2953..314ec9f 100644
> --- a/git.c
> +++ b/git.c
> @@ -342,7 +342,7 @@ static struct cmd_struct commands[] = {
>         { "branch", cmd_branch, RUN_SETUP },
>         { "bundle", cmd_bundle, RUN_SETUP_GENTLY },
>         { "cat-file", cmd_cat_file, RUN_SETUP },
> -       { "check-attr", cmd_check_attr, RUN_SETUP },
> +       { "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
>         { "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
>         { "check-mailmap", cmd_check_mailmap, RUN_SETUP },
>         { "check-ref-format", cmd_check_ref_format },
