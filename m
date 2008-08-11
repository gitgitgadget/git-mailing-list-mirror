From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] merge-recursive: prepare merge_recursive() to be
 called from builtins
Date: Mon, 11 Aug 2008 12:53:51 -0700
Message-ID: <7vzlnjwcog.fsf@gitster.siamese.dyndns.org>
References: <cover.1218374062.git.vmiklos@frugalware.org>
 <3db5bd9a8fa1fefb9bd188cc148db826b77fec12.1218374062.git.vmiklos@frugalware.org> <20080811151303.GA11208@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:55:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSdTw-0006gn-VK
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbYHKTyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 15:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbYHKTyE
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:54:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbYHKTyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 15:54:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 395BC551DD;
	Mon, 11 Aug 2008 15:53:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C3228551D4; Mon, 11 Aug 2008 15:53:53 -0400 (EDT)
In-Reply-To: <20080811151303.GA11208@leksak.fem-net> (Stephan Beyer's message
 of "Mon, 11 Aug 2008 17:13:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3C8D6C8A-67DF-11DD-85F2-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91988>

Stephan Beyer <s-beyer@gmx.net> writes:

> Hmm, I have the long-run vision that we have a nice libgit some day,
> with merge_recursive() being part of it.  And I'm a little unsure if
> libified functions should rely on environment variables.

I think the environment variable is the least of your worries.  

I do not think anybody has vetted if it is safe to call merge_recursive()
more than once in a single run of a process.  Things to watch out for are
the use of static variables (e.g. current_{file,directory}_set that are
used for its (semi-broken) D/F conflict detection), its liberal use of
die(), leaking of "virtual commit", to name a few.  They are all perfectly
fine programming constructs when we assume this is a one-shot "run and
clean up with exit" program, but whoever wants to libify it needs to
arrange them to be cleaned up inside the "library" without making the code
too ugly nor one-shot use too expensive.

But such a clean-up may not be too bad as I initially feared, I suppose.
After a cursory look in builtin-merge-recursive.c, at least it does not
seem to mark objects with random object flags, expecting that nobody else
will look at them after it exits --- which would have been very expensive
to clean up after the fact.
