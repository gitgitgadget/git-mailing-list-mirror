From: Junio C Hamano <gitster@pobox.com>
Subject: Re: clang static analyzer
Date: Sun, 06 Dec 2009 16:26:33 -0800
Message-ID: <7vpr6rd3ye.fsf@alter.siamese.dyndns.org>
References: <33ABC714-2BCC-4910-BCAE-D331AAF2A724@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 01:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHRVo-0004Cy-IX
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 01:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934429AbZLGA0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 19:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934423AbZLGA0s
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 19:26:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934409AbZLGA0f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 19:26:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A57DD85662;
	Sun,  6 Dec 2009 19:26:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uahfJpj0Aml0VIYLa94LWQux0G8=; b=kFq3Oa
	nXYZ0/rxKKxi6TYBL8NOJoOKNHF+uf1xp9niOY/hfULj1hMISb0wZQHqd/u65/EW
	dWL6jTbYsA6ndp+/IdQAAC4I1tlMHxNcSymdBulGG1kO68ypbAkVHhUZFaU5J6W5
	s1WH8z8lelKLfdXXwwvprxWJ1VSPHA7gvLcYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hmR59oqVePawA+On37ItauN2llYvaK73
	AUSt3rT+YSUcu9WjepE8Fg2XN5wcvNCxfEDYXlxvo5cSsyWytkra2LL7fQkyJJK6
	nES13oEos28bAeQ0mFir3xk4MmXMNQgLPa3vaiC6yjydlrgSSK1wT1XI2JLDT5Wt
	miRIDh7wz2c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82B958565F;
	Sun,  6 Dec 2009 19:26:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CFB68565E; Sun,  6 Dec
 2009 19:26:35 -0500 (EST)
In-Reply-To: <33ABC714-2BCC-4910-BCAE-D331AAF2A724@dbservice.com> (Tomas
 Carnecky's message of "Sun\, 6 Dec 2009 07\:11\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2FBDB320-E2C7-11DE-A70A-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134698>

Tomas Carnecky <tom@dbservice.com> writes:

> xdiff-interface.c:xdiff_set_find_func() - When 'value' is a string with
> no newline character in it, the loop at line 291 sets 'value' to NULL on
> its first iteration and then passes 'value' to strchr() in the second
> iteration.

Thanks, but I am confused with your analysis.

If value doesn't have '\n', then regs->nr is 1 when you go into the loop
at ll. 291-, because we counted the number of LF in the first loop in the
function.

The first iteration of the second loop sets ep to NULL, expression is set
to value, then we run regcomp on the expression.  Then at the end of the
loop we do set value to a bogus "(char*)1".  But incrementing i makes it
go over regs->nr and satisfy the termination condition of the loop; we
happily exit the loop before we use the now bogus "value".
