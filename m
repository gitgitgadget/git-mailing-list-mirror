From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Linux 2.6.27-rc3: kernel BUG at mm/vmalloc.c - bisected
Date: Fri, 22 Aug 2008 14:05:21 -0700
Message-ID: <7v7ia8ahgu.fsf@gitster.siamese.dyndns.org>
References: <48A36838.3050309@hp.com>
 <20080819124602.9e8e69f7.akpm@linux-foundation.org> <48AEDD3D.4060507@hp.com>
 <20080822092549.ddcb7e79.akpm@linux-foundation.org>
 <20080822171651.GP10544@machine.or.cz>
 <20080822105136.a8432875.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Alan.Brunelle@hp.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:06:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWdq9-0004L8-NR
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbYHVVFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbYHVVFc
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:05:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbYHVVFc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:05:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EF20D63C9F;
	Fri, 22 Aug 2008 17:05:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3B06563C9A; Fri, 22 Aug 2008 17:05:23 -0400 (EDT)
In-Reply-To: <20080822105136.a8432875.akpm@linux-foundation.org> (Andrew
 Morton's message of "Fri, 22 Aug 2008 10:51:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0D2CDF86-708E-11DD-8118-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93364>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Fri, 22 Aug 2008 19:16:51 +0200
> Petr Baudis <pasky@suse.cz> wrote:
>
>> On Fri, Aug 22, 2008 at 09:25:49AM -0700, Andrew Morton wrote:
> ...
>> > urgh, it's irritating when git-bisect directs you to a merge commit - it
>> > hasn't done it for me for ages.
>> 
>> Hmm, but doesn't that happen only when it's actually really the merge
>> commit that introduces the bug? Both parents of the merge commit were
>> marked as good by the user, so...
>
> A merge commit doesn't contain any kernel changes?  It's the individual
> commits (aka "patches") which were in that merge which broke stuff. 
> Confused.
>
> We're trying to dive inside that merge commit to find out which of the
> real commits caused the regression.

You may find neither parents were buggy, but the result of the merge is.

A trivial example is when one branch changes the semantics of an existing
function and converts all the call sites to the updated semantics, while
the other branch adds a new call site that still relies on the old
behaviour of that function.  The merge most likely won't textually
conflict, and neither git merge nor quilt patch would report conflicts,
but the end result is that the new call site added by the latter branch
now gets an unexpected outcome from the function and can misbehave.  You
cannot blame the breakage to either branch for such a breakage.
