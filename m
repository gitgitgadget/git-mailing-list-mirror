From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-revert: Make use of merge_recursive()
Date: Mon, 11 Aug 2008 16:27:01 -0700
Message-ID: <7v7ianuo8q.fsf@gitster.siamese.dyndns.org>
References: <20080811190924.GR18960@genesis.frugalware.org>
 <1218491096-28756-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Aug 12 01:28:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSgoB-0003Zc-JP
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 01:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbYHKX1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 19:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbYHKX1L
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 19:27:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbYHKX1K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 19:27:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5C2B3558EA;
	Mon, 11 Aug 2008 19:27:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 319B0558E8; Mon, 11 Aug 2008 19:27:03 -0400 (EDT)
In-Reply-To: <1218491096-28756-1-git-send-email-s-beyer@gmx.net> (Stephan
 Beyer's message of "Mon, 11 Aug 2008 23:44:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 04AAC5CE-67FD-11DD-A1BD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92022>

Stephan Beyer <s-beyer@gmx.net> writes:

> Cherry-pick and revert always ran the merging in a separate process.
> This patch makes cherry-pick/revert call merge_recursive() instead
> of running git-merge-recursive.
>
> To be able to cherry-pick/revert -n (without committing) on a dirty
> index, make_virtual_commit() is needed and thus declared non-static.
>
> Also the GITHEAD_* environment definitions are not needed anymore,
> since the names are direct arguments to make_virtual_commit() and
> merge_recursive().
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
> 	Hi,
> 	so I give it a new try.

Looks good from a cursory reading.

I am not absolutely sure if the phoney commit-looking object that has
nonsense SHA-1 created by make_virtual_commit() would have any unintended
side effects to the rest of the system, but it does not look like it is
even inserted into the global object hash table, so this should be Ok.

That was the last piece of worry coming from me regarding this "call
recursive internally" theme.

Would we need to consolidate this and Miklos's "call recursive internally
from git-merge wrapper" by making them into three patches?
I.e.

 (1) move bulk of code from builtin-merge-recursive.c to a new file
     merge-recursive.c and introduce merge_recursive_helper() in there so
     that both of you and cmd_merge_recursive() itself can call it;

 (2) make revert.c use merge_recursive_helper();

 (3) make builtin-merge.c use merge_recursive_helper().
