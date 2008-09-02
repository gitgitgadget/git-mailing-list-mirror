From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ignore trailing slash when creating leading directories
Date: Tue, 02 Sep 2008 13:36:38 -0700
Message-ID: <7vod36jne1.fsf@gitster.siamese.dyndns.org>
References: <20080902081909.GA2059@localhost>
 <7vk5dul7f5.fsf@gitster.siamese.dyndns.org>
 <20080902191322.GA11172@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Sep 02 22:38:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KacdM-00072w-Ky
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 22:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYIBUgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 16:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbYIBUgq
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 16:36:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbYIBUgq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 16:36:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E2C0571326;
	Tue,  2 Sep 2008 16:36:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F3CD671325; Tue,  2 Sep 2008 16:36:40 -0400 (EDT)
In-Reply-To: <20080902191322.GA11172@localhost> (Clemens Buchacher's message
 of "Tue, 2 Sep 2008 21:13:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DAE9C90E-792E-11DD-9F87-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94708>

Clemens Buchacher <drizzd@aon.at> writes:

> Unfortunately, if we simply add strerror to the error message, in place of
>
> fatal: could not create work tree dir 'path/'.
>
> the new version would print
>
> fatal: could not create work tree dir 'path/': File exists.
>
> which makes things worse IMO. We could of course strip trailing slashes in
> builtin-clone.c for now and revert that as soon as the cleanup patch is in,

I think the above statement is a wrong way to think about it.

This particular caller (and nobody else), even when it does not want the
"create all directories" behaviour, is giving such an instruction to the
existing function, without validating the user input.  That is a bug that
needs to be fixed, regardless of what the final semantics of c-l-d should
be, isn't it?

> but I think it's not worth the trouble.

What I think is not worth the trouble is, after fixing this caller, to
revert that fix, when/if we decide that c-l-d should strip trailing
slashes for all callers.

I am not saying the current semantics of c-l-d is optimal.  I am just
worried about breaking people's private patches that may depend on the
current behaviour.  It would be nice if we can clean it up without
breaking people, and after doing so, if somebody really want to have
"create all directories, the last one is also a directory", they can
invent a cleaner function that takes that insn as a separate paremeter,
not as an obscure "trailing slash means create all", which may be cute but
not clean nor clear at all, which is what c-l-d does.
