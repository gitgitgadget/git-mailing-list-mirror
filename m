From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: use true parents for diff when walking reflogs
Date: Mon, 05 Aug 2013 12:16:01 -0700
Message-ID: <7vd2psj6dq.fsf@alter.siamese.dyndns.org>
References: <d6dadc4ab54d81490ca46bcfbd44a61be24f6eb7.1375524982.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>,
	Uwe =?utf-8?Q?Klei?= =?utf-8?Q?ne-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	"Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 05 21:16:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6QGR-0000yN-IP
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 21:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579Ab3HETQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 15:16:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754343Ab3HETQO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 15:16:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32E98369A6;
	Mon,  5 Aug 2013 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=WtDCaNlYMlvmFbRJ5eUYUsja04E=; b=V/j4JT+mzoCDLH2xY9/w
	vi0VkyjADAWbEowVbgpayb36J9q9i00uu+WIODt+787TP28U1J1YC47C+r7+//mh
	/th/JkfsuqF75pOK/VwquhjTJBBgS/GmJy4Gtd9jNsPJDJDAHNYKwW7L6L2ENj2/
	qqBdiaX0eok2SmiX9JQhaXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=WU2GD4MHLr+tap/xdpFeEtrL73jzS6ha4QmrLgVR0LAXwS
	Pkr40VqNoXqvK4yIscZ1ESSLFZc01rZa1op43x9fKQRY4pvsJhIP6KhGPSw3GSKs
	WjvbRuo6h4WfpT40nYossRd7vJz2nuV1OOs5GpiSxiyOyP+UwLk/kHWSq3kQM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26B14369A4;
	Mon,  5 Aug 2013 19:16:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ACE73699F;
	Mon,  5 Aug 2013 19:16:12 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E12BCA4-FE03-11E2-A28B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231691>

Thomas Rast <trast@inf.ethz.ch> writes:

> The reflog walking logic (git log -g) replaces the true parent list
> with the preceding commit in the reflog.  This results in bogus commit
> diffs when combined with options such as -p; the diff is against the
> reflog predecessor, not the parent of the commit.
>
> Save the true parents on the side, extending the functions from the
> previous commit.  The diff logic picks them up and uses them to show
> the correct diffs.
>
> We do have to be somewhat careful about repeated calling of
> save_parents(), since the reflog may list a commit more than once.  We
> now store (commit_list*)-1 to distinguish the "not saved yet" and
> "root commit" cases.  This lets us preserve an empty parent list even
> if save_parents() is repeatedly called.
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>
> Jeff King <peff@peff.net> wrote:
>> 
>> Your description (and solution) make a lot of sense to me. Another code
>> path that has a similar problem is the "-g" reflog walker. It rewrites
>> the parents based on the reflog, and the diffs it produces are mostly
>> useless (e.g., try "git stash list -p").
>> 
>> Should we be applying the same technique there?
>
> Good point.  This is how.  It applies on top of the other patch.

Thanks.

> It doesn't really help for 'git stash list -p', though, because
> stashes are merge commits.  Now they just don't show anything.
> could try 'git stash list -p -m', though.

Using --first-parent may be more convenient and useful.
