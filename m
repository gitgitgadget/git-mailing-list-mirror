From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Wed, 16 Apr 2014 11:23:18 -0700
Message-ID: <xmqqppkhgmll.fsf@gitster.dls.corp.google.com>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
	<0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c>
	<xmqqob03le3v.fsf@gitster.dls.corp.google.com>
	<FAD02895-24B2-46C3-ABEF-E9CE17926FF9@gmail.com>
	<xmqqsipdi5lw.fsf@gitster.dls.corp.google.com>
	<xmqqtx9tgn5l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 20:23:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaUUZ-00037f-0E
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 20:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210AbaDPSXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 14:23:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60888 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755151AbaDPSXV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 14:23:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 369717B8BC;
	Wed, 16 Apr 2014 14:23:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b7EB73Yrqy30mu4Mi7mntj1n1QY=; b=hV/BnS
	w2/DWehDoXqu4SosbHLioafWLZv3G8mkKKdGmBDP9QRXLn5XvyPA9iLzmLlEo75U
	fa+/2H2AbyxpM93hNZWB4+l1FnSIgtTKiYEKRd67RFVjI9PjbrubhuKGtL8itz9V
	lB5sHtlf7vAttYpHoY9fFHYvEm+Kumkj0te7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fqGAiYVUwjHAHnwxm6YcT161jE7P+hIs
	o0FtwBflTGsy8I4FHb7NA5ZRCujbZeOq1pSNAx6blvdHvb+xSGqUmATFK2Llysta
	0uBlB6szHQJd2Buw2mQNsRBKcmUQfCjB0rWIPTjh0mMopirx1PC5OOWiRR/upj8D
	hGbCGwnOzM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16CF07B8BB;
	Wed, 16 Apr 2014 14:23:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89FB07B8BA;
	Wed, 16 Apr 2014 14:23:19 -0400 (EDT)
In-Reply-To: <xmqqtx9tgn5l.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 16 Apr 2014 11:11:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2F9EEE7C-C594-11E3-8DB7-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246370>

Junio C Hamano <gitster@pobox.com> writes:

> By the way, you have this in your log message:
>
>     ... the git-rebase--*.sh scripts have used a "return" to return
>     from the "dot" command that runs them.  While this is allowed by
>     POSIX,...
>
>
> Is it "this is allowed", or is it "this should be the way and shells
> that do not do so are buggy"?

Answering myself...

The only "unspecified" I see is this:

    If the shell is not currently executing a function or dot
    script, the results are unspecified.

which clearly does not apply to the version before this patch (we
are executing a dot script).  And

    The return utility shall cause the shell to stop executing the
    current function or dot script.

would mean that we are correct to expect that "should not get here"
is not reached, as the "return 5" would cause the shell to stop
executing the dot script there.

So "while this is allowed by POSIX" may be a bit misleading and
needs to be reworded, I guess?
