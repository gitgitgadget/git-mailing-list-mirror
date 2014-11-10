From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore submodules
Date: Mon, 10 Nov 2014 11:32:34 -0800
Message-ID: <xmqq389qam25.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de>
	<xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
	<xmqq1tpbawqe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 20:32:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnuhg-0006z5-0S
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 20:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbaKJTcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 14:32:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62489 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752262AbaKJTch (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 14:32:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA5F61DED5;
	Mon, 10 Nov 2014 14:32:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8dLVcZ1Ahyil44Xgkv8ZdaAkaw8=; b=wM9sxY
	B4CCwMlOlIa+UvQBoWE96cWFLVz5TOWdwQ1qxSup1PrlVWHjXtca91dke6be9O3f
	n+9LeWmBdsUtuiXHqwusn9qcdUPaQtMlvJ0+XOrV74dIsvZmff7wukEIM3xivx9r
	AGMuVOxpco2vmi0HUlFm2iPb6Sg7Fppz/C0lE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wUmtEgMiuugVunhisHPXMaldQ0NmQ5Hr
	qKzRmYHcabOSX2CRg283vq4nYqv5Q2v11FqTytGJoeEwnAHJSYR+aamKAhMPDtXz
	4l5qAiBO4zNNYQVramLIUzSDDyG3XGQodfcG8XWEJdkjsJcurFh3tXu22GFJDnRF
	C5kMbzS77c8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D17161DED4;
	Mon, 10 Nov 2014 14:32:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 410AF1DED3;
	Mon, 10 Nov 2014 14:32:36 -0500 (EST)
In-Reply-To: <xmqq1tpbawqe.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 10 Nov 2014 07:42:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 531CF496-6910-11E4-87EF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Dying when "update-index --refresh" signals a difference is an
> attempt to mimic #1, but it is in line with the spirit of the reason
> why a user would want to use updateInstead, I think.  The situation
> is more like the person who pushed into your repository from
> sideline did a "checkout -B $current_branch $new_commit" to update
> the HEAD, the index and the working tree, to let you pretend as if
> you based your work on the commit he pushed to you.
>
> While you still need to error out when your local work does not
> satisfy the cleanliness criteria #3 above, I do not think you would
> want to stop the operation when "checkout" would not fail, e.g. you
> have a local change that does not interfere with the update between
> the two commits, with this one:
>
> +	if (run_command(&child))
> +		die ("Could not refresh the index");
>
> When refreshed the index successfully, we signal that there were
> differences between the index and the working tree with a non-zero
> return value, so "Could not refresh" is not quite right, either.

Just to make sure.  I am *not* saying that you do not need to run
"update-index --refresh".  It is necessary before running read-tree
to avoid false dirtyness, so you do need to run it.

I am only saying that it is too strict to fail the operation when
the command reports that you have a local modification in the
working tree.

> But this one that checks the exit status from two-tree read-tree
>
> +	if (run_command(&child))
> +		die ("Could not merge working tree with new HEAD.  Good luck.");
>
> is checking the right condition, i.e. cleanliness #3.  The
> disposition should not be "die", but an error return to tell the
> caller to abort the push as we discussed earlier.
