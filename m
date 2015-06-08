From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: add config option for custom
Date: Mon, 08 Jun 2015 08:28:35 -0700
Message-ID: <xmqqsia2cj8c.fsf@gitster.dls.corp.google.com>
References: <0000014dd0a821f6-a4ffca2d-d242-4e96-aeec-7a52186c5df1-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 17:28:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1yyj-0006nY-J7
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbbFHP2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:28:38 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33795 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbbFHP2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:28:37 -0400
Received: by iebmu5 with SMTP id mu5so65250272ieb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1OuS7dvzE7HiegnuI+W07OlD0977s4JS6dnY2xR6J14=;
        b=qdQqrUV7KSqGid9u6/E/SuUG2SEfrDDQm3KAG4kIHNIRw7k3TuuV59DM6RJEqis7Tf
         KJd3vLqaOrRVYuFONH0c55X5ADd5H2UWinEn+glj4WX7pU8gKczWgkS7VSPYsdIUCBmT
         r78jPLba4cq9rRyogGl1IYnVumtxb5PZsMuSkp/Ni6wBOLkmuCkHGq/RzKxZmIdimSYJ
         TfhHLS9cnhdsPWnau5KRDWhap3iroD/sBpN/Fn0hRYS3wprLeywcEF6SDlROU8KmCjhH
         JNUPgpWBmMU+I+ATSfmGdIstL7iES8WRFA9+EUPuvk3d2jiOJoIRuYCv/F2HwAm03aqh
         gfFw==
X-Received: by 10.50.64.243 with SMTP id r19mr14060314igs.5.1433777316709;
        Mon, 08 Jun 2015 08:28:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d91a:edb1:b738:fb03])
        by mx.google.com with ESMTPSA id qs10sm539216igb.14.2015.06.08.08.28.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 08:28:36 -0700 (PDT)
In-Reply-To: <0000014dd0a821f6-a4ffca2d-d242-4e96-aeec-7a52186c5df1-000000@eu-west-1.amazonses.com>
	(Michael Rappazzo's message of "Mon, 8 Jun 2015 00:53:09 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271051>

Michael Rappazzo <rappazzo@gmail.com> writes:

> A config option 'rebase.instructionFormat' can override the
> default 'oneline' format of the rebase instruction list.
>
> Since the list is parsed using the left, right or boundary mark plus
> the sha1, they are prepended to the instruction format.
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---

Thanks.  Roberto's gizmo seems to be working OK ;-)

>  git-rebase--interactive.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index dc3133f..cc79b81 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -977,7 +977,14 @@ else
>  	revisions=$onto...$orig_head
>  	shortrevisions=$shorthead
>  fi
> -git rev-list $merges_option --pretty=oneline --reverse --left-right --topo-order \
> +format=$(git config --get rebase.instructionFormat)
> +if test -z "$format"
> +then
> +   format="%s"

Style.  One indent level in our shell scripts is one HT, not a few spaces.

> +fi
> +# the 'rev-list .. | sed' requires %m to parse; the instruction requires %h to parse
> +format="%m%h ${format}"

I think you want %H not %h here.  If you check how the default
"--pretty=online" is shown, you would see something like this:

    >1e9676ec0a771de06abca3009eb4bdc5a4ae3312 lockfile: replace ...
    >2024d3176536fd437b4c0a744161e96bc150a24e help.c: wrap wait-...

> +git rev-list $merges_option --pretty="${format}" --reverse --left-right --topo-order \
>  	$revisions ${restrict_revision+^$restrict_revision} | \
>  	sed -n "s/^>//p" |

This is optional, but I still wonder why the command line cannot be
more like this, though:

	format=$(git config --get rebase.insnFormat)
	git log --format="%H ${format-%s}" --reverse --right-only --topo-order \
	  	$revisions ${restrict_revision+^$restrict_revision} |
        while read -r sha1 junk
        do
        	...

That way we can optimize one "sed" process away.

If this is a good idea, it needs to be a separate follow-up patch
that changes "%m filtered by sed" to "use --right-only".  I do not
think such a change breaks anything, but I do not deal with complex
histories myself, so...
