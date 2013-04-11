From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] cherry-pick: make sure all input objects are commits
Date: Thu, 11 Apr 2013 15:52:44 +0530
Message-ID: <CALkWK0n6FjGbXTqiOT_O6NbB5h0DLaNWKCCTQAFSO_BL-pPdBA@mail.gmail.com>
References: <20130403092704.GC21520@suse.cz> <7v38v1yn8o.fsf@alter.siamese.dyndns.org>
 <20130411092638.GA12770@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu Apr 11 12:23:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQEfB-0003eM-Vz
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 12:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934320Ab3DKKX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 06:23:26 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:52726 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934043Ab3DKKXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 06:23:25 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so1810979ieb.31
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=wHZ8NZVQ7SNRjI4QUHCyPEc80hcRnEsOXDCq+FXQTlo=;
        b=VID6WOR8h4V6mMBmoOuOXp+R9E6GHzMdmKJKn7wvFxgu1fJq8tWx9qobeXOqojgiBL
         DnuMZjN0u5Gzx1+bbrPVgoUFHAhc6D7o4Dk47G9AHp9kHHdB89EMkPDAdip13rwRR6wn
         240IVcbOgjMGxdS+aC4o7a9BK7shYGxYfpHdj7KF2IAAf383khzQ2cyfMQTU+dRB/MIK
         9loZ4iipQHgXoWeayZY1zS9l3lUE+qXD3NxZ9xLlfwdEkZO88t26MRerJGk4ClSMsIYh
         w20+ylgzgIsIXVFHoWlOT9j31oNnumA3GGGUOtgd6i8qEzj4EU/a9h7cG2sAeR4dQ1N8
         MELw==
X-Received: by 10.50.50.71 with SMTP id a7mr15638515igo.14.1365675805048; Thu,
 11 Apr 2013 03:23:25 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 11 Apr 2013 03:22:44 -0700 (PDT)
In-Reply-To: <20130411092638.GA12770@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220841>

Miklos Vajna wrote:
> When a single argument was a non-commit, the error message used to be:
>
>         fatal: BUG: expected exactly one commit from walk
>
> For multiple arguments, when none of the arguments was a commit, the error was:
>
>         fatal: empty commit set passed
>
> Finally, when some of the arguments were non-commits, we ignored those
> arguments.  Instead, now make sure all arguments are commits, and for
> the first non-commit, error out with:
>
>         fatal: <name>: Can't cherry-pick a <type>

Thanks.  This is worth fixing.

> diff --git a/sequencer.c b/sequencer.c
> index baa0310..eb25101 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1067,6 +1068,18 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>         if (opts->subcommand == REPLAY_CONTINUE)
>                 return sequencer_continue(opts);
>
> +       for (i = 0; i < opts->revs->pending.nr; i++) {
> +               unsigned char sha1[20];
> +               const char *name = opts->revs->pending.objects[i].name;
> +
> +               if (!get_sha1(name, sha1)) {
> +                       enum object_type type = sha1_object_info(sha1, NULL);
> +
> +                       if (type > 0 && type != OBJ_COMMIT)
> +                               die(_("%s: can't cherry-pick a %s"), name, typename(type));
> +               }

else?  What happens if get_sha1() fails?

> diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
> index 4e7136b..19c99d7 100755
> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -55,6 +55,12 @@ one
>  two"
>  '
>
> +test_expect_success 'cherry-pick three one two: fails' '
> +       git checkout -f master &&
> +       git reset --hard first &&
> +       test_must_fail git cherry-pick three one two:
> +'

So you're testing just the third case (where commit objects are mixed
with non-commit objects), which is arguably a bug.  Okay.
