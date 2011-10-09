From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Retain caches of submodule refs
Date: Sun, 09 Oct 2011 13:10:02 -0700
Message-ID: <7v39f2rko5.fsf@alter.siamese.dyndns.org>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
 <1313188589-2330-7-git-send-email-mhagger@alum.mit.edu>
 <7v4o1hgemp.fsf@alter.siamese.dyndns.org> <4E918194.5060102@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Oct 09 22:10:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCzhb-0007IX-F3
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 22:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145Ab1JIUKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 16:10:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922Ab1JIUKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 16:10:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ADB4475B;
	Sun,  9 Oct 2011 16:10:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XypNyWqjXZ9D8dz4q2vPcyJPr2g=; b=H7eYwB
	TIhOyCW0CHh55l7d80U4Bqs7hToqHXMGsgxRFom04Dn+hc9anYDZ2h0B83PZR9j/
	E6begJ4QMT5z1Z6K/rQmR6OsQZN0FlR3XVxnoPkj8eCzu6hIk12OfFtpv443nTfC
	dyOt4VZp6YY8qMqsXwQmFJo3p5pD01mLdJG6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JDpn2fKrkzujPUXAWZpovTLj3g1F0rqT
	2mzwN0HROyZvEU0H2xAhfbRcHtnqozQgxLcV7Hu9m7NGrwRu7gxkOWtI5Wqi1e3Y
	GiokjD+SWxaNlxY0PFxbMqCUdxoo3PZc9sbsJddv64yqEzh63ziE2RWSB9YBNXkG
	KU9+ErS0SHI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01D1E475A;
	Sun,  9 Oct 2011 16:10:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 855EF4759; Sun,  9 Oct 2011
 16:10:05 -0400 (EDT)
In-Reply-To: <4E918194.5060102@alum.mit.edu> (Michael Haggerty's message of
 "Sun, 09 Oct 2011 13:12:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ADD49894-F2B2-11E0-9EEE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183210>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> So I think I need help from a submodule guru (Heiko?) who can tell me
> what is done with submodule references and whether they might be
> modified while a git process is executing in the main module.  If so,
> then either this patch has to be withdrawn, or more work has to be put
> in to make such code invalidate the submodule reference cache.
>
> Sorry for the oversight, but I forgot that not all code necessarily uses
> the refs.c API when dealing with references (a regrettable situation, BTW).

In the longer term, I would agree with you that we very much prefer all
the ref accesses to go through the refs API, and I also foresee that the
submodule support would need to become more aware of the status of refs in
checked out submodules. For example, a recursive "submodule update" may
want to inspect the refs in a submodule directory, compare them with the
commit bound in the superproject tree for the submodule path, and decide
to spawn a "fetch && checkout $branch" in there. The same process then may
want to run "status" at the superproject level to show the result, which
in turn would inspect the relationship between the commit bound in the
superproject tree and the commit at the HEAD of the submodule directory.

So let's not rip out the commit but instead give submodule machinery an
explicit way to say "We do not know the current status of the refs in this
submodule anymore".

Thanks.
