From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ignored file can be deleted silently
Date: Thu, 05 May 2011 09:49:23 -0700
Message-ID: <7viptp9jos.fsf@alter.siamese.dyndns.org>
References: <BANLkTinEupQKfBofhH-qKD6gLGWyWRbGvw@mail.gmail.com>
 <BANLkTi=C4pO83mT3pO0B_AMaK3RMOC4V8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 18:49:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI1kD-0002Zr-OQ
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 18:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab1EEQtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 12:49:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab1EEQtg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 12:49:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 921B7560B;
	Thu,  5 May 2011 12:51:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sJ1MuHqPxRdqJU6/ZiYxMGlN104=; b=iWPc49
	DnXXVCmT1EeWjRpc5yVSJL3wbMaghO+bS9U9ARZ5Xp424Nl9OpEIaF0Edrg5SzAI
	9SXqzvYwg6Jbz6f3Qqb9VswLeNLNFQc0YFNTEBUBXSMCXn069lE/bDOLYedFG5+U
	lxuQSqjyPSrx05eAXqRpfTh28GD6M7YXqz8Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lOOyyO+5roTilXDE5NUCgBChQalDMSez
	OXkRc3VFkLqsUXuzpXVBGOAtj8dHVM0i2ZxTDOQkWvVXXPhCKdWawCbUMw4a6qY4
	9ABo1mTxOCWbqkf2M3v8IdeIZPqmFJ1iO44NpgQ/Wi3FH/7YgkhqlM0P8N2KkcVq
	NaaCBnDfrB0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5CE28560A;
	Thu,  5 May 2011 12:51:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 369115609; Thu,  5 May 2011
 12:51:28 -0400 (EDT)
In-Reply-To: <BANLkTi=C4pO83mT3pO0B_AMaK3RMOC4V8g@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 5 May 2011 21:18:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEB6E098-7737-11E0-A075-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172846>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> This is on purpose. Commit f8a9d42 (read-tree: further loosen "working
> file will be lost" check. - 2006-12-04) allowed ignored files to be
> overwritten. Perhaps we can have a config to tighten the check again?

No.  The real issue is that we have only two classes of paths.  Either
ignored or unignored.

If we see an unignored path not yet tracked, we notice and suggest "that
file might be something valuable and you may forgot to add" in "status"
output.  In that sense, "unignored" is a synonym of "worth keeping".

Most of the time, "ignored" is also the same as "can be safely discarded"
(think: *.o files that can be recreated).  If you do not allow them to be
discarded, switching from a branch that has "builtin/hello.c" and leaves
an ignored compilation artifact "builtin/hello.o" to another branch that
did not have "builtin/" directory (probably it is "builtin-hello.c" on
that branch), or even worse, a plain text file "builtin", would stop and
get you into a horrible habit of constantly saying "checkout -f".  Even
though there may be cases where there are some files that are not tracked,
that you may not want to add, but you may still want to keep, because we
have only two ignored/unignored classes, that is how we have done things.

If you really want to fix this to everybody's satisfaction, you need to
introduce the third class, ignored-but-precious (IIRC, tla had such a
concept), and treat them as "not worth nagging about potentially forgotten
as an add target" but still "not automatically nukeable".
