From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 07/11] notes: implement helpers needed for note
 copying during rewrite
Date: Tue, 16 Feb 2010 16:18:40 -0800
Message-ID: <7v7hqcww7z.fsf@alter.siamese.dyndns.org>
References: <cover.1266361759.git.trast@student.ethz.ch>
 <b8d8e699a7067f0bb095f4df73966fc61ffeb6c6.1266361759.git.trast@student.ethz.ch> <7v635w20o5.fsf@alter.siamese.dyndns.org> <201002170109.25211.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:19:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhXdA-0003aE-EP
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 01:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933672Ab0BQAS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 19:18:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933649Ab0BQASz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 19:18:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6385D9A31C;
	Tue, 16 Feb 2010 19:18:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TK1QJhVNlWUgaycSxZQMO13aDAc=; b=KT2Z6n
	LTDVsBl90d1JYjiubBbX8bLZYjbr7RDdrv4EvxgPr1LTOtTqrc+8c3nMDTuApXRd
	h4aCnM4NkuJEvvkKEDO8Cb0fEkoFWSNleKBbZYkZ26Nw8T4t+EyIVf150GSfboJj
	e+sJd+V2HFyq4PHjzXnthzyOZGj60H4YyMFmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z+mS+2dpAD4Wf3ybF+NN210BChvlxhrA
	3vxR0ndaOpjnXIGf8A5b2lHMSyD8mWBM4KMVkYpkQ6BtqYjxX5Go1j769pD2h4AV
	U15HAd+a6QQUEY6yC/gzygOEN5k7KQIGaUVo0/BZgen1llGGou37VuHpc5to2Mig
	jrOefyd5U0w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2050A9A319;
	Tue, 16 Feb 2010 19:18:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 310709A314; Tue, 16 Feb
 2010 19:18:42 -0500 (EST)
In-Reply-To: <201002170109.25211.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed\, 17 Feb 2010 01\:09\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03E95E68-1B5A-11DF-98B0-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140189>

Thomas Rast <trast@student.ethz.ch> writes:

> I believe the code in this patch is fairly well-prepared to deal with
> it.  It would merely need to learn to store a list of trees in the
> notes_rewrite_cfg, provided that it's ok to load them all
> simultaneously.

I was mentally handwaving to myself that all will be well in the end ;-)
but thought that it would never hurt to ask if you have thought things
through.

> However, I haven't really thought about having several notes trees.
> Is this automatic copying the only operation that needs this feature,
> or were you thinking of others too?

I was envisioning that most of the time people would want to read from
(and probably concatenate, or output with the origin information tagged in)
multiple notes but want to create into a single one.  But updating for
rewritten commits fundamentally need to happen in all of these multiple
notes trees they would want to read from.

For example, if I have amlog notes to record the message-id of the
original message I ran "am" to queue people's patches, I would want to
carry that even after I make typofixes in the commit log message or in the
code using "commit --amend".  If you have buildlog notes to record the
output from continuously running build-test-bot, you probably do not want
these notes to get carried forward when you rebase a branch.

In "log --show-notes=amlog --show-notes=buildlog" output, we will see
notes from both amlog and buildlog in the original history, but only the
notes from amlog will be shown in the rebased history.
