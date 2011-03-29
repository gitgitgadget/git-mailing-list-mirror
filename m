From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] notes: refactor display notes default handling
Date: Tue, 29 Mar 2011 15:02:37 -0700
Message-ID: <7vfwq5poua.fsf@alter.siamese.dyndns.org>
References: <20110329205307.GA30959@sigill.intra.peff.net>
 <20110329205727.GD23466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 00:03:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4h06-0006PK-0Q
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 00:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab1C2WCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 18:02:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab1C2WCw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 18:02:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C658E4D56;
	Tue, 29 Mar 2011 18:04:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ea7KS0nO2oOegp2Y1wUqSKESfoM=; b=S01U4rWCN7GIcMkMweAo
	PT9EKx4oCe3wjEa5CZovbsZMbiZLGHYNMmBl651rf9/viuVtbsxto0RHsV5GgMeH
	pXazsA2SOSU4fsuG/GjoUJzdXVPA9hBoXbcbUxFwvoOMqEBaMeyQVdER2rYa3AC+
	pzhvj0megwpwvAESpf6Y+Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=USmD+FOSP4qgXk0NfeYDS7D3Mgan9IvQGTfPaykLKyTW8q
	EJk0y6QNBxiUJ6vrbSZf4IsElUK15CngRa5kT16Kqy9zin8mWbDwxp0dDTgCZHR0
	m+sM2t5VUuePZbPPOOPE7k28X8ydDJ7PK1kgtCcmfCmycFAogIgxROnujQMm8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 70ED24D55;
	Tue, 29 Mar 2011 18:04:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 22A9E4D54; Tue, 29 Mar 2011
 18:04:26 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86A2DDBC-5A50-11E0-8EED-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170330>

Jeff King <peff@peff.net> writes:

> This is in preparation for more notes-related revision
> command-line options.
>
> The "suppress_default_notes" option is renamed to
> "use_default_notes", and is now a tri-state with values less
> than one indicating "not set".  If the value is "not set",
> then we show default refs if and only if no other refs were
> given.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ...
> diff --git a/revision.c b/revision.c
> index 24b89eb..315a7f4 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1368,10 +1370,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--show-notes")) {
>  		revs->show_notes = 1;
>  		revs->show_notes_given = 1;
> +		revs->notes_opt.use_default_notes = 1;
>  	} else if (!prefixcmp(arg, "--show-notes=")) {
>  		struct strbuf buf = STRBUF_INIT;
>  		revs->show_notes = 1;
>  		revs->show_notes_given = 1;
> +		if (revs->notes_opt.use_default_notes < 0)
> +			revs->notes_opt.use_default_notes = 1;

I didn't quite get this hunk while reading the series, but it is to keep
the current semantics that --show-notes=foo means "show foo in addition to
whatever the default one we are going to show anyway", and you will be
fixing that with a saner --notes in a later patch in the series.

I like it; thanks.
