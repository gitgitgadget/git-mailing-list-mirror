From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Wed, 31 Oct 2007 02:14:40 -0700
Message-ID: <7vzlxzhchr.fsf@gitster.siamese.dyndns.org>
References: <1193593581312-git-send-email-prohaska@zib.de>
	<11935935812741-git-send-email-prohaska@zib.de>
	<1193593581114-git-send-email-prohaska@zib.de>
	<1193593581486-git-send-email-prohaska@zib.de>
	<11935935812185-git-send-email-prohaska@zib.de>
	<11935935822846-git-send-email-prohaska@zib.de>
	<11935935821136-git-send-email-prohaska@zib.de>
	<11935935823045-git-send-email-prohaska@zib.de>
	<11935935821800-git-send-email-prohaska@zib.de>
	<11935935823496-git-send-email-prohaska@zib.de>
	<11935935821192-git-send-email-prohaska@zib.de>
	<7vfxztm2dx.fsf@gitster.siamese.dyndns.org>
	<52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de>
	<7vejfcl8aj.fsf@gitster.siamese.dyndns.org>
	<F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de>
	<7v8x5jiseh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 10:15:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In9fO-0002Fw-6O
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 10:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbXJaJOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 05:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753820AbXJaJOs
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 05:14:48 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:49243 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757AbXJaJOr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 05:14:47 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EF7D42EF;
	Wed, 31 Oct 2007 05:15:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 73CC68FA3F;
	Wed, 31 Oct 2007 05:15:04 -0400 (EDT)
In-Reply-To: <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 31 Oct 2007 01:45:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  1. Error on the sending side.  The ref parameters given to
>     git-push were bogus, or they were good commits but they were
>     not fully connected to the commits the other side has
>     (i.e. local repository corruption).  pack-objects will abort
>     and no remote (nor local tracking ref that tracks what we
>     pushed to the remote) would be updated.  This should be
>     "most severe" in _any_ workflow, so I do not mind calling
>     this "fatal".

By the way, as git-push allows an arbitrary SHA-1 on the left
hand side of a refspec, you can have the above error without a
corrupted repository.  Here is how.

 * You run git-fetch from elsewhere.  It is a small fetch and we
   decide not to keep the pack (iow, run unpack-objects instead
   of index-pack on the local side).  Or the fetch is over dumb
   transport that walks commits one-by-one.

   This git-fetch is interrupted.  We do _not_ update any refs
   in such a case, but we do not eradicate loose objects that
   were downloaded.  They stay dangling.

 * You push one of the commits downloaded above.  I.e. it is
   not connected to any of your ref.
