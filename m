From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rev-parse vs. rev-list --no-walk
Date: Sat, 01 May 2010 13:05:00 -0700
Message-ID: <7v1vdv4ccz.fsf@alter.siamese.dyndns.org>
References: <4BDC7471.9030107@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat May 01 22:05:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8IwF-0003lj-Ei
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 22:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab0EAUFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 16:05:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888Ab0EAUFI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 16:05:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B9C9AFB97;
	Sat,  1 May 2010 16:05:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0xHgZuvlJOF/0WF8o3H0MiZ0/YM=; b=Q3Xw3t
	aWHNGzWLf3PakEXGIQ7SPiuUHFi0akptm3h9ebovOn8JDLX663gBsGdrPDnHZm4E
	Jn3zwCaeVS4Pn0m7uxz5nqwL+67joLlASFbwd5D0Um6DfppU87oecrOQEByxI9pG
	6Xlmc9/FtuYMgkqnQxKZ7dNR207faGdJnnoZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wtj09OHjqWLI0wdMNXZ4k3gok8vRuNMV
	kQ15TzrVtgS6JxfhgagEiomLW6PY82r2Wsd7x7jiq8swON6by5mdeJ/WTfyMhfav
	H3DyvtwW1D2b/f2Tt6tUpM+LE7lZ48wWDUHkFmDCS7VstNNdjaWRhhgkNBq4QRXe
	VxROREW1qNc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 42E5BAFB94;
	Sat,  1 May 2010 16:05:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95917AFB91; Sat,  1 May
 2010 16:05:01 -0400 (EDT)
In-Reply-To: <4BDC7471.9030107@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Sat\, 01 May 2010 20\:35\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D4F251F4-555C-11DF-A604-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146118>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> rev-parse does a couple more things, of course, but why doesn't it use
> setup_revision() ? I just wanted to ask before trying to restructure
> things....

Because rev-parse was written as a helper for scripts that take revision
options and non-revision options, whose purpose was to sift the arguments
into four bins:

    - revision parameters       (e.g. HEAD, master~20)
    - revision flags		(e.g. --all, --parents)
    - non-revision parameters	(e.g. Makefile, hello.c)
    - non-revision flags	(e.g. --stat, -p)

as its primary customer was things like whatchanged that used to be
scripted this way:

	git rev-list rev-flags rev-params |
        git diff-tree --stdin non-rev-flags non-rev-params |
        less

If you call setup_revisions(), it will call handle_revision_opt() which in
turn will call diff_opt_parse(), so I suspect you wouldn't be able to sift
between rev-flags and non-rev-flags.

I think one sane thing to do is to stop adding new rev-flags revision.c
supports to rev-parse (it already lags behind and nobody complained that
rev-parse doesn't understand --first-parent as a rev-flag), and keep its
use as "revision and non revision option sifter" only to support older
scripts written back in v1.0.0 days.  Its primary use these days is "turn
symbolic object names into 40-letter SHA-1", but "option sifter" aspect of
the command seems to have outlived its usefulness.
