From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git status: Show detailed dirty status of submodules in
 long format
Date: Sat, 06 Mar 2010 21:41:14 -0800
Message-ID: <7vtyssadtx.fsf@alter.siamese.dyndns.org>
References: <4B90EB19.2070300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 07 06:41:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No9F5-0000mz-T5
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919Ab0CGFlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 00:41:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab0CGFlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:41:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5F8F9F7A6;
	Sun,  7 Mar 2010 00:41:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qMvkPjw73V1bfcPEoaUoSZHDjXY=; b=p44Ui3
	k4/L/YPKAoP6nG4fcZCXsiKEABnPIsjqweQ5lQyEghXI93q97zD+uQIdEDME/DmT
	azSMEakfZPCbDUjtHefsrgbTcJ90uP5OeZ+yhs2ivgqetLRyB0vIIp23zRGrx0i3
	mo7ZDy1G2tKPRMmSEufE073N5GO/c56khf1po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gO+/B+neslQBmtCGBCJ4sDlmYzTAfgeV
	23v2ez2TzEUr3QUrL2l006yO89xb2aaf0YsNw1reMbMc9xi+AHf02sc1bdKrnCwS
	6CtENdxbLySOU1Rpu/gDEouDc5KPs6fkps4rthrYbo/+65zcnIr9/x5wt28NnInS
	64E6Y+eVNuI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E47E9F7A4;
	Sun,  7 Mar 2010 00:41:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8E809F7A2; Sun,  7 Mar
 2010 00:41:15 -0500 (EST)
In-Reply-To: <4B90EB19.2070300@web.de> (Jens Lehmann's message of "Fri\, 05
 Mar 2010 12\:29\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E39C852-29AC-11DF-827C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141668>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #   (commit or discard the untracked or modified content in submodules)

Can we do this additional line only when there is a submodule involved in
the changes?  The whole point of "collect first and then print" is so that
we can compute things like "has_deleted" before starting to emit any
output to intelligently give an appropriate advice message, and it feels
silly to say submodules to users who don't even use any submodule.  I have
a suspicion that the majority of users may not even know nor care what a
submodule is.

> I am not so proud of DIFF_FORMAT_DIRTY_SUBMODULES, the new flag i
> introduced to tell run_diff_files() it should gather the information
> needed even if we don't want patch output. It isn't a "format" per se,
> but i couldn't come up with a better way to do this. Opinions?

It indeed does sound like DIFF_OPT_* than DIFF_FORMAT_*.  In any case, we
probably would want to have a small helper function that encapsulates this
part that appear twice:

	changed = ce_match_stat(ce, &st, ce_option);
	if (S_ISGITLINK(ce->ce_mode)
	    && !DIFF_OPT_TST(&revs->diffopt, IGNORE_SUBMODULES)
	    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH)
		|| (revs->diffopt.output_format & DIFF_FORMAT_DIRTY_SUBMODULES))) {
		dirty_submodule = is_submodule_modified(ce->name);
		if (dirty_submodule)
			changed = 1;
	}

to something like

	changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
        					ce_option, &dirty_submodule);

and the implementation of match_stat_with_submodule() a bit more heavily
commented so that people will know what it is for.
