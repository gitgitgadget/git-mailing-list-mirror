From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] run-command: add new check_command helper
Date: Sun, 07 Apr 2013 10:52:13 -0700
Message-ID: <7vsj322ppu.fsf@alter.siamese.dyndns.org>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
 <1365320706-13539-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 19:52:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtlO-0001Xj-Ln
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934231Ab3DGRwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:52:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49939 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934183Ab3DGRwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:52:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 567C214069;
	Sun,  7 Apr 2013 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mrCQvMhyXDJ0kwlLymTSGCVUDsU=; b=LFcLMu
	616PPANI4y7QHHP990Gad0OaCirSDIhWdAOuQaORIlyYJvcwvI2Y9qu7z565uo0a
	Reh/Ebzhx3mZXutNdHxFTno5l9/qL2psPVotXrCo4zPAiEAXjoVEV9xZv4nFscfI
	IKeqwOxlpXOYrD6ppLk09x79pvXvtq01Y08Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xad0lam1qifYIvfLLuuOV/7QerfnyqrM
	DLbRMZgEgOxZWH46Gt7m04OQBJ5+O0kZKh/Zz4xfay3fVv2vgDKL1Qf84hjQLRhV
	Qo84TTpGbKPS/sDebc76/cyux6XsVYj7tCbyYT4vyuZ/JEbOkIktB4oPjzZL7xHr
	ZxGgVEZMkfk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A0F214068;
	Sun,  7 Apr 2013 17:52:15 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF46E14067; Sun,  7 Apr
 2013 17:52:14 +0000 (UTC)
In-Reply-To: <1365320706-13539-2-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 7 Apr 2013 01:45:05 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1A0C98E-9FAB-11E2-88EA-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220348>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> -	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
> -		;	/* nothing */
> +	/* First try the last status from check_command() */
> +	if (cmd && cmd->last_status.valid) {
> +		status = cmd->last_status.status;
> +		waiting = pid;
> +	} else {
> +		while ((waiting = waitpid(pid, status, 0)) < 0 && errno == EINTR)
> +			;	/* nothing */

waitpid(pid, &status, 0), I presume.
