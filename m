From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: add author info to TODO list in git-rebase--interactive
Date: Fri, 05 Jun 2015 12:35:15 -0700
Message-ID: <xmqq8ubyrlsc.fsf@gitster.dls.corp.google.com>
References: <CANoM8SWX+UVWdV-Aeqqn8DuMf74zUWx=rbEaz3ctNDwa_ZZbeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 21:35:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0xOl-0008LA-P6
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 21:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbbFETfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 15:35:19 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38176 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbbFETfR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 15:35:17 -0400
Received: by igblz2 with SMTP id lz2so21999267igb.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9en7wM00KO3ZroNOyQNJ+XOepRjjHlFsiUJTFATSWrQ=;
        b=S0bN5LfLKlK27iPUo8ABWo8hmgy8MvbiZG3MU4iLg/TeQ/o/sh506bWrfEB6QEKSmi
         xt4CDfOgOoTBfSdZ9TXnI2aj/+8W4ifAcsIH1DJfiZzZUfGguW5FllgfeePrGscEXjnw
         MtUhjtNCGud8mciqGcjY7l0lLEH9DlV26IlQ7j0dadFtIqYdKdowNIhPKXtImrj9gMBK
         j/RneVPy45kZs6PsLlH9beu5zgBptEtWxLxgUa4pmpBxBa1djoJdR3mMgpKe01odJyGC
         zJuaOcaYHktPAAmrWQ7kNVcjUQTFT73EGnz5leJ25X5XAYbyNok5xz405jCRcdUFC/c+
         Jqog==
X-Received: by 10.107.169.157 with SMTP id f29mr6526316ioj.74.1433532916730;
        Fri, 05 Jun 2015 12:35:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d0d:eed3:5800:fefa])
        by mx.google.com with ESMTPSA id j20sm1919204igt.16.2015.06.05.12.35.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 12:35:16 -0700 (PDT)
In-Reply-To: <CANoM8SWX+UVWdV-Aeqqn8DuMf74zUWx=rbEaz3ctNDwa_ZZbeg@mail.gmail.com>
	(Mike Rappazzo's message of "Fri, 5 Jun 2015 15:00:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270876>

Mike Rappazzo <rappazzo@gmail.com> writes:

> I find that If I am doing a rebase with the intention to squash or
> re-order commits, it is helpful to know the commit author.

There is not a fundamental reason why the remainder of the line
after the object name in the rebase insn sheet should not be
customizable, and I think your patch is a good first step to
identify where that customization should go.

But that is a customization issue, not changing the default and the
only format used.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index dc3133f..ec44d41 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -977,7 +977,7 @@ else
>         revisions=$onto...$orig_head
>         shortrevisions=$shorthead
>  fi
> -git rev-list $merges_option --pretty=oneline --reverse --left-right
> --topo-order \
> +git rev-list $merges_option --pretty="%m%h [%an] %x09%s" --reverse
> --left-right --topo-order \
>         $revisions ${restrict_revision+^$restrict_revision} | \
>         sed -n "s/^>//p" |
>  while read -r sha1 rest

This is nothing new, and it may not even be a problem, but why do we
use --left-right and then filter with sed?  Does this part of the
code predate --left-only, I wonder.  I'd probably write

	git log --format="%h	%s" --left-only .....

with today's Git, but perhaps I am missing something?

> The problem, as I see it is that the original '--pretty=oneline' only
> produces a single line of output (of course).  However, the changed
> version '--pretty="%m%h [%an] %x09%s"' produces multiple lines.

Shouldn't you be using tformat, not format, if you are doing a
oneline emulation?
