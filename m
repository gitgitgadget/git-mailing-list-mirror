From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin-merge: avoid run_command_v_opt() for
 recursive
Date: Mon, 11 Aug 2008 13:03:24 -0700
Message-ID: <7vvdy7wc8j.fsf@gitster.siamese.dyndns.org>
References: <cover.1218374062.git.vmiklos@frugalware.org>
 <3db5bd9a8fa1fefb9bd188cc148db826b77fec12.1218374062.git.vmiklos@frugalware.org> <ea5b9868df7c17c55cd091b4408f08a310bed641.1218374062.git.vmiklos@frugalware.org> <7vhc9rxuc4.fsf@gitster.siamese.dyndns.org> <20080811190705.GQ18960@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 22:05:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSdd4-00024V-O5
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 22:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbYHKUDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 16:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbYHKUDc
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 16:03:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbYHKUDb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 16:03:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6341B55328;
	Mon, 11 Aug 2008 16:03:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8819C55325; Mon, 11 Aug 2008 16:03:26 -0400 (EDT)
In-Reply-To: <20080811190705.GQ18960@genesis.frugalware.org> (Miklos Vajna's
 message of "Mon, 11 Aug 2008 21:07:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9197D692-67E0-11DD-85F2-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91990>

Miklos Vajna <vmiklos@frugalware.org> writes:

> So I don't think there is a case when a die() inside merge-recursive
> would occur, but an other strategy would handle the merge properly.

Normal case is fine.

I was not worried too much about "the other strategy will" case, but isn't
the general structure of git-merge driver be:

    - do some set-up computation, and leave info in .git/
    - call strategy
    - depending on how it exits, perform further operation (such as
      writing out tree out of index and updating HEAD) using the info in
      .git it left before it called strategy, and clean up whatever was
      done in the first step (things like "drop the index lock"?).

Dying in the strategy and not allowing the clean-up was what I was worried
about.  If you can guarantee that you are not going to leave the
repository in a wedged state, calling merge-recursive internally is
perfectly fine, but the codepaths involved need to be carefully vetted for
that.
