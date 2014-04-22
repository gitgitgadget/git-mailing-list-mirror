From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] merge: enable defaulttoupstream by default
Date: Tue, 22 Apr 2014 12:53:50 -0700
Message-ID: <xmqqmwfd3zu9.fsf@gitster.dls.corp.google.com>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
	<1398039454-31193-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 21:54:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcglU-0002SM-OV
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 21:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757AbaDVTx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 15:53:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42066 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756731AbaDVTxz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 15:53:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A11C77F356;
	Tue, 22 Apr 2014 15:53:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ujPk0y2RF1X9jgYeYDTdwFzfgLM=; b=ZwPqnV
	Ovvrliqbppjt+JfP03a6x2vhDWqDozljgAKxyndeksT3Qin+NPMqigJQoevRSp7A
	lAu7O7T46l0DrIzunNjvRxqOATseslLEJtgkkSInbBzv3IrWqcmNZnVITWJXWEXo
	q3u5iqeuzk1ZYZBSFN1swG728En38GMfTni1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oh/pXhixA80DLJ8K5QFvtS3kNzkHvnen
	yKqtdtQFpvVcxOtM7zB1GW1DD8Ygcog4O3vJT+cgjwrh09sRzzJN39c/QccdswFO
	UoD3+RLtSpwM6BB8pMek7GWQJvesVRYY0CaGeyXlP1q4KMuZZpS2D2n+vQ391qDV
	EM0k9BH1SgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 892FF7F353;
	Tue, 22 Apr 2014 15:53:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDAFF7F34C;
	Tue, 22 Apr 2014 15:53:51 -0400 (EDT)
In-Reply-To: <1398039454-31193-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 20 Apr 2014 19:17:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D4046A9C-CA57-11E3-9619-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246778>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There's no point in this:
>
> % git merge
> fatal: No commit specified and merge.defaultToUpstream not set.
>
> We know the most likely scenario is that the user wants to merge the
> upstream, and if not, he can set merge.defaultToUpstream to false.

And a new possible failure case is when there is no upstream defined
for the current branch, which gets perfectly good new error message:

    $ git merge
    fatal: No remote for the current branch.

So I think this is good.  We want to protect this with a new test,
no?

Will queue as-is for now.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-merge.txt | 5 ++---
>  builtin/merge.c             | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index a3c1fa3..cf2c374 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -101,9 +101,8 @@ commit or stash your changes before running 'git merge'.
>  	Specifying more than one commit will create a merge with
>  	more than two parents (affectionately called an Octopus merge).
>  +
> -If no commit is given from the command line, and if `merge.defaultToUpstream`
> -configuration variable is set, merge the remote-tracking branches
> -that the current branch is configured to use as its upstream.
> +If no commit is given from the command line, merge the remote-tracking
> +branches that the current branch is configured to use as its upstream.
>  See also the configuration section of this manual page.
>  
>  
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 66d8843..1fc9319 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -63,7 +63,7 @@ static int verbosity;
>  static int allow_rerere_auto;
>  static int abort_current_merge;
>  static int show_progress = -1;
> -static int default_to_upstream;
> +static int default_to_upstream = 1;
>  static const char *sign_commit;
>  
>  static struct strategy all_strategy[] = {
