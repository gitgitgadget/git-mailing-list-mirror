From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset: unbreak hard resets with GIT_WORK_TREE
Date: Wed, 30 Dec 2009 09:54:54 -0800
Message-ID: <7v8wck2vpt.fsf@alter.siamese.dyndns.org>
References: <1a04eebf0912282247p6975a96el8076cb39378bd104@mail.gmail.com>
 <fcaeb9bf0912290038u77a5e83cqe2f3cbfab05af263@mail.gmail.com>
 <20091229200426.6117@nanako3.lavabit.com>
 <fcaeb9bf0912290336m69303c3es8138c4e6497b801a@mail.gmail.com>
 <1a04eebf0912291309u7a222d9ch7e0926d30a5899b7@mail.gmail.com>
 <20091229215015.GA1529@coredump.intra.peff.net>
 <20091230084702.GA19649@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Fyn Fynn <fynfynn@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 18:55:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ2lT-0008Vg-JK
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 18:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbZL3RzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 12:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbZL3RzL
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 12:55:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbZL3RzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 12:55:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D52338BEAE;
	Wed, 30 Dec 2009 12:55:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Lp4tCAvaOcwvixTwSx1bOxGMKMY=; b=roxBgoggOo7SDnn65xpT2vz
	00ZvsqVlUmkcGdv5ZlzA2O7SKojU0nRhVSMDK0t+VKj/80WLPhlyGA7BVRWYtxCT
	D+bZLa3vU0pp5y6AyBH2i7g08FFTa9/t9V3K5aKufIdPIGqhfvvTFZ/WmE7/W9Bo
	U3p0OKk7T+pBN6pdkZ6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=O1UEMU1cUPirPcgrYOyCgNDJoSlKeEUPhG0SBe2C+5KCWhCVn
	a3vxc6/9xG1hHva5RZ2Ap2xcsN4DUs6uVg0vLY8TEXbpbfwQy4G/GsuKyZU4uwAc
	oR9zZ48PZ8xWqEhgkshFt/ETtEdXfOhXC30B8oXCCDam5wGFfv8WBS88Co=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AB028BEAC;
	Wed, 30 Dec 2009 12:55:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E65E8BEAA; Wed, 30 Dec
 2009 12:54:55 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 745593F6-F56C-11DE-8431-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135910>

Jeff King <peff@peff.net> writes:

> Commit 952dfc6 tried to tighten the safety valves for doing
> a "reset --hard" in a bare repository or outside the work
> tree, but accidentally broke the case for GIT_WORK_TREE.
> This patch unbreaks it.
>
> Most git commands which need a work tree simply use
> NEED_WORK_TREE in git.c to die before they get to their
> cmd_* function. Reset, however, only needs a work tree in
> some cases, and so must handle the work tree itself. The
> error that 952dfc6 made was to simply forbid certain
> operations if the work tree was not set up; instead, we need
> to do the same thing that NEED_WORK_TREE does, which is to
> call setup_work_tree(). We no longer have to worry about dying
> in the non-worktree case, as setup_work_tree handles that
> for us.

Sounds very sane to me.  Thanks.
