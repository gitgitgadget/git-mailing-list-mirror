From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: add author info to TODO list in git-rebase--interactive
Date: Sat, 06 Jun 2015 23:14:27 -0700
Message-ID: <xmqq6170dozg.fsf@gitster.dls.corp.google.com>
References: <CANoM8SWX+UVWdV-Aeqqn8DuMf74zUWx=rbEaz3ctNDwa_ZZbeg@mail.gmail.com>
	<xmqq8ubyrlsc.fsf@gitster.dls.corp.google.com>
	<CAPig+cS0dW=KpD3C_6ugiJTccQqNu1NopcU6Pc71hf6iLLbcfw@mail.gmail.com>
	<CANoM8SXnTU5bnyLKUUYEtnug89cC9cN3AU3E07qUmk85teamLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 08:14:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1Tqv-0005XK-2R
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 08:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbbFGGOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 02:14:33 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:32790 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbbFGGOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 02:14:31 -0400
Received: by igbpi8 with SMTP id pi8so39954812igb.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 23:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WMkshzzYfD2r3DRGZPIyv7QzBZI7imjcvegIY6okWkk=;
        b=LCQ1fKmTc5exiQJHF/HtZQOQCyaEnVRwbCh0CFRT19WY6KMPotl96IZe1PO12x8wf8
         3BIuBQAOyu+FM3AUiBBovM7nTCpWt3dCP3ZeAbNSmGFavJQ9qHMeByuO9/7DhL28ZtaD
         o/jpq9C0dQHTvQQ5ftBxeRXXcX7alPf2rUcRJ2kIInxqVcDIIPgOuFssTKok3mnRD+QX
         Uatlr7V1zO+EpStQRBm5CYPb97jDYV+qH5VnKWJ7gqRRWyD5iTvUyOgfGwjAgm25e2xu
         ovj6ppTM2JaCsGJ+9pNwYnhkQmM1Yzj8VZ5haT7uXyy7oeXRJHkntodNhH25NnDl+mYp
         pRdA==
X-Received: by 10.50.138.70 with SMTP id qo6mr6519993igb.15.1433657671042;
        Sat, 06 Jun 2015 23:14:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a868:1333:6cc9:5851])
        by mx.google.com with ESMTPSA id ot6sm2494979igb.11.2015.06.06.23.14.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jun 2015 23:14:29 -0700 (PDT)
In-Reply-To: <CANoM8SXnTU5bnyLKUUYEtnug89cC9cN3AU3E07qUmk85teamLw@mail.gmail.com>
	(Mike Rappazzo's message of "Fri, 5 Jun 2015 21:00:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270956>

Mike Rappazzo <rappazzo@gmail.com> writes:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index dc3133f..e2d5ffc 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -977,7 +977,18 @@ else
>   revisions=$onto...$orig_head
>   shortrevisions=$shorthead
>  fi
> -git rev-list $merges_option --pretty=oneline --reverse --left-right
> --topo-order \
> +custom_format=$(git config --get rebase.interactive.todo-format)

We use three-level names only when we need an unbounded end-user
supplied things (e.g. nickname for remotes in "remote.*.url",
description for a branch in "branch.*.description").  "interactive"
is not such a token, so a two-level name, e.g. "rebase.insnformat"
or something like that.  Also core Git avoids variable names with
"-" in them.

> +if test -z "$custom_format"
> +then
> +   custom_format="oneline"
> +else
> +   # the custom format MUST start with %m%h or %m%H
> + if test "${custom_format:0:5}" != '%m%h '
> +   then
> +      custom_format="%m%h ${custom_format}"
> +   fi
> +fi

Why not allow them to *ONLY* set what follows '%m%h '?  That is, if
they say '%m%h %s', give them '%m%h %m%h %s', by unconditionally
prepend '%m%h '.  That way you do not need these conditional.

Something along the lines of...

        format=$(git config rebase.insnFormat)
        if test -z "$format"
        then
                format="%m%h	%s"
        else
                format="%m%h	$format"
        fi

        git rev-list $merge_option --format="$format" --reverse \
                --topo-order --left-right \
                ...

> ...  I also tried changing the
> '--left-right' to '--left-only', but that seemed to not produce any
> results.

Wouldn't we want right side of the symmetric difference, though?
