From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] rebase -i: don't error out if $state_dir already exists
Date: Tue, 23 Apr 2013 09:35:10 -0700
Message-ID: <7vd2tljjcx.fsf@alter.siamese.dyndns.org>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
	<1366725724-1016-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 18:35:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUgBg-0001ow-5B
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 18:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777Ab3DWQfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 12:35:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756118Ab3DWQfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 12:35:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD15119C58;
	Tue, 23 Apr 2013 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uZuEcI4brXMxm24fG6/Js6fmgmw=; b=xgeqEB
	QUU3bUpZ/HRlcvkT4y55AU0oIAzooEpjZEMyW31Ia/WNhD0YEd+lWOwUy4Tn3+8l
	GGKIW1MxGe1j4UhHj+qqRPpPaGTB8Rp2Uf9RdtSDG+GHnF6vE1LYnVxHcmYYCLxJ
	M6n000AePas3YHNt7oHMOmPdV0peIK/O8rYn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M39OmXXxlGMiBXswTUXVdjbloJ7rFVAx
	NPUYR+/K3NVwoPqqhkk4MCjuNsxpLTGr/Itm3QXdjChNptY+/x5pujcpIkxPTOYa
	9xchEGtWA+KfXU+mZSQQQkY+xO3QXAEa6rMLKxzBwsXHH7PnO0hArxOZnhbL5472
	4diEJZDuxKY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4A7919C55;
	Tue, 23 Apr 2013 16:35:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23D8819C54;
	Tue, 23 Apr 2013 16:35:12 +0000 (UTC)
In-Reply-To: <1366725724-1016-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 23 Apr 2013 19:31:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4EB22A0-AC33-11E2-8085-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222188>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Practically speaking, the only reason why a `mkdir $state_dir` would
> fail is because $state_dir already exists.  There is no problem in
> this case, and we can proceed as usual.

That was started as a cheap way to detect and avoid running the same
rebase -i while another one is already in progress, way back when we
did not have a separate "git-rebase--*backend*" scripts, I think.

If we have a separate safety measure to prevent it, lifting it may
be safe, but in a sane case, $state_dir should _not_ exist when we
start the command, and mkdir should _not_ fail to create it.

So I do not see why this change could be an improvement.  I would
understand it if some future changes may have already created the
state dir from a separate codepath (which may be an indication of a
poor design of integrating that separate codepath, but that is a
different matter) and mkdir needs to be turned into "mkdir -p" here,
but I do not think removal of "|| die" is warranted even in such a
case.

>  So, change the `mkdir` call
> to `mkdir -p`, and strip the `|| die`.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-rebase--interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 048a140..cc3a9a7 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -837,7 +837,7 @@ then
>  fi
>  
>  orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
> -mkdir "$state_dir" || die "Could not create temporary $state_dir"
> +mkdir -p "$state_dir"
>  
>  : > "$state_dir"/interactive || die "Could not mark as interactive"
>  write_basic_state
