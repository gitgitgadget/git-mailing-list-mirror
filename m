From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pre-receive hook ; how to detect file and append code ?
Date: Fri, 22 Jun 2012 11:02:41 -0700
Message-ID: <7v395nql6m.fsf@alter.siamese.dyndns.org>
References: <20120622183709.2f0beaa6@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Fri Jun 22 20:02:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si8C0-0005YN-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 20:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755960Ab2FVSCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 14:02:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755838Ab2FVSCn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 14:02:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5118579F4;
	Fri, 22 Jun 2012 14:02:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ruqqO1c1NRX/B0YGinDL2V/uql8=; b=H5JU8s
	HE3hs8kl+rBwQLtTFXXWU3vz8mC+pr0lGgtHLQF9voBrvcXrOScjirmdZqGjbck9
	EPNwDOzYUUFay+K8b7kgruVjlSXDXr+6wYD43Cpcu5cECPQG/LebQ+9YXDtis8AL
	FHI24vTOAksJhvJxHYknp43TJkRmC7waCSs80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nfmEzI/d1p//QvG4APNIB8pVym7FxUpL
	BK/SXqSJRyRxxuNeejl3AN/eAasr2mbDpa8pqpZTNQCGEZ4dzU7z4nn6Hy8aeGf3
	oqpngK3Gp4SrYzUVOWvCVXXbGKL/i/eNnfKWWl5Kap/v9ie0Kc9KS8k4klilHU1z
	wn9oEt+8LOo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 484DA79F2;
	Fri, 22 Jun 2012 14:02:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF56979F1; Fri, 22 Jun 2012
 14:02:42 -0400 (EDT)
In-Reply-To: <20120622183709.2f0beaa6@shiva.selfip.org> (J. Bakshi's message
 of "Fri, 22 Jun 2012 18:37:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7696BBD0-BC94-11E1-A9C8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200453>

"J. Bakshi" <joydeep.bakshi@infoservices.in> writes:

> How can I detect a specific file during push, if it is modified or not ?
> And how can I then append a block of code into that file; if modified
> during push ? I think pre-receive hook is the best for this operation.

The purpose of the "pre-receive" hook is to either approve or reject
a proposed change made by the push.  When it runs, the repository
already has received all the objects necessary to inspect the
proposed change locally (from the receiving repository's point of
view).

A proposed change comes in the form of <old> <new> <refname> that
says "The pusher saw <old> at <refname> when he started this push,
and it wants to update the ref to <new>".  So any of the following
standard techniques (note: not exhaustive) to inspect the changes
between <old> and <new> can be used:

    # are log messages sane?
    git log <old>..<new>

    # are the changes sane?
    git diff <old>..<new>

    # does it leave forbidden paths intact
    git diff --name-only <old>..<new>

If your script likes the proposed change, exit with 0.  If it does
not, exit with non-zero.

That is all it can do.  It is not supposed to change <new> to some
other value, and there is no interface to do so.

If you want to rewrite the history pushed into the repository after
a push is accepted, you would want to run it from post-receive or
something.  All the usual warning about rewriting published history
will apply if you do so, however.  After all, the history is already
published immediately before post-recieve (or post-update) runs.
