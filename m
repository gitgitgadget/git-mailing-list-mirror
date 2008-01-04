From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: Run git gc only once and not for every patch.
Date: Fri, 04 Jan 2008 14:00:50 -0800
Message-ID: <7vmyrli73h.fsf@gitster.siamese.dyndns.org>
References: <20080104185926.GA11912@redhat.com>
	<alpine.LFD.1.00.0801041437190.2649@xanadu.home>
	<7vhchtjphk.fsf@gitster.siamese.dyndns.org>
	<477EA06A.5090606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 23:01:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAube-0000v0-25
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 23:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346AbYADWBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 17:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754340AbYADWBD
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 17:01:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbYADWBB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 17:01:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E99AF6E81;
	Fri,  4 Jan 2008 17:00:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A30C6E62;
	Fri,  4 Jan 2008 17:00:52 -0500 (EST)
In-Reply-To: <477EA06A.5090606@redhat.com> (Michael Stefaniuc's message of
	"Fri, 04 Jan 2008 22:08:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69610>

Michael Stefaniuc <mstefani@redhat.com> writes:

>> What Nico said.
> Not sure if you read my reply to Nico but the reflog is not there for
> deleted branches. Nor for a cleared stash. Common operations where one
> can loose work by mistake.

I am sure you read what Nico pointed out about HEAD reflog.

> Nevertheless is there a reason why git gc needs to run after applying
> each patch in git-am? Why can't it run just once at the end? git prune
> is optional and there's no reason to penalize a user that doesn't feel
> safe to run it by cluttering the output of git am/rebase. There is also
> a time penalty: git gc --auto on a pruned tree runs so fast that it
> isn't measurable but on my unpruned wine it took 1.5 seconds. Waiting
> 1.5 seconds per am/rebase is acceptable; wasting 1.5 seconds per patch
> in the mailbox/rebase isn't that much fun if there are more than a
> handful of patches to apply.

"Optional" does not mean "whether you do it or not you will see
identical behaviour".  Not pruning may slow things down but you
may still choose not to prune and suffer the penalty --- that's
your choice.  But we still produce the correct result (hopefully
;-) --- and that is what "Optional" means.

The message from "gc --auto" may serve as a coalmine canary for
you to know when to prune.

I do not think moving "gc --auto" outside the loop hurts in
practice because you are not likely to be rebasing a truly huge
series every day, but cruft can accumulate during "git am" run
and the "gc --auto" inside loop was meant to clean them up.  The
idea was taken from importers that run repack every once in a
while (e.g. cvsimport runs every 1k commits), but "gc --auto"
was designed to be much more lightweight than a full repack and
that was the reason it was placed in the loop without counting
"every N commits".
