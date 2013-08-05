From: Junio C Hamano <gitster@pobox.com>
Subject: Re: About close() in commit_lock_file()
Date: Mon, 05 Aug 2013 09:56:19 -0700
Message-ID: <7vli4gkrf0.fsf@alter.siamese.dyndns.org>
References: <CACsJy8By1cpPZ5QyVd6VhKSkd-y_E6pTYdDimK9P0wXia-uMqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 18:56:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6O55-0004jp-0j
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 18:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038Ab3HEQ4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 12:56:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753494Ab3HEQ4W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 12:56:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6952366C6;
	Mon,  5 Aug 2013 16:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y5UX0SSon0O3oRVeJNCFtX3S5Bs=; b=lARsbt
	RAv4DEzIHW7MUhiI61iczr1MwmK15259rbVcoa6ShLKN1DG0qYf7VGVQvsbTewtD
	cqcIwggBsl5bIQ7PKMAd/hlPfEQETvYWBYtXnsljCP/4FbUZ3Dj3TCd+arJF/Udj
	rV5vStYnRhIw1rYiFHqQ2TZVDIIL07yPyPFkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qzpas+30+J+17u3sHKZsk8YJPjQdnWmB
	LkfTGwSgVi+NlEyb2+Gk1u/wzmeyf7Fr78XvAs5J51gl7qcz/bDYbmiqyd5SJAuy
	AsdbxodA3suTXo1a/hePuBsY/ieHLmvt5JTZk4KuBBjoW3+Stq6rP88WL0nwkMKr
	o2g5OqdFnDA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8A56366C5;
	Mon,  5 Aug 2013 16:56:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAF48366C1;
	Mon,  5 Aug 2013 16:56:20 +0000 (UTC)
In-Reply-To: <CACsJy8By1cpPZ5QyVd6VhKSkd-y_E6pTYdDimK9P0wXia-uMqg@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 5 Aug 2013 21:23:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3FE80BA-FDEF-11E2-9CAB-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231679>

Duy Nguyen <pclouds@gmail.com> writes:

> close() is added in commit_lock_file(), before rename(), by 4723ee9
> (Close files opened by lock_file() before unlinking. - 2007-11-13),
> which is needed by Windows. But doesn't that create a gap between
> close() and rename() on other platforms where another process can
> replace .lock file with something else before rename() is executed?

Interesting.

> Should we enclose close() in #ifdef __MINGW32__ (and maybe
> __CYGWIN__)?

Or just have "close and retry" code after seeing rename() fails with
some known errno, without singling out a particular platform?
