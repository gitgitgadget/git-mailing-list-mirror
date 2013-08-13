From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash takes excessively long when many untracked files present
Date: Tue, 13 Aug 2013 10:07:41 -0700
Message-ID: <7v7gfpy0wy.fsf@alter.siamese.dyndns.org>
References: <20130810214453.GA5719@jtriplet-mobl1>
	<loom.20130813T120243-481@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Darander <anders.darander@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 19:08:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9I4f-0001KN-TR
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 19:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758409Ab3HMRH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 13:07:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756901Ab3HMRH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 13:07:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2868D38A94;
	Tue, 13 Aug 2013 17:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=25/haj7JEkvbjOhtg38xwrbuSvA=; b=AXNgzR
	1J4aYmlC5Uprm5iJXl3OPtVs7dF0ZIjIZ22LvVphz4gCCJw+IYYG6yihsuAVJP3F
	1qbgLBcvelxPwfU5OlzAUEPfJ+y1xnvUpnJMyumqab27Dvy4CediFQegTn708m9c
	GErcxTW58EAkoc9CvckHpyh1OaAdUr7/Ql0AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fX99/gpTv+cb8lSEMHZ1UtsaExhF5eBh
	ui0hOmUdfzgW/73iPgylBmoAces1T3rXSBaKCCsnD8PvHuEK1pMLz0LGe97gtDR/
	IEgq+quGVRpqkj96j+QtQbk0riN4wWjMy/MjIFqiLkJ4zBVBtQnH27JmBRJ+WkUQ
	3zxPORibKNM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BF5338A93;
	Tue, 13 Aug 2013 17:07:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 556F438A8F;
	Tue, 13 Aug 2013 17:07:43 +0000 (UTC)
In-Reply-To: <loom.20130813T120243-481@post.gmane.org> (Anders Darander's
	message of "Tue, 13 Aug 2013 10:11:11 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE30B7A2-043A-11E3-B0CE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232236>

Anders Darander <anders.darander@gmail.com> writes:

> diff --git a/git-stash.sh b/git-stash.sh
> index 85c9e2c..e5a2043 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -263,7 +263,7 @@ save_stash () {
>                 exit 0
>         fi
>         if test -z "$untracked$force" &&
> -          test -n "$(git ls-files --killed | head -n 1)"
> +          test -n "$(git ls-files --killed --directory | head -n 1)"
>         then
>                 say "$(gettext "The following untracked files would NOT be 
> saved
>                 test -n "$GIT_QUIET" || git ls-files --killed | sed 
> 's/^/\t/'
> -------------------------------------------
>
> It seems to work in my extremely limited testing. Though, I'm pretty sure 
> that there'll be quite a few error cases... (Especially, as I just made
> a naive attempt at patching git-stash, so I could go on with a few other 
> things).

I am not sure adding "--directory" there is safe.  Aren't there
cases where saving a stash and going back to the committed state
will involve killing no directories, but some files?  If your local
change is to remove a directory and files in it from your working
tree and then deposit a newly created file at the path where the
directory was in the HEAD, stashing that local change and then going
back to the HEAD will involve removing the new file from the working
tree, and unless you have "git add"ed the new file, it will be lost.

> Do anyone have any better idea on how to approach this?

Teaching "ls-files" to leave early once it seens even a single
output is probably a possibility.

>> I see a lot of room for optimization here.  Most importantly, git
>> ls-files --killed really doesn't need to look at any directory entry
>> unless something in the index would conflict with it.

This observation probably is correct, even though I didn't think
about it long enough.

Thanks.
