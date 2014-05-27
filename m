From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 3/3] tests: Add 'rebase -i commits that overwrite untracked files'
Date: Tue, 27 May 2014 11:47:23 -0700
Message-ID: <xmqqr43ff490.fsf@gitster.dls.corp.google.com>
References: <533C913C.20106@cisco.com> <5383BDF0.2040904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Phil Hord <hordp@cisco.com>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 20:47:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpMPM-0003Yh-OM
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 20:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbaE0Sr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 14:47:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60961 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbaE0Sr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 14:47:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E2881A61A;
	Tue, 27 May 2014 14:47:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qQNISm4/cpnDtRWGA6opITfxFgk=; b=Zy3KRL
	/67mrfCKAldFQFjbiLH8osjJQo3rGmm6AiqVcaxwcTXu92mn0OYwHX5mhh5gglKZ
	KFtb0JTZN2BMfHRrIRVRGLuRNgJ4yrr4qWNWMNh1pzzK9Xbmx3lHX1EQrOWX1xuI
	KzOXFAmS98lPz9hPJtsR18aDf59dOnuR5gAho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JDizQBh2jYhZ/QBIbpeV9i0xfzU6kZuW
	nWQzCyW5eGF3PlletauxCXqoBgLD1cFhVER41p2o/3SeJyCiID5Q77RXxyU+Dqse
	NVCMu1g58ROKY4Pj9C4Go2I+Zn1kEEPhuag5yEdeNLlDi3mFGnw4S04sDSKY8u04
	Bz9hXPLq7UU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 02F361A619;
	Tue, 27 May 2014 14:47:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B507B1A614;
	Tue, 27 May 2014 14:47:24 -0400 (EDT)
In-Reply-To: <5383BDF0.2040904@gmail.com> (Fabian Ruch's message of "Tue, 27
	May 2014 00:19:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 57EF5884-E5CF-11E3-853B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250186>

Fabian Ruch <bafain@gmail.com> writes:

> If a todo list will cherry-pick a commit that adds some file and the
> working tree already contains a file with the same name, the rebase
> sequence for that todo list will be interrupted and the cherry-picked
> commit will be lost after the rebasing process is resumed.
>
> This is fixed.
>
> Add as a test case for regression testing to the "rebase-interactive"
> test suite.
>
> Reported-by: Phil Hord <hordp@cisco.com>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  t/t3404-rebase-interactive.sh | 44 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 50e22b1..7f5ac18 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1074,4 +1074,48 @@ test_expect_success 'short SHA-1 collide' '
>  	)
>  '
>  
> +test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
> +	git checkout branch2 &&
> +	set_fake_editor &&
> +	FAKE_LINES="edit 1 2" git rebase -i A &&
> +	test_cmp_rev HEAD F &&
> +	test_path_is_missing file6 &&
> +	touch file6 &&

Unless you care deeply about updating the timestamp file6 has, use
of "touch" is misleading.  Use something like this instead:

	>file6 &&

when it is the existence of "file6" that you care about.

Thanks.
