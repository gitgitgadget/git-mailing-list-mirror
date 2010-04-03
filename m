From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] git status: refresh the index if possible
Date: Fri, 02 Apr 2010 21:33:16 -0700
Message-ID: <7v1vex9mur.fsf@alter.siamese.dyndns.org>
References: <1270211241-10795-5-git-send-email-markus.heidelberg@web.de>
 <1270244661-24173-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 03 06:33:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxv3H-00051n-Bu
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 06:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023Ab0DCEd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 00:33:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab0DCEdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 00:33:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57128A72F8;
	Sat,  3 Apr 2010 00:33:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t+AdNu2sA17WLElmwGlNTeDXsto=; b=SjL0mZ
	7Nff2luD3ybEcXVZkq4Jv10IyjFznkeRbUdT+pVSwN50g4SZHTNjsNhGx3nI8vo0
	uBooEtvqnVC3lGmSUanIe9IEWrsXDHI111gZ7QxgprPDary2mu6NsbFXlj0USpeY
	UpztCL3sGADdlXu/ySm+nXRi4tc3F/AdUeBdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M2JSgXRlfKpjjvcUQdqa0PQuW2BG0mC2
	DRL8CN+x4iYlHPELG19l5I4Gkn3QSx9AUn8NObHm/g4B8JqoCpz2IIAisyz0l2fA
	i590izvhqUipkQtcnhf7OKL9+rl7Zy0ylNsqUIJS6P/IshS0Cybv8lNHTuyrgMUK
	pdh3VHTOVWE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 27D85A72EB;
	Sat,  3 Apr 2010 00:33:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A530A72E9; Sat,  3 Apr
 2010 00:33:17 -0400 (EDT)
In-Reply-To: <1270244661-24173-1-git-send-email-markus.heidelberg@web.de>
 (Markus Heidelberg's message of "Fri\,  2 Apr 2010 23\:44\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0887B016-3EDA-11DF-B382-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143878>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> Is rollback_lock_file(&index_lock) necessary? It isn't used in
> "git commit --dry-run" when commit_style is COMMIT_AS_IS.

That is because AS_IS commit does not even lock anything for writing, as
AS_IS means just that: "git commit" does not touch the index but just
writes tree out of the index.

Upon program exit (unless you get an uncontrolled crash), the lockfile API
arranges atexit(3) to roll back the lockfiles, so it probably may not make
much of a difference if you omitted rollback_lock_file(&index_lock)
yourself, but it is a good idea to clean up the mess you made after you
are done, especially if the mess is not something the operating system
will clean up for us (e.g. open file descriptors, malloc'ed region of
memory etc.)

To make sure that the failure case is covered, you may also want to add a
test case where you run "chmod a-w $GIT_DIR" and then run status (but that
test needs to be conditional on POSIXPERM).

Thanks.
