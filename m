From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] config: make git_config_set die on failure
Date: Mon, 01 Feb 2016 11:10:33 -0800
Message-ID: <xmqqzivkutzq.fsf@gitster.mtv.corp.google.com>
References: <1454324394-854-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Mon Feb 01 20:10:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQJs4-0000O0-Vz
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 20:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbcBATKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 14:10:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752978AbcBATKf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 14:10:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC16440994;
	Mon,  1 Feb 2016 14:10:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NhlvELyZmg11a7i+oSanXGlEYjo=; b=kx+bIZ
	yJB9nG/mOiD4pphdD2n0Pofk9gzyfLujXzV+4iJodNB10ZnLjm+9OHWLUgyASGES
	86INgm+dQsyR3orxcG8E8UMMWj1Ay5f1aWf7HQuaHSqnl1ruJY9xkYUEuHbn0yeZ
	fUY+tZ90JjJnkK39rWui5CcpNiVaX08AGZV/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k4sUR0IFtE1FXCyFn30zA4A+4z5bHUSg
	sqfXnKITwC3inKPiYxo4hLNZyaApANvNlWRAgLyVIfde9GP/kwNbHxqIhIqbP3eb
	p5Gwjbm/SI4q/l6Kx3xl6pHYMc+GgsVsKa36ulq1ehfAWfPbzAV0SuNKfVqOVHJ3
	svQ8IEtRvyI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A41A940993;
	Mon,  1 Feb 2016 14:10:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 280424098F;
	Mon,  1 Feb 2016 14:10:34 -0500 (EST)
In-Reply-To: <1454324394-854-1-git-send-email-ps@pks.im> (Patrick Steinhardt's
	message of "Mon, 1 Feb 2016 11:59:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7824A5AA-C917-11E5-8753-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285209>

Patrick Steinhardt <ps@pks.im> writes:

> Furthermore, I do think it's more explicit what the functions are
> doing when there is a 'or_die' suffix. Without this suffix it may
> be unexpected that the functions simply abort the program
> whenever an error occurs.

That largely depends on what you are used to see.  Many internal API
functions do "if we cannot do this, die" without or_die suffix.

As the endgame state, I'd find it far more preferrable to see a
function that dies without _or_die(), while allowing outlier callers
to call the _gently() variant to do their own clean-up [*1*].

How we get to that endgame is a different matter.  It is a viable
approach like you did in the original series to first temporarily
introduce _or_die() and convert the current callers in small chunks.
The second step would be to rename git_config_set() and friends that
do not die to hae _gently() suffix, and update the remaining callers
to call them.  At that point, nobody calls git_config_set(), so we
can drop the _or_die() suffix, which would lead us to the endgame
state.

But because we are talking about only a very small number of
callers, I think either is OK.

Thanks.


[Footnote]

*1* Another consideration while talking about a transition like this
    is what would happen in topics in flight (either in my tree
    above 'next' or people privately are working on).  New callsites
    they added expecting git_config_set() to return error would have
    to be adjusted to call _gently() variants, and we need to catch
    such sites somehow.  In this partcular transision, it can easily
    be done and you've done so already by making the functions
    return no value, so anybody who checked their return values
    would be flagged by the compiler.
