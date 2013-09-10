From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v3] Allow git-filter-branch to process large repositories with lots of branches.
Date: Tue, 10 Sep 2013 16:20:01 -0700
Message-ID: <xmqqli34uuvy.fsf@gitster.dls.corp.google.com>
References: <522BB170.8040507@gmail.com>
	<CE54F01A.19632%lee.carver@corp.service-now.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Lee Carver <leeca@pnambic.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Lee Carver <Lee.Carver@servicenow.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 01:20:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJXEI-0005dE-F5
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 01:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab3IJXUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 19:20:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42130 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227Ab3IJXUK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 19:20:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A46A340EC6;
	Tue, 10 Sep 2013 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q/9TQHiN2GHlyp7/+YmutZXQnUo=; b=MDByon
	mRrPN+al8YqtPpRS9Ik1oRQ+Z1pY4KkYyjtPFEMpYWBKym9OHF6qhM+6ao67Az/i
	3gKZXhkYTquZY8nJ/9V8Fr7Ny2KA5ur8WNEwlq/l7GWWQlxiPUwAtXREj1U442d1
	6h0JixYKZzGv+X8SyKd6aRASSzQ6HpdHHJGzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kQ+MlToOqJ9jcwjsTBnp+/xsTosHreJy
	Q2YVnvAhapSfSEcVaDkoIWuAs5m0G/rhViJ99ittJZEi3oOMW7h6+oca6bmhad7n
	aV4TBVBFteGzSqWvgc3c4bulqrT25vTTEHzrXJY/5QsuxNsO1db3NwmV+kWYYA+a
	7uCEcTscfvs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 977F740EC5;
	Tue, 10 Sep 2013 23:20:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02A2840EC1;
	Tue, 10 Sep 2013 23:20:08 +0000 (UTC)
In-Reply-To: <CE54F01A.19632%lee.carver@corp.service-now.com> (Lee Carver's
	message of "Tue, 10 Sep 2013 22:55:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 88CF3EE6-1A6F-11E3-A42C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234503>

Lee Carver <Lee.Carver@servicenow.com> writes:

> As noted in several forums, a recommended way to move trees between
> repositories
> is to use git-filter-branch to revise the history for a single tree:
>
> http://gbayer.com/development/moving-files-from-one-git-repository-to-anoth
> er-preserving-history/
> http://stackoverflow.com/questions/1365541/how-to-move-files-from-one-git-r
> epo-to-another-not-a-clone-preserving-history
>
> However, this can lead to argument list too long errors when the original
> repository has many retained branches (>6k)
>
> /usr/local/git/libexec/git-core/git-filter-branch: line 270:
> /usr/local/git/libexec/git-core/git: Argument list too long
> Could not get the commits
>
> Piping the saved output from git rev-parse into git rev-list avoids this
> problem, since the rev-parse output is not processed as a command line
> argument.
> ---
>  git-filter-branch.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index ac2a005..2091885 100755
> --- a/git-filter-branch.shgit
> +++ b/git-filter-branch.sh
> @@ -255,7 +255,7 @@ else
>  	remap_to_ancestor=t
>  fi
>  
> -rev_args=$(git rev-parse --revs-only "$@")
> +git rev-parse --revs-only "$@" > ../parse

Where is this "rev-parse" command running?  Is it always safe to
clobber the file "../parse" like this?

>  
>  case "$filter_subdir" in
>  "")
> @@ -268,7 +268,7 @@ case "$filter_subdir" in
>  esac
>  
>  git rev-list --reverse --topo-order --default HEAD \
> -	--parents --simplify-merges $rev_args "$@" > ../revs ||
> +	--parents --simplify-merges --stdin "$@" < ../parse > ../revs ||
>  	die "Could not get the commits"
>  commits=$(wc -l <../revs | tr -d " ")
