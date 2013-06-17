From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] status: do not depend on rebase reflog messages
Date: Mon, 17 Jun 2013 10:54:56 -0700
Message-ID: <7vr4g0ei6n.fsf@alter.siamese.dyndns.org>
References: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
	<1371372316-16059-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 19:55:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uode1-0008Aq-Jr
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 19:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118Ab3FQRzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 13:55:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab3FQRy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 13:54:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DB22280FF;
	Mon, 17 Jun 2013 17:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=wUtws6FNw1xVbP/GpgMKTZZA7Rs=; b=xPPqcAjlHxPleezhaPzK
	TTqVYzEeAbIph7uJjiK0j+DWTD5osYQMm60AJMu+88ppO+Zp3kD1CmJgX2/kvVsD
	wl56t8XLEiCU32c64B5hc+hfXfvm+dNe2/olYgRb3psf4f82jC6kpGM/Ilrpq+iT
	+Z3l+iu+y8RMsqHIpLVmEjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=P4wsFawTo05v6npq5/MzFmisKtlypNlqBDhKGe/j44b7Hg
	+9zbTIRKx8uXE/r8bH23AQ7MXAZVTmagv8jMeIyh/4GkEUanQqaPxxs41DkRGOp6
	zP4K+EA/H69va/ZX+D5cKvlVvwYDpnE++7axsrWVKUwYC0wx7a+biWGbnVspU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D794280FD;
	Mon, 17 Jun 2013 17:54:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D53AA280F9;
	Mon, 17 Jun 2013 17:54:57 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0626D4DA-D777-11E2-A901-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228091>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index bf08d4e..739624e 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -188,10 +188,9 @@ test_expect_success 'status when rebasing -i in edit mode' '
>  	export FAKE_LINES &&
>  	test_when_finished "git rebase --abort" &&
>  	ONTO=$(git rev-parse --short HEAD~2) &&
> -	TGT=$(git rev-parse --short two_rebase_i) &&
>  	git rebase -i HEAD~2 &&
>  	cat >expected <<-EOF &&
> -	# HEAD detached from $TGT
> +	# rebase in progress; onto $ONTO
>  	# You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
>  	#   (use "git commit --amend" to amend the current commit)
>  	#   (use "git rebase --continue" once you are satisfied with your changes)

This hunk (and others that used to use $TGT) shows that the original
test was depending too much on the implementation detail (i.e. that
rebase/rebase-i internally uses checkout to affect the reflog, making
the info shown as "detached from/at" not useful during "rebase").
This step may have started as a workaround against the fallout from 6/6,
but I think this is a good change by itself independent of "checkut -"
fix, which is the main topic of this series.

> diff --git a/wt-status.c b/wt-status.c
> index 2511270..85a00f1 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1174,7 +1174,10 @@ void wt_status_print(struct wt_status *s)
>  			branch_name += 11;
>  		else if (!strcmp(branch_name, "HEAD")) {
>  			branch_status_color = color(WT_STATUS_NOBRANCH, s);
> -			if (state.detached_from) {
> +			if (state.rebase_in_progress || state.rebase_interactive_in_progress) {
> +				on_what = _("rebase in progress; onto ");
> +				branch_name = state.onto;

The part after "||" is what I missed in the "how about an approach
along this line" patch.

Good job.

> +			} else if (state.detached_from) {
>  				unsigned char sha1[20];
>  				branch_name = state.detached_from;
>  				if (!get_sha1("HEAD", sha1) &&
