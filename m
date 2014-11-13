From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: Add -f to force new-workdir in existing directory.
Date: Thu, 13 Nov 2014 13:21:59 -0800
Message-ID: <xmqqioiizthk.fsf@gitster.dls.corp.google.com>
References: <1415906213.32352.43.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Smith <paul@mad-scientist.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:23:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp1rh-0007SY-82
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934097AbaKMVXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:23:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934044AbaKMVXg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:23:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FE6C1D797;
	Thu, 13 Nov 2014 16:23:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WxAL52sUtg7XZXFK4ARJ5+L/i4Y=; b=oS7efP
	CvbRHkV+Y8Sn+ozO0WdKfEAAYA5eWg7pSPa5i7BSJHlmPBUNVSVKwQCVjdAQ7614
	XgdRtVIjT6kL3wAneBlwlxHCM6oPXfDExEK9jXC3REwWjGFCDK8uJRLQpCwJgDnj
	r7YFV9czl6Q0nxGhpyIXNLShTE+4/v+Wfm/Q8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E802YCaUAm7oNnbxYzYuPzxjSaSisol+
	MxVvKVEleV24WBotMB5HogO4JW2CWZ5wlvyxVr6ckGDqy9LNpb0PTTH61+TwumSg
	SKlVZNNgRJytuPqkQPp4JHLO/hYPN9M538J5qjTNPpIeSTGmhj9ky8I9MGfcGfit
	ls3MKW/KsSM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 462D71D793;
	Thu, 13 Nov 2014 16:23:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 336111D745;
	Thu, 13 Nov 2014 16:22:00 -0500 (EST)
In-Reply-To: <1415906213.32352.43.camel@mad-scientist.net> (Paul Smith's
	message of "Thu, 13 Nov 2014 14:16:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1AC461D4-6B7B-11E4-9F1F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Smith <paul@mad-scientist.net> writes:

> From: Paul Smith <paul@mad-scientist.net>
> Date: Thu, 13 Nov 2014 14:01:34 -0500
> Subject: [PATCH] git-new-workdir: Add -f to force new-workdir in existing directory.
>
> Signed-off-by: Paul Smith <psmith@mad-scientist.net>
> ---
>
> I have an environment I want to use new-workdir for, where the directory
> I need to use is pre-created for me and I'm dropped into that directory
> and I have no control over this (it's an automated build system).  The
> directory is empty but git-new-workdir still is unhappy about it.  I
> added a "-f" flag to allow the user to force git-new-workdir to continue
> even if the directory exists.  It still bails if there's a .git
> directory already, however.

Is there an easy way to check if the existing directory is really
empty?  For one thing, with your patched version, you may be by
mistake overwriting things when "git checkout -f" happens at the
end, even if there weren't any existing ".git/" directory there.
And if you can check that the existing directory is empty, you
perhaps may not even have to protect this behind a "-f" option.

>
>  contrib/workdir/git-new-workdir | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
> index 75e8b25..a4079c1 100755
> --- a/contrib/workdir/git-new-workdir
> +++ b/contrib/workdir/git-new-workdir
> @@ -10,11 +10,17 @@ die () {
>  	exit 128
>  }
>  
> -if test $# -lt 2 || test $# -gt 3
> +if test $# -lt 2 || test $# -gt 4
>  then
> -	usage "$0 <repository> <new_workdir> [<branch>]"
> +	usage "$0 [-f] <repository> <new_workdir> [<branch>]"
>  fi
>  
> +force=false
> +if [ x"$1" = x-f ]
> +then
> +    force=true
> +    shift
> +fi
>  orig_git=$1
>  new_workdir=$2
>  branch=$3
> @@ -51,7 +57,11 @@ fi
>  # don't recreate a workdir over an existing repository
>  if test -e "$new_workdir"
>  then
> -	die "destination directory '$new_workdir' already exists."
> +	$force || die "destination directory '$new_workdir' already exists."
> +	if test -e "$new_workdir/.git"
> +	then
> +		die "destination directory '$new_workdir/.git' already exists."
> +	fi
>  fi
>  
>  # make sure the links use full paths
