From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Mon, 15 Feb 2010 17:07:27 -0800
Message-ID: <7vwryet2cw.fsf@alter.siamese.dyndns.org>
References: <20100215225001.GA944@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 02:07:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhBuh-0005qM-Of
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 02:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366Ab0BPBHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 20:07:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025Ab0BPBHi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 20:07:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84C149A9F3;
	Mon, 15 Feb 2010 20:07:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zx9bQfAMcpmbaIM5aECugTbFfdI=; b=hEu9jr
	jfRZ3j45FxsZ2oMQcWK0SDG+/Gn8H/FE9ZUz6Zkie2fCoxVpx8nL0DhlvvXw1Fqg
	3bjU7mLga2AXP+S/ZMFTMBM6k4e+cgxuv6BYNKbL9PUmXiOxZ85A33fcLK7DwF/7
	CPcw482xk0yYZoLZYwYxrV/sucVRRDcF6aiLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JkeYoH+59VbJDD6+V9lQXKyq9jXjJAOZ
	7ZmDZyr3/0fGhKFOtFdas5oDMcVGVMgQi62g5KY9BXs/34CVDEkC+sn41tqK7Zlm
	Ig18IG+0E3U1VJmrkfiCfXpFOx6ctfnG2Q+hNzdJF28E+TxYl3COugEQGRpIhE8/
	bqCgYj805B4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5307B9A9F2;
	Mon, 15 Feb 2010 20:07:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FD3E9A9F0; Mon, 15 Feb
 2010 20:07:28 -0500 (EST)
In-Reply-To: <20100215225001.GA944@book.hvoigt.net> (Heiko Voigt's message of
 "Mon\, 15 Feb 2010 23\:50\:02 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9A64046-1A97-11DF-B813-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140054>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> In case the machine has only one cpu the initialization was
> skipped.

An obvious question that forces reviewers to go "Huh?" is why this
matters.

If use_threads is false, we do not call start_threads(), and I think at
least the intent of the threaded grep code in 5b594f4 (Threaded grep,
2010-01-25) is that uninitialized mutexes matter at all in that case.

For example, "grep_mutex" is touched by calling grep_lock() and
grep_unlock() macros, or pthread_* functions on it directly.  There are
five functions that touch this mutex: add_work(), get_work(), work_done(),
start_threads(), wait_all().

 - add_work() is called from grep_sha1_async() and grep_file_async().
   They are both called _only_ when use_threads is true.

 - get_work() and work_done() are only called from run() and that is the
   function threads run from start_threads().  They cannot be reached
   unless use_threads is true.

 - wait_all() has three call sites in cmd_grep(); all of them trigger only
   when use_threads is true.

So at least for grep_mutex your patch shouldn't matter.  Please explain
use of which mutex is broken and how your patch fixes it.

I think the fix also assumes that an initialized mutex that is used but
not destroyed is not a programming error, as wait_all() is the ONLY
function that destroys these mutexes and it is called ONLY when we are
using threads by calling start_threads().  But that assumption surely
smells like it is sweeping a bug under a rug rather than fixing it.

Is there some programming rule I am not aware of, like "if you define a
mutex or cond, you must initialize it, even if you are not going to use it
at all?"  If that is the case, I think your patch is necessary, but I
somehow find it a bit hard to believe.
