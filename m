From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge-recursive: move make_virtual_commit()'s
 virtual_id to merge_options
Date: Thu, 04 Sep 2008 12:03:08 -0700
Message-ID: <7vy7273f9v.fsf@gitster.siamese.dyndns.org>
References: <cover.1220463034.git.vmiklos@frugalware.org>
 <e3e7f1cbf3746e7d2ef2c77227c9367a361c10b9.1220463034.git.vmiklos@frugalware.org> <f2a1ff8d2fe354265a80534cd7beaaa95c2ffc54.1220463034.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 21:04:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbK83-0004Tu-5B
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 21:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYIDTDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 15:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYIDTDV
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 15:03:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbYIDTDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 15:03:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4851A74CE2;
	Thu,  4 Sep 2008 15:03:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C625974CDD; Thu,  4 Sep 2008 15:03:10 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 231E160E-7AB4-11DD-AC2A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94947>

I do not think this one is a good idea.

What does it mean for a two "virtual commits" that are returned from
separate calls to make_virtual_commit() to have the same virtual_id?

I do not know offhand if the existing code does something like:

	commit = lookup_commit(commit->object.sha1)

or

	if (hashcmp(commit1->object.sha1, commit2->object.sha1))
        	...

but if there is such a code, I think this change makes the problem
"virtual id" has even worse.  With the current single function local
static "virtual_id", at least during a program's lifetime it is guaranteed
that there won't be any two instances of virtual commits created for
different purposes that share the same (fake) sha1 value.  If you call
merge_recursive more than once in your process, using a fresh "struct
merge_options" each time, that guarantee is lost with your change.

The only purpose of a "virtual commit", as I understand it, is to allow
you to pass a tree resulting from an internal merge to a function that
expects you to call with three commit objects to come up with a new tree
that is the result of the merge.  The code stores a "virtual_id" as a
phoney sha1 value in the object, but I do not think the actual value is
used for anything but debugging purposes (Alex, Dscho, please correct me
as necessary).

Does it hurt if we get rid of virtual_id and always leave the
object->sha1 field of virtual commits 0{40} as it is initialized?

I further suspect we _could_ fix the API that requires you to pass three
commits to accept three trees instead and get rid of virtual commits
altogether, but then we would lose an easy access to the message of
commits that are being merged, and we would need to pass these strings as
separate parameters (or part of merge_options) --- which might be a good
clean-up in a longer run, but I do not think it is absolutely necessary
during this round.
