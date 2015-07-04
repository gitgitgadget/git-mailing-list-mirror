From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 08/23] checkout: fix bug with --to and relative HEAD
Date: Sat, 4 Jul 2015 09:45:01 +0700
Message-ID: <CACsJy8C=BZF57GqRxO6CfBAYOxywEd4zHay4cgSZMrKCv6u77w@mail.gmail.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com> <1435969052-540-9-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 04:45:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBDST-00063r-NQ
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 04:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbbGDCpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 22:45:33 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33555 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178AbbGDCpb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 22:45:31 -0400
Received: by igcur8 with SMTP id ur8so155009387igc.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 19:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5fp3JycOLC3MoM11YVghYueSXDAkgy4eYIJNMpt+b8c=;
        b=hIwxgfSW57DLzlmr9SfoauS1RMGmZNR2BSR6AFpehrYfojk1GvpQR8JwuFtob3/gxp
         C+GRQBj2tiLLbeVQUbzOhojMLQVjZ2xh0L5dxEt8xXlZgNQn/X67KJWygcJ/rBScCE2i
         uaMj74f1Qmjx3SMd+vcnYYhEhE6BnRqey7OHCquqjDVerJckfOaQJ9sqtlrJqWdUN3Kd
         ZbNNhtsiDrMBaGU+ltPgIDgugPSgP0GIj9/CuK2++4J3ZWBrzLZRsrtFlRL/FABQxn52
         NRT74Pa7LaOehiS11obRknrauqhitO22D6Vb4ROOqnOm3RaqZ7GiYYCvfKf+k5lDz6yC
         a5TA==
X-Received: by 10.42.244.4 with SMTP id lo4mr22166578icb.65.1435977931171;
 Fri, 03 Jul 2015 19:45:31 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Fri, 3 Jul 2015 19:45:01 -0700 (PDT)
In-Reply-To: <1435969052-540-9-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273347>

On Sat, Jul 4, 2015 at 7:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Given "git checkout --to <path> HEAD~1", the new worktree's HEAD should
> begin life at the current branch's HEAD~1, however, it actually ends up
> at HEAD~2. The happens because:
>
>     1. git-checkout resolves HEAD~1
>
>     2. to satisfy is_git_directory, prepare_linked_worktree() creates a
>        HEAD in the new worktree with the value of the resolved HEAD~1
>
>     3. git-checkout re-invokes itself with the same arguments within the
>        new worktree to populate the worktree
>
>     4. the sub git-checkout resolves HEAD~1 relative to its own HEAD,
>        which is the resolved HEAD~1 from the original invocation,
>        resulting unexpectedly and incorrectly in HEAD~2 (relative to the
>        original)
>
> Fix this by unconditionally assigning the current worktree's HEAD as the
> value of the new worktree's HEAD.

Good catch!

> @@ -924,9 +925,11 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
>          * value would do because this value will be ignored and
>          * replaced at the next (real) checkout.
>          */

This comment "any valid value would do.. will be ignored" is proved incorrect.

> +       if (!resolve_ref_unsafe("HEAD", 0, rev, NULL))
> +               die(_("unable to resolve HEAD"));
>         strbuf_reset(&sb);
>         strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
> -       write_file(sb.buf, 1, "%s\n", sha1_to_hex(new->commit->object.sha1));
> +       write_file(sb.buf, 1, "%s\n", sha1_to_hex(rev));
>         strbuf_reset(&sb);
>         strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>         write_file(sb.buf, 1, "../..\n");
-- 
Duy
