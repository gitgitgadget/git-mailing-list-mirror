From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rebase: guard against missing files in read_basic_state()
Date: Thu, 13 Jun 2013 15:29:36 -0700
Message-ID: <7vy5adskz3.fsf@alter.siamese.dyndns.org>
References: <1371139573-28047-1-git-send-email-artagnon@gmail.com>
	<1371139573-28047-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 00:29:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnG1X-00083W-NZ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 00:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060Ab3FMW3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 18:29:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535Ab3FMW3j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 18:29:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56006272A5;
	Thu, 13 Jun 2013 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G6mZN2P2XCEzPm7hZp69inoOQ1w=; b=UkA3Nu
	h26AyrISPmXzYKQn+gpaH4ZA9S6eWSQg/GfjbaxouY/03IY3NSgSr1ndTc4BcSQ6
	bJkKPniUKG0NrLfSPc2XWB8be17ZVG4nNbo6CYyj4gDbWctAZ6OdGybpTQ0w1ztt
	q0s45nW0CSliYmG2RaI8B62qCQMSQ1ARhQACo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K3LmltlZMwb2Ug+IgpJD8HwSljtX4b6y
	B6t56CbZpVM3B9p9dCAbKrlGebYHs7SZfukxtrwRxWE6zAAwKOKYx6CUA7qIBTLr
	RGoLkWR609DJkL3Ybw221mZt7EuSDb1q9Sv24FKmajVzmxEw5fDNvIkExbBYRXDq
	txDv6bS3c44=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CEF3272A3;
	Thu, 13 Jun 2013 22:29:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFC63272A0;
	Thu, 13 Jun 2013 22:29:37 +0000 (UTC)
In-Reply-To: <1371139573-28047-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 13 Jun 2013 21:36:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB40B8A6-D478-11E2-941F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227781>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

This does not affect correctness; i.e. head_name=$(cat that-file)
will error out if the file is missing, right?

A more troublesome is that nobody seems to check the return value of
this function.  If head-name, onto or orig-head is missing, is that
an error condition that should make the callers of read_basic_state
stop and refuse to proceed?

The way the && cascade is used seems to indicate that, but up to the
point where it sents $verbose. If and only if head-name, onto, orig-head
and quiet can be read in state-dir, verbose in state-dir is checked
and only then $verbose is set.

Martin, this seems to be from your series around early Feburary
2011.  Do you recall why these checks are cascaded this way?
I do not offhand think of a good reason.

> ---
>  git-rebase.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index d0c11a9..2122fe0 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -84,6 +84,8 @@ keep_empty=
>  test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
>  
>  read_basic_state () {
> +	test -f "$state_dir/head-name" &&
> +	test -f "$state_dir/onto" &&
>  	head_name=$(cat "$state_dir"/head-name) &&
>  	onto=$(cat "$state_dir"/onto) &&
>  	# We always write to orig-head, but interactive rebase used to write to
