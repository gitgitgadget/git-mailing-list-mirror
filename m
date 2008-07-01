From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] Build in merge
Date: Tue, 01 Jul 2008 00:27:48 -0700
Message-ID: <7vzlp2oyh7.fsf@gitster.siamese.dyndns.org>
References: <cover.1214879690.git.vmiklos@frugalware.org>
 <9201d4e13e574c10b1674cf1f6da23a44a73f8b2.1214879690.git.vmiklos@frugalware.org> <1b74bb93e518a906b0067d182fb29279baff3b25.1214879690.git.vmiklos@frugalware.org> <5e65b37998d1fdd9d314e48cea2cf67fd73ba8cd.1214879690.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 09:28:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDaIK-0000R4-69
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 09:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbYGAH17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 03:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbYGAH17
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 03:27:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbYGAH16 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 03:27:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 51D451BF9B;
	Tue,  1 Jul 2008 03:27:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 270D81BF98; Tue,  1 Jul 2008 03:27:49 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3A09F2C8-473F-11DD-A970-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87005>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +	/* See if remote matches <name>~<number>, or <name>^ */
> +	ptr = strrchr(remote, '^');
> +	if (ptr && ptr[1] == '\0') {
> +		for (len = 0, ptr = remote + strlen(remote);
> +				remote < ptr && ptr[-1] == '^';
> +				ptr--)
> +			len++;
> +	}
> +	else {
> +		ptr = strrchr(remote, '~');
> +		if (ptr && ptr[1] != '0' && isdigit(ptr[1])) {
> +			len = ptr-remote;
> +			ptr++;
> +			for (ptr++; *ptr; ptr++)
> +				if (!isdigit(*ptr)) {
> +					len = 0;
> +					break;
> +				}
> +		}
> +	}

I still have problems with the above.  I'd write it this way:

	int len, early;
	...
	/* See if remote matches <name>^^^.. or <name>~<number> */
	for (len = 0, ptr = remote + strlen(remote);
	     remote < ptr && ptr[-1] == '^';
	     ptr--)
		len++;
	if (len)
		early = 1;
	else {
		early = 0;
		ptr = strrchr(remote, '~');
		if (ptr) {
			int seen_nonzero = 0;

			len++; /* count ~ */
			while (*++ptr && isdigit(*ptr)) {
				seen_nonzero |= (*ptr != '0');
				len++;
			}
			if (*ptr)
				len = 0; /* not ...~<number> */
			else if (seen_nonzero)
				early = 1;
			else if (len == 1)
				early = 1; /* "name~" is "name~1"! */
		}
	}
	if (len) {
		struct strbuf truname = STRBUF_INIT;
		strbuf_addstr(&truname, "refs/heads/");
		strbuf_addstr(&truname, remote);
		strbuf_setlen(&truname, len+11);
		if (resolve_ref(truname.buf, buf_sha, 0, 0)) {
			strbuf_addf(msg,
				    "%s\t\tbranch '%s'%s of .\n",
				    sha1_to_hex(remote_head->sha1),
				    truname.buf,
				    (early ? " (early part)" : ""));
			return;
		}
	}


The first loop is obvious.  If the tail end is ^, we set "len" and see if
the remainder is a branch name (and if that is the case we are always
talking about an early part of it of the branch).

Otherwise, we do want to say "early part" if "$name~<number>" is given,
and another special case is "$name~" which is "$name~1" these days.  As
long as number is not zero we would want to say "early part".  Otherwise
we would want to say it is a branch itself, not its early part.

I'll queue the fixed-up result in 'pu', but I have to tend to other topics
before I can actually publish.  Together with the fix to "head_invalid"
confusion I mentioned in another message squashed in to this commit, all
the tests now finally seem to pass on the topic branch.

Oh, by the way, you sent this and the previous round without marking them
as RFC nor WIP, even though they obviously did not even pass the test
suite.  For example, without the head_invalid fix, anything that runs
merge on detached head, most notably "git rebase -i", would not work at
all.
