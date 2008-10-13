From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach/Fix git-pull/git-merge --quiet and --verbose
Date: Mon, 13 Oct 2008 15:13:03 -0700
Message-ID: <7vzll887ps.fsf@gitster.siamese.dyndns.org>
References: <1223934148-13942-1-git-send-email-tuncer.ayaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tuncer.ayaz@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 14 00:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpVgI-0008Qi-1F
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 00:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757952AbYJMWNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 18:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757945AbYJMWNL
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 18:13:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757936AbYJMWNK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 18:13:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E9FFF6C5B5;
	Mon, 13 Oct 2008 18:13:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1D7806C5B4; Mon, 13 Oct 2008 18:13:06 -0400 (EDT)
In-Reply-To: <1223934148-13942-1-git-send-email-tuncer.ayaz@gmail.com>
 (tuncer ayaz's message of "Mon, 13 Oct 2008 23:42:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1DFE68B6-9974-11DD-8C46-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98160>

tuncer.ayaz@gmail.com writes:

> From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
>
> Updated patch to current Junio master.

That's not a commit log message, is it?

> Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
> ---
>  Documentation/merge-options.txt |    8 ++++++++
>  builtin-fetch.c                 |    5 +++--
>  builtin-merge.c                 |   22 +++++++++++++++-------
>  git-pull.sh                     |   10 ++++++++--
>  4 files changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 007909a..427cdef 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -1,3 +1,11 @@
> +-q::
> +--quiet::
> +	Operate quietly.
> +
> +-v::
> +--verbose::
> +	Be verbose.
> +
>  --stat::
>  	Show a diffstat at the end of the merge. The diffstat is also
>  	controlled by the configuration option merge.stat.
> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index ee93d3a..287ce33 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -372,12 +372,13 @@ static int store_updated_refs(const char *url, const char *remote_name,
>  				SUMMARY_WIDTH, *kind ? kind : "branch",
>  				 REFCOL_WIDTH, *what ? what : "HEAD");
>  		if (*note) {
> -			if (!shown_url) {
> +			if ((verbose || !quiet) && !shown_url) {

A pair of external verbosity flag -q and -v may be acceptable, but is it
sane to have a pair of variables in code always used like this?  In other
words, this makes me wonder if a single "verbosity level" variable that
can be set to quiet, normal and verbose would make it more readable.  For
example, this one would say:

	if (verbosity >= VERBOSITY_NORMAL && !shown_url) {
        	...
	}

Also what does your command line parsing code do when the user gives -q
and -v at the same time?  Does the last one on the command line win?
Shouldn't you instead get an error message (which of course would mean you
would need to fix the caller in git-pull.sh)?

> +			if (verbose || !quiet)
> +				fprintf(stderr, " %s\n", note);

Ditto.

> +	if (verbose || !quiet)
> +		printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);

Ditto.

> +		if (verbose || !quiet)
> +			printf("%s\n", msg);
> +		if ((verbose || !quiet) && !merge_msg.len)

Ditto.

> +	if (!verbose && quiet)
> +		show_diffstat = 0;

Hmph, ah, that's (!(verbose || !quiet)).  See the readability issue?

> +		if (verbose || !quiet)
> +			printf("Updating %s..%s\n",
> +				hex,
> +				find_unique_abbrev(remoteheads->item->object.sha1,
> +				DEFAULT_ABBREV));

Ditto.
