From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] receive-pack: receive.denyDeleteCurrent
Date: Mon, 09 Feb 2009 13:38:28 -0800
Message-ID: <7veiy7thnv.fsf@gitster.siamese.dyndns.org>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com>
 <1234170565-6740-2-git-send-email-gitster@pobox.com>
 <1234170565-6740-3-git-send-email-gitster@pobox.com>
 <1234170565-6740-4-git-send-email-gitster@pobox.com>
 <20090209185310.GB27037@coredump.intra.peff.net>
 <20090209192210.GD27037@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:40:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdrI-0001x4-8c
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 22:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826AbZBIVig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 16:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbZBIVig
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 16:38:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbZBIVif (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 16:38:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 476129822E;
	Mon,  9 Feb 2009 16:38:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 20F4D9822D; Mon,
  9 Feb 2009 16:38:30 -0500 (EST)
In-Reply-To: <20090209192210.GD27037@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 9 Feb 2009 14:22:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 008C27C4-F6F2-11DD-B6BB-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109137>

Jeff King <peff@peff.net> writes:

> Should the denyCurrentBranch code be triggering at all on a deletion?
>
> That is, if I have:
>
>   [receive]
>     denyCurrentBranch = refuse
>     denyDeleteCurrent = ignore
>
> should such a deletion be refused or allowed?

I think denyCurrentBranch means do not touch the currently checked out
branch, so 'refuse' there should trump whatever denyDeleteCurrent says as
long as the repository has a work tree.

Perhaps the logic needs to be restructured to:

	if (the push affects the current branch) {
		if (in a repository with a work tree) {
                        decide if we want to refuse or allow;
                	decide what message to issue;
		}
		if (deletion and we decided not to refuse) {
                	decide if we want to refuse or allow;
                        decide what message to issue;
                }
                give message(s), possibly with a paragraph break in between;
                if (refuse)
                	refuse;
	}
