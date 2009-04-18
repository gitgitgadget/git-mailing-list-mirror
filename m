From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Work around ash "alternate value" expansion bug
Date: Sat, 18 Apr 2009 11:30:58 -0700
Message-ID: <7vfxg5x199.fsf@gitster.siamese.dyndns.org>
References: <1240044459-57227-1-git-send-email-ben@ben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nanako3@lavabit.com, gitster@pobox.com
To: Ben Jackson <ben@ben.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 20:32:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvFLI-0005MQ-Iw
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 20:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbZDRSbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 14:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbZDRSbI
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 14:31:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbZDRSbH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 14:31:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9053610781;
	Sat, 18 Apr 2009 14:31:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 988391077F; Sat,
 18 Apr 2009 14:31:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 13E5BDE6-2C47-11DE-A2FA-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116860>

Ben Jackson <ben@ben.com> writes:

> Ash (used as /bin/sh on many distros) has a shell expansion bug
> for the form ${var:+word word}.  The result is a single argument
> "word word".  Work around by using ${var:+word} ${var:+word} or
> equivalent.
>
> Signed-off-by: Ben Jackson <ben@ben.com>
> ---
>
> I found this by accident while testing another trivial git-am patch.
> It was broken about a week ago in git-am.sh by f79d4c8a and one of the
> test cases caught it on FreeBSD.
>
> The other instance has been around longer and I found it by grepping.
> I added a new testcase (none too exciting) which exposes the problem.
> There are more instances of ${x:+alt} which don't have spaces which I
> did not touch.
>
> For the curious:
>
> bash on linux:
> 	$ parent=ok
> 	$ echo ${parent:+-p $parent}
> 	-p ok
> 	$ for i in ${parent:+-p $parent} ; do echo .$i; done
> 	.-p
> 	.ok
>
> ash (/bin/sh) on freebsd:
> 	$ parent=ok
> 	$ echo ${parent:+-p $parent}
> 	-p ok
> 	$ for i in ${parent:+-p $parent} ; do echo .$i; done
> 	.-p ok
>
> This is probably a bug in ash.  It does expand ${foo:+*} into many words.
>
>  git-am.sh                  |    2 +-
>  git-submodule.sh           |    2 +-
>  t/t7400-submodule-basic.sh |    8 ++++++++
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index bfc50c9..e539c60 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -570,7 +570,7 @@ do
>  			GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
>  			export GIT_COMMITTER_DATE
>  		fi &&
> -		git commit-tree $tree ${parent:+-p $parent} <"$dotest/final-commit"
> +		git commit-tree $tree ${parent:+-p} $parent <"$dotest/final-commit"
>  	) &&
>  	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
>  	stop_here $this

I do not mind this one, but

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 7c2e060..bb3766d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -204,7 +204,7 @@ cmd_add()
>  	else
>  
>  		module_clone "$path" "$realrepo" || exit
> -		(unset GIT_DIR; cd "$path" && git checkout -f -q ${branch:+-b "$branch" "origin/$branch"}) ||
> +		(unset GIT_DIR; cd "$path" && git checkout -f -q ${branch:+-b} ${branch:+"$branch"} ${branch:+"origin/$branch"}) ||

this is too ugly to live in our codebase, and without an accompanying code
comment, I am sure somebody (if not myself) will "fix" it again.

	(
        	unset GIT_DIR
		cd "$path" &&
		# BSD ash mishandles ${branch:+-b "$branch" ...}, sheesh.
                case "$branch" in
                '')	git checkout -f -q ;;
                ?*)	git checkout -f -q -b "$branch" "origin/$branch" ;;
                esac
	) ||
	...
