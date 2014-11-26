From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-new-workdir: Don't fail if the target directory is empty
Date: Wed, 26 Nov 2014 13:55:02 -0800
Message-ID: <xmqq8uixpqyx.fsf@gitster.dls.corp.google.com>
References: <1417034308.23650.51.camel@homebase>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: paul@mad-scientist.net
X-From: git-owner@vger.kernel.org Wed Nov 26 22:55:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtkYM-0005vk-Dk
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 22:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbaKZVzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 16:55:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751114AbaKZVzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 16:55:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5E3B210DF;
	Wed, 26 Nov 2014 16:55:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tbgLsvNAiQX9JHs3ME8BAndpiEo=; b=F+uRik
	QTYxkSS5YTpGccHiybo2W80G8L4OzOKL9rPvUgInS1D7SfLHqEaY9anMRR6pCbr4
	YTZf4vtp7pKvyAOXcivd/s4l7UeWPjgcfxBpLttmio8JePwtNU43ERZ2uhJckvbM
	BHdL0lGYabOiflbwot1QehRLoFzokLAzKD1jY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w1JMFUxrmicWkq2u2ihLS6Pzk7ENX8oX
	B54tDI+IIVsNPsb/QI9nTfNfdBpcYkGmj8dfzxrPGExAUgqrsnHP2bsbUBWHNLq6
	BxthjPJv8FxwC+cwp9cDyRk/BSJlSDPewZLGukRGBudntdIoInvelr1o34sE7yBJ
	O4jrdVlrIy8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CFBF210DE;
	Wed, 26 Nov 2014 16:55:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19E50210DD;
	Wed, 26 Nov 2014 16:55:04 -0500 (EST)
In-Reply-To: <1417034308.23650.51.camel@homebase> (Paul Smith's message of
	"Wed, 26 Nov 2014 15:38:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0A1C348-75B6-11E4-8798-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260311>

Paul Smith <paul@mad-scientist.net> writes:

> Allow new workdirs to be created in an empty directory (similar to "git
> clone").  Provide more error checking and clean up on failure.
>
> Signed-off-by: Paul Smith <paul@mad-scientist.net>
> ---
>
> Hopefully this doesn't contain unwanted stylistic changes.

;-)

Unwanted, no, but unrelated yes.

>  
> +failed () {
> +	die "unable to create new workdir \"$new_workdir\"!"
> +}

Use '$new_workdir' instead to match the existing message below?

> -# don't recreate a workdir over an existing repository
> -if test -e "$new_workdir"
> +# make sure the links in the workdir have full paths to the original repo
> +git_dir=$(cd "$git_dir" && pwd) || exit 1
> +
> +# don't recreate a workdir over an existing directory, unless it's empty
> +if test -d "$new_workdir"
>  then
> -	die "destination directory '$new_workdir' already exists."
> +	if test $(ls -a1 "$new_workdir/." | wc -l) -ne 2
> +	then
> +		die "destination directory '$new_workdir' is not empty."
> +	fi
> +	cleandir="$new_workdir/.git"
> +else
> +	cleandir="$new_workdir"
>  fi

The comment in the original is somewhat misleading, but "test -e"
was "test -e" and not "test -d" to stop when an existing file was
given by mistake as $new_workdir, I think.  I do not know what
happens in the new code in that case.
