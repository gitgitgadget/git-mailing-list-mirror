From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC/GSoC 09/17] rebase-common: implement cache_has_unstaged_changes()
Date: Mon, 14 Mar 2016 14:52:44 -0700
Message-ID: <xmqqoaag9177.fsf@gitster.mtv.corp.google.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-10-git-send-email-pyokagan@gmail.com>
	<alpine.DEB.2.20.1603142151230.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 22:52:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afaQ7-0007Hz-CI
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 22:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbcCNVwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 17:52:50 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752481AbcCNVws (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 17:52:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5616C4D6D8;
	Mon, 14 Mar 2016 17:52:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qYgYnXRaJw2wOVjGmyjxl454ddA=; b=sYTtkF
	QWhvFM8RdGtkkiEZL+qlA/ReNiCJUP06cr8SBJB5AZvkgCG119Z+vGsvrLUBYh9L
	IVQHmR/1sxiUYFRcyA8ryncrxj7i/lucvCF+QEXZYht2gYDbxGuDCu6tHCB/DgYq
	biH4cUCzxUunFR9MO1TLKerWPz9HPlScyy5ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B9Zsf4AkMhm5HB//dEAA8vzYfuwSpxSj
	/WDcK5X7Tpg3lCVMNujsiKVpmtEYlpGc0RK8Cl/c4/ef5FvjQi6mhnRC571Znj3T
	zgjOGVz/KFkCszwZwsJgB8r1te5ItVw/katpXHKfIZzSr6XKLywLNinlVU8PCGRE
	0dJqM4wsHSQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C6014D6D7;
	Mon, 14 Mar 2016 17:52:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B471C4D6D6;
	Mon, 14 Mar 2016 17:52:45 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1603142151230.4690@virtualbox> (Johannes
	Schindelin's message of "Mon, 14 Mar 2016 21:54:19 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1602F708-EA2F-11E5-8C50-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288821>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Also, you might want to join my discussion with Junio about the sense or
> nonsense of keeping the prefix parameter instead of silently removing it
> while moving the functions.

This is a tangent to Paul's topic, but it is an important tangent in
the other thread, in that you didn't mention one thing there that I
needed to make an accurate assessment.  I wasn't aware of your plan
of moving it and use it in a context unrelated to "git pull", hence
keeping the prefix would made perfect sense, as the enhanced error
reporting (i.e. "not only I am saying that you have modified files
and hence you cannot proceed, I can tell you which paths have been
modified") would happen inside the function if done in that context.

If the function will be made a public helper that may be called by
anybody, a possible error reporting mechanism would be to give a
list of modified paths to the caller that asks them, and have the
caller apply its own "prefix" processing to make them relative.  The
public helper function will not even be a position to say "you have
modified files and hence you cannot proceed"--it will not be in a
position to even issue an error message.  The only thing it should
do is to communicate to the caller if there are modified files or
not (and leaving the decision on what to do to the caller--after
all, the caller may want to do something only when there are
modified files, e.g. "add ." may decide not to do anything when
there is no change--so "hence you cannot proceed" is not its
business), and if the caller wants to see them, which paths are
dirty.

Incidentally, that is how wt_shortstatus_status() reports the list
of modified paths, using s->prefix.
