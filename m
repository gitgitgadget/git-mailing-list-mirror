From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is empty
Date: Thu, 20 Nov 2014 09:13:27 -0800
Message-ID: <xmqqioi94wy0.fsf@gitster.dls.corp.google.com>
References: <1416498395.23953.8.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Smith <paul@mad-scientist.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 18:13:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrVIa-0001Ur-2F
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 18:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459AbaKTRNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 12:13:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755212AbaKTRNe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 12:13:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6ACA41E04A;
	Thu, 20 Nov 2014 12:13:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hwfFiGla83O15zO/6sbjqQe1TMo=; b=K4n7jX
	1UGUCJJxEk2KV6T1twLu38ffwEZy0i6oR/6hPxJAPuyhfRM5nkAFPn4GTeTPhN6w
	BH4ijfj8guWgVbO8GkL67DsmmTdg5O0yaCQomcvIawpzUoqnSxqZlkssx9QFv5Xn
	AVhwFShagjd1ZMIqo8SvCMcpuAhvd3OS1yE7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G+OKjDuYH3lavFdlb+gVlV0RzV/nr3q8
	dEjwbdjNy8efdp5H5iarg+TovW8JU4iKcaf8xJGNtDuW+4OREPz4cOPtbXWpAs08
	jvdNU2Z0UhmkqcQaDjn+LfWbJaVFcY+ZFqlx4sljsP70utBXM+7bflDPECY0VGvR
	kxwgfGG+gMM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 61B0A1E049;
	Thu, 20 Nov 2014 12:13:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9081F1E048;
	Thu, 20 Nov 2014 12:13:32 -0500 (EST)
In-Reply-To: <1416498395.23953.8.camel@mad-scientist.net> (Paul Smith's
	message of "Thu, 20 Nov 2014 10:46:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E06C152-70D8-11E4-841D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Smith <paul@mad-scientist.net> writes:

> Allow new workdirs to be created in an empty directory (similar to "git
> clone").  Provide more error checking and clean up on failure.
>
> Signed-off-by: Paul Smith <paul@mad-scientist.net>
> ---
>  contrib/workdir/git-new-workdir | 54 +++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 18 deletions(-)

Thanks.  I would have liked [PATCH v$n] on the subject line but
that's minor.

I also see you made a few small improvements here and there, like...

>  # don't link to a configured bare repository
>  isbare=$(git --git-dir="$git_dir" config --bool --get core.bare)
> -if test ztrue = z$isbare
> +if test ztrue = "z$isbare"

... this bit, which I think is a good idea.  We are asking "--bool"
so we know we will never get anything other than true/false to cause
trouble by not quoting, but the dq-pair there does not cost anything
and it is a good discipline.

> +# make sure the links in the workdir have full paths to the original repo
> +git_dir=$(cd "$git_dir" && pwd) || exit 1

... so is this bit, which used to just go even if cd failed.

> +# don't recreate a workdir over an existing directory, unless it's empty
> +if test -d "$new_workdir"
>  then
> -	die "destination directory '$new_workdir' already exists."
> +	if test $(ls -a1 "$new_workdir"/. | wc -l) -ne 2

You used to quote this as

	if test $(ls -a1 "$new_workdir/." | wc -l) -ne 2

and I think that made a lot more sense than the new quoting.

The ultimate reason we quote here is because "$new_workdir/." is the
single directory path we want to give "ls", and quoting the whole
thing shows that intention far clearer than the new one, which says
"there may be an $IFS character in $new_workdir so I am quoting to
keep them together as a single string and then appending /. to that
single string will still be a single string", which is not wrong
per-se in that it is saying the same thing, but it is a roundabout
way to do so.

> +	then
> +		die "destination directory '$new_workdir' is not empty."
> +	fi
> +	cleandir="$new_workdir"/.git
> +else
> +	cleandir="$new_workdir"
>  fi
>  
> -# make sure the links use full paths
> -git_dir=$(cd "$git_dir"; pwd)
> +mkdir -p "$new_workdir"/.git || failed
> +cleandir=$(cd "$cleandir" && pwd) || failed
>  
> -# create the workdir
> -mkdir -p "$new_workdir/.git" || die "unable to create \"$new_workdir\"!"
> +cleanup () {
> +	rm -rf "$cleandir"
> +}
> +siglist="0 1 2 15"
> +trap cleanup $siglist
>  
>  # create the links to the original repo.  explicitly exclude index, HEAD and
>  # logs/HEAD from the list since they are purely related to the current working
>  # directory, and should not be shared.
>  for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn
>  do
> +	# Create a containing directory if needed
>  	case $x in
> -	*/*)
> -		mkdir -p "$(dirname "$new_workdir/.git/$x")"
> -		;;
> +		*/*) mkdir -p "$new_workdir/.git/${x%/*}" ;;

Case arms come at the same indentation level as "case/esac".

>  	esac
> -	ln -s "$git_dir/$x" "$new_workdir/.git/$x"
> +
> +	ln -s "$git_dir/$x" "$new_workdir/.git/$x" || failed
>  done
>  
> -# now setup the workdir
> -cd "$new_workdir"
>  # copy the HEAD from the original repository as a default branch
> -cp "$git_dir/HEAD" .git/HEAD
> -# checkout the branch (either the same as HEAD from the original repository, or
> -# the one that was asked for)
> -git checkout -f $branch
> +cp "$git_dir"/HEAD "$new_workdir"/.git/HEAD || failed
> +

Why these changes?  I thought you are making sure $cleandir is
absolute so that you do not have to do this and can just "cd" into
the new working tree, the same way the user would do once it is set
up.

Puzzled...  Before seeing this bit, I was about to say "but all the
above nits are minor so no need to resend---I'll locally fix them up
while queueing", but I suspect that I may be missing some obvious
reason why you avoid "cd" and I am reluctant to "fix" this part up
myself without seeing a response, so I'd swallow that "no need to
resend" X-<.

> +# the workdir is set up.  if the checkout fails, the user can fix it.
> +trap - $siglist
> +
> +# checkout the branch (either the same as HEAD from the original repository,
> +# or the one that was asked for)
> +git -C "$new_workdir" checkout -f $branch
