From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] cmd_fetch_pack(): fix constness problem and memory
 leak
Date: Sun, 20 May 2012 18:47:03 -0700
Message-ID: <7vk4069ug8.fsf@alter.siamese.dyndns.org>
References: <1335955259-15309-1-git-send-email-mhagger@alum.mit.edu>
 <1335955259-15309-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon May 21 03:47:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWHiM-0007uH-HJ
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 03:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab2EUBrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 21:47:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755289Ab2EUBrH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 21:47:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACD108D0C;
	Sun, 20 May 2012 21:47:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+CwH3nB+NLFsB51kGFirt/cSKmE=; b=kR1AGg
	UvTwS7e5vDx6v/c5NjlkP4c9tJd/nv6tKahIWiHYCnQr/C0FIWDAEex4Tpw9HxRQ
	pTpkBrb/6MGvizfx4xv3Y5+ps5OKEs/OEFGHthgNNg+gMjNvYziiFuB0bIanEEMc
	la4uQQosg7tVMVOip3tkTUewluTZ4tnIak3TI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p0eHCyMghCyK7XL5s8427R9iS0F9K8cw
	wmOYQ/sYsek0byvFRJ2sZML5cmJMwwa3V0j+xNVprxPKdFSVYoqlfKAhi34NpXk0
	K60cdHYH0f2HTX/nRMY0dL8eWEU9fUCQ8fIVHvqzWPDgjKoBOxN4x7EfC3yR5JTR
	VNj+IHqQ8sE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3C788D0B;
	Sun, 20 May 2012 21:47:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37FF38D07; Sun, 20 May 2012
 21:47:05 -0400 (EDT)
In-Reply-To: <1335955259-15309-3-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Wed, 2 May 2012 12:40:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE3ACEC4-A2E6-11E1-A8ED-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198076>

mhagger@alum.mit.edu writes:

> I understand that it is not crucial to free memory allocated in a
> cmd_*() function but it is unclear to me whether it is *preferred* to
> let the process clean up take care of things.

Traditionally, the cmd_foo() functions roughly correspond to main() in
other programs, so from that point of view, "it is not crucial to free" is
an understatement. It is not even worth wasting people's time to (1)
decide which way is *preferred* and to (2) churn the code only to match
whichever way.

These cmd_foo() functions, being roughly equivalent to main(), have logic
to interpret the end-user's intentions (i.e. parse_options()), and carry
out that intention.  In the long run, some _other_ parts of the system may
want to do "foo" (whatever that "foo" may be) from inside the process
without forking, and the first step to do so may be to split cmd_foo()
into two, one that does "parse options", and the other that does "foo".
At that point, it starts to matter that we make the part that does "foo"
leak free, especially if such a caller (or callers) can ask to do "foo"
number of times.

If you have a plan to split cmd_fetch_pack() and make other parts of the
system call it, probably restructuring the current separation between
"figure out what refs will be fetched" done in cmd_fetch_pack() and "fetch
these refs in heads[] array" in fetch_pack() into something else (like
"the new caller also wants to read the list of refs from the standard
input, instead of having parse them into head[] array itself"), then
freeing the memory would matter a lot more, and the approach this patch
takes is a first step in the right direction, I would think.

It also seems that some cruft has snuck into this patch, e.g. like this
part,

> -	int i, ret, nr_heads;
> +	int i, ret;

that do not have anything to do with "fix constness" nor "memory leak".
