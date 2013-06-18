From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] sh-setup: make die_with_status clear GIT_REFLOG_ACTION
Date: Tue, 18 Jun 2013 08:13:34 -0700
Message-ID: <7vbo738na9.fsf@alter.siamese.dyndns.org>
References: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
	<1371557670-12534-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 17:13:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoxbL-0003i6-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 17:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563Ab3FRPNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 11:13:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932413Ab3FRPNh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 11:13:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EB2C269E1;
	Tue, 18 Jun 2013 15:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9rxuqvaCUdJ8naF7RTYyjzm1zJk=; b=Gg+/8e
	Z/S2zRglPN+b+lUdw+tzKolk6Fd4/UYPJb2kfwCnwD3G43TFXm3UiY3hlGXooC1u
	WH6b3hXtwYsazS+P0sUETDN0sS71LwIwXAoHsE2Iv2ZO0WIslttp24+M+KO9CFd6
	1LGa3H7lBRyjjcF3fGhS+c0gBtRZDYY8BRQhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wh/E2FFz6Y0F388Qslo37ihlEhsfJ+vO
	PzCo79qxQk0Y8IxMOh+MAWS0wyYhLNiT/kbWiz/DlpizTOOfCT8qlNEVRugBR3Xg
	dVHHIAOkm+ZA5nqMaYqnLDbwNz68cUEDtnF33h/uLS4YQSHn933hNKkEWLDUnyMf
	3KI0U7pAMJQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 429E9269E0;
	Tue, 18 Jun 2013 15:13:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 810C5269DC;
	Tue, 18 Jun 2013 15:13:36 +0000 (UTC)
In-Reply-To: <1371557670-12534-7-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 18 Jun 2013 17:44:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A608C866-D829-11E2-BF8C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228249>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Several callers set GIT_REFLOG_ACTION via set_reflog_action(), but
> nobody unsets it, leaving a potentially stray variable in the
> environment.  Fix this by making die_with_status() unset it.

I am totally lost.

 - You can set your own environment variables, and they will affect
   your child processes' environment, but only _before_ you spawn
   them.  After you spawn them, changes to your environment will not
   affect your child processes' environment.

 - There is no mechanism for you to affect environment of your
   parent process.

 - And we are exiting the process by calling die_with_status.

Whose environment are you trying to affect (or not affect) with this
change?  This will not affect your children, this will not affect
your parent, and this will not help you, either.

Puzzled.

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-sh-setup.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 2f78359..3297103 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -51,6 +51,7 @@ die () {
>  }
>  
>  die_with_status () {
> +	export GIT_REFLOG_ACTION=
>  	status=$1
>  	shift
>  	echo >&2 "$*"
