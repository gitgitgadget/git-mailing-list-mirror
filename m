From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] merge: deprecate 'git merge <message> HEAD <commit>' syntax
Date: Thu, 26 Mar 2015 09:51:10 -0400
Message-ID: <CAPig+cR6CiEgQzmXS2w7XLfNWpm=vD-kTu5NmyLBLT3z=JAkAg@mail.gmail.com>
References: <xmqqvbhoz75m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 14:51:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb8Bo-0004w4-M7
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 14:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbbCZNvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 09:51:12 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:36388 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbbCZNvL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 09:51:11 -0400
Received: by labe2 with SMTP id e2so45844711lab.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2015 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XefC35As43U2juiLObqQIiDITx4Pgcr8AkzRYGDLkpA=;
        b=XfHw2uTGGPnjcZWEenwfQPIhWLx/LzujQ3J+AFeaQv0Fb8pdj3i/nd9P0OOlchEcbx
         K3P8AphtmJ7axvPZpAYUI9q1U2jtO6ACwOFiklQQGbYSnHEJ+c6aXGRYx5KPYS4MzWsh
         KQFzCpsmqJiMOfNPFJpGhkcSZ/JNjVf2kZ/Wk08fknRczTXXIATeEZv6DRD8Ka8BzmiO
         +nlQc9jLYvxirJlWiRyBWuIv4qVDkvUX6RbR4zDByoW/UJy1aUFgVrRt/rJwwu7iUttQ
         CrDaLMTqgqd1h3tXjxYNwQNWVuppqSkZhu7j1uAKzTfio7NIR5bGNx8gHCCnwgHu8BVE
         9X+A==
X-Received: by 10.152.170.199 with SMTP id ao7mr13144792lac.27.1427377870396;
 Thu, 26 Mar 2015 06:51:10 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Thu, 26 Mar 2015 06:51:10 -0700 (PDT)
In-Reply-To: <xmqqvbhoz75m.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: dEY6IRkt4zVPFv8g_2k_a3G2Ung
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266330>

On Thu, Mar 26, 2015 at 12:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> We had this in "git merge" manual for eternity:
>
>     'git merge' <msg> HEAD <commit>...
>
>     [This] syntax (<msg> `HEAD` <commit>...) is supported for
>     historical reasons.  Do not use it from the command line or in
>     new scripts.  It is the same as `git merge -m <msg> <commit>...`.
>
> I wanted to see how much damage we would incur to people by checking
> what the damage to _our_ system, including the test scripts, if we
> dropped the support for the syntax.  The last time I tried this, I
> thought that replacing the use of this syntax in "git pull" with its
> obvious and trivial rewrite 'git merge -m <msg> <commit>' broke some
> output, and that is the primary reason why I stayed away from trying
> this again, but it no longer seems to be the case with today's code
> for some reason.
>
> There are quite a few fallouts in the test scripts, and it turns out
> that "git cvsimport" also uses this old syntax to record a merge.
>
> Judging from this result, I would not be surprised if dropping the
> support of the old syntax broke scripts people have written and been
> relying on for the past ten years.  But at least we can start the
> deprecation process by throwing a warning message when the syntax is
> used.
>
> With luck, we might be able to drop the support in a few years.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 3b0f8f9..0795358 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1182,6 +1182,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>
>         if (!have_message && head_commit &&
>             is_old_style_invocation(argc, argv, head_commit->object.sha1)) {
> +               warning("old-style 'git merge <msg> HEAD <commit>' is deprecated.");

To be a bit more helpful, perhaps point the user at "git merge -m
<msg> <commit>..." as the recommended replacement?

>                 strbuf_addstr(&merge_msg, argv[0]);
>                 head_arg = argv[1];
>                 argv += 2;
