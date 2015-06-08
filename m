From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-rebase--interactive.sh: add config option for custom instruction format
Date: Mon, 08 Jun 2015 14:29:13 -0700
Message-ID: <xmqqioax99ee.fsf@gitster.dls.corp.google.com>
References: <1433797202-97425-1-git-send-email-rappazzo@gmail.com>
	<1433797202-97425-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:29:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z24bh-0000o3-Nx
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 23:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbbFHV3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 17:29:17 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38572 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbbFHV3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 17:29:16 -0400
Received: by igblz2 with SMTP id lz2so2458560igb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QwZh9o55hUSTldnxYta3GfXvJcn1khMS7I8UybHX0ms=;
        b=bxb+bgUC4DEfzBIrwF07oVN7Vu+KRVS6iu4G2NdMR5OnzPRYa6Zh+zsn+GSl8JYZSu
         Nw55IBKxiNiQdimNLk1kIorJwc81+WyfG0yiLqktvck+P6/1ypatZLC5zkWVBZDOLgkS
         7058/ve71yxQm9mdo9MTcXbPiUdlY+TG2PdB0DRRYn69hUzK0jB78e7rfIihgL9BC/qU
         B5IZ/Jb4mr66BzUJSxgtjE5p1hQKRr7gKMWqIRpGWmmMGcCqvRq2M1JQJEAE4eBuO5DT
         iCIl/p/qK4y/8LdUjkrtjhmV93DsdSblVrkemX8a8iwqPIzaAmnmMbFcurJjByUrLSU1
         IMHA==
X-Received: by 10.50.61.161 with SMTP id q1mr16024013igr.12.1433798955536;
        Mon, 08 Jun 2015 14:29:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id fv2sm1186170igb.22.2015.06.08.14.29.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 14:29:15 -0700 (PDT)
In-Reply-To: <1433797202-97425-2-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Mon, 8 Jun 2015 17:00:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271136>

Michael Rappazzo <rappazzo@gmail.com> writes:

> A config option 'rebase.instructionFormat' can override the
> default 'oneline' format of the rebase instruction list.
>
> Since the list is parsed using the left, right or boundary mark plus
> the sha1, they are prepended to the instruction format.
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  git-rebase--interactive.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index dc3133f..b92375e 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -977,7 +977,9 @@ else
>  	revisions=$onto...$orig_head
>  	shortrevisions=$shorthead
>  fi
> -git rev-list $merges_option --pretty=oneline --reverse --left-right --topo-order \
> +format=$(git config --get rebase.instructionFormat)
> +# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
> +git rev-list $merges_option --format="%m%H ${format-%s}" --reverse --left-right --topo-order \
>  	$revisions ${restrict_revision+^$restrict_revision} | \
>  	sed -n "s/^>//p" |
>  while read -r sha1 rest

Looks OK, but

 - Needs a patch to Documentation/config.txt and possibly also
   Documentation/git-rebase.txt

 - Needs tests somewhere in t34?? series.

Also I think "git rev-list" line has got way too long.  As it is
already using backslash-continuation, do not hesitate to fold it
further, e.g. 

        git rev-list $merges_option --format="%m%H ${format-%s}" \
                --reverse --left-right --topo-order \
                $revisions ${restrict_revision+^$restrict_revision} | \
                sed -n "s/^>//p" |
	while ...

Thanks.
