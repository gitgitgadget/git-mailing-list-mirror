From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] worktree: new place for "git prune --worktrees"
Date: Mon, 29 Jun 2015 09:13:37 -0700
Message-ID: <xmqqh9pqcx1q.fsf@gitster.dls.corp.google.com>
References: <1435582278-31158-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 18:13:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9bgp-0007P8-43
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 18:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbbF2QNn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jun 2015 12:13:43 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33393 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbbF2QNk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 12:13:40 -0400
Received: by igcur8 with SMTP id ur8so40967679igc.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=SsXLAif++G8j9mjCa3Zvs2hB4KTKOP+FFM+NcUCUPJ4=;
        b=tCbl6WL1Y/reIxpj1QwFt91l/O3YIio83SeDC7z+0PuzksGzL6ViOJDCbnlWJYHIoE
         NRvsa0FYZXpFabt+oILbzyVOfWWdsOuV5IxHMN0Q3CDySAkNUy0vm0VOwoUfRy7erzcE
         r5jth61/JFgr39JY4cdXPn95pjdemUlg4oAswY5lVjqm+NeWKrWRkyQKL8A8a8A0fxEk
         qPdCNxaYZsoDcCwSVI1gtqepOTNm1bTnGlNqbqu9TS13ba3mnTM1M1jWPil2hA36uQui
         fJ5YjnwJ2L0E96/wrvARhVQWs9VaUIZbMo6T8N53Lk1IO1vuPgiX7i/jks8nXTjEo67t
         L+Sg==
X-Received: by 10.50.64.243 with SMTP id r19mr16598795igs.5.1435594419794;
        Mon, 29 Jun 2015 09:13:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id 85sm497881iok.44.2015.06.29.09.13.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 09:13:39 -0700 (PDT)
In-Reply-To: <1435582278-31158-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 29
 Jun 2015 19:51:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272968>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Commit 23af91d (prune: strategies for linked checkouts - 2014-11-30)
> adds "--worktrees" to "git prune" without realizing that "git prune" =
is
> for object database only. This patch moves the same functionality to =
a
> new command "git worktree".
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  In future I probably move the big block of text in git-checkout.txt =
to
>  git-worktree.txt and add "git worktree list". But let's start with
>  something small and simple before "git prune --worktrees" is shipped
>  out.

Thanks.  I notice that after applying this, builtin/prune.c does not
revert to the original before 23af91d.  It stops including "dir.h"
and it adds an extra blank line.  We've been including a header that
is not necessary even in v2.4.0, it seems.  We used to walk
$GIT_DIR/objects ourselves to find loose object files and "dir.h"
was needed for is_dot_or_dotdot(); for_each_loose_file_in_objdir()
is what we use these days to hide the implementation details these
days; 27e1e22 forgot to remove the inclusion when it did this.

The C code part is mostly just \C-x \C-v and I found nothing
questionable.

> diff --git a/command-list.txt b/command-list.txt
> index b17c011..2a94137 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -148,4 +148,5 @@ git-verify-pack                         plumbingi=
nterrogators
>  git-verify-tag                          ancillaryinterrogators
>  gitweb                                  ancillaryinterrogators
>  git-whatchanged                         ancillaryinterrogators
> +git-worktree                            mainporcelain

I doubt that a helper that is primarily spawned from "gc" as its
implementation detail is more mainporcelain than "git config" is:

   git-config                              ancillarymanipulators

I also wonder if "git worktree" command should have a mode that
works in a way similar to how new-workdir (in contrib/workdir) does,
instead of an option "checkout --to" that looks just out of place as
"worktree prune" was out of place in "prune".  The feature is doing
a lot more than what "checkout" normally does (somewhere in between
"checkout" and "clone", I would say), and it may be cleaner to use
an independent command "git worktree" to manage a separate worktree.

And when that happens, the command should definitely be classified
as a mainporcelain.

> diff --git a/git.c b/git.c
> index 44374b1..fa77bc9 100644
> --- a/git.c
> +++ b/git.c
> @@ -483,6 +483,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
>  	{ "version", cmd_version },
>  	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
> +	{ "worktree", cmd_worktree, RUN_SETUP },

We do not NEED_WORK_TREE because we can create a new worktree
off of a bare repository?
