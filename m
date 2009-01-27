From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] t3404 & t3411: undo copy&paste
Date: Tue, 27 Jan 2009 13:01:28 -0800
Message-ID: <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901271012550.14855@racer>
 <20090127085418.e113ad5a.stephen@exigencecorp.com>
 <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901271845380.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Haberman <stephen@exigencecorp.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 22:03:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRv5P-0000cr-IF
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 22:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbZA0VBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 16:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbZA0VBl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 16:01:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbZA0VBl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 16:01:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1BF3F1D685;
	Tue, 27 Jan 2009 16:01:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CBF8E1D67B; Tue,
 27 Jan 2009 16:01:29 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901271845380.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 27 Jan 2009 18:45:49 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B03D153A-ECB5-11DD-A383-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107388>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Rather than copying and pasting, which is prone to lead to fixes
> missing in one version, move the fake-editor generator to t/t3404/.
>
> While at it, fix a typo that causes head-scratching: use
> ${SHELL_PATH-/bin/sh} instead of $SHELL_PATH.

I've learned to be cautious whenever I see "while at it".

> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> new file mode 100644
> index 0000000..8c8caab
> --- /dev/null
> +++ b/t/lib-rebase.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +
> +set_fake_editor () {
> +	echo "#!${SHELL_PATH-/bin_sh}" >fake-editor.sh

It is unclear why you would want to do this.  It was unclear what "typo"
you were referring to in your commit log message, either.

The tests are supposed to run under the shell the user specified, so if
there is a case you found that $SHELL_PATH is unset, that is a bug we
would want to fix, and ${SHELL_PATH-/bin/sh} is sweeping the problem under
the rug to make it harder to fix, isn't it?

I would understand if it were

	${SHELL_PATH?"SHELL_PATH Not Set --- bug in tests?"}

though.

Besides, it's /bin/sh, not /bin_sh ;-)

> +	cat >> fake-editor.sh <<\EOF
> +case "$1" in
> +*/COMMIT_EDITMSG)
> +	test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
> +	test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
> +	exit
> +	;;
> +esac
> +test -z "$EXPECT_COUNT" ||
> +	test "$EXPECT_COUNT" = $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) ||
> +	exit
> +test -z "$FAKE_LINES" && exit
> +grep -v '^#' < "$1" > "$1".tmp
> +rm -f "$1"
> +cat "$1".tmp
> +action=pick
> +for line in $FAKE_LINES; do
> +	case $line in
> +	squash|edit)
> +		action="$line";;
> +	*)
> +		echo sed -n "${line}s/^pick/$action/p"
> +		sed -n "${line}p" < "$1".tmp
> +		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"

I looked at the output from this and wondered what these "sed -n" shown in
the "-v" output were about last night.  I do think it is a good idea to
show what edit was done to the insn stream, but I suspect it may be easier
to read the output if you did this instead:

> +		sed -n "${line}p" < "$1".tmp
> +		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
> +		sed -n "${line}s/^pick/$action/p" < "$1".tmp
