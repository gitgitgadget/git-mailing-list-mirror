From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 07:55:09 -0700
Message-ID: <7v8v1zd0du.fsf@alter.siamese.dyndns.org>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-2-git-send-email-artagnon@gmail.com>
	<vpqhagnwraj.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 24 16:55:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8As-0002M0-D7
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 16:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255Ab3FXOzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 10:55:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34139 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854Ab3FXOzM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 10:55:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 910622A4A9;
	Mon, 24 Jun 2013 14:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ox4+wmFKqp8BpvjBmzusaC8b+hY=; b=feCV9Q
	x7iRJGMcB3DYdxORrWAD+Jr970VKct/EzFJB0itA1PkOwo0YWNLDrTGw+Fa1GCHe
	Lg4IReeKyn/T09Unsf70CMZikM29xrm0j9UxznQWnw98OnN9ATRamBJViGV5UNYd
	unH3iqGApxhOKPvSHWtqg6cXD8IuF7kwfNZtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oO7DnU+HMhvQVnirbQAX8FP6mkh6o0uv
	7AK+wOTCO6QJgUl2+BbTHAefTNyogu04H+js01SCgG/KunQeZu2n2qDyIRK7moPn
	0UI9tef9maRCu2Rmsij7/M+uFzeaEm3jITxSnv7mt7p1JFl9rp+3r/zgMHHI1XH4
	kJsHteFYcZk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87CC32A4A8;
	Mon, 24 Jun 2013 14:55:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFF5D2A4A5;
	Mon, 24 Jun 2013 14:55:10 +0000 (UTC)
In-Reply-To: <vpqhagnwraj.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	24 Jun 2013 15:51:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 116FFF1C-DCDE-11E2-B7B3-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228818>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I really don't like this. If we go for a solution looking explicitely at
> argv[], we should at least iterate over it (also not satisfactory
> because --porcelain could be the argument of another switch).

Ram, thanks for a report.

I won't comment on what is the correct way to see if "--porcelain"
is given by the caller before I have enough time to think about it,
but we did read configurattion even when "--porcelain"is given
before the topic was merged, and I think it was done for a good
reason.

Configuration related to the output format (like color=always) must
be ignored under "--porcelain", but if we do not read core-ish
configuration variables (e.g. core.crlf) that affect the logic to
list what is changed what is not, we would not give the right
result, no?

So checking "--porcelain" option and skipping configuration may not
be a solution but merely trading one regression with another.

For now, I'll revert the merge and see if people can come up with a
reasonable way forward.  My knee-jerk reaction is that, because the
"--porcelain" output was designed to be extensible and scripts
reading from it is expected to ignore what it does not understand,
if the setting of status.branch is a problem, the reading side is
buggy and needs to be fixed.

Do we have in-core reader that does not behave well when one or both
of these configuration variables are set (perhaps something related
to submodule?)???
