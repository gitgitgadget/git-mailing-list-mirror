From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] git-submodule: New subcommand 'summary' (3) -
 limit summary size
Date: Fri, 29 Feb 2008 23:29:32 -0800
Message-ID: <7v1w6u7vhf.fsf@gitster.siamese.dyndns.org>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
 <d6e82710452985611fb75c9d32a1b772bf0cb529.1204306070.git.pkufranky@gmail.com>
 <18af168b52a735c33612c9c9e4778d8b8bef1cbc.1204306070.git.pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 08:30:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMAr-0002t7-1e
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 08:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbYCAH3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 02:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753298AbYCAH3t
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 02:29:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbYCAH3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 02:29:48 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AAD662259;
	Sat,  1 Mar 2008 02:29:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E555A2258; Sat,  1 Mar 2008 02:29:41 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75629>

Ping Yin <pkufranky@gmail.com> writes:

> This patches teaches git-submodule an option '--summary-limit|-n <number>'
> to limit number of commits for the summary. Number 0 will disable summary
> and minus number will not limit the summary size.

"Negative means unlimited" feels unnecessary.  Didn't you make "unlimited"
the default anyway?
>
> For beauty and clarification, the last commit for each section (backward
> and forward) will always be shown disregarding the given limit. So actual
> summary size may be greater than the given limit.
>
> In the same super project of these patch series, 'git submodule -n 2
> summary sm1' and 'git submodule -n 3 summary sm1' will show the same.

This description is unclear.  Does "-n 2" tell "show 2 commits from both
side", or "show 2 in total"?

> ---------------------------------------
>  $ git submodule -n 2 summary sm1
>  # Submodules modifiled: sm1
>  #
>  # * sm1 354cd45...3f751e5:
>  #   <one line message for C
>  #   <one line message for B
>  #   >... (1 more)
>  #   >one line message for E
>  #

When you have room only for N lines, you might have to say (X more), but
you never need to say (1 more).  You can fit that omitted one item on that
line instead of wasting that line to say (1 more).

It is unclear from the above illustration as the (1 more) is pointing at
right without having anything newer than that, but I think you meant to do
something like this:

    <top
    <second
    <... (N more)
    <bottom
    >top
    >second
    >... (M more)
    >bottom

I guess fork-point may be interesting enough that showing the bottom one
like you did might make sense.  I am not convinced but we'll see.

> +		-n|--summary-limit)
> +			if test -z "$2" || echo "$2" | grep --quiet -v '^-\?[0-9]\+$'

\?\+?????

	summary_limit=$(expr "$2" : '[0-9][0-9]*$')

or even

	if summary_limit=$(( $2 + 0 )) 2>/dev/null ||
           test "$2" != "$summary_limit"
	then
		usage
	fi

perhaps.

> +			if (( $summary_limit < 0 ))

Don't.  The first line of this script says "#!/bin/sh", not bash.
