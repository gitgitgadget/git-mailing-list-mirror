From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is empty
Date: Wed, 19 Nov 2014 09:32:32 -0800
Message-ID: <xmqqd28jt7tb.fsf@gitster.dls.corp.google.com>
References: <1416339408.3899.22.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Smith <paul@mad-scientist.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 18:32:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xr97R-0000eq-3d
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 18:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279AbaKSRch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 12:32:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753829AbaKSRcg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 12:32:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 195511E833;
	Wed, 19 Nov 2014 12:32:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cGi+Ob5dJdSR9sF+aV1u9lKYwUI=; b=WDiDZi
	5VDcxM052wyki4puM5MSY3Ug8FTIllOzRCZwL8lSL9K5nnpLvR1GOMSyJ8jN4m5x
	s9eQS4QC5gycELeMDirR8lgIvJcUDkwhZ6yNp7eY5b64FRN2hD9JkSWORPYjQY3V
	nmyfS1CsPkB2LO9hYCXLJhsHXmXI4JBMnDWJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o525JNEsrsh9nq5JWDdB9EmED3sNg+0T
	fSEL9iPoenQFDJ4ATlFJwR8bLdYzkOYoEzuK98f64uCsXBXtCUHhhz+kCwIPdJh7
	BGWbGP5AZPNqcwKxXk6sp+qJ9v64nS7gL8YvVBkH8f7x4TCWYVkSeqKuiXtTNKW4
	ntisuKBidPM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 049701E832;
	Wed, 19 Nov 2014 12:32:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54D7F1E831;
	Wed, 19 Nov 2014 12:32:34 -0500 (EST)
In-Reply-To: <1416339408.3899.22.camel@mad-scientist.net> (Paul Smith's
	message of "Tue, 18 Nov 2014 14:36:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C2716F8-7012-11E4-992F-42529F42C9D4-77302942!pb-smtp1.pobox.com
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
>
> Getting rid of ls/wc was not as simple as I'd hoped, due to glob
> pathname expansion (can't rely on nullglob e.g.)  If you want this let
> me know; it will require some yucky code to do the whole thing in native
> shell.  Since new-workdir only works on systems with "ln -s" I think we
> can feel confident requiring "ls" and "wc" as well.
>
>  contrib/workdir/git-new-workdir | 55 +++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 19 deletions(-)

I took a look at this again, and I do not agree with one design
decision it makes, namely:

>> I split the creation of the directories from the symlinks: see the new
>> loop above.  This allows us to avoid the icky dirname stuff.

which forces those who maintain the script to make sure that these
two loops

	for dir in log
        do
        	make leading directory $dir
	done
	for path in refs logs/refs objects ...
	do
        	make symlink, assuming the leading directory exists
	done

kept consistent with each other.  If you forget to add frotz to the
upper loop when adding frotz/nitfol to the latter, you are breaking
it.

I find it much more icky than computing what is necessary on the fly.

> +# don't recreate a workdir over an existing directory, unless it's empty
> +if test -d "$new_workdir"
>  then
> -	die "destination directory '$new_workdir' already exists."
> +	if test $(ls -a1 "$new_workdir/." | wc -l) -ne 2

I wondered if -gt instead of -ne is safer just in case what the
description of "-A" alludes to, i.e. "ls -a" may not have ".." in
its output, happens.

But that would not matter.  If you are on such a filesystem and have
a directory with a single file, you will see two entries in "ls -a"
(one "." and the other the sole file) and mistake it as an empty
directory whether you use -ne or -gt anyway, so -gt is not making it
safer anyway.  So let's go with this version.

> +	then
> +		die "destination directory '$new_workdir' is not empty."
> +	fi
> +	cleandir="$new_workdir"/.git
> +else
> +	mkdir -p "$new_workdir" || failed
> +	cleandir="$new_workdir"
>  fi
>  
> -# make sure the links use full paths
> -git_dir=$(cd "$git_dir"; pwd)
> +cleanup () {
> +	rm -rf "$cleandir"
> +}

Aversion to turning $cleandir to an absolute path?  Why?

You may have avoided a problem by removing "cd" below in the current
code, but I do not think it is a good future-proofing.  If you make
sure $cleandir is absolute, then you would not have to be even
worried about other people breaking that assumption "this script
will never let the trap hit while it cd to other places".

> -# now setup the workdir
> -cd "$new_workdir"
>  # copy the HEAD from the original repository as a default branch
> -cp "$git_dir/HEAD" .git/HEAD
> -# checkout the branch (either the same as HEAD from the original repository, or
> -# the one that was asked for)
> -git checkout -f $branch
> +cp "$git_dir/HEAD" "$new_workdir"/.git/HEAD || failed
> +
> +# the workdir is set up.  if the checkout fails, the user can fix it.
> +trap - $siglist
> +
> +# checkout the branch (either the same as HEAD from the original repository,
> +# or the one that was asked for)
> +git --git-dir="$new_workdir"/.git --work-tree="$new_workdir" checkout -f $branch

These uses of --git-dir/--work-tree look somewhat funny.  You want
to say "I want to run checkout in that $new_workdir", so say it in a
more direct way, i.e.

    git -C "$new_workdir" checkout -f "$branch"

perhaps?

Thanks.
