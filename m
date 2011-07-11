From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Mon, 11 Jul 2011 16:21:54 -0700
Message-ID: <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
 <20110711220107.GC30155@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 12 01:22:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgPne-00011q-Sl
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 01:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985Ab1GKXV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 19:21:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab1GKXV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 19:21:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58D5057E9;
	Mon, 11 Jul 2011 19:21:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W9MBPuucrlBE5IzlOc+E9eE7ybE=; b=nWaFcy
	dfsWkLaYEB9CZeJJ6slGZTlfbvvoKoOuAh9q6WVDdqh8uLniL/uA/adinkjnZu6C
	p/DztacVQ3WICTknhQBi5jC9WXlhVQZeybP6JDbEDzSedooTUHa0L4xmt/ZckHRZ
	75/TenueeSS/4D82HlDUcrnuE3fbGr5VJXb1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K87zy1KCZ1nZFVJpHddyM/dXwCE5R43V
	RSaGRLmbr2reTGNsXB8Kp14+JxdW+twO7KjnRA1eAGezmYWv6EUcHK0y1hEXoyrH
	ISWt6GVd4ZSWE5+lstZDZH3J1qdAE1LUn6Unyvb1c+P/OGTOj/4jmFyqQ3zwWFiW
	/dGRZ0AZLOA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5018257E7;
	Mon, 11 Jul 2011 19:21:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9440357E6; Mon, 11 Jul 2011
 19:21:55 -0400 (EDT)
In-Reply-To: <20110711220107.GC30155@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 11 Jul 2011 18:01:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 912E7C94-AC14-11E0-A963-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176908>

Jeff King <peff@peff.net> writes:

> ... But with a commit no top, you get:
>
>   <<<<<<< HEAD
>   two
>   =======
>   one
>   >>>>>>> one
>
> which looks like you are reverting, because of course you are building
> on top of the finished series.

Exactly.

>   $ git rebase master topic
>   Applying: one
>   Using index info to reconstruct a base tree...
>   Falling back to patching base and 3-way merge...
>   Auto-merging file
>   CONFLICT (content): Merge conflict in file
>   Failed to merge in the changes.
>   Patch failed at 0001 one
>
>   hint: this commit may already be in upstream as 1234abcd;
>   hint: the differences between that commit and this one are:
>
>   diff --git a/file b/file
>   --- a/file
>   +++ b/file
>   @@ -1 +1 @@
>   -modified one
>   +one
>
>   When you have resolved this problem run "git rebase --continue".
>   If you would prefer to skip this patch, instead run "git rebase --skip".
>   To restore the original branch and stop rebasing run "git rebase --abort".

Actually I do not think identifying the ones that can safely skipped is
such a big issue. The case I am most concerned about is when you see that
"two reverted back to one" (which you obviously want to avoid, to keep the
effect of the commit the upstream has to have "two" on that line), but at
the same time when you do not agree with the change that the upstream took
for the _current commit_ you are replaying (i.e. you want the final result
to have "one", not "modified one" which the upstream has applied).

The conflict resolution to come up with such an incremental change is very
painful. You have to avoid the "s/two/one/" revert, and you have to keep
the "s/modified one/one" revert, and you need to know which hunks are
conflicting due to what (i.e. the former is because a patch similar to the
one you haven't replayed in this rebase session is already in upstream,
the latter is the upstream tweaked the current patch you are looking at in
a way you do not agree with).

I do not have a good idea to solve this in mind yet.
