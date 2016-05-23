From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log: invert --author and --committer
Date: Mon, 23 May 2016 10:11:16 -0700
Message-ID: <xmqqmvngaedn.fsf@gitster.mtv.corp.google.com>
References: <CAP=KgsSdX3pCRzeUVobrFWVGOGGSrwkO0MjFhUWruiajAxn38Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Mon May 23 19:11:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4tO0-0004Dm-Qk
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 19:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbcEWRLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 13:11:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752170AbcEWRLT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 13:11:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EDFD71BAE6;
	Mon, 23 May 2016 13:11:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S5HgPT5mUMBd+Isb50yseZ5nx9w=; b=usrQk4
	ofuuHcLli9VHC9DnrmO+AaD5MU1FGJ9fTB7NNgS+FtXqaUFpW0PH1hzL9/NlCXPO
	gnS3NbYORCBqWSQnhp937EY6xzYqOEcxzjJhjEDLH+MNphPY9sH+NIbT+tRieQRE
	JLhy9j4kCmjkUNgtUovjqyj4bw5oH1K+Wb9lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AK1UD+WrxFteaEDpbvdHNAAFAwb+YbeY
	piAHna6rbuET5MgQK07Q9JKjFqZFBKEsA6dYl7SGhBeDoBdU1Nwrd9gGqFcalhQO
	dYnqFbwFKyiy/BuVdiku6iYzsbgj6cmt2z9aAHl/GnE4Bt8j84MO5jzDNpAojK3F
	IfmRjUaYIDs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E6E5B1BAE5;
	Mon, 23 May 2016 13:11:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74BA31BAE4;
	Mon, 23 May 2016 13:11:18 -0400 (EDT)
In-Reply-To: <CAP=KgsSdX3pCRzeUVobrFWVGOGGSrwkO0MjFhUWruiajAxn38Q@mail.gmail.com>
	(Per Cederqvist's message of "Mon, 23 May 2016 11:54:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D4973B0-2109-11E6-8870-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295339>

Per Cederqvist <cederp@opera.com> writes:

> We have a repository that mostly contains configuration data.
> This is updated by our continuous integration build system, but
> every once in a while there are also more interesting commits
> made by humans.
>
> For several years I have suffered in silence, wishing for a way
> to do something like
>
>     git log --author-not cibot
>
> Today a friend told me that you can actually list all commits
> except those made by cibot with this commandline:
>
>     git log --invert-grep --author cibot
>
> The documentation for --invert-grep should mention that it
> also inverts the meaning of --author and --committer.  Perphaps
> something like this would make sense?
>
>     /ceder

Yeah, the author/committer search piggy-backs the more generic "grep
in the log" machinery, but it is quite hidden and the document
failed to tell the end users that is what is going on.  Mentioning
that invert (or any tweak that works on the grep machinery) affects
author/committer search is a good idea.

Does "-i/--regexp-ignore-case" also need the same treatment?

> diff --git a/Documentation/rev-list-options.txt
> b/Documentation/rev-list-options.txt
> index 4f009d4..ae12687 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -70,7 +70,8 @@ endif::git-rev-list[]
>
>  --invert-grep::
>   Limit the commits output to ones with log message that do not
> - match the pattern specified with `--grep=<pattern>`.
> + match the pattern specified with `--grep=<pattern>`.  Also
> + affects `--author=<pattern>` and `--committer=<pattern>`.
>
>  -i::
>  --regexp-ignore-case::
