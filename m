From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-prompt.sh: Show where rebase is at when interrupted by a merge conflict
Date: Tue, 23 Apr 2013 08:08:50 -0700
Message-ID: <7vk3ntl1x9.fsf@alter.siamese.dyndns.org>
References: <1366720507-16504-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 17:09:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUeq3-0002FT-IZ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 17:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044Ab3DWPIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 11:08:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36036 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755856Ab3DWPIy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 11:08:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6F3918F69;
	Tue, 23 Apr 2013 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K1o4Py+qmf+OcO4OER+GW8I0/Tk=; b=Fhonnr
	9c59K4BpdkARtk/MkGIccFZ1nVNi/sn7/yJyusdIbdN3qKHjNs0MomISgalNyFNo
	ShFt/BB8XtAyyY6A4FY+DX1WuvG4A2OsuevPQlgufJ6CfUlvD2vrl2nKshiEEvp0
	dzMzfzaHb7IO2WC+V5OPQzSu4gZOHHJQe6l3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nD29DvytmpU3sQM66is7Qzxql5ynRHIJ
	NrQFZWCdaee7qPY8hwhZc5wCmPUkt8gyXLObX1ZamojmJ3IuWRgFgKdU/kwphfGn
	OTHTB1UXFUR7Sy2KDfBZQKuL/mDHZQAoN7DtC6Qz7Ekiw3ZTK0kbshdTfv54Hgvk
	N0ajiVkf92I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9E6518F68;
	Tue, 23 Apr 2013 15:08:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11FF018F64;
	Tue, 23 Apr 2013 15:08:51 +0000 (UTC)
In-Reply-To: <1366720507-16504-1-git-send-email-zoltan.klinger@gmail.com>
	(Zoltan Klinger's message of "Tue, 23 Apr 2013 22:35:07 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B55A8576-AC27-11E2-A3BF-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222172>

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

> When a rebase is interrupted by a merge conflict it could be useful to
> know how far a rebase has progressed and how many commits in total this
> rebase will apply. Teach the __git_ps1() command to display the number
> of commits so far applied and the total number of commits to be applied.
>
> Below is a sample output of the improved __git_ps1() command:
>   ((3ec0a6a...)|REBASE|2/5)
>
> In the example above the rebase has stopped at the second commit due to
> a merge conflict and there are a total number of five commits to be
> applied by this rebase.
>
> This information can be alredy obtained from the following files which are
> being generated during the rebase:
>     GIT_DIR/.git/rebase-merge/msgnum (git-rebase--merge.sh)
>     GIT_DIR/.git/rebase-merge/end    (git-rebase--merge.sh)
>     GIT_DIR/.git/rebase-apply/next   (git-am.sh)
>     GIT_DIR/.git/rebase-apply/last   (git-am.sh)
>
> 1) Modify git-rebase--interactive.sh to also create
>       GIT_DIR/.git/rebase-merge/msgnum
>       GIT_DIR/.git/rebase-merge/end
>    files for the number of commits so far applied and the total number of
>    commits to be applied.
> 2) Modify git-prompt.sh to read and display info from the above files
> 3) Update test t9903-bash-prompt.sh to reflect changes introduced by
>    this patch.
>
> Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
> ---

Nicely explained.  Felipe?  Szeder?  Comments?

>  contrib/completion/git-prompt.sh |   21 ++++++++++++++++-----
>  git-rebase--interactive.sh       |    5 +++++
>  t/t9903-bash-prompt.sh           |    6 +++---
>  3 files changed, 24 insertions(+), 8 deletions(-)
> ...
> -	printf " (b1|REBASE-i)" > expected
> +	printf " (b1|REBASE-i|1/1)" > expected

This makes me wonder if " (b1|REBASE-i 1/1)" may be easier on the
eyes.  Also it may not be a bad idea to add a new piece to this test
to show the state that is not "1/1" but something else.
